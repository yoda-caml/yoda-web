open Js_of_ocaml
open Js_of_ocaml_lwt
open Lwt.Infix

let poll_interval_seconds = 1.0

let terminal_statuses =
  [ "accepted"
  ; "wrong_answer"
  ; "runtime_error"
  ; "time_limit_exceeded"
  ; "memory_limit_exceeded"
  ; "compilation_error"
  ; "compile_error"
  ; "presentation_error"
  ; "internal_error" ]

type submit_context =
  { contest_id: int
  ; problem_code: string
  ; problem_id: int
  ; language: string
  ; source_artifacts: Api.Openapi.sourceArtifact list }

let show_modal () =
  Spinner_modal.remove () ;
  Helpers.add_element_to_app (Spinner_modal.make ())

let is_terminal_status status =
  List.exists (fun s -> s = String.lowercase_ascii status) terminal_statuses

let modal_kind_of_submission_status status =
  match String.lowercase_ascii status with
  | "accepted" -> "success"
  | "wrong_answer" | "runtime_error" | "time_limit_exceeded"
   |"memory_limit_exceeded" | "compilation_error" | "compile_error"
   |"presentation_error" | "internal_error" ->
      "error"
  | _ -> "warning"

let select_language ~languages_allowed ~source_artifacts =
  let allowed_set = List.map String.lowercase_ascii languages_allowed in
  let from_extensions =
    List.find_map
      (fun (artifact : Api.Openapi.sourceArtifact) ->
        match Tabbar.language_for_filename artifact.filename with
        | Some language when List.mem language allowed_set -> Some language
        | _ -> None )
      source_artifacts
  in
  match from_extensions with
  | Some language -> language
  | None -> (
    match languages_allowed with first :: _ -> first | [] -> "none" )

let get_submission_context () =
  let contest_id = Helpers.get_current_contest_id () in
  match Model.Problem_state.get_selected_problem_id () with
  | None -> Lwt.return (Error (I18n.t "submission_no_problem"))
  | Some problem_id ->
      let languages_allowed = Tabbar.get_current_languages () in
      let source_artifacts = Tabbar.get_current_source_artifacts () in
      (* Select the language based on the selected problem or the extension
         of the artifacts; fallback to the first language allowed if none
         match *)
      let language =
        match Model.Problem_state.get_selected_problem_language () with
        | Some selected_language
          when List.mem
                 (String.lowercase_ascii selected_language)
                 (List.map String.lowercase_ascii languages_allowed) ->
            selected_language
        | _ -> select_language ~languages_allowed ~source_artifacts
      in
      if language = "none" then
        Lwt.return (Error (I18n.t "submission_no_language"))
      else
        let has_non_empty_file =
          List.exists
            (fun (artifact : Api.Openapi.sourceArtifact) ->
              String.trim artifact.content <> "" )
            source_artifacts
        in
        if not has_non_empty_file then
          Lwt.return (Error (I18n.t "submission_empty_editor"))
        else
          Lwt.return
            (Ok
               { contest_id
               ; problem_code= string_of_int problem_id
               ; problem_id
               ; language
               ; source_artifacts } )

let fetch_submission submission_id =
  let url =
    Printf.sprintf "%s/submissions/%d" Api.Helpers.base_url submission_id
  in
  Api.Helpers.fetch_json url
  >>= fun (resp, status) ->
  if status <> 200 then Lwt.return None
  else
    let submissions = Api.Openapi.Submission.of_yojson resp in
    Lwt.return (Some submissions)

let find_submission_by_id submissions submission_id =
  List.find_opt
    (fun (s : Api.Openapi.submission) -> s.id = submission_id)
    submissions

let submit_solution (ctx : submit_context) =
  let solution =
    Api.Openapi.Solution.create ~problem_id:ctx.problem_id
      ~language:ctx.language ~source_artifacts:ctx.source_artifacts ()
  in
  Api.Helpers.submit_solution (Api.Openapi.Solution.to_yojson solution)
  >>= fun (resp, status) ->
  if status <> 200 && status <> 201 && status <> 202 then
    Lwt.return (Error status)
  else
    let submission = Api.Openapi.Submission.of_yojson resp in
    Lwt.return (Ok submission.id)

let is_past_close_time close_at =
  match close_at with
  | None -> false
  | Some timestamp -> (
      let close_ms = Js.Unsafe.global##.Date##parse (Js.string timestamp) in
      match classify_float close_ms with
      | FP_nan | FP_infinite -> false
      | FP_normal | FP_subnormal | FP_zero ->
          let now = new%js Js.date_now in
          Js.float_of_number now##getTime >= close_ms )

let rec poll_until_terminal (ctx : submit_context) submission_id =
  fetch_submission submission_id
  >>= function
  | None ->
      Spinner_modal.update_current_status ~kind:"info"
        (I18n.t "submission_queued") ;
      Lwt_js.sleep poll_interval_seconds
      >>= fun () -> poll_until_terminal ctx submission_id
  | Some submission ->
      let live_status = submission.status in
      Spinner_modal.update_current_status ~kind:"info"
        (I18n.interpolate
           (I18n.t "submission_status_polling")
           [I18n.submission_status live_status] ) ;
      if is_terminal_status live_status then (
        (*notify_result ctx live_status ;*)
        Console.console##log
          (Js.string
             (Printf.sprintf "Submission for %s finished with: %s"
                ctx.problem_code live_status ) ) ;
        Lwt_js.sleep 1.0 >>= fun () -> Lwt.return live_status )
      else
        Lwt_js.sleep poll_interval_seconds
        >>= fun () -> poll_until_terminal ctx submission_id

let submit_and_poll () =
  show_modal () ;
  Spinner_modal.update_text ~kind:"info" (I18n.t "submission_preparing") ;
  get_submission_context ()
  >>= function
  | Error msg ->
      Spinner_modal.update_text ~kind:"error"
        (I18n.interpolate (I18n.t "submission_cannot_submit") [msg]) ;
      Lwt.return_unit
  | Ok ctx -> (
      Api.Helpers.get_problem ctx.problem_id
      >>= fun (resp, status) ->
      if status <> 200 then (
        Spinner_modal.update_text ~kind:"error"
          (I18n.interpolate
             (I18n.t "submission_problem_check_failed")
             [string_of_int status] ) ;
        Lwt.return_unit )
      else
        let problem = Api.Openapi.Problem.of_yojson resp in
        let unavailable_reason =
          if Helpers.is_judge_or_admin () then None
          else if problem.is_submission_disabled = Some true then
            Some (I18n.t "submission_problem_submissions_disabled")
          else if problem.is_force_closed = Some true then
            Some (I18n.t "submission_problem_force_closed")
          else if is_past_close_time problem.close_at then
            Some (I18n.t "submission_problem_closed")
          else None
        in
        match unavailable_reason with
        | Some message ->
            Spinner_modal.update_text ~kind:"error" message ;
            Lwt.return_unit
        | None -> (
            Spinner_modal.update_text ~kind:"info"
              (I18n.interpolate
                 (I18n.t "submission_sending_language")
                 [ctx.language] ) ;
            submit_solution ctx
            >>= function
            | Error code ->
                Spinner_modal.update_text ~kind:"error"
                  (I18n.interpolate
                     (I18n.t "submission_failed_http")
                     [string_of_int code] ) ;
                Lwt.return_unit
            | Ok submission_id ->
                Spinner_modal.update_text ~kind:"info"
                  (I18n.interpolate
                     (I18n.t "submission_created")
                     [string_of_int submission_id] ) ;
                poll_until_terminal ctx submission_id
                >>= fun final_status ->
                Spinner_modal.update_title
                  (I18n.interpolate
                     (I18n.t "submission_done")
                     [I18n.submission_status final_status] ) ;
                Spinner_modal.update_text
                  ~kind:(modal_kind_of_submission_status final_status)
                  (I18n.interpolate
                     (I18n.t "submission_final_verdict")
                     [I18n.submission_status final_status] ) ;
                Lwt.return_unit ) )

let start () = Lwt.async submit_and_poll
