open Js_of_ocaml
open Js_of_ocaml_lwt
open Lwt.Infix

type metric = string * (string -> string -> (int * float) option)

let exporting = ref false

let export_notice = ref ""

let button_id = "judge-board-export"

let button_label () =
  if !export_notice = "" then "Export CSV"
  else "Export CSV: " ^ !export_notice

let update_button () =
  match
    Dom_html.getElementById_coerce button_id Dom_html.CoerceTo.button
  with
  | None -> ()
  | Some button ->
      button##.textContent := Js.some (Js.string (button_label ())) ;
      button##.disabled := Js.bool !exporting

let request_lock = Lwt_mutex.create ()

let next_request_at = ref 0.

let now () = Js.float_of_number (new%js Js.date_now)##getTime /. 1000.

let wait_for_request ~is_current =
  Lwt_mutex.with_lock request_lock (fun () ->
      let rec wait () =
        if not (is_current ()) then Lwt.fail Lwt.Canceled
        else
          let delay = !next_request_at -. now () in
          if delay > 0. then Lwt_js.sleep (min delay 1.) >>= wait
          else (
            next_request_at := now () +. 0.05 ;
            Lwt.return_unit )
      in
      wait () )

let retry_delay header =
  let seconds =
    match header with
    | None -> 0.
    | Some value -> (
      match float_of_string_opt value with
      | Some seconds when Float.is_finite seconds -> seconds
      | _ ->
          let date = Js.Unsafe.global##.Date##parse (Js.string value) in
          let timestamp = Js.float_of_number date /. 1000. in
          if Float.is_finite timestamp then timestamp -. now () else 0. )
  in
  max 10. seconds

let csv_cell value =
  let value =
    let rec first_non_space i =
      if
        i < String.length value
        && ( value.[i] = ' '
           || value.[i] = '\t'
           || value.[i] = '\r'
           || value.[i] = '\n' )
      then first_non_space (i + 1)
      else i
    in
    let i = first_non_space 0 in
    if i < String.length value && String.contains "=+-@" value.[i] then
      "'" ^ value
    else value
  in
  "\"" ^ String.concat "\"\"" (String.split_on_char '"' value) ^ "\""

let csv ~username ~problem_code ~(metrics : metric list) submissions =
  let latest = Hashtbl.create 32 in
  let counts = Hashtbl.create 32 in
  List.iter
    (fun ((sub : Api.Openapi.submission), _) ->
      match sub.owner_id with
      | None -> ()
      | Some owner -> (
          let key = (owner, sub.problem_id) in
          Hashtbl.replace counts key
            (1 + Option.value ~default:0 (Hashtbl.find_opt counts key)) ;
          match Hashtbl.find_opt latest key with
          | Some id when id >= sub.id -> ()
          | _ -> Hashtbl.replace latest key sub.id ) )
    submissions ;
  let previous = Hashtbl.create 32 in
  let rows = ref [] in
  let add_row sub filename distances attempts =
    let user =
      match sub.Api.Openapi.owner_id with
      | None -> "Username unavailable (owner unknown)"
      | Some id -> username id
    in
    let values =
      [user; string_of_int sub.id; filename; problem_code sub.problem_id]
      @ distances
      @ [sub.status; string_of_int attempts]
    in
    rows := String.concat "," (List.map csv_cell values) :: !rows
  in
  submissions
  |> List.sort (fun ((a : Api.Openapi.submission), _) (b, _) ->
      Int.compare a.id b.id )
  |> List.iter (fun ((sub : Api.Openapi.submission), sources) ->
      let is_latest, attempts =
        match sub.owner_id with
        | None -> (true, 1)
        | Some owner ->
            let key = (owner, sub.problem_id) in
            (Hashtbl.find latest key = sub.id, Hashtbl.find counts key)
      in
      if is_latest && sources = [] then
        add_row sub "" (List.map (fun _ -> "") metrics) attempts ;
      List.iter
        (fun (source : Api.Openapi.sourceArtifact) ->
          let key = (sub.owner_id, sub.problem_id, source.filename) in
          let prior =
            match sub.owner_id with
            | None -> None
            | Some _ -> Hashtbl.find_opt previous key
          in
          ( if is_latest then
              let distances =
                List.map
                  (fun (_, calculate) ->
                    match
                      Option.bind prior (fun content ->
                          calculate content source.content )
                    with
                    | Some (distance, _) -> string_of_int distance
                    | None -> "" )
                  metrics
              in
              add_row sub source.filename distances attempts ) ;
          if sub.owner_id <> None then
            Hashtbl.replace previous key source.content )
        sources ) ;
  let header =
    ["User"; "Submission"; "Filename"; "Problem"]
    @ List.map fst metrics
    @ ["Last judge verdict"; "Attempts"]
    |> List.map csv_cell |> String.concat ","
  in
  String.concat "\r\n" (header :: List.rev !rows) ^ "\r\n"

let prepare ~is_current ~on_progress ~username ~problem_code ~metrics
    submissions =
  let total = List.length submissions in
  let completed = ref 0 in
  let rec fetch_details (sub : Api.Openapi.submission) retries =
    wait_for_request ~is_current
    >>= fun () ->
    XmlHttpRequest.perform_raw_url ~headers:(Api.Helpers.headers ())
      (Printf.sprintf "%s/submissions/%d/details" Api.Helpers.base_url sub.id)
    >>= fun response ->
    Helpers.handle_unauthorized response ;
    if not (is_current ()) then Lwt.fail Lwt.Canceled
    else if response.code = 429 && retries > 0 then (
      let delay = retry_delay (response.headers "Retry-After") in
      next_request_at := max !next_request_at (now () +. delay) ;
      on_progress !completed total true ;
      fetch_details sub (retries - 1) )
    else if response.code <> 200 then
      Lwt.fail_with
        (Printf.sprintf "Submission #%d details request failed (%d)." sub.id
           response.code )
    else
      let details =
        response.content |> Yojson.Safe.from_string
        |> Api.Openapi.SubmissionFullDetails.of_yojson
      in
      incr completed ;
      on_progress !completed total false ;
      Lwt.return
        ( {sub with status= details.submission.status}
        , details.source_artifacts )
  in
  Lwt_list.map_s
    (fun (sub : Api.Openapi.submission) -> fetch_details sub 3)
    submissions
  >|= fun fetched -> csv ~username ~problem_code ~metrics fetched

let trigger_download ~contest_id content =
  let blob =
    File.blob_from_any ~contentType:"text/csv;charset=utf-8" [`string content]
  in
  let url_obj = Js.Unsafe.coerce Dom_html.window##._URL in
  let object_url =
    Js.Unsafe.meth_call url_obj "createObjectURL" [|Js.Unsafe.inject blob|]
    |> Js.Unsafe.coerce |> Js.to_string
  in
  let anchor = Dom_html.createA Dom_html.document in
  anchor##.href := Js.string object_url ;
  anchor##.download :=
    Js.string (Printf.sprintf "contest-%d-submissions.csv" contest_id) ;
  anchor##.style##.display := Js.string "none" ;
  ignore (Dom.appendChild Dom_html.document##.body (Js.Unsafe.coerce anchor)) ;
  anchor##click ;
  ignore (Js.Unsafe.meth_call (Js.Unsafe.coerce anchor) "remove" [||]) ;
  ignore
    (Js.Unsafe.meth_call url_obj "revokeObjectURL"
       [|Js.Unsafe.inject (Js.string object_url)|] )

let export_statistics ~contest_id ~is_current ~username ~problem_code
    ~metrics submissions =
  if not !exporting then (
    exporting := true ;
    export_notice := "Preparing CSV export..." ;
    update_button () ;
    Lwt.async (fun () ->
        Lwt.catch
          (fun () ->
            prepare ~is_current
              ~on_progress:(fun completed total rate_limited ->
                export_notice :=
                  Printf.sprintf "Preparing CSV: %d/%d submissions.%s"
                    completed total
                    ( if rate_limited then " Rate limited; waiting to retry."
                      else "" ) ;
                update_button () )
              ~username ~problem_code ~metrics submissions
            >|= fun csv ->
            if is_current () then (
              trigger_download ~contest_id csv ;
              exporting := false ;
              export_notice := "CSV export downloaded." ;
              update_button () ) )
          (fun error ->
            if is_current () then (
              exporting := false ;
              export_notice :=
                "CSV export failed: " ^ Printexc.to_string error ;
              update_button () ) ;
            Lwt.return_unit ) ) )
