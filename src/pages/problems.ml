open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Lwt.Infix

let render ?(contest_id = 1) ?(problem_id = "") () =
  let problem =
    Api.Helpers.get_problems contest_id
    >|= fun (resp, status) ->
    if status <> 200 then (
      Console.console##log
        (Js.string (Printf.sprintf "Failed to fetch problems: %d" status)) ;
      Error status )
    else
      let problems =
        Api.Openapi.ContestsContestsidProblemsGetResponse2.of_yojson resp
      in
      Ok
        (List.find_opt
           (fun (problem : Api.Openapi.problem) -> problem.code = problem_id)
           problems )
  in
  let panel =
    div
      ~a:[a_class ["flex-grow-1"]]
      [ main
          ~a:[a_class ["panel"]]
          [ Components.View_problem_progress.content ~problem ()
          ; Components.View_problem.content ~problem () ] ]
  in
  match Helpers.layout () with
  | Helpers.Mobile ->
      [ div
          ~a:[a_style "width:100%;"]
          [Components.Sidebar.sidebar ~mobile:true (); panel] ]
  | Helpers.Normal -> [Components.Sidebar.sidebar ~wide:false (); panel]
  | Helpers.Wide -> [Components.Sidebar.sidebar (); panel]
