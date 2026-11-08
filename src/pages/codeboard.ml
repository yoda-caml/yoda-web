open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html

(** save editor state and testbar state using a auto-save mechanism *)
let init () =
  (* Set the callback for when the editor is saved *)
  Components.Tabbar.set_on_editor_saved (fun () ->
      Components.Codebar.update_status_bar
        (I18n.t "codebar_all_changes_saved") ) ;
  (* load all state before starting the auto-save loop *)
  Components.Editor.load_state () ;
  Components.Testbar.load_state () ;
  if not (Components.Editor.is_auto_save_enabled ()) then
    Components.Codebar.update_status_bar ~no_time:true
      (I18n.t "codebar_auto_save_disabled")

let start_auto_save panel =
  let open Lwt.Infix in
  let panel_dom = Tyxml_js.To_dom.of_div panel in
  let is_connected () = Js.to_bool panel_dom##.isConnected in
  let rec save_state_loop () =
    if not (is_connected ()) then Lwt.return_unit
    else if Components.Editor.is_auto_save_enabled () then (
      Components.Codebar.show Components.Codebar.spinner ;
      Components.Codebar.update_status_bar ~no_time:true
        (I18n.t "codebar_saving") ;
      Components.Tabbar.save_active_editor_content () ;
      Components.Editor.save_state () ;
      Components.Testbar.save_state () ;
      Js_of_ocaml_lwt.Lwt_js.sleep 1.0
      >>= fun () ->
      if is_connected () then (
        Components.Codebar.update_status_bar
          (I18n.t "codebar_all_changes_saved") ;
        Components.Codebar.hide Components.Codebar.spinner ;
        Js_of_ocaml_lwt.Lwt_js.sleep 60.0 >>= fun () -> save_state_loop () )
      else Lwt.return_unit )
    else
      Js_of_ocaml_lwt.Lwt_js.sleep 1.0
      >>= fun () ->
      if is_connected () then (
        Components.Codebar.hide Components.Codebar.spinner ;
        save_state_loop () )
      else Lwt.return_unit
  in
  Lwt.async (fun () ->
      Js_of_ocaml_lwt.Lwt_js.sleep 0.0 >>= fun () -> save_state_loop () )

let render () =
  let content_short ~mobile =
    div
      ~a:
        [ a_class ["flex-grow-1"]
        ; a_style "height: 100%; min-height: 0; min-width: 0;" ]
      [ main
          ~a:
            [ a_class ["d-flex"; "flex-column"; "panel"]
            ; a_style "height: 100%; min-height: 0; min-width: 0;" ]
          [ Components.Codebar.content ~mobile ()
          ; Components.Testbar.content ()
          ; Components.Tabbar.content ()
          ; Components.Editor.content () ] ]
  in
  let content_wide =
    div
      ~a:
        [ a_class ["flex-grow-1"]
        ; a_style "height: 100%; min-height: 0; min-width: 0;" ]
      [ main
          ~a:
            [ a_class ["d-flex"; "flex-column"; "panel"]
            ; a_style "height: 100%; min-height: 0; min-width: 0;" ]
          [ Components.Codebar.content ~mobile:false ()
          ; div
              ~a:
                [ a_class ["d-flex"; "flex-grow-1"]
                ; a_style "height: 100%; min-height: 0;" ]
              [ (* LEFT: tabbar + editor *)
                div
                  ~a:
                    [ a_class ["flex-grow-1"; "d-flex"; "flex-column"]
                    ; a_style "min-height: 0; min-width: 0; width: 70%;" ]
                  [Components.Tabbar.content (); Components.Editor.content ()]
              ; (* RIGHT: testbar (only spans tabbar + editor) *)
                aside
                  ~a:
                    [ a_style
                        "width: 30%; border-left: 1px solid #ddd; \
                         background: #f8f9fa; height: 100%; overflow-y: \
                         auto;" ]
                  [Components.Testbar.content ~sidebyside:false ()] ] ] ]
  in
  let panel, page =
    match Helpers.layout () with
    | Helpers.Mobile ->
        let panel = content_short ~mobile:true in
        ( panel
        , [ div
              ~a:[a_style "width:100%;"]
              [Components.Sidebar.sidebar ~mobile:true (); panel] ] )
    | Helpers.Normal ->
        let panel = content_short ~mobile:false in
        (panel, [Components.Sidebar.sidebar ~wide:false (); panel])
    | Helpers.Wide ->
        (content_wide, [Components.Sidebar.sidebar (); content_wide])
  in
  start_auto_save panel ; page
