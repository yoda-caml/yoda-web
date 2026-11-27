open Js_of_ocaml

let codemirror_mode_of_markdown_lang lang =
  match String.lowercase_ascii (String.trim lang) with
  | "" | "text" | "plain" | "plaintext" -> "text/plain"
  | "ocaml" | "ml" | "reason" -> "text/x-ocaml"
  | "js" | "jsx" | "javascript" | "node" -> "text/javascript"
  | "ts" | "tsx" | "typescript" -> "text/typescript"
  | "json" -> "application/json"
  | "html" | "xhtml" -> "text/html"
  | "css" -> "text/css"
  | "xml" -> "application/xml"
  | "c" -> "text/x-csrc"
  | "cpp" | "c++" | "cc" | "cxx" -> "text/x-c++src"
  | "java" -> "text/x-java"
  | "python" | "py" -> "text/x-python"
  | "ruby" | "rb" -> "text/x-ruby"
  | "shell" | "sh" | "bash" | "zsh" -> "text/x-sh"
  | "sql" -> "text/x-sql"
  | "markdown" | "md" -> "text/x-markdown"
  | "yaml" | "yml" -> "text/x-yaml"
  | "diff" | "patch" -> "text/x-diff"
  | _ -> "text/plain"

let highlight_with_codemirror ~code ~lang =
  match
    Js.Optdef.to_option (Js.Unsafe.get Js.Unsafe.global "CodeMirror")
  with
  | None -> failwith "CodeMirror not found"
  | Some code_mirror ->
      let mode =
        if String.trim lang = "" then "text/plain"
        else codemirror_mode_of_markdown_lang (String.trim lang)
      in
      let sink = Dom_html.createDiv Dom_html.document in
      sink##.className :=
        Js.string (Editor.current_codemirror_theme_class ()) ;
      ignore
        (Js.Unsafe.meth_call code_mirror "runMode"
           [| Js.Unsafe.inject (Js.string code)
            ; Js.Unsafe.inject (Js.string mode)
            ; Js.Unsafe.inject sink |] ) ;
      Js.to_string sink##.outerHTML

let render_markdown ?(allow_html = true) text =
  let cleaned = text in
  match
    Js.Optdef.to_option (Js.Unsafe.get Js.Unsafe.global "markdownit")
  with
  | None -> cleaned
  | Some markdownit_factory ->
      let highlight_callback =
        Js.wrap_callback (fun code lang ->
            let code = Js.to_string code in
            let lang = Js.to_string lang in
            Js.string
              ( try highlight_with_codemirror ~code ~lang
                with _ -> failwith "Error in highlighting" ) )
      in
      let options =
        Js.Unsafe.obj
          [| ("html", Js.Unsafe.inject (Js.bool allow_html))
           ; ("linkify", Js.Unsafe.inject (Js.bool true))
           ; ("typographer", Js.Unsafe.inject (Js.bool true))
           ; ("highlight", Js.Unsafe.inject highlight_callback) |]
      in
      let markdownit =
        Js.Unsafe.fun_call markdownit_factory [|Js.Unsafe.inject options|]
      in
      ( match
          Js.Optdef.to_option
            (Js.Unsafe.get Js.Unsafe.global "markdownitMathjax")
        with
      | None ->
          Console.console##log (Js.string "markdown-it-mathjax not found")
      | Some mathjax_factory ->
          Console.console##log (Js.string "Using markdown-it-mathjax") ;
          let mathjax_plugin = Js.Unsafe.fun_call mathjax_factory [||] in
          ignore
            (Js.Unsafe.meth_call markdownit "use"
               [|Js.Unsafe.inject mathjax_plugin|] ) ) ;
      let rendered =
        Js.Unsafe.meth_call markdownit "render"
          [|Js.Unsafe.inject (Js.string cleaned)|]
      in
      Js.to_string rendered

let trigger_math_render (root : Dom_html.element Js.t) =
  let render_graphviz_blocks () =
    match Js.Optdef.to_option (Js.Unsafe.get Js.Unsafe.global "Viz") with
    | None -> ()
    | Some viz_constructor ->
        let blocks =
          Js.Unsafe.meth_call root "querySelectorAll"
            [| Js.Unsafe.inject
                 (Js.string
                    "pre > code.language-dot, pre > code.language-graphviz" )
            |]
        in
        let length = Js.Unsafe.get blocks "length" in
        for i = 0 to length - 1 do
          let code_el =
            Js.Unsafe.meth_call blocks "item" [|Js.Unsafe.inject i|]
          in
          if Js.Optdef.test code_el then
            let dot_src =
              Js.to_string (Js.Unsafe.get code_el "textContent")
            in
            let parent = Js.Unsafe.get code_el "parentElement" in
            if Js.Optdef.test parent then
              let viz = Js.Unsafe.new_obj viz_constructor [||] in
              let promise =
                Js.Unsafe.meth_call viz "renderSVGElement"
                  [|Js.Unsafe.inject (Js.string dot_src)|]
              in
              let on_success =
                Js.wrap_callback (fun svg ->
                    (* add class to svg *)
                    ignore
                      (Js.Unsafe.meth_call svg "setAttribute"
                         [| Js.Unsafe.inject (Js.string "class")
                          ; Js.Unsafe.inject (Js.string "graphviz-svg") |] ) ;
                    ignore
                      (Js.Unsafe.meth_call parent "replaceWith"
                         [|Js.Unsafe.inject svg|] ) )
              in
              let on_failure =
                Js.wrap_callback (fun err ->
                    Js.Unsafe.meth_call Js.Unsafe.global "setTimeout"
                      [| Js.Unsafe.inject
                           (Js.wrap_callback (fun () ->
                                Js.Unsafe.fun_call
                                  (Js.Unsafe.js_expr "console.warn")
                                  [| Js.Unsafe.inject
                                       (Js.string
                                          "Failed to render Graphviz block" )
                                   ; Js.Unsafe.inject err |] ) )
                       ; Js.Unsafe.inject 0 |] )
              in
              ignore
                (Js.Unsafe.meth_call promise "then"
                   [| Js.Unsafe.inject on_success
                    ; Js.Unsafe.inject on_failure |] )
        done
  in
  render_graphviz_blocks () ;
  match Js.Optdef.to_option (Js.Unsafe.get Js.Unsafe.global "MathJax") with
  | None -> failwith "MathJax not found"
  | Some mathjax ->
      let roots = Js.array [|Js.Unsafe.inject root|] in
      if Js.Optdef.test (Js.Unsafe.get mathjax "typesetPromise") then
        ignore
          (Js.Unsafe.meth_call mathjax "typesetPromise"
             [|Js.Unsafe.inject roots|] )
      else if Js.Optdef.test (Js.Unsafe.get mathjax "typeset") then
        ignore
          (Js.Unsafe.meth_call mathjax "typeset" [|Js.Unsafe.inject roots|])
