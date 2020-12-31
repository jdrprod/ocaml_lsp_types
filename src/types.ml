type ('a, 'b) either = 
    Left of 'a | Right of 'b [@@deriving yojson]

module Const = struct
  type uri = string [@@deriving yojson]
  type documentUri = string [@@deriving yojson]
  let eol = ["\n"; "\r\n"; "\r"]
end

module RegularExpressionsClientCapabilities = struct
  type t = {
    engine: string;
    version: string option [@default None];
  } [@@deriving yojson]

  let q = { engine = "my engine"; version = Some "1.1"}
end

module Position = struct
  type t = {
    line: int;
    character: int;
  } [@@deriving yojson]
end

module Range = struct
  type t = {
    t_start: Position.t [@key "start"];
    t_end: Position.t [@key "end"];
  } [@@deriving yojson]
end

module Location = struct
  type t = {
    uri: Const.documentUri;
    range: Range.t;
  } [@@deriving yojson]
end

module LocationLink = struct
  (** TODO *)
end

module DiagnosticSeverity = struct
  type t = int [@@deriving yojson]
  type severities = Error | Warning | Information | Hint
  let severity i =
    match i with
    | 1 -> Error
    | 2 -> Warning
    | 3 -> Information
    | 4 -> Hint
    | _ -> failwith ("unknown severity : " ^ (string_of_int i))
end

module CodeDescription = struct
  type t = {
    href: Const.uri;
  } [@@deriving yojson {strict = false}]
end

module DiagnosticTag = struct
  type t = int [@@deriving yojson]
  type tag = Unnecessary | Deprecated
  let tag i =
    match i with
    | 1 -> Unnecessary
    | 2 -> Deprecated
    | _ -> failwith ("unknown tag : " ^ (string_of_int i))
end

module DiagnosticRelatedInformation = struct
  type t = {
    location: Location.t;
    message: string;
  } [@@deriving yojson {strict = false}]
end

module Diagnostic = struct
  type t = {
    range: Range.t;
    severity: DiagnosticSeverity.t option;
    code: string option [@default None];
    codeDescription: CodeDescription.t option;
    source: string option [@default None];
    message: string;
    tags: (DiagnosticTag.t list) option [@default None];
    relatedInformations: DiagnosticRelatedInformation.t option [@default None];
  } [@@deriving yojson {strict = false}]
end

module Command = struct
  type t = {
    title: string;
    command: string;
    arguments: (string list) option
  } [@@deriving yojson {strict = false}]
end

module TextEdit = struct
  type t = {
    range: Range.t;
    newText: string;
  } [@@deriving yojson {strict = false}]
end

module ChangeAnnotation = struct
  type t = {
    label: string;
    needsConfirmation: bool option [@default None];
    description: string option [@default None]
  } [@@deriving yojson {strict = false}]
end

module AnotatedTextEdit = struct
  type t = {
    annotationId: string;
  } [@@deriving yojson]
end