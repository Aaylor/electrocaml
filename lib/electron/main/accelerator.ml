
type modifiers =
  | Command
  | Control
  | CommandOrControl
  | Alt
  | Option
  | AltGr
  | Shift
  | Super

let string_of_modifiers = function
  | Command -> "Command"
  | Control -> "Control"
  | CommandOrControl -> "CommandOrControl"
  | Alt -> "Alt"
  | Option -> "Option"
  | AltGr -> "AltGr"
  | Shift -> "Shift"
  | Super -> "Super"

let modifiers_of_string = function
  | "Command" | "Cmd" -> Command
  | "Control" | "Ctrl" -> Control
  | "CommandOrControl" | "CmdOrCtrl" -> CommandOrControl
  | "Alt" -> Alt
  | "Option" -> Option
  | "AltGr" -> AltGr
  | "Shift" -> Shift
  | "Super" -> Super
  | s -> failwith (Format.sprintf "unknown modifiers: %s" s)

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

let check_key_code = function
  | Number n -> assert (n >= 0 && n <= 9)
  | Letter l -> (match l with 'A'..'Z' -> () | _ -> assert false)
  | FKey i -> assert (i >= 1 && i <= 24)
  | Punc c -> ()                (* TODO *)
  | _ -> ()

let string_of_key_code kc =
  check_key_code kc;
  match kc with
  | Number n -> Format.sprintf "%d" n
  | Letter l -> String.make 1 l
  | FKey i -> Format.sprintf "F%d" i
  | Punc p -> String.make 1 p
  | Plus -> "Plus"
  | Space -> "Space"
  | Tab -> "Tab"
  | Backspace -> "Backspace"
  | Delete -> "Delete"
  | Insert -> "Insert"
  | Return -> "Return"
  | Up -> "Up"
  | Down -> "Down"
  | Left -> "Left"
  | Right -> "Right"
  | Home -> "Home"
  | End -> "End"
  | PageUp -> "PageUp"
  | PageDown -> "PageDown"
  | Escape -> "Escape"
  | VolumeUp -> "VolumeUp"
  | VolumeDown -> "VolumeDown"
  | VolumeMute -> "VolumeMute"
  | MediaNextTrack -> "MediaNextTrack"
  | MediaPreviousTrack -> "MediaPreviousTrack"
  | MediaStop -> "MediaStop"
  | MediaPlayPause -> "MediaPlayPause"
  | PrintScreen -> "PrintScreen"

let key_code_of_string = function
  | "Plus" -> Plus
  | "Space" -> Space
  | "Tab" -> Tab
  | "Backspace" -> Backspace
  | "Delete" -> Delete
  | "Insert" -> Insert
  | "Return" -> Return
  | "Up" -> Up
  | "Down" -> Down
  | "Left" -> Left
  | "Right" -> Right
  | "Home" -> Home
  | "End" -> End
  | "PageUp" -> PageUp
  | "PageDown" -> PageDown
  | "Escape" -> Escape
  | "VolumeUp" -> VolumeUp
  | "VolumeDown" -> VolumeDown
  | "VolumeMute" -> VolumeMute
  | "MediaNextTrack" -> MediaNextTrack
  | "MediaPreviousTrack" -> MediaPreviousTrack
  | "MediaStop" -> MediaStop
  | "MediaPlayPause" -> MediaPlayPause
  | "PrintScreen" -> PrintScreen
  | s ->
    let size = String.length s in
    let error () = failwith (Format.sprintf "unknown key code: %s" s) in
    if size > 0 then
      match String.get s 0 with
      | '0'..'9' as c -> Number (int_of_char c)
      | 'A'..'Z' as c when size = 1 -> Letter c
      | 'F' when size > 1 ->
        let rest = String.sub s 1 (size - 1) in
        FKey (int_of_string rest) (* TODO: catch int_of_string *)
      | _ as c -> Punc c
    else error ()

let make_accelerator modifiers key_codes =
  let modifiers = List.map string_of_modifiers modifiers in
  let key_codes = List.map string_of_key_code key_codes in
  let rec make_string buffer = function
    | [] -> assert false
    | [x] ->
      Buffer.add_string buffer x;
      Buffer.contents buffer
    | x :: xs ->
      Buffer.add_string buffer x;
      Buffer.add_char buffer '+';
      make_string buffer xs
  in
  make_string (Buffer.create 29) (modifiers @ key_codes)
  
