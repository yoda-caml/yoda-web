open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Lwt.Infix

let content ?(show_progress_only = false) () =
  let contest_id = Helpers.get_current_contest_id () in
  let contest_title = h2 ~a:[a_class ["mb-1"]] [txt ""] in
  let contest_description = p ~a:[a_class ["text-muted"; "mb-3"]] [txt ""] in
  let contest_status =
    span ~a:[a_class ["badge"; "bg-success"]; a_id "contest_status"] [txt ""]
  in
  let contest_timeleft =
    span ~a:[a_class ["font-monospace"]; a_id "contest_timeleft"] [txt ""]
  in
  let contest_progressbar =
    div
      ~a:
        [ a_class ["progress-bar"; "bg-info"]
        ; a_id "contest_progressbar"
        ; a_style "width: 0%;" ]
      []
  in
  Lwt.async (fun () ->
      Api.Helpers.get_contest contest_id
      >>= fun (resp, status) ->
      if status <> 200 then (
        Console.console##log
          (Js.string (Printf.sprintf "Failed to fetch contest: %d" status)) ;
        Lwt.return_unit )
      else
        (* resp is a json string *)
        let p = Api.Openapi.Contest.of_yojson resp in
        (* find the dom of contest_title and set new title *)
        Dom.appendChild
          (Tyxml_js.To_dom.of_h2 contest_title)
          (Dom_html.document##createTextNode (Js.string p.title)) ;
        (* find the dom of contest_description and set new description *)
        ( match p.description with
        | Some x ->
            Dom.appendChild
              (Tyxml_js.To_dom.of_p contest_description)
              (Dom_html.document##createTextNode (Js.string x))
        | _ -> () ) ;
        (* find the dom of contest_status and set new status *)
        Dom.appendChild
          (Tyxml_js.To_dom.of_span contest_status)
          (Dom_html.document##createTextNode
             (Js.string
                (Helpers.cleanup_json_string
                   (Api.Openapi.ContestStatus.to_json p.status) ) ) ) ;
        ( match p.status with
        | Api.Openapi.Running -> () (* already has bg-success *)
        | Api.Openapi.Upcoming ->
            let dom_span = Tyxml_js.To_dom.of_span contest_status in
            dom_span##.className := Js.string "badge bg-warning"
        | Api.Openapi.Finished ->
            let dom_span = Tyxml_js.To_dom.of_span contest_status in
            dom_span##.className := Js.string "badge bg-secondary" ) ;
        (* set the progress bar width based on the contest time *)
        let date = new%js Js.date_now in
        let now_ms = Js.float_of_number date##getTime in
        let start_ms =
          Js.Unsafe.global##.Date##parse (Js.string p.start_time)
        in
        let end_ms =
          Js.Unsafe.global##.Date##parse
            (Js.string (Option.value ~default:"" p.end_time))
        in
        let total_duration = end_ms -. start_ms in
        let elapsed = now_ms -. start_ms in
        let progress_pct =
          min 100. (max 0. (elapsed /. total_duration *. 100.))
        in
        (* calculate time left *)
        let remaining_ms = max 0. (end_ms -. now_ms) in
        let remaining_seconds = int_of_float (remaining_ms /. 1000.) in
        let hours = remaining_seconds / 3600 in
        let minutes = remaining_seconds mod 3600 / 60 in
        let seconds = remaining_seconds mod 60 in
        let time_left_str =
          Printf.sprintf "%02d:%02d:%02d" hours minutes seconds
        in
        Console.console##log
          (Js.string
             ( "Progress: "
             ^ string_of_float progress_pct
             ^ "%, Time left: " ^ time_left_str ) ) ;
        (* update progress bar width *)
        let progressbar_dom = Tyxml_js.To_dom.of_div contest_progressbar in
        progressbar_dom##.style##.width
        := Js.string (Printf.sprintf "%.2f%%" progress_pct) ;
        (* update time left span *)
        let timeleft_dom = Tyxml_js.To_dom.of_span contest_timeleft in
        timeleft_dom##.textContent := Js.some (Js.string time_left_str) ;
        Lwt.return_unit ) ;
  let contest_overview =
    if not show_progress_only then
      [ contest_title
      ; contest_description
      ; ul
          ~a:[a_class ["list-unstyled"; "mb-3"]]
          [ li
              [ span
                  ~a:[a_class ["fw-semibold"]]
                  [txt (I18n.t "progress_status_label")]
              ; contest_status ]
          ; li
              [ span
                  ~a:[a_class ["fw-semibold"]]
                  [txt (I18n.t "progress_time_left_label")]
              ; contest_timeleft ] ]
      ; div
          ~a:[a_class ["mb-1"; "small"; "text-muted"]]
          [txt (I18n.t "progress_progress_label")] ]
    else
      [ div
          ~a:[a_class ["mb-1"; "small"; "text-muted"]]
          [txt (I18n.t "progress_title")] ]
  in
  section
    ~a:[a_class ["panel-section"; "container"; "py-3"]]
    [ div
        ~a:[a_class ["contest-card"; "rounded"; "p-3"; "shadow-sm"]]
        ( contest_overview
        @ [ div
              ~a:[a_class ["progress"]; a_style "height: 8px;"]
              [contest_progressbar] ] ) ]
