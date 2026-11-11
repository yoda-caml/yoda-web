open Js_of_ocaml
open Js_of_ocaml_lwt
open Lwt.Infix

let exporting = ref false

let export_notice = ref ""

let button_id = "judge-board-export"

let button_label () =
  if !export_notice = "" then "Export CSV"
  else "Export CSV: " ^ !export_notice

let update_button () =
  match
    Dom_html.getElementById_coerce button_id Dom_html.CoerceTo.button
  with
  | None -> ()
  | Some button ->
      button##.textContent := Js.some (Js.string (button_label ())) ;
      button##.disabled := Js.bool !exporting

let request_lock = Lwt_mutex.create ()

let next_request_at = ref 0.

let now () = Js.float_of_number (new%js Js.date_now)##getTime /. 1000.

let wait_for_request ~is_current =
  Lwt_mutex.with_lock request_lock (fun () ->
      let rec wait () =
        if not (is_current ()) then Lwt.fail Lwt.Canceled
        else
          let delay = !next_request_at -. now () in
          if delay > 0. then Lwt_js.sleep (min delay 1.) >>= wait
          else (
            next_request_at := now () +. 0.05 ;
            Lwt.return_unit )
      in
      wait () )

let retry_delay header =
  let seconds =
    match header with
    | None -> 0.
    | Some value -> (
      match float_of_string_opt value with
      | Some seconds when Float.is_finite seconds -> seconds
      | _ ->
          let date = Js.Unsafe.global##.Date##parse (Js.string value) in
          let timestamp = Js.float_of_number date /. 1000. in
          if Float.is_finite timestamp then timestamp -. now () else 0. )
  in
  max 10. seconds

let csv_cell value =
  let value =
    let rec first_non_space i =
      if
        i < String.length value
        && ( value.[i] = ' '
           || value.[i] = '\t'
           || value.[i] = '\r'
           || value.[i] = '\n' )
      then first_non_space (i + 1)
      else i
    in
    let i = first_non_space 0 in
    if i < String.length value && String.contains "=+-@" value.[i] then
      "'" ^ value
    else value
  in
  "\"" ^ String.concat "\"\"" (String.split_on_char '"' value) ^ "\""

let test_results details =
  List.map
    (fun (detail : Api.Openapi.submissionDetail) ->
      Printf.sprintf "Test #%d: %s (%d ms)" detail.testcase_id detail.status
        detail.time_ms )
    details
  |> String.concat "\n"

let latest_submissions submissions =
  let groups = Hashtbl.create 32 in
  let unknown = ref [] in
  List.iter
    (fun (sub : Api.Openapi.submission) ->
      match sub.owner_id with
      | None -> unknown := (sub, 1) :: !unknown
      | Some owner ->
          let key = (owner, sub.problem_id) in
          let latest, count =
            match Hashtbl.find_opt groups key with
            | None -> (sub, 1)
            | Some ((latest : Api.Openapi.submission), count) ->
                ((if latest.id >= sub.id then latest else sub), count + 1)
          in
          Hashtbl.replace groups key (latest, count) )
    submissions ;
  Hashtbl.fold (fun _ group acc -> group :: acc) groups !unknown
  |> List.sort (fun ((a : Api.Openapi.submission), _) (b, _) ->
      Int.compare a.id b.id )

let csv ~username ~problem_code submissions =
  let rows =
    List.map
      (fun ((sub : Api.Openapi.submission), attempts) ->
        let user =
          match sub.owner_id with
          | None -> "Username unavailable (owner unknown)"
          | Some id -> username id
        in
        [ user
        ; string_of_int sub.id
        ; problem_code sub.problem_id
        ; sub.status
        ; string_of_int attempts
        ; test_results sub.details ]
        |> List.map csv_cell |> String.concat "," )
      submissions
  in
  let header =
    [ "User"
    ; "Submission"
    ; "Problem"
    ; "Last judge verdict"
    ; "Attempts"
    ; "Test results" ]
    |> List.map csv_cell |> String.concat ","
  in
  String.concat "\r\n" (header :: rows) ^ "\r\n"

let prepare ~is_current ~on_progress ~username ~problem_code submissions =
  let submissions = latest_submissions submissions in
  let total = List.length submissions in
  let completed = ref 0 in
  let rec fetch_details (sub : Api.Openapi.submission) attempts retries =
    wait_for_request ~is_current
    >>= fun () ->
    XmlHttpRequest.perform_raw_url ~headers:(Api.Helpers.headers ())
      (Printf.sprintf "%s/submissions/%d/details" Api.Helpers.base_url sub.id)
    >>= fun response ->
    Helpers.handle_unauthorized response ;
    if not (is_current ()) then Lwt.fail Lwt.Canceled
    else if response.code = 429 && retries > 0 then (
      let delay = retry_delay (response.headers "Retry-After") in
      next_request_at := max !next_request_at (now () +. delay) ;
      on_progress !completed total true ;
      fetch_details sub attempts (retries - 1) )
    else if response.code <> 200 then
      Lwt.fail_with
        (Printf.sprintf "Submission #%d details request failed (%d)." sub.id
           response.code )
    else
      let details =
        response.content |> Yojson.Safe.from_string
        |> Api.Openapi.SubmissionFullDetails.of_yojson
      in
      incr completed ;
      on_progress !completed total false ;
      Lwt.return
        ( { sub with
            status= details.submission.status
          ; details= details.submission.details }
        , attempts )
  in
  Lwt_list.map_s
    (fun (sub, attempts) -> fetch_details sub attempts 3)
    submissions
  >|= fun fetched -> csv ~username ~problem_code fetched

let trigger_download ~contest_id content =
  let blob =
    File.blob_from_any ~contentType:"text/csv;charset=utf-8" [`string content]
  in
  let url_obj = Js.Unsafe.coerce Dom_html.window##._URL in
  let object_url =
    Js.Unsafe.meth_call url_obj "createObjectURL" [|Js.Unsafe.inject blob|]
    |> Js.Unsafe.coerce |> Js.to_string
  in
  let anchor = Dom_html.createA Dom_html.document in
  anchor##.href := Js.string object_url ;
  anchor##.download :=
    Js.string (Printf.sprintf "contest-%d-submissions.csv" contest_id) ;
  anchor##.style##.display := Js.string "none" ;
  ignore (Dom.appendChild Dom_html.document##.body (Js.Unsafe.coerce anchor)) ;
  anchor##click ;
  ignore (Js.Unsafe.meth_call (Js.Unsafe.coerce anchor) "remove" [||]) ;
  ignore
    (Js.Unsafe.meth_call url_obj "revokeObjectURL"
       [|Js.Unsafe.inject (Js.string object_url)|] )

let export_statistics ~contest_id ~is_current ~username ~problem_code
    submissions =
  if not !exporting then (
    exporting := true ;
    export_notice := "Preparing CSV export..." ;
    update_button () ;
    Lwt.async (fun () ->
        Lwt.catch
          (fun () ->
            prepare ~is_current
              ~on_progress:(fun completed total rate_limited ->
                export_notice :=
                  Printf.sprintf "Preparing CSV: %d/%d submissions.%s"
                    completed total
                    ( if rate_limited then " Rate limited; waiting to retry."
                      else "" ) ;
                update_button () )
              ~username ~problem_code submissions
            >|= fun csv ->
            if is_current () then (
              trigger_download ~contest_id csv ;
              exporting := false ;
              export_notice := "CSV export downloaded." ;
              update_button () ) )
          (fun error ->
            if is_current () then (
              exporting := false ;
              export_notice :=
                "CSV export failed: " ^ Printexc.to_string error ;
              update_button () ) ;
            Lwt.return_unit ) ) )
