(** Implementation of Accelerator *)

(** {2 Modifiers} *)

type modifiers =
  | Command
  | Control
  | CommandOrControl
  | Alt
  | Option
  | AltGr
  | Shift
  | Super

val string_of_modifiers : modifiers -> string

val modifiers_of_string : string -> modifiers


(** {2 Key codes} *)

type key_code =
  | Number of int
  | Letter of char
  | FKey of int
  | Punc of char
  | Plus
  | Space
  | Tab
  | Backspace
  | Delete
  | Insert
  | Return
  | Up
  | Down
  | Left
  | Right
  | Home
  | End
  | PageUp
  | PageDown
  | Escape
  | VolumeUp
  | VolumeDown
  | VolumeMute
  | MediaNextTrack
  | MediaPreviousTrack
  | MediaStop
  | MediaPlayPause
  | PrintScreen

val string_of_key_code : key_code -> string

val key_code_of_string : string -> key_code


(** {2 Accelerator} *)

type accelerator = modifiers list * key_code list

val make_accelerator : accelerator -> string
