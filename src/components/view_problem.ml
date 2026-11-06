open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Lwt.Infix

let problem_view (problem : Api.Openapi.problem) =
  let description_html = div ~a:[a_class ["markdown-content"]] [] in
  let description_dom = Tyxml_js.To_dom.of_div description_html in
  description_dom##.innerHTML
  := Js.string (View_problem_markdown.render_markdown problem.description) ;
  View_problem_markdown.trigger_math_render description_dom ;
  section
    ~a:[a_class ["panel-section"]]
    ( [ (*h2 [txt (problem.code ^ ". " ^ problem.title)] ;*)
        h3 [txt (I18n.t "problem_description")]
      ; description_html ]
    @ ( if problem.input_spec <> "" then
          [h3 [txt (I18n.t "problem_input")]; p [txt problem.input_spec]]
        else [] )
    @
    if problem.output_spec <> "" then
      [h3 [txt (I18n.t "problem_output")]; p [txt problem.output_spec]]
    else [] )

let content ~contest_id ~problem_id () =
  let subcontainer = div ~a:[a_class ["card-header"; "p-3"]] [] in
  let container =
    section
      ~a:[a_class ["panel-section"; "container"; "py-3"]]
      [div ~a:[a_class ["card"; "shadow-sm"]] [subcontainer]]
  in
  Lwt.async (fun () ->
      Api.Helpers.get_problems contest_id
      >>= fun (resp, status) ->
      if status <> 200 then (
        Console.console##log
          (Js.string (Printf.sprintf "Failed to fetch problems: %d" status)) ;
        Lwt.return_unit )
      else
        let problems =
          Api.Openapi.ContestsContestsidProblemsGetResponse2.of_yojson resp
        in
        ( match
            List.find_opt
              (fun (p : Api.Openapi.problem) -> p.code = problem_id)
              problems
          with
        | None ->
            Dom.appendChild
              (Tyxml_js.To_dom.of_div subcontainer)
              (Tyxml_js.To_dom.of_p (p [txt (I18n.t "problem_not_found")]))
        | Some problem ->
            Option.iter Model.Problem_state.mark_problem_viewed problem.id ;
            Dom.appendChild
              (Tyxml_js.To_dom.of_div subcontainer)
              (Tyxml_js.To_dom.of_section (problem_view problem)) ) ;
        Lwt.return_unit ) ;
  container
