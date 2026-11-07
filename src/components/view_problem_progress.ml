open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Lwt.Infix

let content ?(show_progress_only = false)
    ~(problem : (Api.Openapi.problem option, int) result Lwt.t) () =
  let problem_title = h2 ~a:[a_class ["mb-1"]] [txt ""] in
  let problem_status = span ~a:[a_class ["badge"; "bg-success"]] [txt ""] in
  let problem_timeleft = span ~a:[a_class ["font-monospace"]] [txt ""] in
  let problem_details = div ~a:[a_class ["problem-details"]] [] in
  let submissions_disabled_notice =
    div ~a:[a_class ["alert"; "alert-warning"; "mb-3"; "p-1"; "d-none"]] []
  in
  let problem_progressbar =
    div ~a:[a_class ["progress-bar"; "bg-info"]; a_style "width: 0%;"] []
  in
  Lwt.async (fun () ->
      problem
      >>= function
      | Error _ -> Lwt.return_unit
      | Ok None ->
          Dom.appendChild
            (Tyxml_js.To_dom.of_h2 problem_title)
            (Dom_html.document##createTextNode
               (Js.string (I18n.t "problem_not_found")) ) ;
          Lwt.return_unit
      | Ok (Some problem) ->
          Dom.appendChild
            (Tyxml_js.To_dom.of_h2 problem_title)
            (Dom_html.document##createTextNode
               (Js.string (problem.code ^ ". " ^ problem.title)) ) ;
          if problem.is_submission_disabled = Some true then (
            let notice_dom =
              Tyxml_js.To_dom.of_div submissions_disabled_notice
            in
            notice_dom##.classList##remove (Js.string "d-none") ;
            Dom.appendChild notice_dom
              (Dom_html.document##createTextNode
                 (Js.string
                    ("⚠️ " ^ I18n.t "problem_submissions_disabled_notice") ) )
            ) ;
          let detail label value =
            dl [dt [txt (I18n.t label)]; dd [txt value]]
          in
          let details =
            [ detail "problem_time_limit"
                (Printf.sprintf "%d ms" problem.time_limit_ms)
            ; detail "problem_memory_limit"
                (Printf.sprintf "%d MB" problem.memory_limit_mb)
            ; detail "problems_languages_label"
                ( if problem.languages = [] then "-"
                  else String.concat ", " problem.languages ) ]
          in
          List.iter
            (fun item ->
              Dom.appendChild
                (Tyxml_js.To_dom.of_div problem_details)
                (Tyxml_js.To_dom.of_dl item) )
            details ;
          let date = new%js Js.date_now in
          let now_ms = Js.float_of_number date##getTime in
          let parse_time = function
            | None -> None
            | Some timestamp -> (
                let parsed =
                  Js.Unsafe.global##.Date##parse (Js.string timestamp)
                in
                match classify_float parsed with
                | FP_nan | FP_infinite -> None
                | FP_normal | FP_subnormal | FP_zero -> Some parsed )
          in
          let open_ms = parse_time problem.open_at in
          let close_ms = parse_time problem.close_at in
          let force_closed = problem.is_force_closed = Some true in
          let upcoming =
            (not force_closed)
            && Option.fold ~none:false
                 ~some:(fun start -> now_ms < start)
                 open_ms
          in
          let closed =
            force_closed
            || Option.fold ~none:false
                 ~some:(fun finish -> now_ms >= finish)
                 close_ms
          in
          let status_text, status_class =
            if closed then
              (I18n.t "problem_progress_closed", "badge bg-secondary")
            else if upcoming then
              (I18n.t "problem_progress_upcoming", "badge bg-warning")
            else (I18n.t "problem_progress_open", "badge bg-success")
          in
          let status_dom = Tyxml_js.To_dom.of_span problem_status in
          status_dom##.className := Js.string status_class ;
          status_dom##.textContent := Js.some (Js.string status_text) ;
          let progress_pct =
            if closed then 100.
            else if upcoming then 0.
            else
              match (open_ms, close_ms) with
              | Some start, Some finish when finish > start ->
                  min 100.
                    (max 0.
                       ((now_ms -. start) /. (finish -. start) *. 100.) )
              | _ -> 0.
          in
          let time_target =
            if closed then Some now_ms
            else if upcoming then open_ms
            else close_ms
          in
          let time_left_str =
            match time_target with
            | None -> "--:--:--"
            | Some target ->
                let remaining_seconds =
                  int_of_float (max 0. (target -. now_ms) /. 1000.)
                in
                Printf.sprintf "%02d:%02d:%02d"
                  (remaining_seconds / 3600)
                  (remaining_seconds mod 3600 / 60)
                  (remaining_seconds mod 60)
          in
          let progressbar_dom = Tyxml_js.To_dom.of_div problem_progressbar in
          progressbar_dom##.style##.width
          := Js.string (Printf.sprintf "%.2f%%" progress_pct) ;
          let timeleft_dom = Tyxml_js.To_dom.of_span problem_timeleft in
          timeleft_dom##.textContent := Js.some (Js.string time_left_str) ;
          Lwt.return_unit ) ;
  let problem_overview =
    if not show_progress_only then
      [ problem_title
      ; ul
          ~a:[a_class ["list-unstyled"; "mb-3"]]
          [ li
              [ span
                  ~a:[a_class ["fw-semibold"]]
                  [txt (I18n.t "progress_status_label")]
              ; problem_status ]
          ; li
              [ span
                  ~a:[a_class ["fw-semibold"]]
                  [txt (I18n.t "progress_time_left_label")]
              ; problem_timeleft ] ]
      ; submissions_disabled_notice
      ; problem_details ]
    else
      [ div
          ~a:[a_class ["mb-1"; "small"; "text-muted"]]
          [txt (I18n.t "problem_progress_title")] ]
  in
  section
    ~a:[a_class ["panel-section"; "container"; "py-3"]]
    [ div
        ~a:[a_class ["problem-card"; "rounded"; "p-3"; "shadow-sm"]]
        ( problem_overview
        @ [ div
              ~a:[a_class ["progress"]; a_style "height: 8px;"]
              [problem_progressbar] ] ) ]
