(* Auto-generated from "openapi.atd" by atdml. *)

type yodacLanguageConfig = {
  language: string;
  ext: string;
  image: string;
  tag: string;
  compile: string option option;
  run: string;
}

val create_yodacLanguageConfig : language:string -> ext:string -> image:string -> tag:string -> ?compile:string option -> run:string -> unit -> yodacLanguageConfig
val yodacLanguageConfig_of_yojson : Yojson.Safe.t -> yodacLanguageConfig
val yojson_of_yodacLanguageConfig : yodacLanguageConfig -> Yojson.Safe.t
val yodacLanguageConfig_of_json : string -> yodacLanguageConfig
val json_of_yodacLanguageConfig : yodacLanguageConfig -> string

module YodacLanguageConfig : sig
  type nonrec t = yodacLanguageConfig
  val create : language:string -> ext:string -> image:string -> tag:string -> ?compile:string option -> run:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type yodacLanguagesConfig = yodacLanguageConfig list

val yodacLanguagesConfig_of_yojson : Yojson.Safe.t -> yodacLanguagesConfig
val yojson_of_yodacLanguagesConfig : yodacLanguagesConfig -> Yojson.Safe.t
val yodacLanguagesConfig_of_json : string -> yodacLanguagesConfig
val json_of_yodacLanguagesConfig : yodacLanguagesConfig -> string

module YodacLanguagesConfig : sig
  type nonrec t = yodacLanguagesConfig
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type yodacConfigPutRequest = {
  config: yodacLanguagesConfig;
}

val create_yodacConfigPutRequest : config:yodacLanguagesConfig -> unit -> yodacConfigPutRequest
val yodacConfigPutRequest_of_yojson : Yojson.Safe.t -> yodacConfigPutRequest
val yojson_of_yodacConfigPutRequest : yodacConfigPutRequest -> Yojson.Safe.t
val yodacConfigPutRequest_of_json : string -> yodacConfigPutRequest
val json_of_yodacConfigPutRequest : yodacConfigPutRequest -> string

module YodacConfigPutRequest : sig
  type nonrec t = yodacConfigPutRequest
  val create : config:yodacLanguagesConfig -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type json_ = Yojson.Safe.t

val json__of_yojson : Yojson.Safe.t -> json_
val yojson_of_json_ : json_ -> Yojson.Safe.t
val json__of_json : string -> json_
val json_of_json_ : json_ -> string

module Json_ : sig
  type nonrec t = json_
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type yodacConfigHistoryEntry = {
  version: int;
  timestamp: string;
  changed_by: string;
  action: string;
  previous_config: json_ option option;
  new_config: yodacLanguagesConfig;
}

val create_yodacConfigHistoryEntry : version:int -> timestamp:string -> changed_by:string -> action:string -> ?previous_config:json_ option -> new_config:yodacLanguagesConfig -> unit -> yodacConfigHistoryEntry
val yodacConfigHistoryEntry_of_yojson : Yojson.Safe.t -> yodacConfigHistoryEntry
val yojson_of_yodacConfigHistoryEntry : yodacConfigHistoryEntry -> Yojson.Safe.t
val yodacConfigHistoryEntry_of_json : string -> yodacConfigHistoryEntry
val json_of_yodacConfigHistoryEntry : yodacConfigHistoryEntry -> string

module YodacConfigHistoryEntry : sig
  type nonrec t = yodacConfigHistoryEntry
  val create : version:int -> timestamp:string -> changed_by:string -> action:string -> ?previous_config:json_ option -> new_config:yodacLanguagesConfig -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type yodacConfigHistoryGetResponse = yodacConfigHistoryEntry list

val yodacConfigHistoryGetResponse_of_yojson : Yojson.Safe.t -> yodacConfigHistoryGetResponse
val yojson_of_yodacConfigHistoryGetResponse : yodacConfigHistoryGetResponse -> Yojson.Safe.t
val yodacConfigHistoryGetResponse_of_json : string -> yodacConfigHistoryGetResponse
val json_of_yodacConfigHistoryGetResponse : yodacConfigHistoryGetResponse -> string

module YodacConfigHistoryGetResponse : sig
  type nonrec t = yodacConfigHistoryGetResponse
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type yodacConfigGetResponse = {
  config: yodacLanguagesConfig;
  version: int;
  updated_at: string;
  updated_by: string;
}

val create_yodacConfigGetResponse : config:yodacLanguagesConfig -> version:int -> updated_at:string -> updated_by:string -> unit -> yodacConfigGetResponse
val yodacConfigGetResponse_of_yojson : Yojson.Safe.t -> yodacConfigGetResponse
val yojson_of_yodacConfigGetResponse : yodacConfigGetResponse -> Yojson.Safe.t
val yodacConfigGetResponse_of_json : string -> yodacConfigGetResponse
val json_of_yodacConfigGetResponse : yodacConfigGetResponse -> string

module YodacConfigGetResponse : sig
  type nonrec t = yodacConfigGetResponse
  val create : config:yodacLanguagesConfig -> version:int -> updated_at:string -> updated_by:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type userRole =
  | User
  | Judge
  | Admin

val userRole_of_yojson : Yojson.Safe.t -> userRole
val yojson_of_userRole : userRole -> Yojson.Safe.t
val userRole_of_json : string -> userRole
val json_of_userRole : userRole -> string

module UserRole : sig
  type nonrec t = userRole
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type userGroups = string list

val userGroups_of_yojson : Yojson.Safe.t -> userGroups
val yojson_of_userGroups : userGroups -> Yojson.Safe.t
val userGroups_of_json : string -> userGroups
val json_of_userGroups : userGroups -> string

module UserGroups : sig
  type nonrec t = userGroups
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type userUpdateRequest = {
  username: string option;
  role: userRole option;
  groups: userGroups option;
}

val create_userUpdateRequest : ?username:string -> ?role:userRole -> ?groups:userGroups -> unit -> userUpdateRequest
val userUpdateRequest_of_yojson : Yojson.Safe.t -> userUpdateRequest
val yojson_of_userUpdateRequest : userUpdateRequest -> Yojson.Safe.t
val userUpdateRequest_of_json : string -> userUpdateRequest
val json_of_userUpdateRequest : userUpdateRequest -> string

module UserUpdateRequest : sig
  type nonrec t = userUpdateRequest
  val create : ?username:string -> ?role:userRole -> ?groups:userGroups -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type userCreateRequest = {
  username: string;
  password: string;
  role: userRole;
  groups: userGroups option;
}

val create_userCreateRequest : username:string -> password:string -> role:userRole -> ?groups:userGroups -> unit -> userCreateRequest
val userCreateRequest_of_yojson : Yojson.Safe.t -> userCreateRequest
val yojson_of_userCreateRequest : userCreateRequest -> Yojson.Safe.t
val userCreateRequest_of_json : string -> userCreateRequest
val json_of_userCreateRequest : userCreateRequest -> string

module UserCreateRequest : sig
  type nonrec t = userCreateRequest
  val create : username:string -> password:string -> role:userRole -> ?groups:userGroups -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type user = {
  id: int;
  username: string;
  role: userRole;
  groups: userGroups;
  created_at: string;
  last_seen_at: string option;
}

val create_user : id:int -> username:string -> role:userRole -> groups:userGroups -> created_at:string -> ?last_seen_at:string -> unit -> user
val user_of_yojson : Yojson.Safe.t -> user
val yojson_of_user : user -> Yojson.Safe.t
val user_of_json : string -> user
val json_of_user : user -> string

module User : sig
  type nonrec t = user
  val create : id:int -> username:string -> role:userRole -> groups:userGroups -> created_at:string -> ?last_seen_at:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type oracleConfig = {
  entrypoint: string;  (** Oracle checker entrypoint filename *)
  args: string list option;  (** Optional argv list passed to oracle checker *)
}

val create_oracleConfig : entrypoint:string -> ?args:string list -> unit -> oracleConfig
val oracleConfig_of_yojson : Yojson.Safe.t -> oracleConfig
val yojson_of_oracleConfig : oracleConfig -> Yojson.Safe.t
val oracleConfig_of_json : string -> oracleConfig
val json_of_oracleConfig : oracleConfig -> string

module OracleConfig : sig
  type nonrec t = oracleConfig
  val create : entrypoint:string -> ?args:string list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type testCaseCreateRequest = {
  id: int option;
  input: string;
  output: string;
  is_sample: bool;
  oracle: oracleConfig option;
}

val create_testCaseCreateRequest : ?id:int -> input:string -> output:string -> is_sample:bool -> ?oracle:oracleConfig -> unit -> testCaseCreateRequest
val testCaseCreateRequest_of_yojson : Yojson.Safe.t -> testCaseCreateRequest
val yojson_of_testCaseCreateRequest : testCaseCreateRequest -> Yojson.Safe.t
val testCaseCreateRequest_of_json : string -> testCaseCreateRequest
val json_of_testCaseCreateRequest : testCaseCreateRequest -> string

module TestCaseCreateRequest : sig
  type nonrec t = testCaseCreateRequest
  val create : ?id:int -> input:string -> output:string -> is_sample:bool -> ?oracle:oracleConfig -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type testCase = {
  id: int;
  input: string;
  output: string;
  is_sample: bool;
  oracle: oracleConfig option;
}

val create_testCase : id:int -> input:string -> output:string -> is_sample:bool -> ?oracle:oracleConfig -> unit -> testCase
val testCase_of_yojson : Yojson.Safe.t -> testCase
val yojson_of_testCase : testCase -> Yojson.Safe.t
val testCase_of_json : string -> testCase
val json_of_testCase : testCase -> string

module TestCase : sig
  type nonrec t = testCase
  val create : id:int -> input:string -> output:string -> is_sample:bool -> ?oracle:oracleConfig -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type submissionDetailOutputMeta = {
  stderr_score: int option;
}

val create_submissionDetailOutputMeta : ?stderr_score:int -> unit -> submissionDetailOutputMeta
val submissionDetailOutputMeta_of_yojson : Yojson.Safe.t -> submissionDetailOutputMeta
val yojson_of_submissionDetailOutputMeta : submissionDetailOutputMeta -> Yojson.Safe.t
val submissionDetailOutputMeta_of_json : string -> submissionDetailOutputMeta
val json_of_submissionDetailOutputMeta : submissionDetailOutputMeta -> string

module SubmissionDetailOutputMeta : sig
  type nonrec t = submissionDetailOutputMeta
  val create : ?stderr_score:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type submissionDetailOutput = {
  stdout: string;
  stderr: string;
  return_code: int;
  meta: submissionDetailOutputMeta option;
}

val create_submissionDetailOutput : stdout:string -> stderr:string -> return_code:int -> ?meta:submissionDetailOutputMeta -> unit -> submissionDetailOutput
val submissionDetailOutput_of_yojson : Yojson.Safe.t -> submissionDetailOutput
val yojson_of_submissionDetailOutput : submissionDetailOutput -> Yojson.Safe.t
val submissionDetailOutput_of_json : string -> submissionDetailOutput
val json_of_submissionDetailOutput : submissionDetailOutput -> string

module SubmissionDetailOutput : sig
  type nonrec t = submissionDetailOutput
  val create : stdout:string -> stderr:string -> return_code:int -> ?meta:submissionDetailOutputMeta -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type submissionDetail = {
  testcase_id: int;
  status: string;
  time_ms: int;
  output: submissionDetailOutput option;
}

val create_submissionDetail : testcase_id:int -> status:string -> time_ms:int -> ?output:submissionDetailOutput -> unit -> submissionDetail
val submissionDetail_of_yojson : Yojson.Safe.t -> submissionDetail
val yojson_of_submissionDetail : submissionDetail -> Yojson.Safe.t
val submissionDetail_of_json : string -> submissionDetail
val json_of_submissionDetail : submissionDetail -> string

module SubmissionDetail : sig
  type nonrec t = submissionDetail
  val create : testcase_id:int -> status:string -> time_ms:int -> ?output:submissionDetailOutput -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type submissionDetails = submissionDetail list

val submissionDetails_of_yojson : Yojson.Safe.t -> submissionDetails
val yojson_of_submissionDetails : submissionDetails -> Yojson.Safe.t
val submissionDetails_of_json : string -> submissionDetails
val json_of_submissionDetails : submissionDetails -> string

module SubmissionDetails : sig
  type nonrec t = submissionDetails
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_submission : id:int -> problem_id:int -> ?language:string -> status:string -> score:int -> time_ms:int -> memory_kb:int -> details:submissionDetails -> ?owner:bool -> ?owner_id:int -> ?created_at:string -> unit -> submission
val submission_of_yojson : Yojson.Safe.t -> submission
val yojson_of_submission : submission -> Yojson.Safe.t
val submission_of_json : string -> submission
val json_of_submission : submission -> string

module Submission : sig
  type nonrec t = submission
  val create : id:int -> problem_id:int -> ?language:string -> status:string -> score:int -> time_ms:int -> memory_kb:int -> details:submissionDetails -> ?owner:bool -> ?owner_id:int -> ?created_at:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type submissions = submission list

val submissions_of_yojson : Yojson.Safe.t -> submissions
val yojson_of_submissions : submissions -> Yojson.Safe.t
val submissions_of_json : string -> submissions
val json_of_submissions : submissions -> string

module Submissions : sig
  type nonrec t = submissions
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type sourceArtifact = {
  filename: string;  (** The name of the source file *)
  content: string;  (** The content of the source file *)
}

val create_sourceArtifact : filename:string -> content:string -> unit -> sourceArtifact
val sourceArtifact_of_yojson : Yojson.Safe.t -> sourceArtifact
val yojson_of_sourceArtifact : sourceArtifact -> Yojson.Safe.t
val sourceArtifact_of_json : string -> sourceArtifact
val json_of_sourceArtifact : sourceArtifact -> string

module SourceArtifact : sig
  type nonrec t = sourceArtifact
  val create : filename:string -> content:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type sourceArtifacts = sourceArtifact list

val sourceArtifacts_of_yojson : Yojson.Safe.t -> sourceArtifacts
val yojson_of_sourceArtifacts : sourceArtifacts -> Yojson.Safe.t
val sourceArtifacts_of_json : string -> sourceArtifacts
val json_of_sourceArtifacts : sourceArtifacts -> string

module SourceArtifacts : sig
  type nonrec t = sourceArtifacts
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type submissionFullDetails = {
  submission: submission;
  source_artifacts: sourceArtifacts;
}

val create_submissionFullDetails : submission:submission -> source_artifacts:sourceArtifacts -> unit -> submissionFullDetails
val submissionFullDetails_of_yojson : Yojson.Safe.t -> submissionFullDetails
val yojson_of_submissionFullDetails : submissionFullDetails -> Yojson.Safe.t
val submissionFullDetails_of_json : string -> submissionFullDetails
val json_of_submissionFullDetails : submissionFullDetails -> string

module SubmissionFullDetails : sig
  type nonrec t = submissionFullDetails
  val create : submission:submission -> source_artifacts:sourceArtifacts -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type statusStatus =
  | Ok
  | Maintenance

val statusStatus_of_yojson : Yojson.Safe.t -> statusStatus
val yojson_of_statusStatus : statusStatus -> Yojson.Safe.t
val statusStatus_of_json : string -> statusStatus
val json_of_statusStatus : statusStatus -> string

module StatusStatus : sig
  type nonrec t = statusStatus
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type status = {
  status: statusStatus;
  message: string;
}

val create_status : status:statusStatus -> message:string -> unit -> status
val status_of_yojson : Yojson.Safe.t -> status
val yojson_of_status : status -> Yojson.Safe.t
val status_of_json : string -> status
val json_of_status : status -> string

module Status : sig
  type nonrec t = status
  val create : status:statusStatus -> message:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type solution = {
  problem_id: int;
  language: string;
  source_artifacts: sourceArtifacts;
}

val create_solution : problem_id:int -> language:string -> source_artifacts:sourceArtifacts -> unit -> solution
val solution_of_yojson : Yojson.Safe.t -> solution
val yojson_of_solution : solution -> Yojson.Safe.t
val solution_of_json : string -> solution
val json_of_solution : solution -> string

module Solution : sig
  type nonrec t = solution
  val create : problem_id:int -> language:string -> source_artifacts:sourceArtifacts -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type scoreboardEntry = {
  team: string;
  solved: int;
  penalty: int;
  problems: json_;
}

val create_scoreboardEntry : team:string -> solved:int -> penalty:int -> problems:json_ -> unit -> scoreboardEntry
val scoreboardEntry_of_yojson : Yojson.Safe.t -> scoreboardEntry
val yojson_of_scoreboardEntry : scoreboardEntry -> Yojson.Safe.t
val scoreboardEntry_of_json : string -> scoreboardEntry
val json_of_scoreboardEntry : scoreboardEntry -> string

module ScoreboardEntry : sig
  type nonrec t = scoreboardEntry
  val create : team:string -> solved:int -> penalty:int -> problems:json_ -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type problemsIdTestcasesGetResponse2 = testCase list

val problemsIdTestcasesGetResponse2_of_yojson : Yojson.Safe.t -> problemsIdTestcasesGetResponse2
val yojson_of_problemsIdTestcasesGetResponse2 : problemsIdTestcasesGetResponse2 -> Yojson.Safe.t
val problemsIdTestcasesGetResponse2_of_json : string -> problemsIdTestcasesGetResponse2
val json_of_problemsIdTestcasesGetResponse2 : problemsIdTestcasesGetResponse2 -> string

module ProblemsIdTestcasesGetResponse2 : sig
  type nonrec t = problemsIdTestcasesGetResponse2
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type objectArtifact = {
  filename: string;  (** The name of the object file *)
  content: string;  (** The content of the object file *)
  sha256: string option;  (** The SHA256 hash of the object file *)
  size: int option;  (** The size of the object file in bytes *)
}

val create_objectArtifact : filename:string -> content:string -> ?sha256:string -> ?size:int -> unit -> objectArtifact
val objectArtifact_of_yojson : Yojson.Safe.t -> objectArtifact
val yojson_of_objectArtifact : objectArtifact -> Yojson.Safe.t
val objectArtifact_of_json : string -> objectArtifact
val json_of_objectArtifact : objectArtifact -> string

module ObjectArtifact : sig
  type nonrec t = objectArtifact
  val create : filename:string -> content:string -> ?sha256:string -> ?size:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type objectArtifacts = objectArtifact list

val objectArtifacts_of_yojson : Yojson.Safe.t -> objectArtifacts
val yojson_of_objectArtifacts : objectArtifacts -> Yojson.Safe.t
val objectArtifacts_of_json : string -> objectArtifacts
val json_of_objectArtifacts : objectArtifacts -> string

module ObjectArtifacts : sig
  type nonrec t = objectArtifacts
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type languages = string list

val languages_of_yojson : Yojson.Safe.t -> languages
val yojson_of_languages : languages -> Yojson.Safe.t
val languages_of_json : string -> languages
val json_of_languages : languages -> string

module Languages : sig
  type nonrec t = languages
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_problemUpdateRequest : ?code:string -> ?title:string -> ?description:string -> ?input_spec:string -> ?output_spec:string -> ?open_at:string -> ?close_at:string -> ?is_force_closed:bool -> ?languages:languages -> ?time_limit_ms:int -> ?memory_limit_mb:int -> ?source_artifacts:sourceArtifacts -> ?object_artifacts:objectArtifacts -> unit -> problemUpdateRequest
val problemUpdateRequest_of_yojson : Yojson.Safe.t -> problemUpdateRequest
val yojson_of_problemUpdateRequest : problemUpdateRequest -> Yojson.Safe.t
val problemUpdateRequest_of_json : string -> problemUpdateRequest
val json_of_problemUpdateRequest : problemUpdateRequest -> string

module ProblemUpdateRequest : sig
  type nonrec t = problemUpdateRequest
  val create : ?code:string -> ?title:string -> ?description:string -> ?input_spec:string -> ?output_spec:string -> ?open_at:string -> ?close_at:string -> ?is_force_closed:bool -> ?languages:languages -> ?time_limit_ms:int -> ?memory_limit_mb:int -> ?source_artifacts:sourceArtifacts -> ?object_artifacts:objectArtifacts -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_problemCreateRequest : code:string -> title:string -> description:string -> input_spec:string -> output_spec:string -> languages:languages -> time_limit_ms:int -> memory_limit_mb:int -> source_artifacts:sourceArtifacts -> unit -> problemCreateRequest
val problemCreateRequest_of_yojson : Yojson.Safe.t -> problemCreateRequest
val yojson_of_problemCreateRequest : problemCreateRequest -> Yojson.Safe.t
val problemCreateRequest_of_json : string -> problemCreateRequest
val json_of_problemCreateRequest : problemCreateRequest -> string

module ProblemCreateRequest : sig
  type nonrec t = problemCreateRequest
  val create : code:string -> title:string -> description:string -> input_spec:string -> output_spec:string -> languages:languages -> time_limit_ms:int -> memory_limit_mb:int -> source_artifacts:sourceArtifacts -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_problem : ?id:int -> code:string -> title:string -> time_limit_ms:int -> memory_limit_mb:int -> description:string -> input_spec:string -> output_spec:string -> ?open_at:string -> ?close_at:string -> ?is_force_closed:bool -> languages:languages -> ?source_artifacts:sourceArtifacts -> ?object_artifacts:objectArtifacts -> unit -> problem
val problem_of_yojson : Yojson.Safe.t -> problem
val yojson_of_problem : problem -> Yojson.Safe.t
val problem_of_json : string -> problem
val json_of_problem : problem -> string

module Problem : sig
  type nonrec t = problem
  val create : ?id:int -> code:string -> title:string -> time_limit_ms:int -> memory_limit_mb:int -> description:string -> input_spec:string -> output_spec:string -> ?open_at:string -> ?close_at:string -> ?is_force_closed:bool -> languages:languages -> ?source_artifacts:sourceArtifacts -> ?object_artifacts:objectArtifacts -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
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

val create_job : submission_id:int -> user_id:int -> problem_id:int -> lang:string -> source_code:string -> time_limit_ms:int -> memory_limit_mb:int -> testcases:testCase list -> unit -> job
val job_of_yojson : Yojson.Safe.t -> job
val yojson_of_job : job -> Yojson.Safe.t
val job_of_json : string -> job
val json_of_job : job -> string

module Job : sig
  type nonrec t = job
  val create : submission_id:int -> user_id:int -> problem_id:int -> lang:string -> source_code:string -> time_limit_ms:int -> memory_limit_mb:int -> testcases:testCase list -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type int64 = private int

val create_int64 : int -> int64
val int64_of_yojson : Yojson.Safe.t -> int64
val yojson_of_int64 : int64 -> Yojson.Safe.t
val int64_of_json : string -> int64
val json_of_int64 : int64 -> string

module Int64 : sig
  type nonrec t = int64
  val create : int -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type errorResponse = {
  error: string;
}

val create_errorResponse : error:string -> unit -> errorResponse
val errorResponse_of_yojson : Yojson.Safe.t -> errorResponse
val yojson_of_errorResponse : errorResponse -> Yojson.Safe.t
val errorResponse_of_json : string -> errorResponse
val json_of_errorResponse : errorResponse -> string

module ErrorResponse : sig
  type nonrec t = errorResponse
  val create : error:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestsIdScoreboardGetResponse2 = scoreboardEntry list

val contestsIdScoreboardGetResponse2_of_yojson : Yojson.Safe.t -> contestsIdScoreboardGetResponse2
val yojson_of_contestsIdScoreboardGetResponse2 : contestsIdScoreboardGetResponse2 -> Yojson.Safe.t
val contestsIdScoreboardGetResponse2_of_json : string -> contestsIdScoreboardGetResponse2
val json_of_contestsIdScoreboardGetResponse2 : contestsIdScoreboardGetResponse2 -> string

module ContestsIdScoreboardGetResponse2 : sig
  type nonrec t = contestsIdScoreboardGetResponse2
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestStatus =
  | Upcoming
  | Running
  | Finished

val contestStatus_of_yojson : Yojson.Safe.t -> contestStatus
val yojson_of_contestStatus : contestStatus -> Yojson.Safe.t
val contestStatus_of_json : string -> contestStatus
val json_of_contestStatus : contestStatus -> string

module ContestStatus : sig
  type nonrec t = contestStatus
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contest = {
  title: string;
  description: string option;
  start_time: string;
  end_time: string option;
  status: contestStatus;
  id: int;
}

val create_contest : title:string -> ?description:string -> start_time:string -> ?end_time:string -> status:contestStatus -> id:int -> unit -> contest
val contest_of_yojson : Yojson.Safe.t -> contest
val yojson_of_contest : contest -> Yojson.Safe.t
val contest_of_json : string -> contest
val json_of_contest : contest -> string

module Contest : sig
  type nonrec t = contest
  val create : title:string -> ?description:string -> start_time:string -> ?end_time:string -> status:contestStatus -> id:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestsGetResponse2 = contest list

val contestsGetResponse2_of_yojson : Yojson.Safe.t -> contestsGetResponse2
val yojson_of_contestsGetResponse2 : contestsGetResponse2 -> Yojson.Safe.t
val contestsGetResponse2_of_json : string -> contestsGetResponse2
val json_of_contestsGetResponse2 : contestsGetResponse2 -> string

module ContestsGetResponse2 : sig
  type nonrec t = contestsGetResponse2
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestsContestsidProblemsGetResponse2 = problem list

val contestsContestsidProblemsGetResponse2_of_yojson : Yojson.Safe.t -> contestsContestsidProblemsGetResponse2
val yojson_of_contestsContestsidProblemsGetResponse2 : contestsContestsidProblemsGetResponse2 -> Yojson.Safe.t
val contestsContestsidProblemsGetResponse2_of_json : string -> contestsContestsidProblemsGetResponse2
val json_of_contestsContestsidProblemsGetResponse2 : contestsContestsidProblemsGetResponse2 -> string

module ContestsContestsidProblemsGetResponse2 : sig
  type nonrec t = contestsContestsidProblemsGetResponse2
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestUpdateRequestStatus =
  | Upcoming
  | Running
  | Finished

val contestUpdateRequestStatus_of_yojson : Yojson.Safe.t -> contestUpdateRequestStatus
val yojson_of_contestUpdateRequestStatus : contestUpdateRequestStatus -> Yojson.Safe.t
val contestUpdateRequestStatus_of_json : string -> contestUpdateRequestStatus
val json_of_contestUpdateRequestStatus : contestUpdateRequestStatus -> string

module ContestUpdateRequestStatus : sig
  type nonrec t = contestUpdateRequestStatus
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestUpdateRequest = {
  title: string option;
  description: string option;
  start_time: string option;
  end_time: string option;
  status: contestUpdateRequestStatus option;
  allowed_groups: userGroups option;
}

val create_contestUpdateRequest : ?title:string -> ?description:string -> ?start_time:string -> ?end_time:string -> ?status:contestUpdateRequestStatus -> ?allowed_groups:userGroups -> unit -> contestUpdateRequest
val contestUpdateRequest_of_yojson : Yojson.Safe.t -> contestUpdateRequest
val yojson_of_contestUpdateRequest : contestUpdateRequest -> Yojson.Safe.t
val contestUpdateRequest_of_json : string -> contestUpdateRequest
val json_of_contestUpdateRequest : contestUpdateRequest -> string

module ContestUpdateRequest : sig
  type nonrec t = contestUpdateRequest
  val create : ?title:string -> ?description:string -> ?start_time:string -> ?end_time:string -> ?status:contestUpdateRequestStatus -> ?allowed_groups:userGroups -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestFieldsStatus =
  | Upcoming
  | Running
  | Finished

val contestFieldsStatus_of_yojson : Yojson.Safe.t -> contestFieldsStatus
val yojson_of_contestFieldsStatus : contestFieldsStatus -> Yojson.Safe.t
val contestFieldsStatus_of_json : string -> contestFieldsStatus
val json_of_contestFieldsStatus : contestFieldsStatus -> string

module ContestFieldsStatus : sig
  type nonrec t = contestFieldsStatus
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestFields = {
  title: string option;
  description: string option;
  start_time: string option;
  end_time: string option;
  status: contestFieldsStatus option;
}

val create_contestFields : ?title:string -> ?description:string -> ?start_time:string -> ?end_time:string -> ?status:contestFieldsStatus -> unit -> contestFields
val contestFields_of_yojson : Yojson.Safe.t -> contestFields
val yojson_of_contestFields : contestFields -> Yojson.Safe.t
val contestFields_of_json : string -> contestFields
val json_of_contestFields : contestFields -> string

module ContestFields : sig
  type nonrec t = contestFields
  val create : ?title:string -> ?description:string -> ?start_time:string -> ?end_time:string -> ?status:contestFieldsStatus -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestCreateRequestStatus =
  | Upcoming
  | Running
  | Finished

val contestCreateRequestStatus_of_yojson : Yojson.Safe.t -> contestCreateRequestStatus
val yojson_of_contestCreateRequestStatus : contestCreateRequestStatus -> Yojson.Safe.t
val contestCreateRequestStatus_of_json : string -> contestCreateRequestStatus
val json_of_contestCreateRequestStatus : contestCreateRequestStatus -> string

module ContestCreateRequestStatus : sig
  type nonrec t = contestCreateRequestStatus
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type contestCreateRequest = {
  title: string;
  description: string option;
  start_time: string;
  end_time: string option;
  status: contestCreateRequestStatus;
  allowed_groups: userGroups;
}

val create_contestCreateRequest : title:string -> ?description:string -> start_time:string -> ?end_time:string -> status:contestCreateRequestStatus -> allowed_groups:userGroups -> unit -> contestCreateRequest
val contestCreateRequest_of_yojson : Yojson.Safe.t -> contestCreateRequest
val yojson_of_contestCreateRequest : contestCreateRequest -> Yojson.Safe.t
val contestCreateRequest_of_json : string -> contestCreateRequest
val json_of_contestCreateRequest : contestCreateRequest -> string

module ContestCreateRequest : sig
  type nonrec t = contestCreateRequest
  val create : title:string -> ?description:string -> start_time:string -> ?end_time:string -> status:contestCreateRequestStatus -> allowed_groups:userGroups -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type authToken = {
  token: string;
  user: user;
}

val create_authToken : token:string -> user:user -> unit -> authToken
val authToken_of_yojson : Yojson.Safe.t -> authToken
val yojson_of_authToken : authToken -> Yojson.Safe.t
val authToken_of_json : string -> authToken
val json_of_authToken : authToken -> string

module AuthToken : sig
  type nonrec t = authToken
  val create : token:string -> user:user -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type authRegisterPostRequest = {
  username: string;
  password: string;
  role: userRole;
}

val create_authRegisterPostRequest : username:string -> password:string -> role:userRole -> unit -> authRegisterPostRequest
val authRegisterPostRequest_of_yojson : Yojson.Safe.t -> authRegisterPostRequest
val yojson_of_authRegisterPostRequest : authRegisterPostRequest -> Yojson.Safe.t
val authRegisterPostRequest_of_json : string -> authRegisterPostRequest
val json_of_authRegisterPostRequest : authRegisterPostRequest -> string

module AuthRegisterPostRequest : sig
  type nonrec t = authRegisterPostRequest
  val create : username:string -> password:string -> role:userRole -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type authPasswordPostRequest = {
  current_password: string;
  new_password: string;
}

val create_authPasswordPostRequest : current_password:string -> new_password:string -> unit -> authPasswordPostRequest
val authPasswordPostRequest_of_yojson : Yojson.Safe.t -> authPasswordPostRequest
val yojson_of_authPasswordPostRequest : authPasswordPostRequest -> Yojson.Safe.t
val authPasswordPostRequest_of_json : string -> authPasswordPostRequest
val json_of_authPasswordPostRequest : authPasswordPostRequest -> string

module AuthPasswordPostRequest : sig
  type nonrec t = authPasswordPostRequest
  val create : current_password:string -> new_password:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type authLoginPostRequest = {
  username: string;
  password: string;
}

val create_authLoginPostRequest : username:string -> password:string -> unit -> authLoginPostRequest
val authLoginPostRequest_of_yojson : Yojson.Safe.t -> authLoginPostRequest
val yojson_of_authLoginPostRequest : authLoginPostRequest -> Yojson.Safe.t
val authLoginPostRequest_of_json : string -> authLoginPostRequest
val json_of_authLoginPostRequest : authLoginPostRequest -> string

module AuthLoginPostRequest : sig
  type nonrec t = authLoginPostRequest
  val create : username:string -> password:string -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type adminYodacStats = {
  queued_jobs_total: int option;
  queued_jobs_per_minute: int;
  processed_jobs_total: int;
  processed_jobs_per_minute: int;
}

val create_adminYodacStats : ?queued_jobs_total:int -> queued_jobs_per_minute:int -> processed_jobs_total:int -> processed_jobs_per_minute:int -> unit -> adminYodacStats
val adminYodacStats_of_yojson : Yojson.Safe.t -> adminYodacStats
val yojson_of_adminYodacStats : adminYodacStats -> Yojson.Safe.t
val adminYodacStats_of_json : string -> adminYodacStats
val json_of_adminYodacStats : adminYodacStats -> string

module AdminYodacStats : sig
  type nonrec t = adminYodacStats
  val create : ?queued_jobs_total:int -> queued_jobs_per_minute:int -> processed_jobs_total:int -> processed_jobs_per_minute:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type adminYodabStats = {
  yodab_requests_total: int;
  yodab_requests_per_minute: int;
  submissions_total: int;
  submissions_per_minute: int;
}

val create_adminYodabStats : yodab_requests_total:int -> yodab_requests_per_minute:int -> submissions_total:int -> submissions_per_minute:int -> unit -> adminYodabStats
val adminYodabStats_of_yojson : Yojson.Safe.t -> adminYodabStats
val yojson_of_adminYodabStats : adminYodabStats -> Yojson.Safe.t
val adminYodabStats_of_json : string -> adminYodabStats
val json_of_adminYodabStats : adminYodabStats -> string

module AdminYodabStats : sig
  type nonrec t = adminYodabStats
  val create : yodab_requests_total:int -> yodab_requests_per_minute:int -> submissions_total:int -> submissions_per_minute:int -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type adminUsersGetResponse2 = user list

val adminUsersGetResponse2_of_yojson : Yojson.Safe.t -> adminUsersGetResponse2
val yojson_of_adminUsersGetResponse2 : adminUsersGetResponse2 -> Yojson.Safe.t
val adminUsersGetResponse2_of_json : string -> adminUsersGetResponse2
val json_of_adminUsersGetResponse2 : adminUsersGetResponse2 -> string

module AdminUsersGetResponse2 : sig
  type nonrec t = adminUsersGetResponse2
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

type adminStatsResponse = {
  api_version: string;
  yoda_version: string;
  contributors: string list;
  yodab: adminYodabStats;
  yodac: adminYodacStats;
}

val create_adminStatsResponse : api_version:string -> yoda_version:string -> contributors:string list -> yodab:adminYodabStats -> yodac:adminYodacStats -> unit -> adminStatsResponse
val adminStatsResponse_of_yojson : Yojson.Safe.t -> adminStatsResponse
val yojson_of_adminStatsResponse : adminStatsResponse -> Yojson.Safe.t
val adminStatsResponse_of_json : string -> adminStatsResponse
val json_of_adminStatsResponse : adminStatsResponse -> string

module AdminStatsResponse : sig
  type nonrec t = adminStatsResponse
  val create : api_version:string -> yoda_version:string -> contributors:string list -> yodab:adminYodabStats -> yodac:adminYodacStats -> unit -> t
  val of_yojson : Yojson.Safe.t -> t
  val to_yojson : t -> Yojson.Safe.t
  val of_json : string -> t
  val to_json : t -> string
end

