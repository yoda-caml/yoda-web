open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Lwt.Infix

(* --- Types --- *)

type difficulty = Easy | Medium | Hard

let difficulty_label = function
  | Easy -> "Easy"
  | Medium -> "Medium"
  | Hard -> "Hard"

let difficulty_color = function
  | Easy -> "success"
  | Medium -> "warning"
  | Hard -> "danger"

type problem_state =
  { problems: Api.Openapi.problem list
  ; testcases: (int, Api.Openapi.testCase list) Hashtbl.t
  ; contest_id: int option
  ; search: string
  ; selected_code: string option
  ; difficulty_filter: difficulty option
  ; source_artifacts: (int, Api.Openapi.sourceArtifact list) Hashtbl.t
  ; object_artifacts: (int, Api.Openapi.objectArtifact list) Hashtbl.t }

type edit_mode =
  | Create of Api.Openapi.problem
  | Edit of Api.Openapi.problem
  | None_

(* --- State --- *)

let state : problem_state ref =
  ref
    { problems= []
    ; testcases= Hashtbl.create 16
    ; contest_id= None
    ; search= ""
    ; selected_code= None
    ; difficulty_filter= None
    ; source_artifacts= Hashtbl.create 16
    ; object_artifacts= Hashtbl.create 16 }

let edit_mode : edit_mode ref = ref None_

let loading : bool ref = ref false

let error_msg : string option ref = ref None

let last_loaded = ref None

let oracle_args_state : (string, string list ref) Hashtbl.t =
  Hashtbl.create 16

let contest_select =
  select ~a:[a_id "problem-select"; a_class ["form-select"; "w-auto"]] []

(* --- Helpers --- *)

let section_card title content =
  Tyxml_js.Html.div
    ~a:[a_class ["card"; "mb-3"]]
    [ div
        ~a:[a_class ["card-header"]]
        [h6 ~a:[a_class ["card-title"; "mb-0"]] [txt title]]
    ; div ~a:[a_class ["card-body"]] content ]

let toggle_switch ~checked ~label_text ~on_change () =
  let attrs =
    [ a_input_type `Checkbox
    ; a_class ["form-check-input"]
    ; a_id ("toggle-" ^ label_text)
    ; a_onchange (fun ev ->
          let target =
            Js.Opt.get
              (Dom_html.CoerceTo.input
                 (Js.Opt.get ev##.target (fun () -> assert false)) )
              (fun () -> assert false)
          in
          on_change (Js.to_bool target##.checked) ;
          false ) ]
    @ if checked then [a_checked ()] else []
  in
  div
    ~a:[a_class ["d-flex"; "justify-content-between"; "align-items-center"]]
    [ label [txt label_text]
    ; div
        ~a:[a_class ["form-check"; "form-switch"]]
        [ input ~a:attrs ()
        ; label
            ~a:
              [ a_class ["form-check-label"]
              ; a_label_for ("toggle-" ^ label_text) ]
            [] ] ]

(* --- Load data for contest --- *)

let load_problems contest_id =
  loading := true ;
  error_msg := None ;
  (*Helpers.trigger_render () ;*)
  Api.Helpers.get_problems contest_id
  >>= fun (resp, status) ->
  if status <> 200 then (
    error_msg :=
      Some (Printf.sprintf "Failed to load problems: HTTP %d" status) ;
    loading := false ;
    Helpers.trigger_render () ;
    Lwt.return_unit )
  else begin
    let problems =
      Api.Openapi.ContestsContestsidProblemsGetResponse2.of_yojson resp
    in
    state := {!state with problems; contest_id= Some contest_id} ;
    Hashtbl.clear !state.testcases ;
    Hashtbl.clear !state.object_artifacts ;
    loading := false ;
    error_msg := None ;
    Helpers.trigger_render () ;
    Lwt.return_unit
  end

let load_testcases problem_id =
  match Hashtbl.find_opt !state.testcases problem_id with
  | Some _ -> Lwt.return_unit (* already loaded *)
  | None ->
      Api.Helpers.get_testcases problem_id
      >>= fun (resp, status) ->
      if status <> 200 then (
        (* this means the problem doesn't exist or has no test cases, so we
           just add an empty list; this allows to distinguish loading errors
           from no test cases *)
        Hashtbl.add !state.testcases problem_id [] ;
        Lwt.return_unit )
      else
        let cases =
          Api.Openapi.ProblemsIdTestcasesGetResponse2.of_yojson resp
        in
        Hashtbl.add !state.testcases problem_id cases ;
        Helpers.trigger_render () ;
        Lwt.return_unit

let refresh_testcases problem_id =
  Hashtbl.remove !state.testcases problem_id ;
  load_testcases problem_id
  >>= fun () -> Helpers.trigger_render () ; Lwt.return_unit

let load_source_artifacts (problem_id : int) =
  match Hashtbl.find_opt !state.source_artifacts problem_id with
  | Some _ -> Lwt.return_unit (* already loaded *)
  | None ->
      Api.Helpers.get_problem problem_id
      >>= fun (resp, status) ->
      if status <> 200 then (
        (* this means the problem doesn't exist or has no source artifacts,
           so we just add an empty list; this allows to distinguish loading
           errors from no source artifacts *)
        Hashtbl.add !state.source_artifacts problem_id [] ;
        Lwt.return_unit )
      else
        let artifacts =
          (Api.Openapi.Problem.of_yojson resp).source_artifacts
          |> Option.value ~default:[]
        in
        Hashtbl.add !state.source_artifacts problem_id artifacts ;
        Helpers.trigger_render () ;
        Lwt.return_unit

let get_source_artifacts_for_problem problem_id =
  try Hashtbl.find !state.source_artifacts problem_id with Not_found -> []

let load_object_artifacts (problem_id : int) =
  match Hashtbl.find_opt !state.object_artifacts problem_id with
  | Some _ -> Lwt.return_unit (* already loaded *)
  | None ->
      Api.Helpers.get_problem problem_id
      >>= fun (resp, status) ->
      if status <> 200 then (
        Hashtbl.add !state.object_artifacts problem_id [] ;
        Lwt.return_unit )
      else
        let object_artifacts =
          match resp with
          | `Assoc fields -> (
            match List.assoc_opt "object_artifacts" fields with
            | Some v -> Api.Openapi.objectArtifacts_of_yojson v
            | None -> [] )
          | _ -> []
        in
        Hashtbl.add !state.object_artifacts problem_id object_artifacts ;
        Helpers.trigger_render () ;
        Lwt.return_unit

let get_object_artifacts_for_problem problem_id =
  try Hashtbl.find !state.object_artifacts problem_id with Not_found -> []

let open_testcase_modal ~problem_id ~(testcase : Api.Openapi.testCase option)
    =
  let title =
    match testcase with
    | Some _ -> I18n.t "problems_edit_testcase"
    | None -> I18n.t "problems_add_testcase"
  in
  let input_id =
    match testcase with
    | Some tc -> Printf.sprintf "edit-testcase-input-%d" tc.id
    | None -> Printf.sprintf "new-testcase-input-%d" problem_id
  in
  let output_id =
    match testcase with
    | Some tc -> Printf.sprintf "edit-testcase-output-%d" tc.id
    | None -> Printf.sprintf "new-testcase-output-%d" problem_id
  in
  let sample_id =
    match testcase with
    | Some tc -> Printf.sprintf "edit-testcase-sample-%d" tc.id
    | None -> Printf.sprintf "new-testcase-sample-%d" problem_id
  in
  let oracle_enabled_id =
    match testcase with
    | Some tc -> Printf.sprintf "edit-testcase-oracle-enabled-%d" tc.id
    | None -> Printf.sprintf "new-testcase-oracle-enabled-%d" problem_id
  in
  let oracle_entrypoint_id =
    match testcase with
    | Some tc -> Printf.sprintf "edit-testcase-oracle-entrypoint-%d" tc.id
    | None -> Printf.sprintf "new-testcase-oracle-entrypoint-%d" problem_id
  in
  let oracle_args_id =
    match testcase with
    | Some tc -> Printf.sprintf "edit-testcase-oracle-args-%d" tc.id
    | None -> Printf.sprintf "new-testcase-oracle-args-%d" problem_id
  in
  let oracle_args_container_id = oracle_args_id ^ "-list" in
  let oracle_args_row_id i = oracle_args_id ^ "-row-" ^ string_of_int i in
  let default_input =
    match testcase with Some tc -> tc.input | None -> ""
  in
  let default_output =
    match testcase with Some tc -> tc.output | None -> ""
  in
  let default_is_sample =
    match testcase with Some tc -> tc.is_sample | None -> false
  in
  let default_oracle =
    match testcase with Some tc -> tc.oracle | None -> None
  in
  let default_oracle_enabled = Option.is_some default_oracle in
  let oracle_enabled = ref default_oracle_enabled in
  let default_oracle_entrypoint =
    match default_oracle with Some oracle -> oracle.entrypoint | None -> ""
  in
  let default_oracle_args =
    match default_oracle with
    | Some oracle -> Option.value ~default:[] oracle.args
    | None -> []
  in
  let modal_name =
    match testcase with
    | Some tc -> Printf.sprintf "testcase-modal-%d" tc.id
    | None -> Printf.sprintf "testcase-modal-new-%d" problem_id
  in
  let oracle_args_values =
    try Hashtbl.find oracle_args_state modal_name
    with Not_found ->
      let values = ref default_oracle_args in
      Hashtbl.add oracle_args_state modal_name values ;
      values
  in
  let get_textarea_value field_id =
    match
      Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.textarea
    with
    | Some el -> Js.to_string el##.value
    | None -> ""
  in
  let get_checkbox_value field_id =
    match
      Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.input
    with
    | Some el -> Js.to_bool el##.checked
    | None -> false
  in
  let get_input_value field_id =
    match
      Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.input
    with
    | Some el -> Js.to_string el##.value
    | None -> (
      match
        Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.textarea
      with
      | Some el -> Js.to_string el##.value
      | None -> "" )
  in
  let set_disabled_for_field field_id disabled =
    match
      Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.input
    with
    | Some field -> field##.disabled := Js.bool disabled
    | None -> (
      match
        Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.textarea
      with
      | Some field -> field##.disabled := Js.bool disabled
      | None -> () )
  in
  Components.Modal_view.make modal_name title
    [ div
        ~a:[a_class ["mb-3"]]
        [ label ~a:[a_class ["form-label"]] [txt "Input"]
        ; textarea
            ~a:
              [ a_id input_id
              ; a_class ["form-control"]
              ; a_rows 5
              ; a_placeholder "Test input" ]
            (txt default_input) ]
    ; div
        ~a:[a_class ["mb-3"]]
        [ label ~a:[a_class ["form-label"]] [txt "Output"]
        ; textarea
            ~a:
              [ a_id output_id
              ; a_class ["form-control"]
              ; a_rows 5
              ; a_placeholder "Expected output" ]
            (txt default_output) ]
    ; div
        ~a:[a_class ["form-check"]]
        [ input
            ~a:
              ( [ a_id sample_id
                ; a_class ["form-check-input"]
                ; a_input_type `Checkbox ]
              @ if default_is_sample then [a_checked ()] else [] )
            ()
        ; label
            ~a:[a_class ["form-check-label"]; a_label_for sample_id]
            [txt "Sample"] ]
    ; div
        ~a:[a_class ["border-top"; "mt-3"; "pt-3"]]
        [ div
            ~a:[a_class ["form-check"]]
            [ input
                ~a:
                  ( [ a_id oracle_enabled_id
                    ; a_class ["form-check-input"]
                    ; a_input_type `Checkbox
                    ; a_onchange (fun _ ->
                          oracle_enabled := not !oracle_enabled ;
                          ( match
                              Dom_html.getElementById_coerce
                                oracle_entrypoint_id Dom_html.CoerceTo.input
                            with
                          | Some field ->
                              field##.disabled :=
                                Js.bool (not !oracle_enabled)
                          | None -> () ) ;
                          let rec disable_oracle_arg_rows index =
                            let field_id =
                              Printf.sprintf "%s-%d" oracle_args_id index
                            in
                            match
                              Dom_html.getElementById_coerce field_id
                                Dom_html.CoerceTo.input
                            with
                            | Some _ ->
                                set_disabled_for_field field_id
                                  (not !oracle_enabled) ;
                                disable_oracle_arg_rows (index + 1)
                            | None -> (
                              match
                                Dom_html.getElementById_coerce field_id
                                  Dom_html.CoerceTo.textarea
                              with
                              | Some _ ->
                                  set_disabled_for_field field_id
                                    (not !oracle_enabled) ;
                                  disable_oracle_arg_rows (index + 1)
                              | None -> () )
                          in
                          disable_oracle_arg_rows 0 ; false ) ]
                  @ if default_oracle_enabled then [a_checked ()] else [] )
                ()
            ; label
                ~a:
                  [ a_class ["form-check-label"]
                  ; a_label_for oracle_enabled_id ]
                [txt "Use custom oracle checker"] ]
        ; div
            ~a:[a_class ["mt-2"]]
            [ label ~a:[a_class ["form-label"]] [txt "Oracle entrypoint"]
            ; input
                ~a:
                  [ a_id oracle_entrypoint_id
                  ; a_class ["form-control"]
                  ; a_placeholder "checker.py"
                  ; ( if default_oracle_enabled then
                        Unsafe.string_attrib "data-oracle-enabled" "true"
                      else Unsafe.string_attrib "disabled" "disabled" )
                  ; a_value default_oracle_entrypoint ]
                () ]
        ; div
            ~a:[a_class ["mt-2"]]
            [ label ~a:[a_class ["form-label"]] [txt "Oracle arguments"]
            ; div
                ~a:
                  [ a_id oracle_args_container_id
                  ; a_class ["d-flex"; "flex-column"; "gap-2"] ]
                (let rows = !oracle_args_values in
                 List.mapi
                   (fun i arg_value ->
                     let field_id =
                       Printf.sprintf "%s-%d" oracle_args_id i
                     in
                     let row_id = oracle_args_row_id i in
                     div
                       ~a:[a_id row_id; a_class ["d-flex"; "gap-2"]]
                       [ textarea
                           ~a:
                             [ a_id field_id
                             ; a_class ["form-control"]
                             ; a_rows 2
                             ; a_placeholder "Argument"
                             ; a_oninput (fun _ ->
                                   oracle_args_values :=
                                     List.mapi
                                       (fun j value ->
                                         if j = i then
                                           get_textarea_value field_id
                                         else value )
                                       !oracle_args_values ;
                                   false )
                             ; ( if default_oracle_enabled then
                                   Unsafe.string_attrib "data-oracle-enabled"
                                     "true"
                                 else
                                   Unsafe.string_attrib "disabled" "disabled"
                               ) ]
                           (txt arg_value)
                       ; button
                           ~a:
                             [ a_class ["btn"; "btn-outline-danger"; "btn-sm"]
                             ; a_onclick (fun _ ->
                                   oracle_args_values :=
                                     List.filteri
                                       (fun j _ -> j <> i)
                                       !oracle_args_values ;
                                   ( match
                                       Dom_html.getElementById_coerce row_id
                                         Dom_html.CoerceTo.div
                                     with
                                   | Some el ->
                                       ignore
                                         (Js.Unsafe.meth_call el "remove" [||])
                                   | None -> () ) ;
                                   false ) ]
                           [txt "Remove"] ] )
                   rows )
            ; button
                ~a:
                  [ a_class ["btn"; "btn-outline-primary"; "btn-sm"; "mt-2"]
                  ; a_onclick (fun _ ->
                        let next_index = List.length !oracle_args_values in
                        oracle_args_values := !oracle_args_values @ [""] ;
                        let row_id = oracle_args_row_id next_index in
                        let field_id =
                          Printf.sprintf "%s-%d" oracle_args_id next_index
                        in
                        let new_row =
                          div
                            ~a:[a_id row_id; a_class ["d-flex"; "gap-2"]]
                            [ textarea
                                ~a:
                                  [ a_id field_id
                                  ; a_class ["form-control"]
                                  ; a_rows 2
                                  ; a_placeholder "Argument"
                                  ; a_oninput (fun _ ->
                                        oracle_args_values :=
                                          List.mapi
                                            (fun j value ->
                                              if j = next_index then
                                                get_textarea_value field_id
                                              else value )
                                            !oracle_args_values ;
                                        false )
                                  ; ( if default_oracle_enabled then
                                        Unsafe.string_attrib
                                          "data-oracle-enabled" "true"
                                      else
                                        Unsafe.string_attrib "disabled"
                                          "disabled" ) ]
                                (txt "")
                            ; button
                                ~a:
                                  [ a_class
                                      ["btn"; "btn-outline-danger"; "btn-sm"]
                                  ; a_onclick (fun _ ->
                                        oracle_args_values :=
                                          List.filteri
                                            (fun j _ -> j <> next_index)
                                            !oracle_args_values ;
                                        ( match
                                            Dom_html.getElementById_coerce
                                              row_id Dom_html.CoerceTo.div
                                          with
                                        | Some el ->
                                            ignore
                                              (Js.Unsafe.meth_call el
                                                 "remove" [||] )
                                        | None -> () ) ;
                                        false ) ]
                                [txt "Remove"] ]
                        in
                        ( match
                            Dom_html.getElementById_coerce
                              oracle_args_container_id Dom_html.CoerceTo.div
                          with
                        | Some container ->
                            Dom.appendChild container
                              (Tyxml_js.To_dom.of_div new_row)
                        | None -> () ) ;
                        false ) ]
                [txt "Add argument"] ] ] ]
    (fun () ->
      let input_v = get_textarea_value input_id in
      let output_v = get_textarea_value output_id in
      let is_sample_v = get_checkbox_value sample_id in
      let oracle_enabled = get_checkbox_value oracle_enabled_id in
      let oracle_entrypoint =
        get_input_value oracle_entrypoint_id |> String.trim
      in
      let oracle_args =
        !oracle_args_values |> List.map String.trim
        |> List.filter (fun arg -> arg <> "")
      in
      let oracle =
        if oracle_enabled && oracle_entrypoint <> "" then
          Some
            (Api.Openapi.OracleConfig.create ~entrypoint:oracle_entrypoint
               ~args:oracle_args () )
        else None
      in
      let body =
        Api.Openapi.TestCaseCreateRequest.create ~input:input_v
          ~output:output_v ~is_sample:is_sample_v ?oracle ()
        |> Api.Openapi.TestCaseCreateRequest.to_json
      in
      Lwt.async (fun () ->
          match testcase with
          | Some tc ->
              Api.Helpers.put_testcase tc.id body
              >>= fun (_resp, status) ->
              if status = 200 || status = 201 || status = 204 then (
                Settings_problems_import.RerenderFlag.set_rerender () ;
                refresh_testcases problem_id )
              else Lwt.return_unit
          | None ->
              Api.Helpers.post_testcase problem_id body
              >>= fun (_resp, status) ->
              if status = 200 || status = 201 then (
                Settings_problems_import.RerenderFlag.set_rerender () ;
                refresh_testcases problem_id )
              else Lwt.return_unit ) ;
      false )
    ()
  |> Helpers.add_element_to_app

(* --- Format helpers --- *)

let format_time_ms ms =
  if ms < 1000 then Printf.sprintf "%dms" ms
  else Printf.sprintf "%.1fs" (float_of_int ms /. 1000.)

let format_memory_mb mb = Printf.sprintf "%dMB" mb

(* --- Contest selector --- *)

let current_contest_select = ref None

let contest_options (contests : Api.Openapi.contest list)
    (selected_id : int option) =
  (* clear select before filling *)
  let select = Tyxml_js.To_dom.of_select contest_select in
  select##.length := 0 ;
  List.iter
    (fun (c : Api.Openapi.contest) ->
      let opt =
        option
          ~a:
            ( [a_value (string_of_int c.id)]
            @
            match selected_id with
            | Some sid when sid = c.id -> [a_selected ()]
            | _ -> [] )
          (txt c.title)
      in
      Dom.appendChild
        (Tyxml_js.To_dom.of_select contest_select)
        (Tyxml_js.To_dom.of_option opt) )
    contests ;
  (* add a_onchange to select *)
  select##.onchange :=
    Dom_html.handler (fun ev ->
        let select =
          Js.Opt.get
            (Dom_html.CoerceTo.select (Dom_html.eventTarget ev))
            (fun () -> assert false)
        in
        let selected_index = Js.to_string select##.value in
        (* print selected_index *)
        Console.console##log
          (Js.string
             (Printf.sprintf "Selected contest index: %s" selected_index) ) ;
        current_contest_select := Some (int_of_string selected_index) ;
        Helpers.trigger_render () ;
        Js._false )

(* --- Add / Edit Modal --- *)

let problem_modal_id = "problem-modal"

let problem_code_input_id = "problem-code-input"

let problem_title_input_id = "problem-title-input"

let problem_time_limit_input_id = "problem-time-limit-input"

let problem_memory_limit_input_id = "problem-memory-limit-input"

let problem_languages_input_id = "problem-languages-input"

let problem_force_closed_input_id = "problem-force-closed-input"

let problem_draft_input_id = "problem-draft-input"

let problem_submission_disabled_input_id =
  "problem-submission-disabled-input"

let problem_description_input_id = "problem-description-input"

let problem_input_spec_input_id = "problem-input-spec-input"

let problem_output_spec_input_id = "problem-output-spec-input"

let object_artifact_input_id problem_id =
  Printf.sprintf "object-artifact-input-%d" problem_id

let problem_open_at_input_id = "problem-open-at-input"

let problem_close_at_input_id = "problem-close-at-input"

let close_problem_modal () =
  edit_mode := None_ ;
  Helpers.remove_first_element_from_app ("#" ^ problem_modal_id) ;
  Helpers.trigger_render ()

let get_input_value field_id =
  match Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.input with
  | Some el -> Js.to_string el##.value
  | None -> ""

let get_textarea_value field_id =
  match
    Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.textarea
  with
  | Some el -> Js.to_string el##.value
  | None -> ""

let get_checkbox_value field_id =
  match Dom_html.getElementById_coerce field_id Dom_html.CoerceTo.input with
  | Some el -> Js.to_bool el##.checked
  | None -> false

let datetime_local_input_value_of_string value =
  let value = String.trim value in
  if value = "" then ""
  else if String.length value >= 16 && value.[10] = 'T' then
    String.sub value 0 16
  else if String.length value >= 16 && value.[10] = ' ' then
    String.sub value 0 10 ^ "T" ^ String.sub value 11 5
  else value

let datetime_local_to_api_value value =
  let value = String.trim value in
  if value = "" then None
  else
    let js_date =
      Js.Unsafe.new_obj
        (Js.Unsafe.pure_js_expr "Date")
        [|Js.Unsafe.inject (Js.string value)|]
    in
    let time_ms =
      Js.float_of_number (Js.Unsafe.meth_call js_date "getTime" [||])
    in
    if classify_float time_ms = FP_nan then None
    else
      let iso_full =
        Js.to_string (Js.Unsafe.meth_call js_date "toISOString" [||])
      in
      if String.length iso_full >= 20 then
        Some (String.sub iso_full 0 19 ^ "Z")
      else Some iso_full

let read_file_as_data_url (file : File.file Js.t) : string Lwt.t =
  let waiter, wakener = Lwt.wait () in
  let reader =
    Js.Unsafe.new_obj (Js.Unsafe.pure_js_expr "FileReader") [||]
  in
  let on_success =
    Js.wrap_callback (fun _ ->
        let result = Js.to_string (Js.Unsafe.get reader "result") in
        Lwt.wakeup_later wakener result )
  in
  let on_error =
    Js.wrap_callback (fun _ ->
        Lwt.wakeup_later_exn wakener (Failure "file_read_error") )
  in
  Js.Unsafe.set reader "onload" (Js.Unsafe.inject on_success) ;
  Js.Unsafe.set reader "onerror" (Js.Unsafe.inject on_error) ;
  ignore
    (Js.Unsafe.meth_call reader "readAsDataURL" [|Js.Unsafe.inject file|]) ;
  waiter

let base64_from_data_url data_url =
  match String.split_on_char ',' data_url with
  | _ :: rest -> String.concat "," rest
  | [] -> data_url

let parse_languages raw_value =
  raw_value |> String.split_on_char ',' |> List.map String.trim
  |> List.filter (fun value -> value <> "")

let submit_problem_modal ~mode ~default_time_limit_ms
    ~default_memory_limit_mb () =
  let code = get_input_value problem_code_input_id |> String.trim in
  let title = get_input_value problem_title_input_id |> String.trim in
  let open_at =
    get_input_value problem_open_at_input_id |> datetime_local_to_api_value
  in
  let close_at =
    get_input_value problem_close_at_input_id |> datetime_local_to_api_value
  in
  let time_limit_ms =
    get_input_value problem_time_limit_input_id
    |> int_of_string_opt
    |> Option.value ~default:default_time_limit_ms
  in
  let memory_limit_mb =
    get_input_value problem_memory_limit_input_id
    |> int_of_string_opt
    |> Option.value ~default:default_memory_limit_mb
  in
  let languages =
    get_input_value problem_languages_input_id |> parse_languages
  in
  let description = get_textarea_value problem_description_input_id in
  let input_spec = get_textarea_value problem_input_spec_input_id in
  let output_spec = get_textarea_value problem_output_spec_input_id in
  let is_force_closed = get_checkbox_value problem_force_closed_input_id in
  let is_draft = get_checkbox_value problem_draft_input_id in
  let is_submission_disabled =
    get_checkbox_value problem_submission_disabled_input_id
  in
  if code = "" || title = "" then (
    error_msg :=
      Some
        (Printf.sprintf "%s and %s are required"
           (I18n.t "problems_code_label")
           (I18n.t "problems_title_label") ) ;
    Helpers.trigger_render () ;
    Lwt.return_unit )
  else
    match !state.contest_id with
    | None ->
        error_msg := Some (I18n.t "problems_no_contest") ;
        Helpers.trigger_render () ;
        Lwt.return_unit
    | Some contest_id ->
        let save_request =
          match mode with
          | Create _ ->
              let body =
                Api.Openapi.ProblemCreateRequest.create ~code ~title
                  ~description ~input_spec ~output_spec ~languages
                  ~time_limit_ms ~memory_limit_mb ~source_artifacts:[]
                  ~is_submission_disabled ~is_draft ()
                |> Api.Openapi.ProblemCreateRequest.to_json
              in
              Api.Helpers.post_problem contest_id body
          | Edit problem -> (
            match problem.id with
            | None -> Lwt.return (`Null, 400)
            | Some problem_id ->
                let body =
                  Api.Openapi.ProblemUpdateRequest.create ~code ~title
                    ~description ~input_spec ~output_spec ~languages ?open_at
                    ?close_at ~time_limit_ms ~memory_limit_mb
                    ~is_force_closed ~is_submission_disabled ~is_draft ()
                  |> Api.Openapi.ProblemUpdateRequest.to_json
                in
                Api.Helpers.put_problem problem_id body )
          | None_ -> Lwt.return (`Null, 400)
        in
        save_request
        >>= fun (_resp, status) ->
        if status = 200 || status = 201 || status = 204 then (
          error_msg := None ;
          Settings_problems_import.RerenderFlag.set_rerender () ;
          close_problem_modal () ;
          Lwt.return_unit )
        else (
          error_msg :=
            Some (Printf.sprintf "Failed to save problem: HTTP %d" status) ;
          Helpers.trigger_render () ;
          Lwt.return_unit )

let make_problem_modal () =
  match !edit_mode with
  | None_ -> div []
  | mode ->
      let is_create = match mode with Create _ -> true | _ -> false in
      let title = if is_create then "Add Problem" else "Edit Problem" in
      let ( code
          , title_t
          , time_limit_ms
          , memory_limit_mb
          , open_at
          , close_at
          , description
          , input_spec
          , output_spec
          , languages
          , is_force_closed
          , is_draft
          , is_submission_disabled ) =
        match mode with
        | Create p | Edit p ->
            ( p.code
            , p.title
            , p.time_limit_ms
            , p.memory_limit_mb
            , Option.value ~default:"" p.open_at
            , Option.value ~default:"" p.close_at
            , p.description
            , p.input_spec
            , p.output_spec
            , String.concat ", " p.languages
            , Option.value ~default:false p.is_force_closed
            , Option.value ~default:false p.is_draft
            , Option.value ~default:false p.is_submission_disabled )
        | None_ -> ("", "", 0, 0, "", "", "", "", "", "", false, false, false)
      in
      div
        ~a:[a_id problem_modal_id]
        [ (* Backdrop *)
          div ~a:[a_class ["modal-backdrop"; "fade"; "show"]] []
        ; (* Modal dialog *)
          div
            ~a:
              [ a_class ["modal"; "fade"; "show"]
              ; a_style "display:block; z-index:1050;" ]
            [ div
                ~a:[a_class ["modal-dialog"; "modal-xl"]]
                [ div
                    ~a:[a_class ["modal-content"]]
                    [ (* Header *)
                      div
                        ~a:[a_class ["modal-header"]]
                        [ h5 ~a:[a_class ["modal-title"]] [txt title]
                        ; button
                            ~a:
                              [ a_class ["btn-close"]
                              ; a_onclick (fun _ ->
                                    close_problem_modal () ; false ) ]
                            [] ]
                    ; (* Body *)
                      div
                        ~a:[a_class ["modal-body"]]
                        [ div
                            ~a:[a_class ["row"; "g-3"]]
                            [ (* Code + Title row *)
                              div
                                ~a:[a_class ["col-md-4"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [ txt
                                        (I18n.t "problems_code_label" ^ " *")
                                    ]
                                ; input
                                    ~a:
                                      [ a_id problem_code_input_id
                                      ; a_class ["form-control"]
                                      ; a_placeholder "A01"
                                      ; a_value code ]
                                    () ]
                            ; div
                                ~a:[a_class ["col-md-8"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [ txt
                                        (I18n.t "problems_title_label" ^ " *")
                                    ]
                                ; input
                                    ~a:
                                      [ a_id problem_title_input_id
                                      ; a_class ["form-control"]
                                      ; a_placeholder "Add Two Numbers"
                                      ; a_value title_t ]
                                    () ]
                            ; ( if is_create then div []
                                else
                                  div
                                    ~a:[a_class ["col-12"]]
                                    [ div
                                        ~a:[a_class ["row"; "g-3"]]
                                        [ div
                                            ~a:[a_class ["col-md-6"]]
                                            [ label
                                                ~a:[a_class ["form-label"]]
                                                [txt "Begin date and time"]
                                            ; input
                                                ~a:
                                                  [ a_id
                                                      problem_open_at_input_id
                                                  ; a_class ["form-control"]
                                                  ; Unsafe.string_attrib
                                                      "type" "datetime-local"
                                                  ; a_value
                                                      (datetime_local_input_value_of_string
                                                         open_at ) ]
                                                () ]
                                        ; div
                                            ~a:[a_class ["col-md-6"]]
                                            [ label
                                                ~a:[a_class ["form-label"]]
                                                [txt "End date and time"]
                                            ; input
                                                ~a:
                                                  [ a_id
                                                      problem_close_at_input_id
                                                  ; a_class ["form-control"]
                                                  ; Unsafe.string_attrib
                                                      "type" "datetime-local"
                                                  ; a_value
                                                      (datetime_local_input_value_of_string
                                                         close_at ) ]
                                                () ] ] ] )
                            ; (* Limits row *)
                              div
                                ~a:[a_class ["col-md-6"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [ txt
                                        ( I18n.t "problem_time_limit"
                                        ^ " (ms)" ) ]
                                ; input
                                    ~a:
                                      [ a_id problem_time_limit_input_id
                                      ; a_class ["form-control"]
                                      ; a_input_type `Number
                                      ; a_value (string_of_int time_limit_ms)
                                      ; a_input_min (`Number 10) ]
                                    () ]
                            ; div
                                ~a:[a_class ["col-md-6"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [ txt
                                        ( I18n.t "problem_memory_limit"
                                        ^ " (MB)" ) ]
                                ; input
                                    ~a:
                                      [ a_id problem_memory_limit_input_id
                                      ; a_class ["form-control"]
                                      ; a_input_type `Number
                                      ; a_value
                                          (string_of_int memory_limit_mb)
                                      ; a_input_min (`Number 16) ]
                                    () ]
                            ; (* Languages *)
                              div
                                ~a:[a_class ["col-12"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [txt (I18n.t "problems_languages_label")]
                                ; input
                                    ~a:
                                      [ a_id problem_languages_input_id
                                      ; a_class ["form-control"]
                                      ; a_placeholder "python, java, cpp"
                                      ; a_value languages ]
                                    () ]
                            ; (* Draft *)
                              div
                                ~a:[a_class ["col-12"]]
                                [ div
                                    ~a:[a_class ["form-check"; "form-switch"]]
                                    [ input
                                        ~a:
                                          ( [ a_id problem_draft_input_id
                                            ; a_input_type `Checkbox
                                            ; a_class ["form-check-input"] ]
                                          @
                                          if is_draft then [a_checked ()]
                                          else [] )
                                        ()
                                    ; label
                                        ~a:
                                          [ a_class ["form-check-label"]
                                          ; a_label_for
                                              problem_draft_input_id ]
                                        [txt "Draft"] ] ]
                            ; (* Disable submissions *)
                              div
                                ~a:[a_class ["col-12"]]
                                [ div
                                    ~a:[a_class ["form-check"; "form-switch"]]
                                    [ input
                                        ~a:
                                          ( [ a_id
                                                problem_submission_disabled_input_id
                                            ; a_input_type `Checkbox
                                            ; a_class ["form-check-input"] ]
                                          @
                                          if is_submission_disabled then
                                            [a_checked ()]
                                          else [] )
                                        ()
                                    ; label
                                        ~a:
                                          [ a_class ["form-check-label"]
                                          ; a_label_for
                                              problem_submission_disabled_input_id
                                          ]
                                        [ txt
                                            (I18n.t
                                               "problems_disable_submissions_label" )
                                        ] ] ]
                            ; (* Force closed *)
                              div
                                ~a:[a_class ["col-12"]]
                                [ (let force_closed_attrs =
                                     [ a_id problem_force_closed_input_id
                                     ; a_input_type `Checkbox
                                     ; a_class ["form-check-input"] ]
                                     @
                                     if is_force_closed then [a_checked ()]
                                     else []
                                   in
                                   div
                                     ~a:
                                       [a_class ["form-check"; "form-switch"]]
                                     [ input ~a:force_closed_attrs ()
                                     ; label
                                         ~a:[a_class ["form-check-label"]]
                                         [ txt
                                             (I18n.t
                                                "problems_force_closed_label" )
                                         ] ] ) ]
                            ; (* Description *)
                              div
                                ~a:[a_class ["col-12"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [ txt
                                        (I18n.t "problems_description_label")
                                    ]
                                ; textarea
                                    ~a:
                                      [ a_id problem_description_input_id
                                      ; a_class ["form-control"]
                                      ; a_rows 10
                                      ; a_placeholder
                                          "Problem description..."
                                        (*; a_value description*) ]
                                    (txt description) ]
                            ; (* Input spec *)
                              div
                                ~a:[a_class ["col-12"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [txt "Input Specification"]
                                ; textarea
                                    ~a:
                                      [ a_id problem_input_spec_input_id
                                      ; a_class ["form-control"]
                                      ; a_rows 3
                                      ; a_placeholder
                                          "Describe the input format..."
                                        (*; a_value input_spec *) ]
                                    (txt input_spec) ]
                            ; (* Output spec *)
                              div
                                ~a:[a_class ["col-12"]]
                                [ label
                                    ~a:[a_class ["form-label"]]
                                    [txt "Output Specification"]
                                ; textarea
                                    ~a:
                                      [ a_id problem_output_spec_input_id
                                      ; a_class ["form-control"]
                                      ; a_rows 3
                                      ; a_placeholder
                                          "Describe the expected output..."
                                        (*; a_value output_spec *) ]
                                    (txt output_spec) ] ]
                        ; (* Footer *)
                          div
                            ~a:[a_class ["modal-footer"]]
                            [ button
                                ~a:
                                  [ a_class ["btn"; "btn-secondary"]
                                  ; a_onclick (fun _ ->
                                        close_problem_modal () ; false ) ]
                                [txt "Cancel"]
                            ; button
                                ~a:
                                  [ a_class ["btn"; "btn-primary"]
                                  ; a_onclick (fun _ ->
                                        Lwt.async
                                          (submit_problem_modal ~mode
                                             ~default_time_limit_ms:
                                               time_limit_ms
                                             ~default_memory_limit_mb:
                                               memory_limit_mb ) ;
                                        false ) ]
                                [txt (if is_create then "Create" else "Save")]
                            ] ] ] ] ] ]

(* --- Problem card row --- *)

let problem_card (problem : Api.Openapi.problem) =
  let is_selected =
    match !state.selected_code with
    | Some c -> c = problem.code
    | None -> false
  in
  let cases =
    try
      Some
        (Hashtbl.find !state.testcases (Option.value ~default:0 problem.id))
    with Not_found -> None
  in
  let artifacts =
    try
      Some
        (Hashtbl.find !state.source_artifacts
           (Option.value ~default:0 problem.id) )
    with Not_found -> None
  in
  let object_artifacts =
    try
      Some
        (Hashtbl.find !state.object_artifacts
           (Option.value ~default:0 problem.id) )
    with Not_found -> None
  in
  let a_class_list =
    ["card"; "mb-2"; "border"; "border-secondary-subtle"; "problem-card"]
    @ if is_selected then ["shadow-sm"] else []
  in
  div
    ~a:[a_class a_class_list]
    [ (* Card header — always visible *)
      div
        ~a:
          [ a_class
              [ "card-header"
              ; "p-2"
              ; "d-flex"
              ; "align-items-center"
              ; "justify-content-between"
              ; "bg-light" ] ]
        [ div
            [ kbd ~a:[a_class ["me-2"]] [txt problem.code]
            ; span ~a:[a_class ["fw-bold"]] [txt problem.title] ]
        ; div
            ~a:[a_class ["d-flex"; "align-items-center"; "gap-1"; "ms-auto"]]
            [ (* Difficulty badge *)
              ( match !state.difficulty_filter with
              | Some _ -> div []
              | None -> div [] )
              (* placeholder for difficulty badge when field exists *)
            ; button
                ~a:
                  [ a_class ["btn"; "btn-sm"; "btn-outline-secondary"]
                  ; a_title "Export problem"
                  ; a_onclick (fun _ ->
                        let problem_id =
                          Option.value ~default:0 problem.id
                        in
                        Lwt.async (fun () ->
                            ( match cases with
                              | Some testcases -> Lwt.return testcases
                              | None ->
                                  load_testcases problem_id
                                  >>= fun () ->
                                  Lwt.return
                                    ( try
                                        Hashtbl.find !state.testcases
                                          problem_id
                                      with Not_found -> [] ) )
                            >>= fun testcases ->
                            ( match
                                Hashtbl.find_opt !state.source_artifacts
                                  problem_id
                              with
                              | Some artifacts -> Lwt.return artifacts
                              | None ->
                                  load_source_artifacts problem_id
                                  >>= fun () ->
                                  Lwt.return
                                    ( try
                                        Hashtbl.find !state.source_artifacts
                                          problem_id
                                      with Not_found -> [] ) )
                            >>= fun source_artifacts ->
                            Settings_problems_export.export_problem
                              ~testcases ~source_artifacts problem ;
                            Lwt.return_unit ) ;
                        false ) ]
                [Components.Icons.download_icon ()]
            ; button
                ~a:
                  [ a_class ["btn"; "btn-sm"; "btn-outline-primary"]
                  ; a_onclick (fun _ ->
                        let () =
                          state :=
                            { !state with
                              selected_code=
                                ( if is_selected then None
                                  else Some problem.code ) }
                        in
                        match !state.contest_id with
                        | Some _cid ->
                            Lwt.async (fun () ->
                                load_testcases
                                  (Option.value ~default:0 problem.id)
                                >>= fun () ->
                                load_source_artifacts
                                  (Option.value ~default:0 problem.id)
                                >>= fun () ->
                                load_object_artifacts
                                  (Option.value ~default:0 problem.id)
                                >>= fun () ->
                                Helpers.trigger_render () ; Lwt.return () ) ;
                            false
                        | None -> false ) ]
                [ Components.Icons.list_ul_icon ~a:["me-2"] ()
                ; txt
                    ( match cases with
                    | Some _ as c ->
                        Printf.sprintf "%s (%d)"
                          (I18n.t "problems_testcases_title")
                          (List.length (Option.get c))
                    | None ->
                        Printf.sprintf "%s (...)"
                          (I18n.t "problems_testcases_title") ) ] ]
        ; button
            ~a:
              [ a_class ["btn"; "btn-sm"; "btn-outline-secondary"]
              ; a_onclick (fun _ ->
                    edit_mode := Edit problem ;
                    make_problem_modal () |> Helpers.add_element_to_app ;
                    false ) ]
            [Components.Icons.pencil_icon ()]
        ; button
            ~a:
              [ a_class ["btn"; "btn-sm"; "btn-outline-danger"]
              ; a_onclick (fun _ ->
                    Console.console##log
                      (Js.string
                         (Printf.sprintf "Delete problem code: %s"
                            problem.code ) ) ;
                    let _ =
                      match !state.contest_id with
                      | Some _cid ->
                          Components.Modal_view.make "confirm-delete-problem"
                            problem.code
                            [ p
                                [ txt
                                    (Printf.sprintf
                                       "Are you sure you want to delete  \
                                        \"%s\" problem?"
                                       problem.title ) ] ]
                            (fun () ->
                              Lwt.async (fun () ->
                                  Api.Helpers.delete_problem
                                    (Option.value ~default:0 problem.id)
                                  >>= fun status ->
                                  if status = 204 then (
                                    Settings_problems_import.RerenderFlag
                                    .set_rerender () ;
                                    Helpers.trigger_render () ;
                                    Lwt.return_unit )
                                  else Lwt.return_unit ) ;
                              false )
                            ()
                          |> Helpers.add_element_to_app
                      | None -> ()
                    in
                    false ) ]
            [Components.Icons.trash_icon ()] ]
    ; (* Card body — expandable *)
      ( if is_selected then
          div
            ~a:[a_class ["card-body"; "p-3"; "border-top"]]
            [ (* Problem metadata *)
              div
                ~a:[a_class ["row"; "g-2"; "mb-3"]]
                [ div
                    ~a:[a_class ["col-md-6"]]
                    [ label
                        ~a:[a_class ["form-label"; "fw-bold"]]
                        [txt (I18n.t "problem_time_limit")]
                    ; p
                        ~a:[a_class ["form-control-static"]]
                        [txt (format_time_ms problem.time_limit_ms)] ]
                ; div
                    ~a:[a_class ["col-md-6"]]
                    [ label
                        ~a:[a_class ["form-label"; "fw-bold"]]
                        [txt (I18n.t "problem_memory_limit")]
                    ; p
                        ~a:[a_class ["form-control-static"]]
                        [txt (format_memory_mb problem.memory_limit_mb)] ] ]
            ; (* languages *)
              div
                ~a:[a_class ["col-12"]]
                [ label
                    ~a:[a_class ["form-label"; "fw-bold"]]
                    [txt (I18n.t "problems_languages_label")]
                ; p
                    ~a:[a_class ["form-control-static"]]
                    [txt (String.concat ", " problem.languages)] ]
            ; (* Description *)
              div
                ~a:[a_class ["mb-3"]]
                [ label
                    ~a:[a_class ["form-label"; "fw-bold"]]
                    [txt (I18n.t "problem_description")]
                ; pre
                    ~a:
                      [ a_class
                          [ "bg-light"
                          ; "p-3"
                          ; "rounded"
                          ; "font-monospace"
                          ; "border" ]
                      ; a_style "white-space: pre-wrap;" ]
                    [code [txt problem.description]] ]
            ; (* Test cases *)
              div
                (let testcase_actions =
                   div
                     ~a:[a_class ["d-flex"; "gap-2"; "mb-2"]]
                     [ button
                         ~a:
                           [ a_class ["btn"; "btn-sm"; "btn-primary"]
                           ; a_onclick (fun _ ->
                                 ( match (problem.id, !state.contest_id) with
                                 | Some problem_id, Some _contest_id ->
                                     open_testcase_modal ~problem_id
                                       ~testcase:None
                                 | _ -> () ) ;
                                 false ) ]
                         [ Components.Icons.plus_lg_icon ~a:["me-2"] ()
                         ; txt (I18n.t "problems_add_testcase") ]
                     ; (let input_id =
                          Printf.sprintf "testcase-directory-input-%d"
                            (Option.value ~default:0 problem.id)
                        in
                        div
                          [ input
                              ~a:
                                [ a_id input_id
                                ; a_input_type `File
                                ; a_class ["d-none"]
                                ; Unsafe.string_attrib "webkitdirectory"
                                    "true"
                                ; Unsafe.string_attrib "directory" "true"
                                ; a_onchange (fun _ ->
                                      let input =
                                        Dom_html.CoerceTo.input
                                          (Dom_html.getElementById input_id)
                                      in
                                      match Js.Opt.to_option input with
                                      | None -> false
                                      | Some element -> (
                                        match
                                          Js.Opt.to_option element##.files
                                        with
                                        | None -> false
                                        | Some files ->
                                            ( match problem.id with
                                            | Some problem_id ->
                                                Settings_problems_import
                                                .import_testcases_from_directory
                                                  problem_id files
                                            | None -> () ) ;
                                            false ) ) ]
                              ()
                          ; button
                              ~a:
                                [ a_class
                                    ["btn"; "btn-sm"; "btn-outline-primary"]
                                ; a_onclick (fun _ ->
                                      let input =
                                        Dom_html.CoerceTo.input
                                          (Dom_html.getElementById input_id)
                                      in
                                      ( match Js.Opt.to_option input with
                                      | Some element ->
                                          ignore
                                            (Js.Unsafe.set element
                                               "webkitdirectory"
                                               (Js.Unsafe.inject Js._true) ) ;
                                          ignore
                                            (Js.Unsafe.set element
                                               "directory"
                                               (Js.Unsafe.inject Js._true) ) ;
                                          element##click
                                      | None -> () ) ;
                                      false ) ]
                              [ Components.Icons.folder_upload_icon ()
                              ; txt "Import tests" ] ] ) ]
                 in
                 [ label
                     ~a:[a_class ["form-label"; "fw-bold"]]
                     [txt "Test Cases"]
                 ; testcase_actions
                 ; ( match cases with
                   | Some [] ->
                       p
                         ~a:[a_class ["text-muted"]]
                         [txt "No test cases defined"]
                   | Some tcases ->
                       let test_case_rows =
                         List.mapi
                           (fun idx (tc : Api.Openapi.testCase) ->
                             div
                               ~a:
                                 [ a_class
                                     ["mb-3"; "border"; "rounded"; "p-3"] ]
                               [ div
                                   ~a:
                                     [ a_class
                                         [ "d-flex"
                                         ; "align-items-center"
                                         ; "justify-content-between"
                                         ; "mb-2" ] ]
                                   [ span
                                       [ kbd
                                           [ txt
                                               (Printf.sprintf "Test Case %d"
                                                  (idx + 1) ) ]
                                       ; ( if tc.is_sample then
                                             span
                                               ~a:
                                                 [ a_class
                                                     [ "badge"
                                                     ; "bg-info"
                                                     ; "ms-2" ] ]
                                               [txt "Sample"]
                                           else span [] ) ]
                                   ; (* edit button *)
                                     button
                                       ~a:
                                         [ a_class
                                             [ "btn"
                                             ; "btn-sm"
                                             ; "btn-outline-secondary"
                                             ; "me-1"
                                             ; "ms-auto" ]
                                         ; a_onclick (fun _ ->
                                               Console.console##log
                                                 (Js.string
                                                    (Printf.sprintf
                                                       "Edit testcase: %d"
                                                       tc.id ) ) ;
                                               open_testcase_modal
                                                 ~problem_id:
                                                   (Option.value ~default:0
                                                      problem.id )
                                                 ~testcase:(Some tc) ;
                                               false ) ]
                                       [Components.Icons.pencil_icon ()]
                                   ; button
                                       ~a:
                                         [ a_class
                                             [ "btn"
                                             ; "btn-sm"
                                             ; "btn-outline-danger" ]
                                         ; a_onclick (fun _ ->
                                               Console.console##log
                                                 (Js.string
                                                    (Printf.sprintf
                                                       "Delete testcase: %d"
                                                       tc.id ) ) ;
                                               Lwt.async (fun () ->
                                                   Api.Helpers
                                                   .delete_testcase tc.id
                                                   >>= fun status ->
                                                   if status = 204 then (
                                                     Settings_problems_import
                                                     .RerenderFlag
                                                     .set_rerender () ;
                                                     refresh_testcases
                                                       (Option.value
                                                          ~default:0
                                                          problem.id ) )
                                                   else Lwt.return_unit ) ;
                                               false ) ]
                                       [Components.Icons.trash_icon ()] ]
                               ; label
                                   ~a:[a_class ["form-label"]]
                                   [txt "Input"]
                               ; pre
                                   ~a:
                                     [ a_class
                                         [ "bg-light"
                                         ; "p-2"
                                         ; "rounded"
                                         ; "font-monospace" ] ]
                                   [txt tc.input]
                               ; ( match tc.oracle with
                                 | None -> div []
                                 | Some oracle ->
                                     div
                                       ~a:
                                         [ a_class
                                             ["mt-2"; "small"; "text-muted"]
                                         ]
                                       [ txt
                                           (Printf.sprintf "Oracle: %s%s"
                                              oracle.entrypoint
                                              ( match oracle.args with
                                              | None -> ""
                                              | Some args ->
                                                  " ("
                                                  ^ String.concat ", " args
                                                  ^ ")" ) ) ] )
                               ; label
                                   ~a:[a_class ["form-label"; "mt-2"]]
                                   [txt "Output"]
                               ; pre
                                   ~a:
                                     [ a_class
                                         [ "bg-light"
                                         ; "p-2"
                                         ; "rounded"
                                         ; "font-monospace" ] ]
                                   [txt tc.output] ] )
                           tcases
                       in
                       div
                         [ div
                             ~a:[a_class ["row"]]
                             (List.mapi
                                (fun i row ->
                                  div
                                    ~a:
                                      [ a_class
                                          [ ( if i mod 2 = 0 then "col-md-6"
                                              else "" ) ] ]
                                    [row] )
                                test_case_rows ) ]
                   | None -> p ~a:[a_class ["text-muted"]] [txt "Loading..."]
                   ) ] )
            ; (* Source artifacts *)
              div
                [ label
                    ~a:[a_class ["form-label"; "fw-bold"]]
                    [txt "Source Artifacts"]
                ; ( match artifacts with
                  | Some [] ->
                      p
                        ~a:[a_class ["text-muted"]]
                        [txt "No source artifacts defined"]
                  | Some arts ->
                      let artifact_rows =
                        List.map
                          (fun (art : Api.Openapi.sourceArtifact) ->
                            div
                              ~a:
                                [ a_class
                                    [ "d-flex"
                                    ; "justify-content-between"
                                    ; "align-items-center"
                                    ; "mb-2"
                                    ; "border"
                                    ; "rounded"
                                    ; "p-3" ] ]
                              [ div
                                  ~a:[a_class ["flex-grow-1"]]
                                  [ span
                                      ~a:[a_class ["fw-bold"]]
                                      [txt art.filename]
                                  ; br ()
                                  ; small
                                      ~a:[a_class ["text-muted"]]
                                      [ txt
                                          ( "Size: "
                                          ^ string_of_int
                                              (String.length art.content)
                                          ^ " bytes" ) ] ]
                              ; div
                                  ~a:[a_class ["d-flex"; "gap-1"]]
                                  [ button
                                      ~a:
                                        [ a_class
                                            [ "btn"
                                            ; "btn-sm"
                                            ; "btn-outline-secondary" ]
                                        ; a_onclick (fun _ ->
                                              Console.console##log
                                                (Js.string
                                                   (Printf.sprintf
                                                      "Edit artifact: %s"
                                                      art.filename ) ) ;
                                              false ) ]
                                      [Components.Icons.pencil_icon ()]
                                  ; button
                                      ~a:
                                        [ a_class
                                            [ "btn"
                                            ; "btn-sm"
                                            ; "btn-outline-danger" ]
                                        ; a_onclick (fun _ ->
                                              Console.console##log
                                                (Js.string
                                                   (Printf.sprintf
                                                      "Delete artifact: %s"
                                                      art.filename ) ) ;
                                              false ) ]
                                      [Components.Icons.trash_icon ()] ] ] )
                          arts
                      in
                      div artifact_rows
                  | None -> p ~a:[a_class ["text-muted"]] [txt "Loading..."]
                  ) ]
            ; div
                [ label
                    ~a:[a_class ["form-label"; "fw-bold"; "mt-3"]]
                    [txt "Object Artifacts"]
                ; (let upload_input_id =
                     object_artifact_input_id
                       (Option.value ~default:0 problem.id)
                   in
                   let on_upload_click () =
                     match
                       Dom_html.getElementById_coerce upload_input_id
                         Dom_html.CoerceTo.input
                     with
                     | Some element -> (
                       match Js.Opt.to_option element##.files with
                       | Some files when files##.length > 0 ->
                           let file =
                             Js.Opt.get
                               (files##item 0)
                               (fun () -> raise Not_found)
                           in
                           let file_name = Js.to_string file##.name in
                           Lwt.async (fun () ->
                               read_file_as_data_url file
                               >>= fun data_url ->
                               let content = base64_from_data_url data_url in
                               let artifact =
                                 Api.Openapi.ObjectArtifact.create
                                   ~filename:file_name ~content
                                   ~size:(String.length content) ()
                               in
                               let body =
                                 Api.Openapi.ProblemUpdateRequest.create
                                   ~object_artifacts:[artifact] ()
                                 |> Api.Openapi.ProblemUpdateRequest.to_json
                               in
                               Api.Helpers.put_problem
                                 (Option.value ~default:0 problem.id)
                                 body
                               >>= fun (_resp, status) ->
                               if
                                 status = 200 || status = 201 || status = 204
                               then (
                                 let existing =
                                   match object_artifacts with
                                   | Some arts -> arts
                                   | None -> []
                                 in
                                 Hashtbl.replace !state.object_artifacts
                                   (Option.value ~default:0 problem.id)
                                   (existing @ [artifact]) ;
                                 Helpers.trigger_render () ;
                                 Lwt.return_unit )
                               else Lwt.return_unit ) ;
                           element##.value := Js.string "" ;
                           false
                       | _ -> false )
                     | None -> false
                   in
                   div
                     ~a:[a_class ["d-flex"; "gap-2"; "align-items-center"]]
                     [ input
                         ~a:
                           [ a_id upload_input_id
                           ; a_input_type `File
                           ; a_class ["form-control"; "w-auto"] ]
                         ()
                     ; button
                         ~a:
                           [ a_class ["btn"; "btn-sm"; "btn-primary"]
                           ; a_onclick (fun _ -> on_upload_click ()) ]
                         [txt "Upload object artifact"] ] )
                ; ( match object_artifacts with
                  | Some [] ->
                      p
                        ~a:[a_class ["text-muted"]]
                        [txt "No object artifacts defined"]
                  | Some arts ->
                      let object_rows =
                        List.map
                          (fun (art : Api.Openapi.objectArtifact) ->
                            div
                              ~a:
                                [ a_class
                                    [ "d-flex"
                                    ; "justify-content-between"
                                    ; "align-items-center"
                                    ; "mb-2"
                                    ; "border"
                                    ; "rounded"
                                    ; "p-3" ] ]
                              [ div
                                  ~a:[a_class ["flex-grow-1"]]
                                  [ span
                                      ~a:[a_class ["fw-bold"]]
                                      [txt art.filename]
                                  ; br ()
                                  ; small
                                      ~a:[a_class ["text-muted"]]
                                      [ txt
                                          ( "Size: "
                                          ^ string_of_int
                                              (Option.value art.size
                                                 ~default:
                                                   (String.length art.content) )
                                          ^ " bytes" ) ] ]
                              ; div
                                  ~a:[a_class ["d-flex"; "gap-1"]]
                                  [ button
                                      ~a:
                                        [ a_class
                                            [ "btn"
                                            ; "btn-sm"
                                            ; "btn-outline-secondary" ]
                                        ; a_onclick (fun _ ->
                                              Console.console##log
                                                (Js.string
                                                   (Printf.sprintf
                                                      "View object \
                                                       artifact: %s"
                                                      art.filename ) ) ;
                                              false ) ]
                                      [Components.Icons.list_ul_icon ()]
                                  ; button
                                      ~a:
                                        [ a_class
                                            [ "btn"
                                            ; "btn-sm"
                                            ; "btn-outline-danger" ]
                                        ; a_onclick (fun _ ->
                                              Console.console##log
                                                (Js.string
                                                   (Printf.sprintf
                                                      "Delete object \
                                                       artifact: %s"
                                                      art.filename ) ) ;
                                              false ) ]
                                      [Components.Icons.trash_icon ()] ] ] )
                          arts
                      in
                      div object_rows
                  | None -> p ~a:[a_class ["text-muted"]] [txt "Loading..."]
                  ) ] ]
        else div [] ) ]

(* --- Main render --- *)

let render_problems_tab () =
  let cid =
    match !current_contest_select with
    | Some id -> id
    | None -> Helpers.get_current_contest_id ()
  in
  Lwt.async (fun () ->
      Api.Helpers.get_contests ()
      >>= fun (contests, status) ->
      if status <> 200 then (
        Console.console##log
          (Js.string (Printf.sprintf "Failed to fetch contests: %d" status)) ;
        Lwt.return_unit )
      else
        let _ =
          contest_options
            (Api.Openapi.ContestsGetResponse2.of_yojson contests)
            (Some cid)
        in
        Lwt.return_unit ) ;
  if
    !last_loaded <> Some cid
    || Settings_problems_import.RerenderFlag.need_rerender ()
  then begin
    Settings_problems_import.RerenderFlag.unset_rerender () ;
    last_loaded := Some cid ;
    Lwt.async (fun () ->
        load_problems cid
        >>= fun () ->
        match !state.selected_code with
        | Some code -> (
          match
            List.find_opt
              (fun (p : Api.Openapi.problem) -> p.code = code)
              !state.problems
          with
          | Some p ->
              load_testcases (Option.value ~default:0 p.id)
              >>= fun () ->
              load_object_artifacts (Option.value ~default:0 p.id)
          | None -> Lwt.return_unit )
        | None -> Lwt.return_unit )
  end ;
  (* Problem list area *)
  let problem_list () =
    let filtered_problems =
      List.filter
        (fun (p : Api.Openapi.problem) ->
          let match_search =
            match !state.search with
            | "" -> true
            | s ->
                Astring.String.is_infix
                  ~affix:(String.lowercase_ascii s)
                  (String.lowercase_ascii p.code)
                || Astring.String.is_infix
                     ~affix:(String.lowercase_ascii s)
                     (String.lowercase_ascii p.title)
          in
          let match_difficulty =
            match !state.difficulty_filter with
            | None -> true
            | _ -> true (* TODO: filter by difficulty field *)
          in
          match_search && match_difficulty )
        !state.problems
    in
    div
      ~a:[a_class ["d-flex"; "flex-column"]]
      ( if List.length filtered_problems = 0 then
          [ div
              ~a:[a_class ["text-center"; "py-5"; "text-muted"]]
              [Components.Icons.inbox_icon (); p [txt "No problems found"]]
          ]
        else List.map problem_card filtered_problems )
  in
  (* Search bar *)
  let search_bar () =
    div
      ~a:[a_class ["d-flex"; "gap-2"; "mb-3"]]
      [ div
          ~a:[a_class ["position-relative"; "flex-grow-1"]]
          [ input
              ~a:
                [ a_class ["form-control"; "ps-5"]
                ; a_placeholder (I18n.t "problems_search_placeholder")
                ; a_input_type `Text ]
              ()
          ; span
              ~a:
                [ a_class
                    [ "position-absolute"
                    ; "top-50"
                    ; "translate-middle-y"
                    ; "ms-3"
                    ; "text-muted" ] ]
              [Components.Icons.search_icon ()] ]
      ; button
          ~a:
            [ a_class ["btn"; "btn-primary"]
            ; a_onclick (fun _ ->
                  edit_mode :=
                    Create
                      { id= None
                      ; code= ""
                      ; title= ""
                      ; time_limit_ms= 1000
                      ; memory_limit_mb= 256
                      ; description= ""
                      ; input_spec= ""
                      ; output_spec= ""
                      ; open_at= None
                      ; close_at= None
                      ; is_force_closed= Some false
                      ; is_draft= Some false
                      ; is_submission_disabled= Some false
                      ; languages= []
                      ; source_artifacts= None
                      ; object_artifacts= None } ;
                  make_problem_modal () |> Helpers.add_element_to_app ;
                  false ) ]
          [ Components.Icons.plus_lg_icon ~a:["me-2"] ()
          ; txt (I18n.t "problems_add_btn") ] ]
  in
  (* Main content *)
  section_card (I18n.t "problems_title")
    [ div
        ~a:[a_class ["mb-3"]]
        [ label
            ~a:[a_class ["form-label"]]
            [txt (I18n.t "problems_select_contest")]
        ; contest_select ]
    ; (* Import card *)
      Settings_problems_import.render_import_card cid ()
    ; search_bar ()
    ; ( match !error_msg with
      | Some e -> div ~a:[a_class ["alert"; "alert-danger"]] [txt e]
      | None -> div [] )
    ; ( if !loading then
          div
            ~a:[a_class ["text-center"; "py-3"]]
            [Components.Icons.arrow_repeat_icon (); txt "Loading..."]
        else div [] )
    ; problem_list () ]
