(* Auto-generated from "openapi.atd" by atdml. *)
[@@@ocaml.warning "-27-32-33-35-39"]

(* Inlined runtime — no external dependency needed. *)
module Atdml_runtime = struct
  (* Returns true iff the list has strictly more than [n] elements,
     without traversing past element n+1. *)
  let rec list_length_gt n = function
    | _ :: rest -> if n = 0 then true else list_length_gt (n - 1) rest
    | [] -> false

  module Yojson = struct
    let bad_type expected_type x =
      Printf.ksprintf failwith "expected %s, got: %s"
        expected_type (Yojson.Safe.to_string x)

    let bad_sum type_name x =
      Printf.ksprintf failwith "invalid variant for type '%s': %s"
        type_name (Yojson.Safe.to_string x)

    let missing_field type_name field_name =
      Printf.ksprintf failwith "missing field '%s' in object of type '%s'"
        field_name type_name

    let bool_of_yojson = function
      | `Bool b -> b
      | x -> bad_type "bool" x

    let yojson_of_bool b = `Bool b

    let int_of_yojson = function
      | `Int n -> n
      | x -> bad_type "int" x

    let yojson_of_int n = `Int n

    let float_of_yojson = function
      | `Float f -> f
      | `Int n -> Float.of_int n
      | x -> bad_type "float" x

    let yojson_of_float f = `Float f

    let string_of_yojson = function
      | `String s -> s
      | x -> bad_type "string" x

    let yojson_of_string s = `String s

    let unit_of_yojson = function
      | `Null -> ()
      | x -> bad_type "null" x

    let yojson_of_unit () = `Null

    let list_of_yojson f = function
      | `List xs -> List.map f xs
      | x -> bad_type "array" x

    let yojson_of_list f xs = `List (List.map f xs)

    let option_of_yojson f = function
      | `String "None" -> None
      | `List [`String "Some"; x] -> Some (f x)
      | x -> bad_type "option" x

    let yojson_of_option f = function
      | None -> `String "None"
      | Some x -> `List [`String "Some"; f x]

    let nullable_of_yojson f = function
      | `Null -> None
      | x -> Some (f x)

    let yojson_of_nullable f = function
      | None -> `Null
      | Some x -> f x

    let assoc_of_yojson f = function
      | `Assoc pairs -> List.map (fun (k, v) -> (k, f v)) pairs
      | x -> bad_type "object" x

    let yojson_of_assoc f xs =
      `Assoc (List.map (fun (k, v) -> (k, f v)) xs)
  end
end

type yodacLanguageConfig = {
  language: string;
  ext: string;
  image: string;
  tag: string;
  compile: string option option;
  run: string;
}

let create_yodacLanguageConfig ~language ~ext ~image ~tag ?compile ~run () : yodacLanguageConfig =
  { language; ext; image; tag; compile; run }

let yodacLanguageConfig_of_yojson (x : Yojson.Safe.t) : yodacLanguageConfig =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let language =
      match assoc "language" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacLanguageConfig" "language"
    in
    let ext =
      match assoc "ext" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacLanguageConfig" "ext"
    in
    let image =
      match assoc "image" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacLanguageConfig" "image"
    in
    let tag =
      match assoc "tag" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacLanguageConfig" "tag"
    in
    let compile =
      match assoc "compile" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.nullable_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    let run =
      match assoc "run" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacLanguageConfig" "run"
    in
    { language; ext; image; tag; compile; run }
  | _ -> Atdml_runtime.Yojson.bad_type "yodacLanguageConfig" x

let yojson_of_yodacLanguageConfig (x : yodacLanguageConfig) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("language", Atdml_runtime.Yojson.yojson_of_string x.language)];
    [("ext", Atdml_runtime.Yojson.yojson_of_string x.ext)];
    [("image", Atdml_runtime.Yojson.yojson_of_string x.image)];
    [("tag", Atdml_runtime.Yojson.yojson_of_string x.tag)];
    (match x.compile with None -> [] | Some v -> [("compile", (Atdml_runtime.Yojson.yojson_of_nullable Atdml_runtime.Yojson.yojson_of_string) v)]);
    [("run", Atdml_runtime.Yojson.yojson_of_string x.run)];
  ])

let yodacLanguageConfig_of_json s =
  yodacLanguageConfig_of_yojson (Yojson.Safe.from_string s)

let json_of_yodacLanguageConfig x =
  Yojson.Safe.to_string (yojson_of_yodacLanguageConfig x)

module YodacLanguageConfig = struct
  type nonrec t = yodacLanguageConfig
  let create = create_yodacLanguageConfig
  let of_yojson = yodacLanguageConfig_of_yojson
  let to_yojson = yojson_of_yodacLanguageConfig
  let of_json = yodacLanguageConfig_of_json
  let to_json = json_of_yodacLanguageConfig
end

type yodacLanguagesConfig = yodacLanguageConfig list

let yodacLanguagesConfig_of_yojson (x : Yojson.Safe.t) : yodacLanguagesConfig =
  (Atdml_runtime.Yojson.list_of_yojson yodacLanguageConfig_of_yojson) x

let yojson_of_yodacLanguagesConfig (x : yodacLanguagesConfig) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_yodacLanguageConfig) x

let yodacLanguagesConfig_of_json s =
  yodacLanguagesConfig_of_yojson (Yojson.Safe.from_string s)

let json_of_yodacLanguagesConfig x =
  Yojson.Safe.to_string (yojson_of_yodacLanguagesConfig x)

module YodacLanguagesConfig = struct
  type nonrec t = yodacLanguagesConfig
  let of_yojson = yodacLanguagesConfig_of_yojson
  let to_yojson = yojson_of_yodacLanguagesConfig
  let of_json = yodacLanguagesConfig_of_json
  let to_json = json_of_yodacLanguagesConfig
end

type yodacConfigPutRequest = {
  config: yodacLanguagesConfig;
}

let create_yodacConfigPutRequest ~config () : yodacConfigPutRequest =
  { config }

let yodacConfigPutRequest_of_yojson (x : Yojson.Safe.t) : yodacConfigPutRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let config =
      match assoc "config" with
      | Some v -> yodacLanguagesConfig_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigPutRequest" "config"
    in
    { config }
  | _ -> Atdml_runtime.Yojson.bad_type "yodacConfigPutRequest" x

let yojson_of_yodacConfigPutRequest (x : yodacConfigPutRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("config", yojson_of_yodacLanguagesConfig x.config)];
  ])

let yodacConfigPutRequest_of_json s =
  yodacConfigPutRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_yodacConfigPutRequest x =
  Yojson.Safe.to_string (yojson_of_yodacConfigPutRequest x)

module YodacConfigPutRequest = struct
  type nonrec t = yodacConfigPutRequest
  let create = create_yodacConfigPutRequest
  let of_yojson = yodacConfigPutRequest_of_yojson
  let to_yojson = yojson_of_yodacConfigPutRequest
  let of_json = yodacConfigPutRequest_of_json
  let to_json = json_of_yodacConfigPutRequest
end

type json_ = Yojson.Safe.t

let json__of_yojson (x : Yojson.Safe.t) : json_ =
  (fun x -> x) x

let yojson_of_json_ (x : json_) : Yojson.Safe.t =
  (fun x -> x) x

let json__of_json s =
  json__of_yojson (Yojson.Safe.from_string s)

let json_of_json_ x =
  Yojson.Safe.to_string (yojson_of_json_ x)

module Json_ = struct
  type nonrec t = json_
  let of_yojson = json__of_yojson
  let to_yojson = yojson_of_json_
  let of_json = json__of_json
  let to_json = json_of_json_
end

type yodacConfigHistoryEntry = {
  version: int;
  timestamp: string;
  changed_by: string;
  action: string;
  previous_config: json_ option option;
  new_config: yodacLanguagesConfig;
}

let create_yodacConfigHistoryEntry ~version ~timestamp ~changed_by ~action ?previous_config ~new_config () : yodacConfigHistoryEntry =
  { version; timestamp; changed_by; action; previous_config; new_config }

let yodacConfigHistoryEntry_of_yojson (x : Yojson.Safe.t) : yodacConfigHistoryEntry =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let version =
      match assoc "version" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigHistoryEntry" "version"
    in
    let timestamp =
      match assoc "timestamp" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigHistoryEntry" "timestamp"
    in
    let changed_by =
      match assoc "changed_by" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigHistoryEntry" "changed_by"
    in
    let action =
      match assoc "action" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigHistoryEntry" "action"
    in
    let previous_config =
      match assoc "previous_config" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.nullable_of_yojson json__of_yojson) v)
    in
    let new_config =
      match assoc "new_config" with
      | Some v -> yodacLanguagesConfig_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigHistoryEntry" "new_config"
    in
    { version; timestamp; changed_by; action; previous_config; new_config }
  | _ -> Atdml_runtime.Yojson.bad_type "yodacConfigHistoryEntry" x

let yojson_of_yodacConfigHistoryEntry (x : yodacConfigHistoryEntry) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("version", Atdml_runtime.Yojson.yojson_of_int x.version)];
    [("timestamp", Atdml_runtime.Yojson.yojson_of_string x.timestamp)];
    [("changed_by", Atdml_runtime.Yojson.yojson_of_string x.changed_by)];
    [("action", Atdml_runtime.Yojson.yojson_of_string x.action)];
    (match x.previous_config with None -> [] | Some v -> [("previous_config", (Atdml_runtime.Yojson.yojson_of_nullable yojson_of_json_) v)]);
    [("new_config", yojson_of_yodacLanguagesConfig x.new_config)];
  ])

let yodacConfigHistoryEntry_of_json s =
  yodacConfigHistoryEntry_of_yojson (Yojson.Safe.from_string s)

let json_of_yodacConfigHistoryEntry x =
  Yojson.Safe.to_string (yojson_of_yodacConfigHistoryEntry x)

module YodacConfigHistoryEntry = struct
  type nonrec t = yodacConfigHistoryEntry
  let create = create_yodacConfigHistoryEntry
  let of_yojson = yodacConfigHistoryEntry_of_yojson
  let to_yojson = yojson_of_yodacConfigHistoryEntry
  let of_json = yodacConfigHistoryEntry_of_json
  let to_json = json_of_yodacConfigHistoryEntry
end

type yodacConfigHistoryGetResponse = yodacConfigHistoryEntry list

let yodacConfigHistoryGetResponse_of_yojson (x : Yojson.Safe.t) : yodacConfigHistoryGetResponse =
  (Atdml_runtime.Yojson.list_of_yojson yodacConfigHistoryEntry_of_yojson) x

let yojson_of_yodacConfigHistoryGetResponse (x : yodacConfigHistoryGetResponse) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_yodacConfigHistoryEntry) x

let yodacConfigHistoryGetResponse_of_json s =
  yodacConfigHistoryGetResponse_of_yojson (Yojson.Safe.from_string s)

let json_of_yodacConfigHistoryGetResponse x =
  Yojson.Safe.to_string (yojson_of_yodacConfigHistoryGetResponse x)

module YodacConfigHistoryGetResponse = struct
  type nonrec t = yodacConfigHistoryGetResponse
  let of_yojson = yodacConfigHistoryGetResponse_of_yojson
  let to_yojson = yojson_of_yodacConfigHistoryGetResponse
  let of_json = yodacConfigHistoryGetResponse_of_json
  let to_json = json_of_yodacConfigHistoryGetResponse
end

type yodacConfigGetResponse = {
  config: yodacLanguagesConfig;
  version: int;
  updated_at: string;
  updated_by: string;
}

let create_yodacConfigGetResponse ~config ~version ~updated_at ~updated_by () : yodacConfigGetResponse =
  { config; version; updated_at; updated_by }

let yodacConfigGetResponse_of_yojson (x : Yojson.Safe.t) : yodacConfigGetResponse =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let config =
      match assoc "config" with
      | Some v -> yodacLanguagesConfig_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigGetResponse" "config"
    in
    let version =
      match assoc "version" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigGetResponse" "version"
    in
    let updated_at =
      match assoc "updated_at" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigGetResponse" "updated_at"
    in
    let updated_by =
      match assoc "updated_by" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "yodacConfigGetResponse" "updated_by"
    in
    { config; version; updated_at; updated_by }
  | _ -> Atdml_runtime.Yojson.bad_type "yodacConfigGetResponse" x

let yojson_of_yodacConfigGetResponse (x : yodacConfigGetResponse) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("config", yojson_of_yodacLanguagesConfig x.config)];
    [("version", Atdml_runtime.Yojson.yojson_of_int x.version)];
    [("updated_at", Atdml_runtime.Yojson.yojson_of_string x.updated_at)];
    [("updated_by", Atdml_runtime.Yojson.yojson_of_string x.updated_by)];
  ])

let yodacConfigGetResponse_of_json s =
  yodacConfigGetResponse_of_yojson (Yojson.Safe.from_string s)

let json_of_yodacConfigGetResponse x =
  Yojson.Safe.to_string (yojson_of_yodacConfigGetResponse x)

module YodacConfigGetResponse = struct
  type nonrec t = yodacConfigGetResponse
  let create = create_yodacConfigGetResponse
  let of_yojson = yodacConfigGetResponse_of_yojson
  let to_yojson = yojson_of_yodacConfigGetResponse
  let of_json = yodacConfigGetResponse_of_json
  let to_json = json_of_yodacConfigGetResponse
end

type userRole =
  | User
  | Judge
  | Admin

let userRole_of_yojson (x : Yojson.Safe.t) : userRole =
  match x with
  | `String "user" -> User
  | `String "judge" -> Judge
  | `String "admin" -> Admin
  | _ -> Atdml_runtime.Yojson.bad_sum "userRole" x

let yojson_of_userRole (x : userRole) : Yojson.Safe.t =
  match x with
  | User -> `String "user"
  | Judge -> `String "judge"
  | Admin -> `String "admin"

let userRole_of_json s =
  userRole_of_yojson (Yojson.Safe.from_string s)

let json_of_userRole x =
  Yojson.Safe.to_string (yojson_of_userRole x)

module UserRole = struct
  type nonrec t = userRole
  let of_yojson = userRole_of_yojson
  let to_yojson = yojson_of_userRole
  let of_json = userRole_of_json
  let to_json = json_of_userRole
end

type userGroups = string list

let userGroups_of_yojson (x : Yojson.Safe.t) : userGroups =
  (Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) x

let yojson_of_userGroups (x : userGroups) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) x

let userGroups_of_json s =
  userGroups_of_yojson (Yojson.Safe.from_string s)

let json_of_userGroups x =
  Yojson.Safe.to_string (yojson_of_userGroups x)

module UserGroups = struct
  type nonrec t = userGroups
  let of_yojson = userGroups_of_yojson
  let to_yojson = yojson_of_userGroups
  let of_json = userGroups_of_json
  let to_json = json_of_userGroups
end

type userUpdateRequest = {
  username: string option;
  role: userRole option;
  groups: userGroups option;
}

let create_userUpdateRequest ?username ?role ?groups () : userUpdateRequest =
  { username; role; groups }

let userUpdateRequest_of_yojson (x : Yojson.Safe.t) : userUpdateRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let username =
      match assoc "username" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let role =
      match assoc "role" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (userRole_of_yojson v)
    in
    let groups =
      match assoc "groups" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (userGroups_of_yojson v)
    in
    { username; role; groups }
  | _ -> Atdml_runtime.Yojson.bad_type "userUpdateRequest" x

let yojson_of_userUpdateRequest (x : userUpdateRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.username with None -> [] | Some v -> [("username", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.role with None -> [] | Some v -> [("role", yojson_of_userRole v)]);
    (match x.groups with None -> [] | Some v -> [("groups", yojson_of_userGroups v)]);
  ])

let userUpdateRequest_of_json s =
  userUpdateRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_userUpdateRequest x =
  Yojson.Safe.to_string (yojson_of_userUpdateRequest x)

module UserUpdateRequest = struct
  type nonrec t = userUpdateRequest
  let create = create_userUpdateRequest
  let of_yojson = userUpdateRequest_of_yojson
  let to_yojson = yojson_of_userUpdateRequest
  let of_json = userUpdateRequest_of_json
  let to_json = json_of_userUpdateRequest
end

type userCreateRequest = {
  username: string;
  password: string;
  role: userRole;
  groups: userGroups option;
}

let create_userCreateRequest ~username ~password ~role ?groups () : userCreateRequest =
  { username; password; role; groups }

let userCreateRequest_of_yojson (x : Yojson.Safe.t) : userCreateRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let username =
      match assoc "username" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "userCreateRequest" "username"
    in
    let password =
      match assoc "password" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "userCreateRequest" "password"
    in
    let role =
      match assoc "role" with
      | Some v -> userRole_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "userCreateRequest" "role"
    in
    let groups =
      match assoc "groups" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (userGroups_of_yojson v)
    in
    { username; password; role; groups }
  | _ -> Atdml_runtime.Yojson.bad_type "userCreateRequest" x

let yojson_of_userCreateRequest (x : userCreateRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("username", Atdml_runtime.Yojson.yojson_of_string x.username)];
    [("password", Atdml_runtime.Yojson.yojson_of_string x.password)];
    [("role", yojson_of_userRole x.role)];
    (match x.groups with None -> [] | Some v -> [("groups", yojson_of_userGroups v)]);
  ])

let userCreateRequest_of_json s =
  userCreateRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_userCreateRequest x =
  Yojson.Safe.to_string (yojson_of_userCreateRequest x)

module UserCreateRequest = struct
  type nonrec t = userCreateRequest
  let create = create_userCreateRequest
  let of_yojson = userCreateRequest_of_yojson
  let to_yojson = yojson_of_userCreateRequest
  let of_json = userCreateRequest_of_json
  let to_json = json_of_userCreateRequest
end

type user = {
  id: int;
  username: string;
  role: userRole;
  groups: userGroups;
  created_at: string;
  last_seen_at: string option;
}

let create_user ~id ~username ~role ~groups ~created_at ?last_seen_at () : user =
  { id; username; role; groups; created_at; last_seen_at }

let user_of_yojson (x : Yojson.Safe.t) : user =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let id =
      match assoc "id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "user" "id"
    in
    let username =
      match assoc "username" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "user" "username"
    in
    let role =
      match assoc "role" with
      | Some v -> userRole_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "user" "role"
    in
    let groups =
      match assoc "groups" with
      | Some v -> userGroups_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "user" "groups"
    in
    let created_at =
      match assoc "created_at" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "user" "created_at"
    in
    let last_seen_at =
      match assoc "last_seen_at" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { id; username; role; groups; created_at; last_seen_at }
  | _ -> Atdml_runtime.Yojson.bad_type "user" x

let yojson_of_user (x : user) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("id", Atdml_runtime.Yojson.yojson_of_int x.id)];
    [("username", Atdml_runtime.Yojson.yojson_of_string x.username)];
    [("role", yojson_of_userRole x.role)];
    [("groups", yojson_of_userGroups x.groups)];
    [("created_at", Atdml_runtime.Yojson.yojson_of_string x.created_at)];
    (match x.last_seen_at with None -> [] | Some v -> [("last_seen_at", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let user_of_json s =
  user_of_yojson (Yojson.Safe.from_string s)

let json_of_user x =
  Yojson.Safe.to_string (yojson_of_user x)

module User = struct
  type nonrec t = user
  let create = create_user
  let of_yojson = user_of_yojson
  let to_yojson = yojson_of_user
  let of_json = user_of_json
  let to_json = json_of_user
end

type oracleConfig = {
  entrypoint: string;  (** Oracle checker entrypoint filename *)
  args: string list option;  (** Optional argv list passed to oracle checker *)
}

let create_oracleConfig ~entrypoint ?args () : oracleConfig =
  { entrypoint; args }

let oracleConfig_of_yojson (x : Yojson.Safe.t) : oracleConfig =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let entrypoint =
      match assoc "entrypoint" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "oracleConfig" "entrypoint"
    in
    let args =
      match assoc "args" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some ((Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v)
    in
    { entrypoint; args }
  | _ -> Atdml_runtime.Yojson.bad_type "oracleConfig" x

let yojson_of_oracleConfig (x : oracleConfig) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("entrypoint", Atdml_runtime.Yojson.yojson_of_string x.entrypoint)];
    (match x.args with None -> [] | Some v -> [("args", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) v)]);
  ])

let oracleConfig_of_json s =
  oracleConfig_of_yojson (Yojson.Safe.from_string s)

let json_of_oracleConfig x =
  Yojson.Safe.to_string (yojson_of_oracleConfig x)

module OracleConfig = struct
  type nonrec t = oracleConfig
  let create = create_oracleConfig
  let of_yojson = oracleConfig_of_yojson
  let to_yojson = yojson_of_oracleConfig
  let of_json = oracleConfig_of_json
  let to_json = json_of_oracleConfig
end

type testCaseCreateRequest = {
  id: int option;
  input: string;
  output: string;
  is_sample: bool;
  oracle: oracleConfig option;
}

let create_testCaseCreateRequest ?id ~input ~output ~is_sample ?oracle () : testCaseCreateRequest =
  { id; input; output; is_sample; oracle }

let testCaseCreateRequest_of_yojson (x : Yojson.Safe.t) : testCaseCreateRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let id =
      match assoc "id" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let input =
      match assoc "input" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "testCaseCreateRequest" "input"
    in
    let output =
      match assoc "output" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "testCaseCreateRequest" "output"
    in
    let is_sample =
      match assoc "is_sample" with
      | Some v -> Atdml_runtime.Yojson.bool_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "testCaseCreateRequest" "is_sample"
    in
    let oracle =
      match assoc "oracle" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (oracleConfig_of_yojson v)
    in
    { id; input; output; is_sample; oracle }
  | _ -> Atdml_runtime.Yojson.bad_type "testCaseCreateRequest" x

let yojson_of_testCaseCreateRequest (x : testCaseCreateRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.id with None -> [] | Some v -> [("id", Atdml_runtime.Yojson.yojson_of_int v)]);
    [("input", Atdml_runtime.Yojson.yojson_of_string x.input)];
    [("output", Atdml_runtime.Yojson.yojson_of_string x.output)];
    [("is_sample", Atdml_runtime.Yojson.yojson_of_bool x.is_sample)];
    (match x.oracle with None -> [] | Some v -> [("oracle", yojson_of_oracleConfig v)]);
  ])

let testCaseCreateRequest_of_json s =
  testCaseCreateRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_testCaseCreateRequest x =
  Yojson.Safe.to_string (yojson_of_testCaseCreateRequest x)

module TestCaseCreateRequest = struct
  type nonrec t = testCaseCreateRequest
  let create = create_testCaseCreateRequest
  let of_yojson = testCaseCreateRequest_of_yojson
  let to_yojson = yojson_of_testCaseCreateRequest
  let of_json = testCaseCreateRequest_of_json
  let to_json = json_of_testCaseCreateRequest
end

type testCase = {
  id: int;
  input: string;
  output: string;
  is_sample: bool;
  oracle: oracleConfig option;
}

let create_testCase ~id ~input ~output ~is_sample ?oracle () : testCase =
  { id; input; output; is_sample; oracle }

let testCase_of_yojson (x : Yojson.Safe.t) : testCase =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let id =
      match assoc "id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "testCase" "id"
    in
    let input =
      match assoc "input" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "testCase" "input"
    in
    let output =
      match assoc "output" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "testCase" "output"
    in
    let is_sample =
      match assoc "is_sample" with
      | Some v -> Atdml_runtime.Yojson.bool_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "testCase" "is_sample"
    in
    let oracle =
      match assoc "oracle" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (oracleConfig_of_yojson v)
    in
    { id; input; output; is_sample; oracle }
  | _ -> Atdml_runtime.Yojson.bad_type "testCase" x

let yojson_of_testCase (x : testCase) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("id", Atdml_runtime.Yojson.yojson_of_int x.id)];
    [("input", Atdml_runtime.Yojson.yojson_of_string x.input)];
    [("output", Atdml_runtime.Yojson.yojson_of_string x.output)];
    [("is_sample", Atdml_runtime.Yojson.yojson_of_bool x.is_sample)];
    (match x.oracle with None -> [] | Some v -> [("oracle", yojson_of_oracleConfig v)]);
  ])

let testCase_of_json s =
  testCase_of_yojson (Yojson.Safe.from_string s)

let json_of_testCase x =
  Yojson.Safe.to_string (yojson_of_testCase x)

module TestCase = struct
  type nonrec t = testCase
  let create = create_testCase
  let of_yojson = testCase_of_yojson
  let to_yojson = yojson_of_testCase
  let of_json = testCase_of_json
  let to_json = json_of_testCase
end

type submissionDetailOutputMeta = {
  stderr_score: int option;
}

let create_submissionDetailOutputMeta ?stderr_score () : submissionDetailOutputMeta =
  { stderr_score }

let submissionDetailOutputMeta_of_yojson (x : Yojson.Safe.t) : submissionDetailOutputMeta =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let stderr_score =
      match assoc "stderr_score" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    { stderr_score }
  | _ -> Atdml_runtime.Yojson.bad_type "submissionDetailOutputMeta" x

let yojson_of_submissionDetailOutputMeta (x : submissionDetailOutputMeta) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.stderr_score with None -> [] | Some v -> [("stderr_score", Atdml_runtime.Yojson.yojson_of_int v)]);
  ])

let submissionDetailOutputMeta_of_json s =
  submissionDetailOutputMeta_of_yojson (Yojson.Safe.from_string s)

let json_of_submissionDetailOutputMeta x =
  Yojson.Safe.to_string (yojson_of_submissionDetailOutputMeta x)

module SubmissionDetailOutputMeta = struct
  type nonrec t = submissionDetailOutputMeta
  let create = create_submissionDetailOutputMeta
  let of_yojson = submissionDetailOutputMeta_of_yojson
  let to_yojson = yojson_of_submissionDetailOutputMeta
  let of_json = submissionDetailOutputMeta_of_json
  let to_json = json_of_submissionDetailOutputMeta
end

type submissionDetailOutput = {
  stdout: string;
  stderr: string;
  return_code: int;
  meta: submissionDetailOutputMeta option;
}

let create_submissionDetailOutput ~stdout ~stderr ~return_code ?meta () : submissionDetailOutput =
  { stdout; stderr; return_code; meta }

let submissionDetailOutput_of_yojson (x : Yojson.Safe.t) : submissionDetailOutput =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let stdout =
      match assoc "stdout" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionDetailOutput" "stdout"
    in
    let stderr =
      match assoc "stderr" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionDetailOutput" "stderr"
    in
    let return_code =
      match assoc "return_code" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionDetailOutput" "return_code"
    in
    let meta =
      match assoc "meta" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (submissionDetailOutputMeta_of_yojson v)
    in
    { stdout; stderr; return_code; meta }
  | _ -> Atdml_runtime.Yojson.bad_type "submissionDetailOutput" x

let yojson_of_submissionDetailOutput (x : submissionDetailOutput) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("stdout", Atdml_runtime.Yojson.yojson_of_string x.stdout)];
    [("stderr", Atdml_runtime.Yojson.yojson_of_string x.stderr)];
    [("return_code", Atdml_runtime.Yojson.yojson_of_int x.return_code)];
    (match x.meta with None -> [] | Some v -> [("meta", yojson_of_submissionDetailOutputMeta v)]);
  ])

let submissionDetailOutput_of_json s =
  submissionDetailOutput_of_yojson (Yojson.Safe.from_string s)

let json_of_submissionDetailOutput x =
  Yojson.Safe.to_string (yojson_of_submissionDetailOutput x)

module SubmissionDetailOutput = struct
  type nonrec t = submissionDetailOutput
  let create = create_submissionDetailOutput
  let of_yojson = submissionDetailOutput_of_yojson
  let to_yojson = yojson_of_submissionDetailOutput
  let of_json = submissionDetailOutput_of_json
  let to_json = json_of_submissionDetailOutput
end

type submissionDetail = {
  testcase_id: int;
  status: string;
  time_ms: int;
  output: submissionDetailOutput option;
}

let create_submissionDetail ~testcase_id ~status ~time_ms ?output () : submissionDetail =
  { testcase_id; status; time_ms; output }

let submissionDetail_of_yojson (x : Yojson.Safe.t) : submissionDetail =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let testcase_id =
      match assoc "testcase_id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionDetail" "testcase_id"
    in
    let status =
      match assoc "status" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionDetail" "status"
    in
    let time_ms =
      match assoc "time_ms" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionDetail" "time_ms"
    in
    let output =
      match assoc "output" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (submissionDetailOutput_of_yojson v)
    in
    { testcase_id; status; time_ms; output }
  | _ -> Atdml_runtime.Yojson.bad_type "submissionDetail" x

let yojson_of_submissionDetail (x : submissionDetail) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("testcase_id", Atdml_runtime.Yojson.yojson_of_int x.testcase_id)];
    [("status", Atdml_runtime.Yojson.yojson_of_string x.status)];
    [("time_ms", Atdml_runtime.Yojson.yojson_of_int x.time_ms)];
    (match x.output with None -> [] | Some v -> [("output", yojson_of_submissionDetailOutput v)]);
  ])

let submissionDetail_of_json s =
  submissionDetail_of_yojson (Yojson.Safe.from_string s)

let json_of_submissionDetail x =
  Yojson.Safe.to_string (yojson_of_submissionDetail x)

module SubmissionDetail = struct
  type nonrec t = submissionDetail
  let create = create_submissionDetail
  let of_yojson = submissionDetail_of_yojson
  let to_yojson = yojson_of_submissionDetail
  let of_json = submissionDetail_of_json
  let to_json = json_of_submissionDetail
end

type submissionDetails = submissionDetail list

let submissionDetails_of_yojson (x : Yojson.Safe.t) : submissionDetails =
  (Atdml_runtime.Yojson.list_of_yojson submissionDetail_of_yojson) x

let yojson_of_submissionDetails (x : submissionDetails) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_submissionDetail) x

let submissionDetails_of_json s =
  submissionDetails_of_yojson (Yojson.Safe.from_string s)

let json_of_submissionDetails x =
  Yojson.Safe.to_string (yojson_of_submissionDetails x)

module SubmissionDetails = struct
  type nonrec t = submissionDetails
  let of_yojson = submissionDetails_of_yojson
  let to_yojson = yojson_of_submissionDetails
  let of_json = submissionDetails_of_json
  let to_json = json_of_submissionDetails
end

type submission = {
  id: int;
  problem_id: int;
  language: string option;
  status: string;
  score: int;
  time_ms: int;
  memory_kb: int;
  details: submissionDetails;
  owner: bool option;
  owner_id: int option;
  created_at: string option;
}

let create_submission ~id ~problem_id ?language ~status ~score ~time_ms ~memory_kb ~details ?owner ?owner_id ?created_at () : submission =
  { id; problem_id; language; status; score; time_ms; memory_kb; details; owner; owner_id; created_at }

let submission_of_yojson (x : Yojson.Safe.t) : submission =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let id =
      match assoc "id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submission" "id"
    in
    let problem_id =
      match assoc "problem_id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submission" "problem_id"
    in
    let language =
      match assoc "language" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let status =
      match assoc "status" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submission" "status"
    in
    let score =
      match assoc "score" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submission" "score"
    in
    let time_ms =
      match assoc "time_ms" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submission" "time_ms"
    in
    let memory_kb =
      match assoc "memory_kb" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submission" "memory_kb"
    in
    let details =
      match assoc "details" with
      | Some v -> submissionDetails_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submission" "details"
    in
    let owner =
      match assoc "owner" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let owner_id =
      match assoc "owner_id" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let created_at =
      match assoc "created_at" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    { id; problem_id; language; status; score; time_ms; memory_kb; details; owner; owner_id; created_at }
  | _ -> Atdml_runtime.Yojson.bad_type "submission" x

let yojson_of_submission (x : submission) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("id", Atdml_runtime.Yojson.yojson_of_int x.id)];
    [("problem_id", Atdml_runtime.Yojson.yojson_of_int x.problem_id)];
    (match x.language with None -> [] | Some v -> [("language", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("status", Atdml_runtime.Yojson.yojson_of_string x.status)];
    [("score", Atdml_runtime.Yojson.yojson_of_int x.score)];
    [("time_ms", Atdml_runtime.Yojson.yojson_of_int x.time_ms)];
    [("memory_kb", Atdml_runtime.Yojson.yojson_of_int x.memory_kb)];
    [("details", yojson_of_submissionDetails x.details)];
    (match x.owner with None -> [] | Some v -> [("owner", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.owner_id with None -> [] | Some v -> [("owner_id", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.created_at with None -> [] | Some v -> [("created_at", Atdml_runtime.Yojson.yojson_of_string v)]);
  ])

let submission_of_json s =
  submission_of_yojson (Yojson.Safe.from_string s)

let json_of_submission x =
  Yojson.Safe.to_string (yojson_of_submission x)

module Submission = struct
  type nonrec t = submission
  let create = create_submission
  let of_yojson = submission_of_yojson
  let to_yojson = yojson_of_submission
  let of_json = submission_of_json
  let to_json = json_of_submission
end

type submissions = submission list

let submissions_of_yojson (x : Yojson.Safe.t) : submissions =
  (Atdml_runtime.Yojson.list_of_yojson submission_of_yojson) x

let yojson_of_submissions (x : submissions) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_submission) x

let submissions_of_json s =
  submissions_of_yojson (Yojson.Safe.from_string s)

let json_of_submissions x =
  Yojson.Safe.to_string (yojson_of_submissions x)

module Submissions = struct
  type nonrec t = submissions
  let of_yojson = submissions_of_yojson
  let to_yojson = yojson_of_submissions
  let of_json = submissions_of_json
  let to_json = json_of_submissions
end

type sourceArtifact = {
  filename: string;  (** The name of the source file *)
  content: string;  (** The content of the source file *)
}

let create_sourceArtifact ~filename ~content () : sourceArtifact =
  { filename; content }

let sourceArtifact_of_yojson (x : Yojson.Safe.t) : sourceArtifact =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let filename =
      match assoc "filename" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "sourceArtifact" "filename"
    in
    let content =
      match assoc "content" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "sourceArtifact" "content"
    in
    { filename; content }
  | _ -> Atdml_runtime.Yojson.bad_type "sourceArtifact" x

let yojson_of_sourceArtifact (x : sourceArtifact) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("filename", Atdml_runtime.Yojson.yojson_of_string x.filename)];
    [("content", Atdml_runtime.Yojson.yojson_of_string x.content)];
  ])

let sourceArtifact_of_json s =
  sourceArtifact_of_yojson (Yojson.Safe.from_string s)

let json_of_sourceArtifact x =
  Yojson.Safe.to_string (yojson_of_sourceArtifact x)

module SourceArtifact = struct
  type nonrec t = sourceArtifact
  let create = create_sourceArtifact
  let of_yojson = sourceArtifact_of_yojson
  let to_yojson = yojson_of_sourceArtifact
  let of_json = sourceArtifact_of_json
  let to_json = json_of_sourceArtifact
end

type sourceArtifacts = sourceArtifact list

let sourceArtifacts_of_yojson (x : Yojson.Safe.t) : sourceArtifacts =
  (Atdml_runtime.Yojson.list_of_yojson sourceArtifact_of_yojson) x

let yojson_of_sourceArtifacts (x : sourceArtifacts) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_sourceArtifact) x

let sourceArtifacts_of_json s =
  sourceArtifacts_of_yojson (Yojson.Safe.from_string s)

let json_of_sourceArtifacts x =
  Yojson.Safe.to_string (yojson_of_sourceArtifacts x)

module SourceArtifacts = struct
  type nonrec t = sourceArtifacts
  let of_yojson = sourceArtifacts_of_yojson
  let to_yojson = yojson_of_sourceArtifacts
  let of_json = sourceArtifacts_of_json
  let to_json = json_of_sourceArtifacts
end

type submissionFullDetails = {
  submission: submission;
  source_artifacts: sourceArtifacts;
}

let create_submissionFullDetails ~submission ~source_artifacts () : submissionFullDetails =
  { submission; source_artifacts }

let submissionFullDetails_of_yojson (x : Yojson.Safe.t) : submissionFullDetails =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let submission =
      match assoc "submission" with
      | Some v -> submission_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionFullDetails" "submission"
    in
    let source_artifacts =
      match assoc "source_artifacts" with
      | Some v -> sourceArtifacts_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "submissionFullDetails" "source_artifacts"
    in
    { submission; source_artifacts }
  | _ -> Atdml_runtime.Yojson.bad_type "submissionFullDetails" x

let yojson_of_submissionFullDetails (x : submissionFullDetails) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("submission", yojson_of_submission x.submission)];
    [("source_artifacts", yojson_of_sourceArtifacts x.source_artifacts)];
  ])

let submissionFullDetails_of_json s =
  submissionFullDetails_of_yojson (Yojson.Safe.from_string s)

let json_of_submissionFullDetails x =
  Yojson.Safe.to_string (yojson_of_submissionFullDetails x)

module SubmissionFullDetails = struct
  type nonrec t = submissionFullDetails
  let create = create_submissionFullDetails
  let of_yojson = submissionFullDetails_of_yojson
  let to_yojson = yojson_of_submissionFullDetails
  let of_json = submissionFullDetails_of_json
  let to_json = json_of_submissionFullDetails
end

type statusStatus =
  | Ok
  | Maintenance

let statusStatus_of_yojson (x : Yojson.Safe.t) : statusStatus =
  match x with
  | `String "ok" -> Ok
  | `String "maintenance" -> Maintenance
  | _ -> Atdml_runtime.Yojson.bad_sum "statusStatus" x

let yojson_of_statusStatus (x : statusStatus) : Yojson.Safe.t =
  match x with
  | Ok -> `String "ok"
  | Maintenance -> `String "maintenance"

let statusStatus_of_json s =
  statusStatus_of_yojson (Yojson.Safe.from_string s)

let json_of_statusStatus x =
  Yojson.Safe.to_string (yojson_of_statusStatus x)

module StatusStatus = struct
  type nonrec t = statusStatus
  let of_yojson = statusStatus_of_yojson
  let to_yojson = yojson_of_statusStatus
  let of_json = statusStatus_of_json
  let to_json = json_of_statusStatus
end

type status = {
  status: statusStatus;
  message: string;
}

let create_status ~status ~message () : status =
  { status; message }

let status_of_yojson (x : Yojson.Safe.t) : status =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let status =
      match assoc "status" with
      | Some v -> statusStatus_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "status" "status"
    in
    let message =
      match assoc "message" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "status" "message"
    in
    { status; message }
  | _ -> Atdml_runtime.Yojson.bad_type "status" x

let yojson_of_status (x : status) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("status", yojson_of_statusStatus x.status)];
    [("message", Atdml_runtime.Yojson.yojson_of_string x.message)];
  ])

let status_of_json s =
  status_of_yojson (Yojson.Safe.from_string s)

let json_of_status x =
  Yojson.Safe.to_string (yojson_of_status x)

module Status = struct
  type nonrec t = status
  let create = create_status
  let of_yojson = status_of_yojson
  let to_yojson = yojson_of_status
  let of_json = status_of_json
  let to_json = json_of_status
end

type solution = {
  problem_id: int;
  language: string;
  source_artifacts: sourceArtifacts;
}

let create_solution ~problem_id ~language ~source_artifacts () : solution =
  { problem_id; language; source_artifacts }

let solution_of_yojson (x : Yojson.Safe.t) : solution =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let problem_id =
      match assoc "problem_id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "solution" "problem_id"
    in
    let language =
      match assoc "language" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "solution" "language"
    in
    let source_artifacts =
      match assoc "source_artifacts" with
      | Some v -> sourceArtifacts_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "solution" "source_artifacts"
    in
    { problem_id; language; source_artifacts }
  | _ -> Atdml_runtime.Yojson.bad_type "solution" x

let yojson_of_solution (x : solution) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("problem_id", Atdml_runtime.Yojson.yojson_of_int x.problem_id)];
    [("language", Atdml_runtime.Yojson.yojson_of_string x.language)];
    [("source_artifacts", yojson_of_sourceArtifacts x.source_artifacts)];
  ])

let solution_of_json s =
  solution_of_yojson (Yojson.Safe.from_string s)

let json_of_solution x =
  Yojson.Safe.to_string (yojson_of_solution x)

module Solution = struct
  type nonrec t = solution
  let create = create_solution
  let of_yojson = solution_of_yojson
  let to_yojson = yojson_of_solution
  let of_json = solution_of_json
  let to_json = json_of_solution
end

type scoreboardEntry = {
  team: string;
  solved: int;
  penalty: int;
  problems: json_;
}

let create_scoreboardEntry ~team ~solved ~penalty ~problems () : scoreboardEntry =
  { team; solved; penalty; problems }

let scoreboardEntry_of_yojson (x : Yojson.Safe.t) : scoreboardEntry =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let team =
      match assoc "team" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "scoreboardEntry" "team"
    in
    let solved =
      match assoc "solved" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "scoreboardEntry" "solved"
    in
    let penalty =
      match assoc "penalty" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "scoreboardEntry" "penalty"
    in
    let problems =
      match assoc "problems" with
      | Some v -> json__of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "scoreboardEntry" "problems"
    in
    { team; solved; penalty; problems }
  | _ -> Atdml_runtime.Yojson.bad_type "scoreboardEntry" x

let yojson_of_scoreboardEntry (x : scoreboardEntry) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("team", Atdml_runtime.Yojson.yojson_of_string x.team)];
    [("solved", Atdml_runtime.Yojson.yojson_of_int x.solved)];
    [("penalty", Atdml_runtime.Yojson.yojson_of_int x.penalty)];
    [("problems", yojson_of_json_ x.problems)];
  ])

let scoreboardEntry_of_json s =
  scoreboardEntry_of_yojson (Yojson.Safe.from_string s)

let json_of_scoreboardEntry x =
  Yojson.Safe.to_string (yojson_of_scoreboardEntry x)

module ScoreboardEntry = struct
  type nonrec t = scoreboardEntry
  let create = create_scoreboardEntry
  let of_yojson = scoreboardEntry_of_yojson
  let to_yojson = yojson_of_scoreboardEntry
  let of_json = scoreboardEntry_of_json
  let to_json = json_of_scoreboardEntry
end

type problemsIdTestcasesGetResponse2 = testCase list

let problemsIdTestcasesGetResponse2_of_yojson (x : Yojson.Safe.t) : problemsIdTestcasesGetResponse2 =
  (Atdml_runtime.Yojson.list_of_yojson testCase_of_yojson) x

let yojson_of_problemsIdTestcasesGetResponse2 (x : problemsIdTestcasesGetResponse2) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_testCase) x

let problemsIdTestcasesGetResponse2_of_json s =
  problemsIdTestcasesGetResponse2_of_yojson (Yojson.Safe.from_string s)

let json_of_problemsIdTestcasesGetResponse2 x =
  Yojson.Safe.to_string (yojson_of_problemsIdTestcasesGetResponse2 x)

module ProblemsIdTestcasesGetResponse2 = struct
  type nonrec t = problemsIdTestcasesGetResponse2
  let of_yojson = problemsIdTestcasesGetResponse2_of_yojson
  let to_yojson = yojson_of_problemsIdTestcasesGetResponse2
  let of_json = problemsIdTestcasesGetResponse2_of_json
  let to_json = json_of_problemsIdTestcasesGetResponse2
end

type objectArtifact = {
  filename: string;  (** The name of the object file *)
  content: string;  (** The content of the object file *)
  sha256: string option;  (** The SHA256 hash of the object file *)
  size: int option;  (** The size of the object file in bytes *)
}

let create_objectArtifact ~filename ~content ?sha256 ?size () : objectArtifact =
  { filename; content; sha256; size }

let objectArtifact_of_yojson (x : Yojson.Safe.t) : objectArtifact =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let filename =
      match assoc "filename" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "objectArtifact" "filename"
    in
    let content =
      match assoc "content" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "objectArtifact" "content"
    in
    let sha256 =
      match assoc "sha256" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let size =
      match assoc "size" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    { filename; content; sha256; size }
  | _ -> Atdml_runtime.Yojson.bad_type "objectArtifact" x

let yojson_of_objectArtifact (x : objectArtifact) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("filename", Atdml_runtime.Yojson.yojson_of_string x.filename)];
    [("content", Atdml_runtime.Yojson.yojson_of_string x.content)];
    (match x.sha256 with None -> [] | Some v -> [("sha256", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.size with None -> [] | Some v -> [("size", Atdml_runtime.Yojson.yojson_of_int v)]);
  ])

let objectArtifact_of_json s =
  objectArtifact_of_yojson (Yojson.Safe.from_string s)

let json_of_objectArtifact x =
  Yojson.Safe.to_string (yojson_of_objectArtifact x)

module ObjectArtifact = struct
  type nonrec t = objectArtifact
  let create = create_objectArtifact
  let of_yojson = objectArtifact_of_yojson
  let to_yojson = yojson_of_objectArtifact
  let of_json = objectArtifact_of_json
  let to_json = json_of_objectArtifact
end

type objectArtifacts = objectArtifact list

let objectArtifacts_of_yojson (x : Yojson.Safe.t) : objectArtifacts =
  (Atdml_runtime.Yojson.list_of_yojson objectArtifact_of_yojson) x

let yojson_of_objectArtifacts (x : objectArtifacts) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_objectArtifact) x

let objectArtifacts_of_json s =
  objectArtifacts_of_yojson (Yojson.Safe.from_string s)

let json_of_objectArtifacts x =
  Yojson.Safe.to_string (yojson_of_objectArtifacts x)

module ObjectArtifacts = struct
  type nonrec t = objectArtifacts
  let of_yojson = objectArtifacts_of_yojson
  let to_yojson = yojson_of_objectArtifacts
  let of_json = objectArtifacts_of_json
  let to_json = json_of_objectArtifacts
end

type languages = string list

let languages_of_yojson (x : Yojson.Safe.t) : languages =
  (Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) x

let yojson_of_languages (x : languages) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) x

let languages_of_json s =
  languages_of_yojson (Yojson.Safe.from_string s)

let json_of_languages x =
  Yojson.Safe.to_string (yojson_of_languages x)

module Languages = struct
  type nonrec t = languages
  let of_yojson = languages_of_yojson
  let to_yojson = yojson_of_languages
  let of_json = languages_of_json
  let to_json = json_of_languages
end

type problemUpdateRequest = {
  code: string option;
  title: string option;
  description: string option;
  input_spec: string option;
  output_spec: string option;
  open_at: string option;
  close_at: string option;
  is_force_closed: bool option;
  languages: languages option;
  time_limit_ms: int option;
  memory_limit_mb: int option;
  source_artifacts: sourceArtifacts option;
  object_artifacts: objectArtifacts option;
}

let create_problemUpdateRequest ?code ?title ?description ?input_spec ?output_spec ?open_at ?close_at ?is_force_closed ?languages ?time_limit_ms ?memory_limit_mb ?source_artifacts ?object_artifacts () : problemUpdateRequest =
  { code; title; description; input_spec; output_spec; open_at; close_at; is_force_closed; languages; time_limit_ms; memory_limit_mb; source_artifacts; object_artifacts }

let problemUpdateRequest_of_yojson (x : Yojson.Safe.t) : problemUpdateRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let code =
      match assoc "code" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let title =
      match assoc "title" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let input_spec =
      match assoc "input_spec" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let output_spec =
      match assoc "output_spec" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let open_at =
      match assoc "open_at" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let close_at =
      match assoc "close_at" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let is_force_closed =
      match assoc "is_force_closed" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let languages =
      match assoc "languages" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (languages_of_yojson v)
    in
    let time_limit_ms =
      match assoc "time_limit_ms" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let memory_limit_mb =
      match assoc "memory_limit_mb" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let source_artifacts =
      match assoc "source_artifacts" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (sourceArtifacts_of_yojson v)
    in
    let object_artifacts =
      match assoc "object_artifacts" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (objectArtifacts_of_yojson v)
    in
    { code; title; description; input_spec; output_spec; open_at; close_at; is_force_closed; languages; time_limit_ms; memory_limit_mb; source_artifacts; object_artifacts }
  | _ -> Atdml_runtime.Yojson.bad_type "problemUpdateRequest" x

let yojson_of_problemUpdateRequest (x : problemUpdateRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.code with None -> [] | Some v -> [("code", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.title with None -> [] | Some v -> [("title", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.input_spec with None -> [] | Some v -> [("input_spec", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.output_spec with None -> [] | Some v -> [("output_spec", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.open_at with None -> [] | Some v -> [("open_at", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.close_at with None -> [] | Some v -> [("close_at", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.is_force_closed with None -> [] | Some v -> [("is_force_closed", Atdml_runtime.Yojson.yojson_of_bool v)]);
    (match x.languages with None -> [] | Some v -> [("languages", yojson_of_languages v)]);
    (match x.time_limit_ms with None -> [] | Some v -> [("time_limit_ms", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.memory_limit_mb with None -> [] | Some v -> [("memory_limit_mb", Atdml_runtime.Yojson.yojson_of_int v)]);
    (match x.source_artifacts with None -> [] | Some v -> [("source_artifacts", yojson_of_sourceArtifacts v)]);
    (match x.object_artifacts with None -> [] | Some v -> [("object_artifacts", yojson_of_objectArtifacts v)]);
  ])

let problemUpdateRequest_of_json s =
  problemUpdateRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_problemUpdateRequest x =
  Yojson.Safe.to_string (yojson_of_problemUpdateRequest x)

module ProblemUpdateRequest = struct
  type nonrec t = problemUpdateRequest
  let create = create_problemUpdateRequest
  let of_yojson = problemUpdateRequest_of_yojson
  let to_yojson = yojson_of_problemUpdateRequest
  let of_json = problemUpdateRequest_of_json
  let to_json = json_of_problemUpdateRequest
end

type problemCreateRequest = {
  code: string;
  title: string;
  description: string;
  input_spec: string;
  output_spec: string;
  languages: languages;
  time_limit_ms: int;
  memory_limit_mb: int;
  source_artifacts: sourceArtifacts;
}

let create_problemCreateRequest ~code ~title ~description ~input_spec ~output_spec ~languages ~time_limit_ms ~memory_limit_mb ~source_artifacts () : problemCreateRequest =
  { code; title; description; input_spec; output_spec; languages; time_limit_ms; memory_limit_mb; source_artifacts }

let problemCreateRequest_of_yojson (x : Yojson.Safe.t) : problemCreateRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let code =
      match assoc "code" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "code"
    in
    let title =
      match assoc "title" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "title"
    in
    let description =
      match assoc "description" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "description"
    in
    let input_spec =
      match assoc "input_spec" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "input_spec"
    in
    let output_spec =
      match assoc "output_spec" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "output_spec"
    in
    let languages =
      match assoc "languages" with
      | Some v -> languages_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "languages"
    in
    let time_limit_ms =
      match assoc "time_limit_ms" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "time_limit_ms"
    in
    let memory_limit_mb =
      match assoc "memory_limit_mb" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "memory_limit_mb"
    in
    let source_artifacts =
      match assoc "source_artifacts" with
      | Some v -> sourceArtifacts_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problemCreateRequest" "source_artifacts"
    in
    { code; title; description; input_spec; output_spec; languages; time_limit_ms; memory_limit_mb; source_artifacts }
  | _ -> Atdml_runtime.Yojson.bad_type "problemCreateRequest" x

let yojson_of_problemCreateRequest (x : problemCreateRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("code", Atdml_runtime.Yojson.yojson_of_string x.code)];
    [("title", Atdml_runtime.Yojson.yojson_of_string x.title)];
    [("description", Atdml_runtime.Yojson.yojson_of_string x.description)];
    [("input_spec", Atdml_runtime.Yojson.yojson_of_string x.input_spec)];
    [("output_spec", Atdml_runtime.Yojson.yojson_of_string x.output_spec)];
    [("languages", yojson_of_languages x.languages)];
    [("time_limit_ms", Atdml_runtime.Yojson.yojson_of_int x.time_limit_ms)];
    [("memory_limit_mb", Atdml_runtime.Yojson.yojson_of_int x.memory_limit_mb)];
    [("source_artifacts", yojson_of_sourceArtifacts x.source_artifacts)];
  ])

let problemCreateRequest_of_json s =
  problemCreateRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_problemCreateRequest x =
  Yojson.Safe.to_string (yojson_of_problemCreateRequest x)

module ProblemCreateRequest = struct
  type nonrec t = problemCreateRequest
  let create = create_problemCreateRequest
  let of_yojson = problemCreateRequest_of_yojson
  let to_yojson = yojson_of_problemCreateRequest
  let of_json = problemCreateRequest_of_json
  let to_json = json_of_problemCreateRequest
end

type problem = {
  id: int option;
  code: string;
  title: string;
  time_limit_ms: int;
  memory_limit_mb: int;
  description: string;
  input_spec: string;
  output_spec: string;
  open_at: string option;  (** Optional date/time from which the problem is open. *)
  close_at: string option;  (** Optional date/time after which the problem is closed. *)
  is_force_closed: bool option;  (** True when the problem has been manually stopped by an admin. *)
  languages: languages;
  source_artifacts: sourceArtifacts option;
  object_artifacts: objectArtifacts option;
}

let create_problem ?id ~code ~title ~time_limit_ms ~memory_limit_mb ~description ~input_spec ~output_spec ?open_at ?close_at ?is_force_closed ~languages ?source_artifacts ?object_artifacts () : problem =
  { id; code; title; time_limit_ms; memory_limit_mb; description; input_spec; output_spec; open_at; close_at; is_force_closed; languages; source_artifacts; object_artifacts }

let problem_of_yojson (x : Yojson.Safe.t) : problem =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let id =
      match assoc "id" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let code =
      match assoc "code" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "code"
    in
    let title =
      match assoc "title" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "title"
    in
    let time_limit_ms =
      match assoc "time_limit_ms" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "time_limit_ms"
    in
    let memory_limit_mb =
      match assoc "memory_limit_mb" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "memory_limit_mb"
    in
    let description =
      match assoc "description" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "description"
    in
    let input_spec =
      match assoc "input_spec" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "input_spec"
    in
    let output_spec =
      match assoc "output_spec" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "output_spec"
    in
    let open_at =
      match assoc "open_at" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let close_at =
      match assoc "close_at" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let is_force_closed =
      match assoc "is_force_closed" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.bool_of_yojson v)
    in
    let languages =
      match assoc "languages" with
      | Some v -> languages_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "problem" "languages"
    in
    let source_artifacts =
      match assoc "source_artifacts" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (sourceArtifacts_of_yojson v)
    in
    let object_artifacts =
      match assoc "object_artifacts" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (objectArtifacts_of_yojson v)
    in
    { id; code; title; time_limit_ms; memory_limit_mb; description; input_spec; output_spec; open_at; close_at; is_force_closed; languages; source_artifacts; object_artifacts }
  | _ -> Atdml_runtime.Yojson.bad_type "problem" x

let yojson_of_problem (x : problem) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.id with None -> [] | Some v -> [("id", Atdml_runtime.Yojson.yojson_of_int v)]);
    [("code", Atdml_runtime.Yojson.yojson_of_string x.code)];
    [("title", Atdml_runtime.Yojson.yojson_of_string x.title)];
    [("time_limit_ms", Atdml_runtime.Yojson.yojson_of_int x.time_limit_ms)];
    [("memory_limit_mb", Atdml_runtime.Yojson.yojson_of_int x.memory_limit_mb)];
    [("description", Atdml_runtime.Yojson.yojson_of_string x.description)];
    [("input_spec", Atdml_runtime.Yojson.yojson_of_string x.input_spec)];
    [("output_spec", Atdml_runtime.Yojson.yojson_of_string x.output_spec)];
    (match x.open_at with None -> [] | Some v -> [("open_at", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.close_at with None -> [] | Some v -> [("close_at", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.is_force_closed with None -> [] | Some v -> [("is_force_closed", Atdml_runtime.Yojson.yojson_of_bool v)]);
    [("languages", yojson_of_languages x.languages)];
    (match x.source_artifacts with None -> [] | Some v -> [("source_artifacts", yojson_of_sourceArtifacts v)]);
    (match x.object_artifacts with None -> [] | Some v -> [("object_artifacts", yojson_of_objectArtifacts v)]);
  ])

let problem_of_json s =
  problem_of_yojson (Yojson.Safe.from_string s)

let json_of_problem x =
  Yojson.Safe.to_string (yojson_of_problem x)

module Problem = struct
  type nonrec t = problem
  let create = create_problem
  let of_yojson = problem_of_yojson
  let to_yojson = yojson_of_problem
  let of_json = problem_of_json
  let to_json = json_of_problem
end

type job = {
  submission_id: int;
  user_id: int;
  problem_id: int;
  lang: string;
  source_code: string;
  time_limit_ms: int;
  memory_limit_mb: int;
  testcases: testCase list;
}

let create_job ~submission_id ~user_id ~problem_id ~lang ~source_code ~time_limit_ms ~memory_limit_mb ~testcases () : job =
  { submission_id; user_id; problem_id; lang; source_code; time_limit_ms; memory_limit_mb; testcases }

let job_of_yojson (x : Yojson.Safe.t) : job =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let submission_id =
      match assoc "submission_id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "job" "submission_id"
    in
    let user_id =
      match assoc "user_id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "job" "user_id"
    in
    let problem_id =
      match assoc "problem_id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "job" "problem_id"
    in
    let lang =
      match assoc "lang" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "job" "lang"
    in
    let source_code =
      match assoc "source_code" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "job" "source_code"
    in
    let time_limit_ms =
      match assoc "time_limit_ms" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "job" "time_limit_ms"
    in
    let memory_limit_mb =
      match assoc "memory_limit_mb" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "job" "memory_limit_mb"
    in
    let testcases =
      match assoc "testcases" with
      | Some v -> (Atdml_runtime.Yojson.list_of_yojson testCase_of_yojson) v
      | None -> Atdml_runtime.Yojson.missing_field "job" "testcases"
    in
    { submission_id; user_id; problem_id; lang; source_code; time_limit_ms; memory_limit_mb; testcases }
  | _ -> Atdml_runtime.Yojson.bad_type "job" x

let yojson_of_job (x : job) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("submission_id", Atdml_runtime.Yojson.yojson_of_int x.submission_id)];
    [("user_id", Atdml_runtime.Yojson.yojson_of_int x.user_id)];
    [("problem_id", Atdml_runtime.Yojson.yojson_of_int x.problem_id)];
    [("lang", Atdml_runtime.Yojson.yojson_of_string x.lang)];
    [("source_code", Atdml_runtime.Yojson.yojson_of_string x.source_code)];
    [("time_limit_ms", Atdml_runtime.Yojson.yojson_of_int x.time_limit_ms)];
    [("memory_limit_mb", Atdml_runtime.Yojson.yojson_of_int x.memory_limit_mb)];
    [("testcases", (Atdml_runtime.Yojson.yojson_of_list yojson_of_testCase) x.testcases)];
  ])

let job_of_json s =
  job_of_yojson (Yojson.Safe.from_string s)

let json_of_job x =
  Yojson.Safe.to_string (yojson_of_job x)

module Job = struct
  type nonrec t = job
  let create = create_job
  let of_yojson = job_of_yojson
  let to_yojson = yojson_of_job
  let of_json = job_of_json
  let to_json = json_of_job
end

type int64 = int

let create_int64 (x : int) : int64 = x


let int64_of_yojson (x : Yojson.Safe.t) : int64 =
  Atdml_runtime.Yojson.int_of_yojson x

let yojson_of_int64 (x : int64) : Yojson.Safe.t =
  Atdml_runtime.Yojson.yojson_of_int x

let int64_of_json s =
  int64_of_yojson (Yojson.Safe.from_string s)

let json_of_int64 x =
  Yojson.Safe.to_string (yojson_of_int64 x)

module Int64 = struct
  type nonrec t = int64
  let create = create_int64
  let of_yojson = int64_of_yojson
  let to_yojson = yojson_of_int64
  let of_json = int64_of_json
  let to_json = json_of_int64
end

type errorResponse = {
  error: string;
}

let create_errorResponse ~error () : errorResponse =
  { error }

let errorResponse_of_yojson (x : Yojson.Safe.t) : errorResponse =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let error =
      match assoc "error" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "errorResponse" "error"
    in
    { error }
  | _ -> Atdml_runtime.Yojson.bad_type "errorResponse" x

let yojson_of_errorResponse (x : errorResponse) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("error", Atdml_runtime.Yojson.yojson_of_string x.error)];
  ])

let errorResponse_of_json s =
  errorResponse_of_yojson (Yojson.Safe.from_string s)

let json_of_errorResponse x =
  Yojson.Safe.to_string (yojson_of_errorResponse x)

module ErrorResponse = struct
  type nonrec t = errorResponse
  let create = create_errorResponse
  let of_yojson = errorResponse_of_yojson
  let to_yojson = yojson_of_errorResponse
  let of_json = errorResponse_of_json
  let to_json = json_of_errorResponse
end

type contestsIdScoreboardGetResponse2 = scoreboardEntry list

let contestsIdScoreboardGetResponse2_of_yojson (x : Yojson.Safe.t) : contestsIdScoreboardGetResponse2 =
  (Atdml_runtime.Yojson.list_of_yojson scoreboardEntry_of_yojson) x

let yojson_of_contestsIdScoreboardGetResponse2 (x : contestsIdScoreboardGetResponse2) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_scoreboardEntry) x

let contestsIdScoreboardGetResponse2_of_json s =
  contestsIdScoreboardGetResponse2_of_yojson (Yojson.Safe.from_string s)

let json_of_contestsIdScoreboardGetResponse2 x =
  Yojson.Safe.to_string (yojson_of_contestsIdScoreboardGetResponse2 x)

module ContestsIdScoreboardGetResponse2 = struct
  type nonrec t = contestsIdScoreboardGetResponse2
  let of_yojson = contestsIdScoreboardGetResponse2_of_yojson
  let to_yojson = yojson_of_contestsIdScoreboardGetResponse2
  let of_json = contestsIdScoreboardGetResponse2_of_json
  let to_json = json_of_contestsIdScoreboardGetResponse2
end

type contestStatus =
  | Upcoming
  | Running
  | Finished

let contestStatus_of_yojson (x : Yojson.Safe.t) : contestStatus =
  match x with
  | `String "upcoming" -> Upcoming
  | `String "running" -> Running
  | `String "finished" -> Finished
  | _ -> Atdml_runtime.Yojson.bad_sum "contestStatus" x

let yojson_of_contestStatus (x : contestStatus) : Yojson.Safe.t =
  match x with
  | Upcoming -> `String "upcoming"
  | Running -> `String "running"
  | Finished -> `String "finished"

let contestStatus_of_json s =
  contestStatus_of_yojson (Yojson.Safe.from_string s)

let json_of_contestStatus x =
  Yojson.Safe.to_string (yojson_of_contestStatus x)

module ContestStatus = struct
  type nonrec t = contestStatus
  let of_yojson = contestStatus_of_yojson
  let to_yojson = yojson_of_contestStatus
  let of_json = contestStatus_of_json
  let to_json = json_of_contestStatus
end

type contest = {
  title: string;
  description: string option;
  start_time: string;
  end_time: string option;
  status: contestStatus;
  id: int;
}

let create_contest ~title ?description ~start_time ?end_time ~status ~id () : contest =
  { title; description; start_time; end_time; status; id }

let contest_of_yojson (x : Yojson.Safe.t) : contest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let title =
      match assoc "title" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contest" "title"
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let start_time =
      match assoc "start_time" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contest" "start_time"
    in
    let end_time =
      match assoc "end_time" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let status =
      match assoc "status" with
      | Some v -> contestStatus_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contest" "status"
    in
    let id =
      match assoc "id" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contest" "id"
    in
    { title; description; start_time; end_time; status; id }
  | _ -> Atdml_runtime.Yojson.bad_type "contest" x

let yojson_of_contest (x : contest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("title", Atdml_runtime.Yojson.yojson_of_string x.title)];
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("start_time", Atdml_runtime.Yojson.yojson_of_string x.start_time)];
    (match x.end_time with None -> [] | Some v -> [("end_time", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("status", yojson_of_contestStatus x.status)];
    [("id", Atdml_runtime.Yojson.yojson_of_int x.id)];
  ])

let contest_of_json s =
  contest_of_yojson (Yojson.Safe.from_string s)

let json_of_contest x =
  Yojson.Safe.to_string (yojson_of_contest x)

module Contest = struct
  type nonrec t = contest
  let create = create_contest
  let of_yojson = contest_of_yojson
  let to_yojson = yojson_of_contest
  let of_json = contest_of_json
  let to_json = json_of_contest
end

type contestsGetResponse2 = contest list

let contestsGetResponse2_of_yojson (x : Yojson.Safe.t) : contestsGetResponse2 =
  (Atdml_runtime.Yojson.list_of_yojson contest_of_yojson) x

let yojson_of_contestsGetResponse2 (x : contestsGetResponse2) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_contest) x

let contestsGetResponse2_of_json s =
  contestsGetResponse2_of_yojson (Yojson.Safe.from_string s)

let json_of_contestsGetResponse2 x =
  Yojson.Safe.to_string (yojson_of_contestsGetResponse2 x)

module ContestsGetResponse2 = struct
  type nonrec t = contestsGetResponse2
  let of_yojson = contestsGetResponse2_of_yojson
  let to_yojson = yojson_of_contestsGetResponse2
  let of_json = contestsGetResponse2_of_json
  let to_json = json_of_contestsGetResponse2
end

type contestsContestsidProblemsGetResponse2 = problem list

let contestsContestsidProblemsGetResponse2_of_yojson (x : Yojson.Safe.t) : contestsContestsidProblemsGetResponse2 =
  (Atdml_runtime.Yojson.list_of_yojson problem_of_yojson) x

let yojson_of_contestsContestsidProblemsGetResponse2 (x : contestsContestsidProblemsGetResponse2) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_problem) x

let contestsContestsidProblemsGetResponse2_of_json s =
  contestsContestsidProblemsGetResponse2_of_yojson (Yojson.Safe.from_string s)

let json_of_contestsContestsidProblemsGetResponse2 x =
  Yojson.Safe.to_string (yojson_of_contestsContestsidProblemsGetResponse2 x)

module ContestsContestsidProblemsGetResponse2 = struct
  type nonrec t = contestsContestsidProblemsGetResponse2
  let of_yojson = contestsContestsidProblemsGetResponse2_of_yojson
  let to_yojson = yojson_of_contestsContestsidProblemsGetResponse2
  let of_json = contestsContestsidProblemsGetResponse2_of_json
  let to_json = json_of_contestsContestsidProblemsGetResponse2
end

type contestUpdateRequestStatus =
  | Upcoming
  | Running
  | Finished

let contestUpdateRequestStatus_of_yojson (x : Yojson.Safe.t) : contestUpdateRequestStatus =
  match x with
  | `String "upcoming" -> Upcoming
  | `String "running" -> Running
  | `String "finished" -> Finished
  | _ -> Atdml_runtime.Yojson.bad_sum "contestUpdateRequestStatus" x

let yojson_of_contestUpdateRequestStatus (x : contestUpdateRequestStatus) : Yojson.Safe.t =
  match x with
  | Upcoming -> `String "upcoming"
  | Running -> `String "running"
  | Finished -> `String "finished"

let contestUpdateRequestStatus_of_json s =
  contestUpdateRequestStatus_of_yojson (Yojson.Safe.from_string s)

let json_of_contestUpdateRequestStatus x =
  Yojson.Safe.to_string (yojson_of_contestUpdateRequestStatus x)

module ContestUpdateRequestStatus = struct
  type nonrec t = contestUpdateRequestStatus
  let of_yojson = contestUpdateRequestStatus_of_yojson
  let to_yojson = yojson_of_contestUpdateRequestStatus
  let of_json = contestUpdateRequestStatus_of_json
  let to_json = json_of_contestUpdateRequestStatus
end

type contestUpdateRequest = {
  title: string option;
  description: string option;
  start_time: string option;
  end_time: string option;
  status: contestUpdateRequestStatus option;
  allowed_groups: userGroups option;
}

let create_contestUpdateRequest ?title ?description ?start_time ?end_time ?status ?allowed_groups () : contestUpdateRequest =
  { title; description; start_time; end_time; status; allowed_groups }

let contestUpdateRequest_of_yojson (x : Yojson.Safe.t) : contestUpdateRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let title =
      match assoc "title" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let start_time =
      match assoc "start_time" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let end_time =
      match assoc "end_time" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let status =
      match assoc "status" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (contestUpdateRequestStatus_of_yojson v)
    in
    let allowed_groups =
      match assoc "allowed_groups" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (userGroups_of_yojson v)
    in
    { title; description; start_time; end_time; status; allowed_groups }
  | _ -> Atdml_runtime.Yojson.bad_type "contestUpdateRequest" x

let yojson_of_contestUpdateRequest (x : contestUpdateRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.title with None -> [] | Some v -> [("title", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.start_time with None -> [] | Some v -> [("start_time", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.end_time with None -> [] | Some v -> [("end_time", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.status with None -> [] | Some v -> [("status", yojson_of_contestUpdateRequestStatus v)]);
    (match x.allowed_groups with None -> [] | Some v -> [("allowed_groups", yojson_of_userGroups v)]);
  ])

let contestUpdateRequest_of_json s =
  contestUpdateRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_contestUpdateRequest x =
  Yojson.Safe.to_string (yojson_of_contestUpdateRequest x)

module ContestUpdateRequest = struct
  type nonrec t = contestUpdateRequest
  let create = create_contestUpdateRequest
  let of_yojson = contestUpdateRequest_of_yojson
  let to_yojson = yojson_of_contestUpdateRequest
  let of_json = contestUpdateRequest_of_json
  let to_json = json_of_contestUpdateRequest
end

type contestFieldsStatus =
  | Upcoming
  | Running
  | Finished

let contestFieldsStatus_of_yojson (x : Yojson.Safe.t) : contestFieldsStatus =
  match x with
  | `String "upcoming" -> Upcoming
  | `String "running" -> Running
  | `String "finished" -> Finished
  | _ -> Atdml_runtime.Yojson.bad_sum "contestFieldsStatus" x

let yojson_of_contestFieldsStatus (x : contestFieldsStatus) : Yojson.Safe.t =
  match x with
  | Upcoming -> `String "upcoming"
  | Running -> `String "running"
  | Finished -> `String "finished"

let contestFieldsStatus_of_json s =
  contestFieldsStatus_of_yojson (Yojson.Safe.from_string s)

let json_of_contestFieldsStatus x =
  Yojson.Safe.to_string (yojson_of_contestFieldsStatus x)

module ContestFieldsStatus = struct
  type nonrec t = contestFieldsStatus
  let of_yojson = contestFieldsStatus_of_yojson
  let to_yojson = yojson_of_contestFieldsStatus
  let of_json = contestFieldsStatus_of_json
  let to_json = json_of_contestFieldsStatus
end

type contestFields = {
  title: string option;
  description: string option;
  start_time: string option;
  end_time: string option;
  status: contestFieldsStatus option;
}

let create_contestFields ?title ?description ?start_time ?end_time ?status () : contestFields =
  { title; description; start_time; end_time; status }

let contestFields_of_yojson (x : Yojson.Safe.t) : contestFields =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let title =
      match assoc "title" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let start_time =
      match assoc "start_time" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let end_time =
      match assoc "end_time" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let status =
      match assoc "status" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (contestFieldsStatus_of_yojson v)
    in
    { title; description; start_time; end_time; status }
  | _ -> Atdml_runtime.Yojson.bad_type "contestFields" x

let yojson_of_contestFields (x : contestFields) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.title with None -> [] | Some v -> [("title", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.start_time with None -> [] | Some v -> [("start_time", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.end_time with None -> [] | Some v -> [("end_time", Atdml_runtime.Yojson.yojson_of_string v)]);
    (match x.status with None -> [] | Some v -> [("status", yojson_of_contestFieldsStatus v)]);
  ])

let contestFields_of_json s =
  contestFields_of_yojson (Yojson.Safe.from_string s)

let json_of_contestFields x =
  Yojson.Safe.to_string (yojson_of_contestFields x)

module ContestFields = struct
  type nonrec t = contestFields
  let create = create_contestFields
  let of_yojson = contestFields_of_yojson
  let to_yojson = yojson_of_contestFields
  let of_json = contestFields_of_json
  let to_json = json_of_contestFields
end

type contestCreateRequestStatus =
  | Upcoming
  | Running
  | Finished

let contestCreateRequestStatus_of_yojson (x : Yojson.Safe.t) : contestCreateRequestStatus =
  match x with
  | `String "upcoming" -> Upcoming
  | `String "running" -> Running
  | `String "finished" -> Finished
  | _ -> Atdml_runtime.Yojson.bad_sum "contestCreateRequestStatus" x

let yojson_of_contestCreateRequestStatus (x : contestCreateRequestStatus) : Yojson.Safe.t =
  match x with
  | Upcoming -> `String "upcoming"
  | Running -> `String "running"
  | Finished -> `String "finished"

let contestCreateRequestStatus_of_json s =
  contestCreateRequestStatus_of_yojson (Yojson.Safe.from_string s)

let json_of_contestCreateRequestStatus x =
  Yojson.Safe.to_string (yojson_of_contestCreateRequestStatus x)

module ContestCreateRequestStatus = struct
  type nonrec t = contestCreateRequestStatus
  let of_yojson = contestCreateRequestStatus_of_yojson
  let to_yojson = yojson_of_contestCreateRequestStatus
  let of_json = contestCreateRequestStatus_of_json
  let to_json = json_of_contestCreateRequestStatus
end

type contestCreateRequest = {
  title: string;
  description: string option;
  start_time: string;
  end_time: string option;
  status: contestCreateRequestStatus;
  allowed_groups: userGroups;
}

let create_contestCreateRequest ~title ?description ~start_time ?end_time ~status ~allowed_groups () : contestCreateRequest =
  { title; description; start_time; end_time; status; allowed_groups }

let contestCreateRequest_of_yojson (x : Yojson.Safe.t) : contestCreateRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let title =
      match assoc "title" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contestCreateRequest" "title"
    in
    let description =
      match assoc "description" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let start_time =
      match assoc "start_time" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contestCreateRequest" "start_time"
    in
    let end_time =
      match assoc "end_time" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.string_of_yojson v)
    in
    let status =
      match assoc "status" with
      | Some v -> contestCreateRequestStatus_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contestCreateRequest" "status"
    in
    let allowed_groups =
      match assoc "allowed_groups" with
      | Some v -> userGroups_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "contestCreateRequest" "allowed_groups"
    in
    { title; description; start_time; end_time; status; allowed_groups }
  | _ -> Atdml_runtime.Yojson.bad_type "contestCreateRequest" x

let yojson_of_contestCreateRequest (x : contestCreateRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("title", Atdml_runtime.Yojson.yojson_of_string x.title)];
    (match x.description with None -> [] | Some v -> [("description", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("start_time", Atdml_runtime.Yojson.yojson_of_string x.start_time)];
    (match x.end_time with None -> [] | Some v -> [("end_time", Atdml_runtime.Yojson.yojson_of_string v)]);
    [("status", yojson_of_contestCreateRequestStatus x.status)];
    [("allowed_groups", yojson_of_userGroups x.allowed_groups)];
  ])

let contestCreateRequest_of_json s =
  contestCreateRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_contestCreateRequest x =
  Yojson.Safe.to_string (yojson_of_contestCreateRequest x)

module ContestCreateRequest = struct
  type nonrec t = contestCreateRequest
  let create = create_contestCreateRequest
  let of_yojson = contestCreateRequest_of_yojson
  let to_yojson = yojson_of_contestCreateRequest
  let of_json = contestCreateRequest_of_json
  let to_json = json_of_contestCreateRequest
end

type authToken = {
  token: string;
  user: user;
}

let create_authToken ~token ~user () : authToken =
  { token; user }

let authToken_of_yojson (x : Yojson.Safe.t) : authToken =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let token =
      match assoc "token" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authToken" "token"
    in
    let user =
      match assoc "user" with
      | Some v -> user_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authToken" "user"
    in
    { token; user }
  | _ -> Atdml_runtime.Yojson.bad_type "authToken" x

let yojson_of_authToken (x : authToken) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("token", Atdml_runtime.Yojson.yojson_of_string x.token)];
    [("user", yojson_of_user x.user)];
  ])

let authToken_of_json s =
  authToken_of_yojson (Yojson.Safe.from_string s)

let json_of_authToken x =
  Yojson.Safe.to_string (yojson_of_authToken x)

module AuthToken = struct
  type nonrec t = authToken
  let create = create_authToken
  let of_yojson = authToken_of_yojson
  let to_yojson = yojson_of_authToken
  let of_json = authToken_of_json
  let to_json = json_of_authToken
end

type authRegisterPostRequest = {
  username: string;
  password: string;
  role: userRole;
}

let create_authRegisterPostRequest ~username ~password ~role () : authRegisterPostRequest =
  { username; password; role }

let authRegisterPostRequest_of_yojson (x : Yojson.Safe.t) : authRegisterPostRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let username =
      match assoc "username" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authRegisterPostRequest" "username"
    in
    let password =
      match assoc "password" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authRegisterPostRequest" "password"
    in
    let role =
      match assoc "role" with
      | Some v -> userRole_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authRegisterPostRequest" "role"
    in
    { username; password; role }
  | _ -> Atdml_runtime.Yojson.bad_type "authRegisterPostRequest" x

let yojson_of_authRegisterPostRequest (x : authRegisterPostRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("username", Atdml_runtime.Yojson.yojson_of_string x.username)];
    [("password", Atdml_runtime.Yojson.yojson_of_string x.password)];
    [("role", yojson_of_userRole x.role)];
  ])

let authRegisterPostRequest_of_json s =
  authRegisterPostRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_authRegisterPostRequest x =
  Yojson.Safe.to_string (yojson_of_authRegisterPostRequest x)

module AuthRegisterPostRequest = struct
  type nonrec t = authRegisterPostRequest
  let create = create_authRegisterPostRequest
  let of_yojson = authRegisterPostRequest_of_yojson
  let to_yojson = yojson_of_authRegisterPostRequest
  let of_json = authRegisterPostRequest_of_json
  let to_json = json_of_authRegisterPostRequest
end

type authPasswordPostRequest = {
  current_password: string;
  new_password: string;
}

let create_authPasswordPostRequest ~current_password ~new_password () : authPasswordPostRequest =
  { current_password; new_password }

let authPasswordPostRequest_of_yojson (x : Yojson.Safe.t) : authPasswordPostRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let current_password =
      match assoc "current_password" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authPasswordPostRequest" "current_password"
    in
    let new_password =
      match assoc "new_password" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authPasswordPostRequest" "new_password"
    in
    { current_password; new_password }
  | _ -> Atdml_runtime.Yojson.bad_type "authPasswordPostRequest" x

let yojson_of_authPasswordPostRequest (x : authPasswordPostRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("current_password", Atdml_runtime.Yojson.yojson_of_string x.current_password)];
    [("new_password", Atdml_runtime.Yojson.yojson_of_string x.new_password)];
  ])

let authPasswordPostRequest_of_json s =
  authPasswordPostRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_authPasswordPostRequest x =
  Yojson.Safe.to_string (yojson_of_authPasswordPostRequest x)

module AuthPasswordPostRequest = struct
  type nonrec t = authPasswordPostRequest
  let create = create_authPasswordPostRequest
  let of_yojson = authPasswordPostRequest_of_yojson
  let to_yojson = yojson_of_authPasswordPostRequest
  let of_json = authPasswordPostRequest_of_json
  let to_json = json_of_authPasswordPostRequest
end

type authLoginPostRequest = {
  username: string;
  password: string;
}

let create_authLoginPostRequest ~username ~password () : authLoginPostRequest =
  { username; password }

let authLoginPostRequest_of_yojson (x : Yojson.Safe.t) : authLoginPostRequest =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let username =
      match assoc "username" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authLoginPostRequest" "username"
    in
    let password =
      match assoc "password" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "authLoginPostRequest" "password"
    in
    { username; password }
  | _ -> Atdml_runtime.Yojson.bad_type "authLoginPostRequest" x

let yojson_of_authLoginPostRequest (x : authLoginPostRequest) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("username", Atdml_runtime.Yojson.yojson_of_string x.username)];
    [("password", Atdml_runtime.Yojson.yojson_of_string x.password)];
  ])

let authLoginPostRequest_of_json s =
  authLoginPostRequest_of_yojson (Yojson.Safe.from_string s)

let json_of_authLoginPostRequest x =
  Yojson.Safe.to_string (yojson_of_authLoginPostRequest x)

module AuthLoginPostRequest = struct
  type nonrec t = authLoginPostRequest
  let create = create_authLoginPostRequest
  let of_yojson = authLoginPostRequest_of_yojson
  let to_yojson = yojson_of_authLoginPostRequest
  let of_json = authLoginPostRequest_of_json
  let to_json = json_of_authLoginPostRequest
end

type adminYodacStats = {
  queued_jobs_total: int option;
  queued_jobs_per_minute: int;
  processed_jobs_total: int;
  processed_jobs_per_minute: int;
}

let create_adminYodacStats ?queued_jobs_total ~queued_jobs_per_minute ~processed_jobs_total ~processed_jobs_per_minute () : adminYodacStats =
  { queued_jobs_total; queued_jobs_per_minute; processed_jobs_total; processed_jobs_per_minute }

let adminYodacStats_of_yojson (x : Yojson.Safe.t) : adminYodacStats =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let queued_jobs_total =
      match assoc "queued_jobs_total" with
      | None | Some `Null -> Option.None
      | Some v -> Option.Some (Atdml_runtime.Yojson.int_of_yojson v)
    in
    let queued_jobs_per_minute =
      match assoc "queued_jobs_per_minute" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminYodacStats" "queued_jobs_per_minute"
    in
    let processed_jobs_total =
      match assoc "processed_jobs_total" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminYodacStats" "processed_jobs_total"
    in
    let processed_jobs_per_minute =
      match assoc "processed_jobs_per_minute" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminYodacStats" "processed_jobs_per_minute"
    in
    { queued_jobs_total; queued_jobs_per_minute; processed_jobs_total; processed_jobs_per_minute }
  | _ -> Atdml_runtime.Yojson.bad_type "adminYodacStats" x

let yojson_of_adminYodacStats (x : adminYodacStats) : Yojson.Safe.t =
  `Assoc (List.concat [
    (match x.queued_jobs_total with None -> [] | Some v -> [("queued_jobs_total", Atdml_runtime.Yojson.yojson_of_int v)]);
    [("queued_jobs_per_minute", Atdml_runtime.Yojson.yojson_of_int x.queued_jobs_per_minute)];
    [("processed_jobs_total", Atdml_runtime.Yojson.yojson_of_int x.processed_jobs_total)];
    [("processed_jobs_per_minute", Atdml_runtime.Yojson.yojson_of_int x.processed_jobs_per_minute)];
  ])

let adminYodacStats_of_json s =
  adminYodacStats_of_yojson (Yojson.Safe.from_string s)

let json_of_adminYodacStats x =
  Yojson.Safe.to_string (yojson_of_adminYodacStats x)

module AdminYodacStats = struct
  type nonrec t = adminYodacStats
  let create = create_adminYodacStats
  let of_yojson = adminYodacStats_of_yojson
  let to_yojson = yojson_of_adminYodacStats
  let of_json = adminYodacStats_of_json
  let to_json = json_of_adminYodacStats
end

type adminYodabStats = {
  yodab_requests_total: int;
  yodab_requests_per_minute: int;
  submissions_total: int;
  submissions_per_minute: int;
}

let create_adminYodabStats ~yodab_requests_total ~yodab_requests_per_minute ~submissions_total ~submissions_per_minute () : adminYodabStats =
  { yodab_requests_total; yodab_requests_per_minute; submissions_total; submissions_per_minute }

let adminYodabStats_of_yojson (x : Yojson.Safe.t) : adminYodabStats =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let yodab_requests_total =
      match assoc "yodab_requests_total" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminYodabStats" "yodab_requests_total"
    in
    let yodab_requests_per_minute =
      match assoc "yodab_requests_per_minute" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminYodabStats" "yodab_requests_per_minute"
    in
    let submissions_total =
      match assoc "submissions_total" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminYodabStats" "submissions_total"
    in
    let submissions_per_minute =
      match assoc "submissions_per_minute" with
      | Some v -> Atdml_runtime.Yojson.int_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminYodabStats" "submissions_per_minute"
    in
    { yodab_requests_total; yodab_requests_per_minute; submissions_total; submissions_per_minute }
  | _ -> Atdml_runtime.Yojson.bad_type "adminYodabStats" x

let yojson_of_adminYodabStats (x : adminYodabStats) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("yodab_requests_total", Atdml_runtime.Yojson.yojson_of_int x.yodab_requests_total)];
    [("yodab_requests_per_minute", Atdml_runtime.Yojson.yojson_of_int x.yodab_requests_per_minute)];
    [("submissions_total", Atdml_runtime.Yojson.yojson_of_int x.submissions_total)];
    [("submissions_per_minute", Atdml_runtime.Yojson.yojson_of_int x.submissions_per_minute)];
  ])

let adminYodabStats_of_json s =
  adminYodabStats_of_yojson (Yojson.Safe.from_string s)

let json_of_adminYodabStats x =
  Yojson.Safe.to_string (yojson_of_adminYodabStats x)

module AdminYodabStats = struct
  type nonrec t = adminYodabStats
  let create = create_adminYodabStats
  let of_yojson = adminYodabStats_of_yojson
  let to_yojson = yojson_of_adminYodabStats
  let of_json = adminYodabStats_of_json
  let to_json = json_of_adminYodabStats
end

type adminUsersGetResponse2 = user list

let adminUsersGetResponse2_of_yojson (x : Yojson.Safe.t) : adminUsersGetResponse2 =
  (Atdml_runtime.Yojson.list_of_yojson user_of_yojson) x

let yojson_of_adminUsersGetResponse2 (x : adminUsersGetResponse2) : Yojson.Safe.t =
  (Atdml_runtime.Yojson.yojson_of_list yojson_of_user) x

let adminUsersGetResponse2_of_json s =
  adminUsersGetResponse2_of_yojson (Yojson.Safe.from_string s)

let json_of_adminUsersGetResponse2 x =
  Yojson.Safe.to_string (yojson_of_adminUsersGetResponse2 x)

module AdminUsersGetResponse2 = struct
  type nonrec t = adminUsersGetResponse2
  let of_yojson = adminUsersGetResponse2_of_yojson
  let to_yojson = yojson_of_adminUsersGetResponse2
  let of_json = adminUsersGetResponse2_of_json
  let to_json = json_of_adminUsersGetResponse2
end

type adminStatsResponse = {
  api_version: string;
  yoda_version: string;
  contributors: string list;
  yodab: adminYodabStats;
  yodac: adminYodacStats;
}

let create_adminStatsResponse ~api_version ~yoda_version ~contributors ~yodab ~yodac () : adminStatsResponse =
  { api_version; yoda_version; contributors; yodab; yodac }

let adminStatsResponse_of_yojson (x : Yojson.Safe.t) : adminStatsResponse =
  match x with
  | `Assoc fields ->
    (* Duplicate JSON keys: behavior is unspecified (RFC 8259 §4 says keys SHOULD
       be unique). Below the threshold, List.assoc_opt returns the first binding;
       above it, the hashtable returns the last. *)
    let assoc =
      if Atdml_runtime.list_length_gt 5 fields then
        let tbl = Hashtbl.create 16 in
        List.iter (fun (k, v) -> Hashtbl.add tbl k v) fields;
        (fun key -> Hashtbl.find_opt tbl key)
      else (fun key -> List.assoc_opt key fields)
    in
    let api_version =
      match assoc "api_version" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminStatsResponse" "api_version"
    in
    let yoda_version =
      match assoc "yoda_version" with
      | Some v -> Atdml_runtime.Yojson.string_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminStatsResponse" "yoda_version"
    in
    let contributors =
      match assoc "contributors" with
      | Some v -> (Atdml_runtime.Yojson.list_of_yojson Atdml_runtime.Yojson.string_of_yojson) v
      | None -> Atdml_runtime.Yojson.missing_field "adminStatsResponse" "contributors"
    in
    let yodab =
      match assoc "yodab" with
      | Some v -> adminYodabStats_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminStatsResponse" "yodab"
    in
    let yodac =
      match assoc "yodac" with
      | Some v -> adminYodacStats_of_yojson v
      | None -> Atdml_runtime.Yojson.missing_field "adminStatsResponse" "yodac"
    in
    { api_version; yoda_version; contributors; yodab; yodac }
  | _ -> Atdml_runtime.Yojson.bad_type "adminStatsResponse" x

let yojson_of_adminStatsResponse (x : adminStatsResponse) : Yojson.Safe.t =
  `Assoc (List.concat [
    [("api_version", Atdml_runtime.Yojson.yojson_of_string x.api_version)];
    [("yoda_version", Atdml_runtime.Yojson.yojson_of_string x.yoda_version)];
    [("contributors", (Atdml_runtime.Yojson.yojson_of_list Atdml_runtime.Yojson.yojson_of_string) x.contributors)];
    [("yodab", yojson_of_adminYodabStats x.yodab)];
    [("yodac", yojson_of_adminYodacStats x.yodac)];
  ])

let adminStatsResponse_of_json s =
  adminStatsResponse_of_yojson (Yojson.Safe.from_string s)

let json_of_adminStatsResponse x =
  Yojson.Safe.to_string (yojson_of_adminStatsResponse x)

module AdminStatsResponse = struct
  type nonrec t = adminStatsResponse
  let create = create_adminStatsResponse
  let of_yojson = adminStatsResponse_of_yojson
  let to_yojson = yojson_of_adminStatsResponse
  let of_json = adminStatsResponse_of_json
  let to_json = json_of_adminStatsResponse
end

