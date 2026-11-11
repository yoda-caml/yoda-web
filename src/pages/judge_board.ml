open Js_of_ocaml
open Js_of_ocaml_tyxml
open Tyxml_js.Html
open Lwt.Infix

type file_entry =
  { submission: Api.Openapi.submission
  ; filename: string
  ; content: string
  ; distances: (string * (int * float) option) list }

type evaluation =
  {submission_id: int; filename: string; response: string; error: bool}

let contest = ref (-1)

let contest_details : Api.Openapi.contest option ref = ref None

let submissions : Api.Openapi.submission list ref = ref []

let selected_user : int option ref = ref None

let usernames : (int, string) Hashtbl.t = Hashtbl.create 32

let problem_codes : (int, string) Hashtbl.t = Hashtbl.create 32

let problem_code id =
  Option.value
    ~default:("Problem #" ^ string_of_int id)
    (Hashtbl.find_opt problem_codes id)

let files : file_entry list ref = ref []

let evaluations : evaluation list ref = ref []

let evaluations_key contest_id =
  Printf.sprintf "yoda-judge-evaluations-%d-%s" contest_id
    (Helpers.get_username ())

let load_evaluations contest_id =
  match Helpers.get_local_variable (evaluations_key contest_id) with
  | None -> []
  | Some saved -> (
    try
      Yojson.Safe.from_string (Js.to_string saved)
      |> Yojson.Safe.Util.to_list
      |> List.filter_map (fun json ->
          try
            let open Yojson.Safe.Util in
            Some
              { submission_id= json |> member "submission_id" |> to_int
              ; filename= json |> member "filename" |> to_string
              ; response= json |> member "response" |> to_string
              ; error= false }
          with _ -> None )
    with _ -> [] )

let save_evaluation contest_id evaluation =
  evaluation
  :: List.filter
       (fun result ->
         (result.submission_id, result.filename)
         <> (evaluation.submission_id, evaluation.filename) )
       (load_evaluations contest_id)
  |> List.map (fun result ->
      `Assoc
        [ ("submission_id", `Int result.submission_id)
        ; ("filename", `String result.filename)
        ; ("response", `String result.response) ] )
  |> fun json ->
  Helpers.set_local_variable
    (evaluations_key contest_id)
    (Yojson.Safe.to_string (`List json))

let loading = ref false

let analyzing = ref false

let reevaluating : int option ref = ref None

let reevaluation_notice = ref ""

let batch_problem : int option ref = ref None

let batch_fetching = ref false

let batch_notice = ref ""

let batch_request_id = ref 0

type batch_preview =
  { contest_id: int
  ; request_id: int
  ; username: string
  ; problem_id: int
  ; user_count: int
  ; inputs: Components.Llm_evaluation.input list }

let batch_preview : batch_preview option ref = ref None

let generation = ref 0

let message = ref ""

type metric =
  { key: string
  ; label: string
  ; unit_name: string
  ; relative_basis: string
  ; calculate: string -> string -> (int * float) option }

module IntSet = Set.Make (Int)
module StringSet = Set.Make (String)

let hamming a b =
  let count = ref (abs (String.length a - String.length b)) in
  for i = 0 to min (String.length a) (String.length b) - 1 do
    if a.[i] <> b.[i] then incr count
  done ;
  !count

let relative distance size =
  if size = 0 then 0. else 100. *. float distance /. float size

let levenshtein a b =
  let longer, shorter =
    if String.length a >= String.length b then (a, b) else (b, a)
  in
  let n = String.length longer and m = String.length shorter in
  if m = 0 then Some n
  else if n > 2_000_000 / m then None
  else
    let previous = ref (Array.init (m + 1) Fun.id) in
    let current = ref (Array.make (m + 1) 0) in
    for i = 1 to n do
      let prev = !previous and curr = !current in
      curr.(0) <- i ;
      for j = 1 to m do
        let cost = if longer.[i - 1] = shorter.[j - 1] then 0 else 1 in
        curr.(j) <-
          min (prev.(j) + 1) (min (curr.(j - 1) + 1) (prev.(j - 1) + cost))
      done ;
      previous := curr ;
      current := prev
    done ;
    Some !previous.(m)

let tokens source =
  let result = ref StringSet.empty in
  let word = Buffer.create 32 in
  let flush () =
    if Buffer.length word > 0 then (
      result := StringSet.add (Buffer.contents word) !result ;
      Buffer.clear word )
  in
  String.iter
    (fun c ->
      match c with
      | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' -> Buffer.add_char word c
      | ' ' | '\n' | '\r' | '\t' -> flush ()
      | _ ->
          flush () ;
          result := StringSet.add (String.make 1 c) !result )
    source ;
  flush () ;
  !result

let metrics =
  [ { key= "hamming"
    ; label= "Hamming (position-by-position)"
    ; unit_name= "bytes"
    ; relative_basis= "the longer file length"
    ; calculate=
        (fun a b ->
          let distance = hamming a b in
          Some
            ( distance
            , relative distance (max (String.length a) (String.length b)) ) )
    }
  ; { key= "levenshtein"
    ; label= "Levenshtein (insertions, deletions, substitutions)"
    ; unit_name= "edits"
    ; relative_basis= "the longer file length"
    ; calculate=
        (fun a b ->
          Option.map
            (fun distance ->
              ( distance
              , relative distance (max (String.length a) (String.length b))
              ) )
            (levenshtein a b) ) }
  ; { key= "tokens"
    ; label= "Token Jaccard (whitespace ignored)"
    ; unit_name= "unique tokens"
    ; relative_basis= "the unique-token union size"
    ; calculate=
        (fun a b ->
          let left = tokens a and right = tokens b in
          let union = StringSet.union left right in
          let distance =
            StringSet.cardinal union
            - StringSet.cardinal (StringSet.inter left right)
          in
          Some (distance, relative distance (StringSet.cardinal union)) ) }
  ]

let selected_metrics = ref [List.hd metrics]

let rerender () =
  if Js.to_string Dom_html.window##.location##.hash = "#judge-board" then
    Helpers.trigger_render ()

let _unsubscribe_jobs = Components.Llm_evaluation.subscribe rerender

let record_evaluation contest_id submission_id filename text error =
  let evaluation = {submission_id; filename; response= text; error} in
  if not error then save_evaluation contest_id evaluation ;
  if !contest = contest_id then (
    evaluations :=
      evaluation
      :: List.filter
           (fun result ->
             (result.submission_id, result.filename)
             <> (submission_id, filename) )
           !evaluations ;
    rerender () )

let load_contest_details contest_id =
  Lwt.async (fun () ->
      Lwt.catch
        (fun () ->
          Api.Helpers.get_contest contest_id
          >>= fun (json, status) ->
          if status = 200 && !contest = contest_id then (
            contest_details := Some (Api.Openapi.Contest.of_yojson json) ;
            rerender () ) ;
          Lwt.return_unit )
        (fun _ -> Lwt.return_unit) )

let visible_submissions () =
  match !selected_user with
  | None -> !submissions
  | Some user_id ->
      List.filter
        (fun (sub : Api.Openapi.submission) -> sub.owner_id = Some user_id)
        !submissions

let select_user user_id =
  incr generation ;
  Judge_board_export.exporting := false ;
  Judge_board_export.export_notice := "" ;
  selected_user := user_id ;
  files := [] ;
  analyzing := false ;
  reevaluating := None ;
  reevaluation_notice := "" ;
  message := ""

let user_selector ~on_select () =
  let ids =
    List.filter_map
      (fun (sub : Api.Openapi.submission) -> sub.owner_id)
      !submissions
    |> List.sort_uniq Int.compare
    |> List.filter (Hashtbl.mem usernames)
  in
  label
    ~a:[a_class ["d-block"; "mb-3"]]
    [ span
        ~a:[a_class ["d-block"; "fw-semibold"; "mb-1"]]
        [txt "View submissions for"]
    ; select
        ~a:
          [ a_class ["form-select"]
          ; a_style "max-width:24rem"
          ; a_onchange (fun event ->
                let target =
                  Js.Opt.get event##.target (fun () -> assert false)
                in
                let field =
                  Js.Opt.get (Dom_html.CoerceTo.select target) (fun () ->
                      assert false )
                in
                let value = Js.to_string field##.value in
                select_user
                  (if value = "" then None else Some (int_of_string value)) ;
                on_select () ;
                false ) ]
        ( option
            ~a:
              ( [a_value ""]
              @ if !selected_user = None then [a_selected ()] else [] )
            (txt "All users (contest overview)")
        :: List.map
             (fun id ->
               option
                 ~a:
                   ( [a_value (string_of_int id)]
                   @ if !selected_user = Some id then [a_selected ()] else []
                   )
                 (txt (Hashtbl.find usernames id)) )
             ids ) ]

let load ~on_loaded contest_id =
  incr generation ;
  Judge_board_export.exporting := false ;
  Judge_board_export.export_notice := "" ;
  incr batch_request_id ;
  batch_preview := None ;
  batch_fetching := false ;
  batch_notice := "" ;
  let request_generation = !generation in
  loading := true ;
  submissions := [] ;
  files := [] ;
  reevaluating := None ;
  reevaluation_notice := "" ;
  let url =
    Printf.sprintf "%s/contests/%d/submissions" Api.Helpers.base_url
      contest_id
  in
  Lwt.async (fun () ->
      Lwt.catch
        (fun () ->
          Api.Helpers.fetch_json url
          >>= fun (json, code) ->
          ( if code <> 200 then Lwt.return ([], [])
            else
              Lwt.both
                (Lwt.catch
                   (fun () ->
                     Api.Helpers.get_admin_users ()
                     >|= fun (users_json, users_code) ->
                     if users_code = 200 then
                       Api.Openapi.AdminUsersGetResponse2.of_yojson
                         users_json
                     else [] )
                   (fun _ -> Lwt.return []) )
                (Lwt.catch
                   (fun () ->
                     Api.Helpers.get_problems contest_id
                     >|= fun (problems_json, problems_code) ->
                     if problems_code = 200 then
                       Api.Openapi.ContestsContestsidProblemsGetResponse2
                       .of_yojson problems_json
                     else [] )
                   (fun _ -> Lwt.return []) ) )
          >>= fun (users, problems) ->
          if !contest = contest_id && !generation = request_generation then (
            if code = 200 then (
              submissions := Api.Openapi.Submissions.of_yojson json ;
              ( match !batch_problem with
              | Some problem_id
                when not
                       (List.exists
                          (fun (sub : Api.Openapi.submission) ->
                            sub.problem_id = problem_id )
                          !submissions ) ->
                  batch_problem := None
              | _ -> () ) ;
              Hashtbl.clear usernames ;
              List.iter
                (fun (user : Api.Openapi.user) ->
                  Hashtbl.replace usernames user.id user.username )
                users ;
              Hashtbl.clear problem_codes ;
              List.iter
                (fun (problem : Api.Openapi.problem) ->
                  Option.iter
                    (fun id -> Hashtbl.replace problem_codes id problem.code)
                    problem.id )
                problems ;
              ( match !selected_user with
              | Some id
                when (not
                        (List.exists
                           (fun (sub : Api.Openapi.submission) ->
                             sub.owner_id = Some id )
                           !submissions ) )
                     || not (Hashtbl.mem usernames id) ->
                  selected_user := None
              | _ -> () ) ;
              message := "" )
            else (
              selected_user := None ;
              message :=
                Printf.sprintf "Submissions request failed (%d)." code ) ;
            loading := false ;
            if code = 200 then on_loaded () ;
            rerender () ) ;
          Lwt.return_unit )
        (fun _ ->
          if !contest = contest_id && !generation = request_generation then (
            loading := false ;
            selected_user := None ;
            message := "Could not load submissions." ;
            rerender () ) ;
          Lwt.return_unit ) )

let analyze contest_id =
  if not !analyzing then (
    let request_generation = !generation in
    let selected = !selected_metrics in
    analyzing := true ;
    message :=
      "Loading source files for the current view's latest 50 submissions..." ;
    rerender () ;
    let recent =
      List.sort
        (fun (a : Api.Openapi.submission) b -> Int.compare b.id a.id)
        (visible_submissions ())
      |> List.filteri (fun i _ -> i < 50)
    in
    let pool = Lwt_pool.create 5 (fun () -> Lwt.return_unit) in
    Lwt.async (fun () ->
        Lwt_list.map_p
          (fun (sub : Api.Openapi.submission) ->
            Lwt_pool.use pool (fun () ->
                Lwt.catch
                  (fun () ->
                    Api.Helpers.fetch_json
                      (Printf.sprintf "%s/submissions/%d/details"
                         Api.Helpers.base_url sub.id )
                    >|= fun (json, code) ->
                    if code <> 200 then []
                    else
                      let details =
                        Api.Openapi.SubmissionFullDetails.of_yojson json
                      in
                      List.map
                        (fun (source : Api.Openapi.sourceArtifact) ->
                          { submission= sub
                          ; filename= source.filename
                          ; content= source.content
                          ; distances= [] } )
                        details.source_artifacts )
                  (fun _ -> Lwt.return []) ) )
          recent
        >>= fun fetched ->
        if !contest = contest_id && !generation = request_generation then (
          let previous = Hashtbl.create 32 in
          let skipped = ref 0 in
          files :=
            List.concat fetched
            |> List.sort (fun a b ->
                Int.compare a.submission.id b.submission.id )
            |> List.map (fun entry ->
                let key =
                  ( entry.submission.owner_id
                  , entry.submission.problem_id
                  , entry.filename )
                in
                let distances =
                  match
                    (entry.submission.owner_id, Hashtbl.find_opt previous key)
                  with
                  | Some _, Some content ->
                      List.map
                        (fun metric ->
                          let result =
                            metric.calculate content entry.content
                          in
                          if result = None then incr skipped ;
                          (metric.key, result) )
                        selected
                  | _ -> []
                in
                if entry.submission.owner_id <> None then
                  Hashtbl.replace previous key entry.content ;
                {entry with distances} ) ;
          let unavailable =
            List.length recent
            - List.length (List.filter (fun xs -> xs <> []) fetched)
          in
          message :=
            ( if unavailable = 0 then ""
              else
                Printf.sprintf
                  "%d submission(s) have no accessible source files. "
                  unavailable )
            ^
            if !skipped = 0 then ""
            else
              Printf.sprintf
                "%d file pair(s) exceeded the 2-million-cell edit-distance \
                 limit."
                !skipped ;
          analyzing := false ;
          rerender () ) ;
        Lwt.return_unit ) )

let attempts entry =
  List.fold_left
    (fun count (sub : Api.Openapi.submission) ->
      if
        entry.submission.owner_id <> None
        && sub.owner_id = entry.submission.owner_id
        && sub.problem_id = entry.submission.problem_id
        && sub.id <= entry.submission.id
      then count + 1
      else count )
    0 (visible_submissions ())

let evaluate_latest_for_problem problem_id =
  if not !batch_fetching then (
    let contest_id = !contest and request_id = !batch_request_id in
    let username = Helpers.get_username () in
    let all_submissions = !submissions in
    let latest = Hashtbl.create 32 in
    List.iter
      (fun (sub : Api.Openapi.submission) ->
        if sub.problem_id = problem_id then
          match sub.owner_id with
          | None -> ()
          | Some owner_id -> (
            match Hashtbl.find_opt latest owner_id with
            | Some (previous : Api.Openapi.submission)
              when previous.id >= sub.id ->
                ()
            | _ -> Hashtbl.replace latest owner_id sub ) )
      all_submissions ;
    let latest = Hashtbl.fold (fun _ sub acc -> sub :: acc) latest [] in
    batch_fetching := true ;
    batch_preview := None ;
    batch_notice := "Fetching latest submissions' source files..." ;
    rerender () ;
    let pool = Lwt_pool.create 5 (fun () -> Lwt.return_unit) in
    Lwt.async (fun () ->
        Lwt_list.map_p
          (fun (sub : Api.Openapi.submission) ->
            Lwt_pool.use pool (fun () ->
                Lwt.catch
                  (fun () ->
                    Api.Helpers.fetch_json
                      (Printf.sprintf "%s/submissions/%d/details"
                         Api.Helpers.base_url sub.id )
                    >|= fun (json, code) ->
                    if code <> 200 then (sub, [])
                    else
                      let details =
                        Api.Openapi.SubmissionFullDetails.of_yojson json
                      in
                      (sub, details.source_artifacts) )
                  (fun _ -> Lwt.return (sub, [])) ) )
          latest
        >>= fun fetched ->
        if
          !contest = contest_id
          && !batch_request_id = request_id
          && Helpers.get_username () = username
        then (
          batch_fetching := false ;
          let unavailable =
            List.length
              (List.filter (fun (_, sources) -> sources = []) fetched)
          in
          let saved = load_evaluations contest_id in
          let inputs =
            List.concat_map
              (fun ((sub : Api.Openapi.submission), sources) ->
                let attempts =
                  List.fold_left
                    (fun count (prior : Api.Openapi.submission) ->
                      if
                        prior.owner_id = sub.owner_id
                        && prior.problem_id = problem_id
                        && prior.id <= sub.id
                      then count + 1
                      else count )
                    0 all_submissions
                in
                List.map
                  (fun (source : Api.Openapi.sourceArtifact) ->
                    Components.Llm_evaluation.
                      { contest_id
                      ; submission_id= sub.id
                      ; filename= source.filename
                      ; problem_code= problem_code problem_id
                      ; attempts
                      ; verdict= sub.status
                      ; source= source.content } )
                  sources )
              fetched
            |> List.filter (fun (input : Components.Llm_evaluation.input) ->
                (not
                   (List.exists
                      (fun result ->
                        result.submission_id = input.submission_id
                        && result.filename = input.filename )
                      saved ) )
                && not (Components.Llm_evaluation.is_pending input) )
          in
          let inputs =
            List.sort_uniq
              (fun (a : Components.Llm_evaluation.input) b ->
                compare
                  (a.submission_id, a.filename)
                  (b.submission_id, b.filename) )
              inputs
          in
          let total = List.length inputs in
          let user_count =
            List.map
              (fun (input : Components.Llm_evaluation.input) ->
                input.submission_id )
              inputs
            |> List.sort_uniq Int.compare
            |> List.length
          in
          if total = 0 then
            batch_notice :=
              Printf.sprintf
                "No new source files to evaluate (%d latest submission(s) \
                 unavailable)."
                unavailable
          else (
            batch_preview :=
              Some
                { contest_id
                ; request_id
                ; username
                ; problem_id
                ; user_count
                ; inputs } ;
            batch_notice :=
              Printf.sprintf
                "Ready to send %d source file(s) from %d user(s) for \
                 problem %s. This may incur provider charges."
                total user_count (problem_code problem_id) ) ;
          rerender () ) ;
        Lwt.return_unit ) )

let confirm_batch (config : Components.Llm_evaluation.config) =
  match !batch_preview with
  | None -> ()
  | Some preview ->
      batch_preview := None ;
      if
        !contest = preview.contest_id
        && !batch_request_id = preview.request_id
        && Helpers.get_username () = preview.username
        && Helpers.is_judge_or_admin ()
      then (
        let saved = load_evaluations preview.contest_id in
        let inputs =
          List.filter
            (fun (input : Components.Llm_evaluation.input) ->
              (not
                 (List.exists
                    (fun result ->
                      result.submission_id = input.submission_id
                      && result.filename = input.filename )
                    saved ) )
              && not (Components.Llm_evaluation.is_pending input) )
            preview.inputs
        in
        let total = List.length inputs in
        let completed = ref 0 and failed = ref 0 in
        batch_notice :=
          if total = 0 then "No new files remain to evaluate."
          else
            Printf.sprintf "Queued %d file(s) for problem %s." total
              (problem_code preview.problem_id) ;
        List.iter
          (fun (input : Components.Llm_evaluation.input) ->
            ignore
              (Components.Llm_evaluation.enqueue ~input ~config
                 ~on_result:(fun text error ->
                   record_evaluation preview.contest_id input.submission_id
                     input.filename text error ;
                   if
                     !contest = preview.contest_id
                     && !batch_request_id = preview.request_id
                   then (
                     incr completed ;
                     if error then incr failed ;
                     batch_notice :=
                       Printf.sprintf
                         "LLM batch: %d/%d finished (%d failed)." !completed
                         total !failed ;
                     rerender () ) ) ) )
          inputs ;
        rerender () )

let request_reevaluation submission_id =
  if Helpers.is_judge_or_admin () && !reevaluating = None then (
    reevaluating := Some submission_id ;
    reevaluation_notice := "" ;
    rerender () ;
    Lwt.async (fun () ->
        Lwt.catch
          (fun () ->
            Api.Helpers.re_evaluate_submission submission_id
            >>= fun (_, status) ->
            if !reevaluating = Some submission_id then (
              reevaluation_notice :=
                if status >= 200 && status < 300 then
                  Printf.sprintf
                    "Re-evaluation requested for submission #%d. Refresh to \
                     see the updated verdict."
                    submission_id
                else
                  Printf.sprintf
                    "Re-evaluation of submission #%d failed (HTTP %d)."
                    submission_id status ;
              reevaluating := None ;
              rerender () ) ;
            Lwt.return_unit )
          (fun _ ->
            if !reevaluating = Some submission_id then (
              reevaluation_notice :=
                Printf.sprintf
                  "Could not request re-evaluation of submission #%d."
                  submission_id ;
              reevaluating := None ;
              rerender () ) ;
            Lwt.return_unit ) ) )

let status_rank = function
  | "accepted" -> 0
  | "wrong_answer" -> 1
  | "time_limit_exceeded" -> 2
  | "memory_limit_exceeded" -> 3
  | "runtime_error" -> 4
  | "compilation_error" | "compile_error" -> 5
  | "presentation_error" -> 6
  | "internal_error" -> 7
  | "running" -> 8
  | "queued" -> 9
  | "pending" -> 10
  | _ -> 11

let status_color = function
  | "accepted" -> "accepted"
  | "wrong_answer" -> "wrong-answer"
  | "time_limit_exceeded" -> "time-limit"
  | "memory_limit_exceeded" -> "memory-limit"
  | "runtime_error" -> "runtime-error"
  | "compilation_error" | "compile_error" -> "compilation-error"
  | "presentation_error" -> "presentation-error"
  | "internal_error" -> "internal-error"
  | "running" -> "running"
  | "queued" -> "queued"
  | "pending" -> "pending"
  | _ -> "other"

let histogram ?(show_users = false) ~title submissions =
  let counts = Hashtbl.create 16 in
  let users_by_problem = Hashtbl.create 16 in
  List.iter
    (fun (sub : Api.Openapi.submission) ->
      let statuses =
        match Hashtbl.find_opt counts sub.problem_id with
        | Some statuses -> statuses
        | None ->
            let statuses = Hashtbl.create 8 in
            Hashtbl.add counts sub.problem_id statuses ;
            statuses
      in
      let status = sub.status in
      Hashtbl.replace statuses status
        (1 + Option.value ~default:0 (Hashtbl.find_opt statuses status)) ;
      match sub.owner_id with
      | None -> ()
      | Some user_id ->
          let users =
            Option.value ~default:IntSet.empty
              (Hashtbl.find_opt users_by_problem sub.problem_id)
          in
          Hashtbl.replace users_by_problem sub.problem_id
            (IntSet.add user_id users) )
    submissions ;
  let rows =
    Hashtbl.fold
      (fun id statuses acc ->
        let breakdown =
          Hashtbl.fold
            (fun status count xs -> (status, count) :: xs)
            statuses []
          |> List.sort (fun (a, _) (b, _) ->
              let order = Int.compare (status_rank a) (status_rank b) in
              if order = 0 then String.compare a b else order )
        in
        let total =
          List.fold_left (fun n (_, count) -> n + count) 0 breakdown
        in
        (id, total, breakdown) :: acc )
      counts []
    |> List.sort (fun (a, _, _) (b, _, _) -> Int.compare a b)
  in
  let peak = List.fold_left (fun n (_, count, _) -> max n count) 1 rows in
  let unique_users =
    submissions
    |> List.filter_map (fun (sub : Api.Openapi.submission) -> sub.owner_id)
    |> List.sort_uniq Int.compare
    |> List.length
  in
  div
    ~a:[a_class ["card"; "p-3"; "mb-3"]]
    ( [ h2 ~a:[a_class ["h5"]] [txt title]
      ; p
          ~a:[a_class ["text-muted"; "small"]]
          [ txt
              "Bar length compares submission totals across problems; \
               colors show judge verdicts. Counts include every submission, \
               not just each user's latest verdict." ] ]
    @ ( if show_users then
          [ p
              ~a:[a_class ["text-muted"]]
              [ txt
                  (Printf.sprintf "%d submissions from %d users"
                     (List.length submissions) unique_users ) ] ]
        else
          [ p
              ~a:[a_class ["text-muted"]]
              [ txt
                  (Printf.sprintf "%d submissions in current view"
                     (List.length submissions) ) ] ] )
    @
    if rows = [] then [p [txt "No submissions available."]]
    else
      List.map
        (fun (id, count, breakdown) ->
          div
            ~a:[a_class ["judge-status-row"]]
            [ div
                ~a:
                  [ a_class
                      [ "d-flex"
                      ; "flex-wrap"
                      ; "justify-content-between"
                      ; "gap-2" ] ]
                [ strong [txt (problem_code id)]
                ; span
                    ~a:[a_class ["text-muted"; "small"]]
                    [ txt
                        ( if show_users then
                            Printf.sprintf "%d submissions from %d users"
                              count
                              ( Hashtbl.find_opt users_by_problem id
                              |> Option.value ~default:IntSet.empty
                              |> IntSet.cardinal )
                          else Printf.sprintf "%d submissions" count ) ] ]
            ; div
                ~a:
                  [ a_class ["judge-status-bar"]
                  ; a_aria "label"
                      [ Printf.sprintf "%s: %d submissions" (problem_code id)
                          count ] ]
                (List.map
                   (fun (status, amount) ->
                     div
                       ~a:
                         [ a_class
                             [ "judge-status-segment"
                             ; "judge-status-" ^ status_color status ]
                         ; a_style
                             (Printf.sprintf "width:%.4f%%"
                                (100. *. float amount /. float peak) )
                         ; a_title
                             (Printf.sprintf "%s: %d"
                                (I18n.submission_status status)
                                amount ) ]
                       [] )
                   breakdown )
            ; div
                ~a:[a_class ["judge-status-breakdown"]]
                (List.map
                   (fun (status, amount) ->
                     span
                       ~a:[a_class ["judge-status-item"]]
                       [ span
                           ~a:
                             [ a_class
                                 [ "judge-status-swatch"
                                 ; "judge-status-" ^ status_color status ] ]
                           []
                       ; txt
                           (Printf.sprintf "%s %d"
                              (I18n.submission_status status)
                              amount ) ] )
                   breakdown ) ] )
        rows )

let distance_plot metric =
  let problem_ids =
    visible_submissions ()
    |> List.map (fun (sub : Api.Openapi.submission) -> sub.problem_id)
    |> List.sort_uniq Int.compare
  in
  let plot_problem problem_id =
    let measured =
      List.filter_map
        (fun file ->
          if file.submission.problem_id = problem_id then
            Option.map
              (fun (distance, relative) -> (file, distance, relative))
              (Option.join (List.assoc_opt metric.key file.distances))
          else None )
        !files
    in
    let n = List.length measured in
    let peak = List.fold_left (fun p (_, d, _) -> max p d) 1 measured in
    let points =
      List.mapi
        (fun i (_, d, _) ->
          ( 10. +. (980. *. float i /. float (max 1 (n - 1)))
          , 175. -. (155. *. float d /. float peak) ) )
        measured
    in
    let path =
      points
      |> List.mapi (fun i (x, y) ->
          Printf.sprintf "%s %.2f %.2f" (if i = 0 then "M" else "L") x y )
      |> String.concat " "
    in
    div
      ~a:[a_class ["mb-4"]]
      [ h3 ~a:[a_class ["h6"]] [txt (problem_code problem_id)]
      ; ( if n = 0 then
            p
              ~a:[a_class ["text-muted"]]
              [txt "No comparable file pairs in the analyzed submissions."]
          else
            div
              [ Tyxml_js.Html.svg
                  ~a:
                    [ Tyxml_js.Svg.a_class ["judge-distance-chart"]
                    ; Tyxml_js.Svg.a_viewBox (0., 0., 1000., 190.) ]
                  ( Tyxml_js.Svg.path
                      ~a:
                        [ Tyxml_js.Svg.a_d path
                        ; Tyxml_js.Svg.a_class ["judge-distance-line"] ]
                      []
                  :: List.map2
                       (fun (file, distance, relative) (x, y) ->
                         Tyxml_js.Svg.circle
                           ~a:
                             [ Tyxml_js.Svg.a_cx (x, None)
                             ; Tyxml_js.Svg.a_cy (y, None)
                             ; Tyxml_js.Svg.a_r (6., None)
                             ; Tyxml_js.Svg.a_class ["judge-distance-dot"] ]
                           [ Tyxml_js.Svg.title
                               (Tyxml_js.Svg.txt
                                  (Printf.sprintf
                                     "Submission #%d, %s: %d %s (%.2f%% \
                                      relative)"
                                     file.submission.id file.filename
                                     distance metric.unit_name relative ) )
                           ] )
                       measured points )
              ; small
                  ~a:[a_class ["text-muted"]]
                  [ txt
                      (Printf.sprintf
                         "%d comparable files; maximum distance %d %s. \
                          Points follow submission order."
                         n peak metric.unit_name ) ] ] ) ]
  in
  div
    ~a:[a_class ["card"; "p-3"; "mb-3"; "w-100"]]
    ( [ h2 ~a:[a_class ["h5"]] [txt (metric.label ^ " by problem")]
      ; p
          ~a:[a_class ["text-muted"]]
          [ txt
              ( "Each file is compared only with an earlier file from the \
                 same owner, problem and filename. First files have no \
                 predecessor. Only accessible sources from the current \
                 view's latest 50 submissions are analyzed. Relative \
                 distance is the raw distance divided by "
              ^ metric.relative_basis ^ "." ) ] ]
    @ ( match metric.key with
      | "tokens" ->
          [ p
              ~a:[a_class ["text-muted"]]
              [ txt
                  "Token Jaccard ignores whitespace, token order and \
                   repeated tokens; comments still count." ] ]
      | "levenshtein" ->
          [ p
              ~a:[a_class ["text-muted"]]
              [ txt
                  "Edit distance is limited to 2 million comparison cells \
                   per file pair; larger pairs are omitted." ] ]
      | _ -> [] )
    @
    if problem_ids = [] then [p [txt "No submissions in this view."]]
    else List.map plot_problem problem_ids )

let metric_selector ~on_select () =
  div
    ~a:[a_class ["mb-3"]]
    [ p ~a:[a_class ["fw-semibold"; "mb-1"]] [txt "File distance metrics"]
    ; div
        ~a:[a_class ["d-flex"; "flex-wrap"; "gap-2"]]
        (List.concat_map
           (fun metric ->
             let selected =
               List.exists (fun m -> m.key = metric.key) !selected_metrics
             in
             let id = "judge-metric-" ^ metric.key in
             [ input
                 ~a:
                   ( [ a_id id
                     ; a_class ["btn-check"]
                     ; a_input_type `Checkbox
                     ; a_onchange (fun _ ->
                           let selected_keys =
                             List.map (fun m -> m.key) !selected_metrics
                           in
                           selected_metrics :=
                             List.filter
                               (fun m ->
                                 if m.key = metric.key then not selected
                                 else List.mem m.key selected_keys )
                               metrics ;
                           incr generation ;
                           Judge_board_export.exporting := false ;
                           Judge_board_export.export_notice := "" ;
                           analyzing := false ;
                           files := [] ;
                           message := "" ;
                           on_select () ;
                           false ) ]
                   @ (if selected then [a_checked ()] else [])
                   @
                   if selected && List.length !selected_metrics = 1 then
                     [a_disabled ()]
                   else [] )
                 ()
             ; label
                 ~a:
                   [ a_class ["btn"; "btn-outline-primary"; "btn-sm"]
                   ; a_label_for id
                   ; a_title metric.label ]
                 [ txt
                     ( match metric.key with
                     | "hamming" -> "Hamming"
                     | "levenshtein" -> "Levenshtein"
                     | "tokens" -> "Token Jaccard"
                     | _ -> metric.label ) ] ] )
           metrics ) ]

let results_table () =
  let llm_config =
    Option.map
      (fun (config : Settings_llm.config) ->
        Components.Llm_evaluation.
          { endpoint= config.endpoint
          ; model= config.model
          ; api_key= config.api_key
          ; prompt= config.prompt } )
      (Settings_llm.configuration ())
  in
  let show_user = !selected_user = None in
  let batch_problems =
    !submissions
    |> List.filter_map (fun (sub : Api.Openapi.submission) ->
        match sub.owner_id with
        | Some _ -> Some sub.problem_id
        | None -> None )
    |> List.sort_uniq Int.compare
    |> List.sort (fun a b ->
        String.compare (problem_code a) (problem_code b) )
  in
  let rows =
    List.sort (fun a b -> Int.compare b.submission.id a.submission.id) !files
  in
  div
    ~a:[a_class ["card"; "p-3"; "mb-3"]]
    [ div
        ~a:
          [ a_class
              [ "d-flex"
              ; "flex-wrap"
              ; "justify-content-between"
              ; "align-items-center"
              ; "gap-2"
              ; "mb-2" ] ]
        ( h2 ~a:[a_class ["h5"; "mb-0"]] [txt "Submission Review"]
        ::
        ( if show_user then
            [ div
                ~a:[a_class ["d-flex"; "flex-wrap"; "gap-2"]]
                [ label
                    ~a:
                      [ a_class ["visually-hidden"]
                      ; a_label_for "judge-batch-problem" ]
                    [txt "Problem for batch LLM evaluation"]
                ; select
                    ~a:
                      ( [ a_id "judge-batch-problem"
                        ; a_class ["form-select"; "form-select-sm"]
                        ; a_style "width:auto;max-width:18rem"
                        ; a_onchange (fun event ->
                              let target =
                                Js.Opt.get event##.target (fun () ->
                                    assert false )
                              in
                              let field =
                                Js.Opt.get (Dom_html.CoerceTo.select target)
                                  (fun () -> assert false )
                              in
                              let value = Js.to_string field##.value in
                              batch_problem :=
                                if value = "" then None
                                else Some (int_of_string value) ;
                              batch_preview := None ;
                              batch_notice := "" ;
                              rerender () ;
                              false ) ]
                      @ if !batch_fetching then [a_disabled ()] else [] )
                    ( option ~a:[a_value ""] (txt "Select a problem")
                    :: List.map
                         (fun id ->
                           option
                             ~a:
                               ( [a_value (string_of_int id)]
                               @
                               if !batch_problem = Some id then
                                 [a_selected ()]
                               else [] )
                             (txt (problem_code id)) )
                         batch_problems )
                ; button
                    ~a:
                      ( [ a_button_type `Button
                        ; a_class ["btn"; "btn-sm"; "btn-outline-primary"]
                        ; a_title
                            "Evaluate each user's latest submission for the \
                             selected problem"
                        ; a_onclick (fun _ ->
                              ( match (!batch_problem, llm_config) with
                              | Some id, Some _ ->
                                  evaluate_latest_for_problem id
                              | _ -> () ) ;
                              false ) ]
                      @
                      if
                        !batch_fetching || !batch_problem = None
                        || llm_config = None || !batch_preview <> None
                      then [a_disabled ()]
                      else [] )
                    [ txt
                        ( if !batch_fetching then "Fetching sources..."
                          else "Evaluate latest per user" ) ] ] ]
          else [] ) )
    ; ( if !batch_notice = "" || not show_user then div []
        else
          p
            ~a:[a_class ["text-muted"; "mb-2"]; a_aria "live" ["polite"]]
            [txt !batch_notice] )
    ; ( if not show_user then div []
        else
          match !batch_preview with
          | None -> div []
          | Some preview ->
              div
                ~a:[a_class ["d-flex"; "gap-2"; "mb-3"]]
                [ button
                    ~a:
                      ( [ a_button_type `Button
                        ; a_class ["btn"; "btn-sm"; "btn-primary"]
                        ; a_onclick (fun _ ->
                              Option.iter confirm_batch llm_config ;
                              false ) ]
                      @ if llm_config = None then [a_disabled ()] else [] )
                    [ txt
                        (Printf.sprintf "Confirm %d file(s) from %d user(s)"
                           (List.length preview.inputs)
                           preview.user_count ) ]
                ; button
                    ~a:
                      [ a_button_type `Button
                      ; a_class ["btn"; "btn-sm"; "btn-outline-secondary"]
                      ; a_onclick (fun _ ->
                            batch_preview := None ;
                            batch_notice := "LLM batch canceled." ;
                            rerender () ;
                            false ) ]
                    [txt "Cancel"] ] )
    ; ( if !reevaluation_notice = "" then div []
        else
          p
            ~a:[a_class ["alert"; "alert-info"]; a_aria "live" ["polite"]]
            [txt !reevaluation_notice] )
    ; p
        ~a:[a_class ["text-muted"]]
        [ txt "Configure the provider and prompt in "
        ; a ~a:[a_href "#settings-llm"] [txt "LLM settings"]
        ; txt
            ". Evaluation sends code only when requested. Successful \
             results are saved in this browser." ]
    ; div
        ~a:[a_class ["table-responsive"]]
        [ table
            ~a:[a_class ["table"; "table-striped"]]
            ~thead:
              (thead
                 [ tr
                     ( (if show_user then [th [txt "User"]] else [])
                     @ [ th [txt "Submission / file"]
                       ; th [txt "Problem"]
                       ; th [txt "Distance"]
                       ; th [txt "Judge verdict"]
                       ; th [txt "LLM evaluation"]
                       ; th [txt "Action"] ] ) ] )
            ( if rows = [] then
                [ tr
                    [ td
                        ~a:[a_colspan (if show_user then 7 else 6)]
                        [txt "Analyze source files to populate this table."]
                    ] ]
              else
                List.map
                  (fun entry ->
                    let key = (entry.submission.id, entry.filename) in
                    let result =
                      List.find_opt
                        (fun r -> (r.submission_id, r.filename) = key)
                        !evaluations
                    in
                    let contest_id = !contest in
                    let input =
                      Components.Llm_evaluation.
                        { contest_id
                        ; submission_id= entry.submission.id
                        ; filename= entry.filename
                        ; problem_code=
                            problem_code entry.submission.problem_id
                        ; attempts= attempts entry
                        ; verdict= entry.submission.status
                        ; source= entry.content }
                    in
                    let on_result text error =
                      record_evaluation contest_id entry.submission.id
                        entry.filename text error
                    in
                    tr
                      ( ( if show_user then
                            [ td
                                [ txt
                                    ( match entry.submission.owner_id with
                                    | Some id ->
                                        Option.value
                                          ~default:"Username unavailable"
                                          (Hashtbl.find_opt usernames id)
                                    | None -> "Username unavailable" ) ] ]
                          else [] )
                      @ [ td
                            [ txt
                                (Printf.sprintf "#%d / %s"
                                   entry.submission.id entry.filename ) ]
                        ; td [txt (problem_code entry.submission.problem_id)]
                        ; td
                            (List.map
                               (fun metric ->
                                 div
                                   [ txt
                                       ( metric.label ^ ": "
                                       ^
                                       match
                                         List.assoc_opt metric.key
                                           entry.distances
                                       with
                                       | Some (Some (d, relative)) ->
                                           Printf.sprintf "%d %s (%.2f%%)" d
                                             metric.unit_name relative
                                       | _ -> "-" ) ] )
                               !selected_metrics )
                        ; td
                            [ txt
                                (I18n.submission_status
                                   entry.submission.status ) ]
                        ; Components.Llm_evaluation.result_cell ~input
                            ~result:
                              (Option.map
                                 (fun r -> (r.response, r.error))
                                 result )
                        ; td
                            [ div
                                ~a:[a_class ["d-flex"; "flex-wrap"; "gap-2"]]
                                ( Components.Llm_evaluation.action_button
                                    ~input ~config:llm_config ~on_result
                                :: Components.Submissions_list_details
                                   .reevaluate_action
                                     ~disabled:(!reevaluating <> None)
                                     ~spinning:
                                       ( !reevaluating
                                       = Some entry.submission.id )
                                     ~on_click:(fun () ->
                                       request_reevaluation
                                         entry.submission.id )
                                     ()
                                :: ( Option.to_list
                                       (Components.Submissions_list_details
                                        .action entry.submission.id
                                          entry.submission )
                                   @ Option.to_list
                                       (Components.Submissions_list_details
                                        .source_artifacts_action
                                          entry.submission ) ) ) ] ] ) )
                  rows ) ] ]

let format_contest_time value =
  let timestamp = Js.Unsafe.global##.Date##parse (Js.string value) in
  if Float.is_nan (Js.float_of_number timestamp) then value
  else
    let date = new%js Js.date_fromTimeValue timestamp in
    let offset = -date##getTimezoneOffset in
    Printf.sprintf "%s (UTC%s%02d:%02d)"
      (Js.to_string date##toLocaleString)
      (if offset < 0 then "-" else "+")
      (abs offset / 60)
      (abs offset mod 60)

let content contest_id =
  if !contest <> contest_id then (
    batch_problem := None ;
    contest := contest_id ;
    contest_details := None ;
    load_contest_details contest_id ;
    submissions := [] ;
    files := [] ;
    evaluations := load_evaluations contest_id ;
    analyzing := false ;
    selected_user := None ;
    Hashtbl.clear usernames ;
    Hashtbl.clear problem_codes ;
    message := "" ;
    load ~on_loaded:(fun () -> analyze contest_id) contest_id ) ;
  let contest_title =
    match !contest_details with
    | Some details -> details.title
    | None -> string_of_int contest_id
  in
  main
    ~a:[a_class ["panel"; "flex-grow-1"; "judge-board"]]
    [ section
        ~a:
          [ a_class
              ["panel-section"; "container-fluid"; "py-3"; "px-3"; "px-lg-4"]
          ]
        [ div
            ~a:
              [ a_class
                  [ "d-flex"
                  ; "flex-wrap"
                  ; "justify-content-between"
                  ; "align-items-center"
                  ; "gap-2"
                  ; "mb-3" ] ]
            [ h1 ~a:[a_class ["h3"; "mb-0"]] [txt ""]
            ; div
                ~a:[a_class ["d-flex"; "gap-2"]]
                [ button
                    ~a:
                      ( [ a_class ["btn"; "btn-outline-secondary"]
                        ; a_onclick (fun _ ->
                              load
                                ~on_loaded:(fun () -> analyze contest_id)
                                contest_id ;
                              rerender () ;
                              false ) ]
                      @
                      if !loading || !analyzing then [a_disabled ()] else []
                      )
                    [txt "Refresh"]
                ; button
                    ~a:
                      ( [ a_button_type `Button
                        ; a_id Judge_board_export.button_id
                        ; a_class ["btn"; "btn-outline-primary"]
                        ; a_aria "live" ["polite"]
                        ; a_onclick (fun _ ->
                              let request_generation = !generation in
                              Judge_board_export.export_statistics
                                ~contest_id
                                ~is_current:(fun () ->
                                  !contest = contest_id
                                  && !generation = request_generation )
                                ~username:(fun id ->
                                  Option.value
                                    ~default:(Printf.sprintf "User #%d" id)
                                    (Hashtbl.find_opt usernames id) )
                                ~problem_code
                                (visible_submissions ()) ;
                              false ) ]
                      @
                      if
                        !loading
                        || !Judge_board_export.exporting
                        || !submissions = []
                      then [a_disabled ()]
                      else [] )
                    [txt (Judge_board_export.button_label ())]
                ; button
                    ~a:
                      ( [ a_class ["btn"; "btn-primary"]
                        ; a_onclick (fun _ -> analyze contest_id ; false) ]
                      @
                      if !analyzing || !loading then [a_disabled ()] else []
                      )
                    [ txt
                        ( if !analyzing then "Analyzing..."
                          else "Recalculate file distances" ) ] ] ]
        ; div
            ~a:[a_class ["card"; "p-3"; "mb-3"]]
            ( match !contest_details with
            | None ->
                [ p
                    ~a:[a_class ["text-muted"; "mb-0"]]
                    [ txt
                        (Printf.sprintf "Loading contest #%d details..."
                           contest_id ) ] ]
            | Some details ->
                let status_label, status_class =
                  match details.status with
                  | Api.Openapi.Running -> ("Running", "text-bg-success")
                  | Api.Openapi.Upcoming -> ("Upcoming", "text-bg-warning")
                  | Api.Openapi.Finished -> ("Finished", "text-bg-secondary")
                in
                [ div
                    ~a:
                      [ a_class
                          [ "d-flex"
                          ; "flex-wrap"
                          ; "align-items-center"
                          ; "gap-2" ] ]
                    [ h2
                        ~a:[a_class ["h5"; "mb-0"]]
                        [ txt
                            (Printf.sprintf "%s | #%d" details.title
                               details.id ) ]
                    ; span
                        ~a:[a_class ["badge"; status_class]]
                        [txt status_label] ] ]
                @ ( match details.description with
                  | Some description when description <> "" ->
                      [ p
                          ~a:[a_class ["text-muted"; "mt-2"; "mb-0"]]
                          [txt description] ]
                  | _ -> [] )
                @ [ div
                      ~a:[a_class ["judge-contest-dates"]]
                      [ div
                          [ span
                              ~a:[a_class ["text-muted"; "small"]]
                              [txt "Starts"]
                          ; time
                              ~a:[a_datetime details.start_time]
                              [txt (format_contest_time details.start_time)]
                          ]
                      ; div
                          [ span
                              ~a:[a_class ["text-muted"; "small"]]
                              [txt "Ends"]
                          ; time
                              ~a:
                                [ a_datetime
                                    (Option.value ~default:""
                                       details.end_time ) ]
                              [ txt
                                  (format_contest_time
                                     (Option.value ~default:""
                                        details.end_time ) ) ] ] ] ] )
        ; (if !loading then p [txt "Loading submissions..."] else div [])
        ; ( if !message <> "" then
              p ~a:[a_class ["text-muted"]] [txt !message]
            else div [] )
        ; ( if !loading then div []
            else
              histogram ~show_users:true
                ~title:
                  ("Verdicts for Each Problem in Contest " ^ contest_title)
                !submissions )
        ; ( if !loading then div []
            else
              div
                [ user_selector ~on_select:(fun () -> analyze contest_id) ()
                ; metric_selector
                    ~on_select:(fun () -> analyze contest_id)
                    ()
                ; ( if
                      List.exists
                        (fun (sub : Api.Openapi.submission) ->
                          match sub.owner_id with
                          | None -> false
                          | Some id -> not (Hashtbl.mem usernames id) )
                        !submissions
                    then
                      p
                        ~a:[a_class ["text-warning"]]
                        [ txt
                            "Some usernames are unavailable; those \
                             individual views require access to \
                             /admin/users." ]
                    else div [] ) ] )
        ; ( if !loading then div []
            else
              div
                ( ( match !selected_user with
                    | None -> []
                    | Some id ->
                        [ histogram
                            ~title:
                              ( "Verdicts per Problem for "
                              ^ Option.value ~default:"User"
                                  (Hashtbl.find_opt usernames id) )
                            (visible_submissions ()) ] )
                @ List.map distance_plot !selected_metrics
                @ [results_table ()] ) ) ] ]

let render () =
  if not (Helpers.is_judge_or_admin ()) then
    [ div
        ~a:[a_class ["panel"; "p-4"]]
        [h1 [txt "Judge board"]; p [txt "Judge or admin access required."]]
    ]
  else
    let body = content (Helpers.get_current_contest_id ()) in
    match Helpers.layout () with
    | Helpers.Mobile ->
        [ div
            ~a:[a_class ["w-100"]]
            [Components.Sidebar.sidebar ~mobile:true (); body] ]
    | Helpers.Normal ->
        [ Components.Sidebar.sidebar ~wide:false ()
        ; div ~a:[a_class ["flex-grow-1"; "judge-board"]] [body] ]
    | Helpers.Wide ->
        [ Components.Sidebar.sidebar ()
        ; div ~a:[a_class ["flex-grow-1"; "judge-board"]] [body] ]
