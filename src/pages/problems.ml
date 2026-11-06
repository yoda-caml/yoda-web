open Js_of_ocaml_tyxml
open Tyxml_js.Html

let render ?(contest_id = 1) ?(problem_id = "") () =
  let panel =
    div
      ~a:[a_class ["flex-grow-1"]]
      [ main
          ~a:[a_class ["panel"]]
          [ Components.View_problem_progress.content
              ~contest_id ~problem_id ()
          ; Components.View_problem.content ~contest_id ~problem_id () ] ]
  in
  match Helpers.layout () with
  | Helpers.Mobile ->
      [ div
          ~a:[a_style "width:100%;"]
          [Components.Sidebar.sidebar ~mobile:true (); panel] ]
  | Helpers.Normal -> [Components.Sidebar.sidebar ~wide:false (); panel]
  | Helpers.Wide -> [Components.Sidebar.sidebar (); panel]
