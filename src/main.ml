open Js_of_ocaml
open Js_of_ocaml_tyxml

let hash_of_url (url : string) =
  match Astring.String.cut ~sep:"#" url with
  | Some (_, hash_suffix) when hash_suffix <> "" -> "#" ^ hash_suffix
  | _ -> ""

let () =
  Lwt.async (fun () ->
      let open Lwt.Infix in
      Helpers.ensure_local_cache_preloaded ()
      >>= fun () ->
      Pages.Settings.init () ;
      Pages.Settings_llm.init () ;
      Pages.Codeboard.init () ;
      Blobs.init () ;
      I18n.init () ;
      (* Get the app div where the content will be rendered *)
      let app_div = Dom_html.getElementById "app" in
      (* Function to render the page based on the URL hash *)
      let render_page () =
        let scroll_y = Dom_html.window##.scrollY in
        let hash = Js.to_string Dom_html.window##.location##.hash in
        (* update title with current hash *)
        Dom_html.document##.title :=
          Js.string (hash ^ " - " ^ I18n.t "sidebar_app_name") ;
        (* Clear the app div for rendering new content *)
        app_div##.innerHTML := Js.string "" ;
        app_div##.style##.height := Js.string "100%" ;
        app_div##.classList##add (Js.string "d-flex") ;
        app_div##.classList##add (Js.string "align-items-start") ;
        (* track hash changes *)
        Pages.Settings.save_referrer () ;
        (* Determine the page to render based on hash *)
        let page =
          if not (Components.Service_status.is_available ()) then
            [Components.Service_status.render ()]
          else
            match hash with
            | "#logout" ->
                Helpers.clear_auth_state () ;
                Pages.Settings_user.reset_state () ;
                Pages.Settings_contests.reset_state () ;
                Helpers.navigate_to_with_reload "#login" ;
                []
            | "#users" -> [Pages.Users.render ()]
            | "#contests" -> Pages.Contests.render ()
            | p when Astring.String.is_prefix ~affix:"#show-problems" p ->
                Pages.Problems.render ()
            | p when Astring.String.is_prefix ~affix:"#scoreboard/" p ->
                let parts = Astring.String.cuts ~sep:"/" p in
                let contest_id = int_of_string (List.nth parts 1) in
                [Pages.Scoreboard.render ~contest_id ()]
            | "#dashboard" -> Pages.Dashboard.render ()
            | "#codeboard" ->
                List.iter
                  (fun p ->
                    Dom.appendChild app_div (Tyxml_js.To_dom.of_div p) )
                  (Pages.Codeboard.render ()) ;
                Components.Editor.apply_settings
                  (Pages.Settings.get_font_size ())
                  (Pages.Settings.get_tab_size ())
                  (Pages.Settings.get_line_wrapping ()) ;
                ignore Components.Editor.editor##refresh ;
                []
            | "#submissions" -> Pages.Submissions.render ()
            | "#judge-board" -> Pages.Judge_board.render ()
            | p when Astring.String.is_prefix ~affix:"#show-problem-" p ->
                let parts = Astring.String.cuts ~sep:"-" p in
                let problem_id = List.nth parts 2 in
                Pages.Problems.render
                  ~contest_id:(Helpers.get_current_contest_id ())
                  ~problem_id ()
            | p when Astring.String.is_prefix ~affix:"#settings" p ->
                let parts = Astring.String.cuts ~sep:"-" p in
                if List.length parts <= 1 then [Pages.Settings.render ()]
                else
                  let id = List.nth parts 1 in
                  [Pages.Settings.render ~tab:id ()]
                (* Defaults to login *)
            | _ ->
                [ Pages.Login.render
                    ~on_success:(fun () -> Helpers.navigate_after_login ())
                    () ]
          (* save last 10 previous hash *)
        in
        (* Append the divs that need to be rendered *)
        List.iter
          (fun p -> Dom.appendChild app_div (Tyxml_js.To_dom.of_div p))
          page ;
        (* Restore the scroll position so re-renders (e.g. after clicking
           cancel or submit) do not snap the viewport back to the top.
           Deferred to the next tick so it runs after editor/widgets finish
           their layout and the final page height is known *)
        if Js.to_float scroll_y > 0.0 then
          ignore
            (Js.Unsafe.fun_call
               (Js.Unsafe.js_expr "window.setTimeout")
               [| Js.Unsafe.inject
                    (Js.wrap_callback (fun () ->
                         ignore
                           (Js.Unsafe.meth_call Dom_html.window "scrollTo"
                              [| Js.Unsafe.inject 0.0
                               ; Js.Unsafe.inject (Js.to_float scroll_y) |] ) )
                    )
                ; Js.Unsafe.inject 0 |] )
      in
      (* Handle the hashchange event to respond to changes in the hash part
         of the URL *)
      Dom_html.window##.onhashchange
      := Dom.handler (fun ev ->
          let current_hash =
            Js.to_string Dom_html.window##.location##.hash
          in
          let old_hash =
            try
              Js.Unsafe.get ev (Js.string "oldURL")
              |> Js.to_string |> hash_of_url
            with _ -> ""
          in
          if
            current_hash = "#login" && old_hash <> "" && old_hash <> "#login"
            && old_hash <> "#logout"
          then (
            Helpers.remember_post_login_redirect old_hash ;
            Helpers.set_session_expired_notice () ) ;
          Console.console##log (Js.string "Hash changed") ;
          render_page () ;
          Js._false ) ;
      Dom_html.window##.onload :=
        Dom_html.handler (fun _ ->
            Console.console##log (Js.string "Page loaded") ;
            render_page () ;
            Js._false ) ;
      let queries =
        [ Dom_html.window##matchMedia (Js.string "(max-width: 767px)")
        ; Dom_html.window##matchMedia
            (Js.string "(min-width: 768px) and (max-width: 1199px)")
        ; Dom_html.window##matchMedia (Js.string "(min-width: 1200px)") ]
      in
      List.iter
        (fun media ->
          media##.onchange :=
            Dom_html.handler (fun _ -> Helpers.trigger_render () ; Js._false) )
        queries ;
      let _ =
        (* Listen for the "render" event *)
        Dom_html.addEventListener Dom_html.window (Dom.Event.make "render")
          (Dom_html.handler (fun _ ->
               Console.console##log (Js.string "Render event triggered") ;
               render_page () ;
               Js._false ) )
          Js._false
      in
      (*render_page () ;*)
      Components.Service_status.start ~on_change:render_page () ;
      Lwt.return_unit )
