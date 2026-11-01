open Js_of_ocaml
open Js_of_ocaml_lwt
open Lwt.Infix

let decrypt_cipher cipher_hex =
  let len = String.length cipher_hex / 2 in
  let buf = Bytes.create len in
  for i = 0 to len - 1 do
    let byte = int_of_string ("0x" ^ String.sub cipher_hex (2 * i) 2) in
    Bytes.set buf i (Char.chr (byte lxor 27))
  done ;
  Bytes.to_string buf

let get_base_url () : string =
  let v = Js.Unsafe.get Js.Unsafe.global (Js.string "__BASE_API_URL__") in
  try
    let cipher_hex = Js.to_string (Obj.magic v) in
    decrypt_cipher cipher_hex
  with _ -> "http://localhost:8001"

let base_url = get_base_url ()

let headers () =
  let token = Js.to_string (External_lib.Helpers.auth_token ()) in
  let h = [("Content-Type", "application/json")] in
  if token <> "" then ("Authorization", "Bearer " ^ token) :: h else h

let fetch_json ?(redirect_on_unauthorized = true) url =
  XmlHttpRequest.perform_raw_url ~headers:(headers ()) url
  >>= fun resp ->
  External_lib.Helpers.handle_unauthorized ~redirect_on_unauthorized resp ;
  Console.console##log (Js.string ("Response: " ^ resp.content)) ;
  Lwt.return (Yojson.Safe.from_string resp.content, resp.code)

let post_json ?(redirect_on_unauthorized = true) url body =
  XmlHttpRequest.perform_raw_url ~override_method:`POST ~headers:(headers ())
    ~contents:(`String body) url
  >>= fun resp ->
  External_lib.Helpers.handle_unauthorized ~redirect_on_unauthorized resp ;
  Lwt.return (Yojson.Safe.from_string resp.content, resp.code)

let get_users () = fetch_json (base_url ^ "/users")

let get_contests () = fetch_json (base_url ^ "/contests")

let get_contest contest_id =
  fetch_json (Printf.sprintf "%s/contests/%d" base_url contest_id)

let post_contest body = post_json (base_url ^ "/judge/contests") body

let submit_solution json_obj =
  post_json (base_url ^ "/submissions") (Yojson.Safe.to_string json_obj)

let get_scoreboard contest_id =
  fetch_json (Printf.sprintf "%s/contests/%d/scoreboard" base_url contest_id)

let verify_token () =
  XmlHttpRequest.perform_raw_url ~headers:(headers ())
    (base_url ^ "/contests")
  >>= fun resp -> Lwt.return (resp.code = 200)

let get_problems contest_id =
  fetch_json (Printf.sprintf "%s/contests/%d/problems" base_url contest_id)

let get_problem problem_id =
  fetch_json (Printf.sprintf "%s/problems/%d" base_url problem_id)

(* --- admin config helpers --- *)
let put_json url body =
  XmlHttpRequest.perform_raw_url ~override_method:`PUT ~headers:(headers ())
    ~contents:(`String body) url
  >>= fun resp ->
  External_lib.Helpers.handle_unauthorized resp ;
  Lwt.return (Yojson.Safe.from_string resp.content, resp.code)

let delete_json url =
  XmlHttpRequest.perform_raw_url ~override_method:`DELETE
    ~headers:(headers ()) url
  >>= fun resp ->
  External_lib.Helpers.handle_unauthorized resp ;
  Lwt.return resp.code

let put_contest contest_id body =
  put_json (Printf.sprintf "%s/judge/contests/%d" base_url contest_id) body

let delete_contest contest_id =
  delete_json (Printf.sprintf "%s/judge/contests/%d" base_url contest_id)

let post_admin_user json_obj =
  post_json (base_url ^ "/admin/users") (Yojson.Basic.to_string json_obj)

let post_auth_password ~current_password ~new_password () =
  let request =
    Openapi.AuthPasswordPostRequest.create ~current_password ~new_password ()
  in
  post_json
    (base_url ^ "/auth/password")
    ( Openapi.AuthPasswordPostRequest.to_yojson request
    |> Yojson.Safe.to_string )

let get_admin_users () = fetch_json (base_url ^ "/admin/users")

let put_admin_user user_id json_obj =
  put_json
    (Printf.sprintf "%s/admin/users/%d" base_url user_id)
    (Yojson.Basic.to_string json_obj)

let delete_admin_user user_id =
  delete_json (Printf.sprintf "%s/admin/users/%d" base_url user_id)

let get_config () = fetch_json (base_url ^ "/admin/yodac/config")

let put_config json_obj =
  put_json
    (base_url ^ "/admin/yodac/config")
    (Yojson.Basic.to_string json_obj)

let get_config_history () =
  fetch_json (base_url ^ "/admin/yodac/config/history")

let get_admin_stats () = fetch_json (base_url ^ "/admin/stats")

(* --- Problem CRUD helpers --- *)

let post_problem contest_id body =
  post_json
    (Printf.sprintf "%s/contests/%d/problems" base_url contest_id)
    body

let put_problem problem_id body =
  put_json (Printf.sprintf "%s/admin/problems/%d" base_url problem_id) body

let delete_problem problem_id =
  delete_json (Printf.sprintf "%s/admin/problems/%d" base_url problem_id)

(* --- Submission re-evaluate helpers --- *)

let re_evaluate_submission submission_id =
  post_json
    (Printf.sprintf "%s/admin/submissions/%d/reevaluate" base_url
       submission_id )
    "{}"

(* --- Testcase helpers --- *)

let get_testcases problem_id =
  fetch_json (Printf.sprintf "%s/problems/%d/testcases" base_url problem_id)

let post_testcase problem_id body =
  post_json
    (Printf.sprintf "%s/problems/%d/testcases" base_url problem_id)
    body

let put_testcase testcase_id body =
  put_json (Printf.sprintf "%s/testcases/%d" base_url testcase_id) body

let delete_testcase testcase_id =
  delete_json (Printf.sprintf "%s/testcases/%d" base_url testcase_id)

(* --- Import helpers --- *)

let create_problem_with_source contest_id ~code ~title ~time_limit_ms
    ~memory_limit_mb ~description ~input_spec ~output_spec ~languages
    ~source_artifacts =
  let body =
    match source_artifacts with
    | Some arts ->
        Openapi.ProblemCreateRequest.create ~code ~title ~description
          ~input_spec ~output_spec ~time_limit_ms ~memory_limit_mb ~languages
          ~source_artifacts:arts ()
        |> Openapi.ProblemCreateRequest.to_json
    | None ->
        Openapi.ProblemCreateRequest.create ~code ~title ~description
          ~input_spec ~output_spec ~languages ~time_limit_ms ~memory_limit_mb
          ~source_artifacts:[] ()
        |> Openapi.ProblemCreateRequest.to_json
  in
  post_json
    (Printf.sprintf "%s/contests/%d/problems" base_url contest_id)
    body

let update_problem_source contest_id problem_id source_artifacts =
  let body =
    Openapi.ProblemUpdateRequest.create ~source_artifacts ()
    |> Openapi.ProblemUpdateRequest.to_json
  in
  put_json
    (Printf.sprintf "%s/contests/%d/problems/%d" base_url contest_id
       problem_id )
    body

let update_problem_object_artifacts contest_id problem_id object_artifacts =
  let body =
    Openapi.ProblemUpdateRequest.create ~object_artifacts ()
    |> Openapi.ProblemUpdateRequest.to_json
  in
  put_json
    (Printf.sprintf "%s/contests/%d/problems/%d" base_url contest_id
       problem_id )
    body
