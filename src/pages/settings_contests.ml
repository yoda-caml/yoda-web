open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Lwt.Infix

let contests : Api.Openapi.contest list ref = ref []

let loaded = ref false

let loading = ref false

let busy = ref false

let error = ref None

let notice = ref None

let editing_id = ref None

let title = ref ""

let description = ref ""

let start_time = ref ""

let end_time = ref ""

let status = ref "upcoming"

let reset_form () =
  editing_id := None ;
  title := "" ;
  description := "" ;
  start_time := "" ;
  end_time := "" ;
  status := "upcoming"

let reset_state () =
  contests := [] ;
  loaded := false ;
  loading := false ;
  busy := false ;
  error := None ;
  notice := None ;
  reset_form ()

let response_error json code =
  let detail =
    match json with
    | `Assoc fields -> (
      match List.assoc_opt "error" fields with
      | Some (`String message) -> ": " ^ message
      | _ -> "" )
    | _ -> ""
  in
  Printf.sprintf "HTTP %d%s" code detail

let load () =
  loading := true ;
  Lwt.catch
    (fun () ->
      Api.Helpers.get_contests ()
      >>= fun (json, code) ->
      loading := false ;
      loaded := true ;
      if code = 200 then (
        contests := Api.Openapi.ContestsGetResponse2.of_yojson json ;
        error := None )
      else
        error := Some ("Could not load contests: " ^ response_error json code) ;
      Helpers.trigger_render () ;
      Lwt.return_unit )
    (fun exn ->
      loading := false ;
      loaded := true ;
      error := Some ("Could not load contests: " ^ Printexc.to_string exn) ;
      Helpers.trigger_render () ;
      Lwt.return_unit )

let status_of_string = function
  | "running" -> Api.Openapi.Running
  | "finished" -> Api.Openapi.Finished
  | _ -> Api.Openapi.Upcoming

let datetime_local_value value =
  let date =
    Js.Unsafe.new_obj
      (Js.Unsafe.pure_js_expr "Date")
      [|Js.Unsafe.inject (Js.string value)|]
  in
  let part method_name =
    Js.Unsafe.meth_call date method_name [||]
    |> Js.float_of_number |> int_of_float
  in
  let timestamp =
    Js.Unsafe.meth_call date "getTime" [||] |> Js.float_of_number
  in
  if classify_float timestamp = FP_nan then ""
  else
    Printf.sprintf "%04d-%02d-%02dT%02d:%02d" (part "getFullYear")
      (part "getMonth" + 1)
      (part "getDate") (part "getHours") (part "getMinutes")

let string_of_status value =
  Api.Openapi.ContestStatus.to_json value |> Helpers.cleanup_json_string

let edit (contest : Api.Openapi.contest) =
  editing_id := Some contest.id ;
  title := contest.title ;
  description := Option.value ~default:"" contest.description ;
  start_time := datetime_local_value contest.start_time ;
  end_time :=
    datetime_local_value (Option.value ~default:"" contest.end_time) ;
  status := string_of_status contest.status ;
  error := None ;
  notice := None ;
  Helpers.trigger_render ()

let save () =
  if !busy then Lwt.return_unit
  else if
    String.trim !title = ""
    || String.trim !start_time = ""
    || String.trim !end_time = ""
  then (
    error := Some "Title, start time and end time are required." ;
    Helpers.trigger_render () ;
    Lwt.return_unit )
  else
    let start = Settings_problems.datetime_local_to_api_value !start_time in
    let finish = Settings_problems.datetime_local_to_api_value !end_time in
    match (start, finish) with
    | Some start, Some finish when start < finish ->
        busy := true ;
        error := None ;
        notice := None ;
        Helpers.trigger_render () ;
        let fields =
          [ ("title", `String (String.trim !title))
          ; ("description", `String (String.trim !description))
          ; ("start_time", `String start)
          ; ("end_time", `String finish)
          ; ( "status"
            , Api.Openapi.ContestCreateRequestStatus.to_yojson
                (status_of_string !status) ) ]
        in
        let body = Yojson.Safe.to_string (`Assoc fields) in
        let request =
          match !editing_id with
          | None -> Api.Helpers.post_contest body
          | Some id -> Api.Helpers.put_contest id body
        in
        Lwt.catch
          (fun () ->
            request
            >>= fun (json, code) ->
            busy := false ;
            if code = 200 || code = 201 || code = 204 then (
              notice :=
                Some
                  ( if !editing_id = None then "Contest created."
                    else "Contest updated." ) ;
              reset_form () ;
              load ()
              >>= fun () -> Helpers.trigger_render () ; Lwt.return_unit )
            else (
              error :=
                Some ("Could not save contest: " ^ response_error json code) ;
              Helpers.trigger_render () ;
              Lwt.return_unit ) )
          (fun exn ->
            busy := false ;
            error :=
              Some ("Could not save contest: " ^ Printexc.to_string exn) ;
            Helpers.trigger_render () ;
            Lwt.return_unit )
    | _ ->
        error := Some "Enter valid dates, with the end after the start." ;
        Helpers.trigger_render () ;
        Lwt.return_unit

let remove (contest : Api.Openapi.contest) =
  if
    !busy
    || not
         (Js.to_bool
            (Dom_html.window##confirm
               (Js.string ("Delete contest " ^ contest.title ^ "?")) ) )
  then Lwt.return_unit
  else (
    busy := true ;
    error := None ;
    notice := None ;
    Helpers.trigger_render () ;
    Lwt.catch
      (fun () ->
        Api.Helpers.delete_contest contest.id
        >>= fun code ->
        busy := false ;
        if List.mem code [200; 204] then (
          if !editing_id = Some contest.id then reset_form () ;
          notice := Some "Contest deleted." ;
          load () >>= fun () -> Helpers.trigger_render () ; Lwt.return_unit )
        else (
          error :=
            Some (Printf.sprintf "Could not delete contest: HTTP %d" code) ;
          Helpers.trigger_render () ;
          Lwt.return_unit ) )
      (fun exn ->
        busy := false ;
        error := Some ("Could not delete contest: " ^ Printexc.to_string exn) ;
        Helpers.trigger_render () ;
        Lwt.return_unit ) )

let text_field ?(date = false) ~id ~label_text ~value ~on_input () =
  div
    ~a:[a_class ["col-12"; "col-md-6"]]
    [ label ~a:[a_class ["form-label"]; a_label_for id] [txt label_text]
    ; input
        ~a:
          ( [ a_id id
            ; a_class ["form-control"]
            ; a_value !value
            ; a_oninput (fun ev ->
                  let input =
                    Js.Opt.get
                      (Dom_html.CoerceTo.input
                         (Js.Opt.get ev##.target (fun () -> assert false)) )
                      (fun () -> assert false)
                  in
                  on_input (Js.to_string input##.value) ;
                  false ) ]
          @
          if date then [Unsafe.string_attrib "type" "datetime-local"] else []
          )
        () ]

let render_tab () =
  if (not !loaded) && not !loading then ignore (load ()) ;
  let form =
    Settings_helpers.section_card
      (if !editing_id = None then "Add contest" else "Edit contest")
      [ div
          ~a:[a_class ["row"; "g-3"]]
          [ text_field ~id:"contest-title" ~label_text:"Title" ~value:title
              ~on_input:(fun v -> title := v)
              ()
          ; text_field ~id:"contest-description" ~label_text:"Description"
              ~value:description
              ~on_input:(fun v -> description := v)
              ()
          ; text_field ~date:true ~id:"contest-start"
              ~label_text:"Begin date and time" ~value:start_time
              ~on_input:(fun v -> start_time := v)
              ()
          ; text_field ~date:true ~id:"contest-end"
              ~label_text:"End date and time" ~value:end_time
              ~on_input:(fun v -> end_time := v)
              ()
          ; div
              ~a:[a_class ["col-12"; "col-md-6"]]
              [ label
                  ~a:[a_class ["form-label"]; a_label_for "contest-status"]
                  [txt "Status"]
              ; select
                  ~a:
                    [ a_id "contest-status"
                    ; a_class ["form-select"]
                    ; a_onchange (fun ev ->
                          let target =
                            Js.Opt.get
                              (Dom_html.CoerceTo.select
                                 (Js.Opt.get ev##.target (fun () ->
                                      assert false ) ) )
                              (fun () -> assert false)
                          in
                          status := Js.to_string target##.value ;
                          false ) ]
                  (Settings_helpers.select_options
                     ["upcoming"; "running"; "finished"]
                     !status ) ]
          ; div
              ~a:[a_class ["col-12"; "d-flex"; "gap-2"]]
              [ button
                  ~a:
                    ( [ a_class ["btn"; "btn-primary"]
                      ; a_onclick (fun _ ->
                            ignore (save ()) ;
                            false ) ]
                    @ if !busy then [a_disabled ()] else [] )
                  [ txt
                      ( if !editing_id = None then "Add contest"
                        else "Save changes" ) ]
              ; ( if !editing_id = None then span []
                  else
                    button
                      ~a:
                        [ a_class ["btn"; "btn-outline-secondary"]
                        ; a_onclick (fun _ ->
                              reset_form () ;
                              Helpers.trigger_render () ;
                              false ) ]
                      [txt "Cancel"] ) ] ] ]
  in
  let rows =
    List.map
      (fun (contest : Api.Openapi.contest) ->
        tr
          [ td [txt (string_of_int contest.id)]
          ; td [txt contest.title]
          ; td [txt contest.start_time]
          ; td [txt (Option.value ~default:"" contest.end_time)]
          ; td [txt (string_of_status contest.status)]
          ; td
              ~a:[a_class ["text-end"]]
              [ button
                  ~a:
                    ( [ a_class
                          ["btn"; "btn-outline-primary"; "btn-sm"; "me-2"]
                      ; a_onclick (fun _ -> edit contest ; false) ]
                    @ if !busy then [a_disabled ()] else [] )
                  [txt "Edit"]
              ; button
                  ~a:
                    ( [ a_class ["btn"; "btn-outline-danger"; "btn-sm"]
                      ; a_onclick (fun _ ->
                            ignore (remove contest) ;
                            false ) ]
                    @ if !busy then [a_disabled ()] else [] )
                  [txt "Delete"] ] ] )
      !contests
  in
  div
    [ ( match !error with
      | Some message ->
          div ~a:[a_class ["alert"; "alert-danger"]] [txt message]
      | None -> div [] )
    ; ( match !notice with
      | Some message ->
          div ~a:[a_class ["alert"; "alert-success"]] [txt message]
      | None -> div [] )
    ; form
    ; Settings_helpers.section_card (I18n.t "contests_title")
        [ button
            ~a:
              ( [ a_class ["btn"; "btn-outline-secondary"; "btn-sm"; "mb-3"]
                ; a_onclick (fun _ ->
                      ignore (load ()) ;
                      false ) ]
              @ if !loading || !busy then [a_disabled ()] else [] )
            [txt "Refresh"]
        ; ( if !loading then p [txt "Loading contests..."]
            else if !contests = [] then p [txt "No contests found."]
            else
              div
                ~a:[a_class ["table-responsive"]]
                [ table
                    ~a:[a_class ["table"; "table-striped"; "align-middle"]]
                    ( tr
                        [ th [txt "ID"]
                        ; th [txt "Title"]
                        ; th [txt "Start"]
                        ; th [txt "End"]
                        ; th [txt "Status"]
                        ; th ~a:[a_class ["text-end"]] [txt "Actions"] ]
                    :: rows ) ] ) ] ]
