(** Implementation of Menu and MenuItem classes. *)

val menu_module : Util.instance
val menu_item_module : Util.instance


(** {2 Menu and MenuItem classes} *)

class type menu = object
  method instance : Util.instance
  method items : menu_item list
  method popup : unit -> unit -> unit -> unit -> unit
  method append : menu_item -> unit
  method insert : int -> menu_item -> unit
end
and menu_item = object
  method instance : Util.instance
  method enabled : unit -> bool
  method set_enabled : bool -> unit
  method visible : unit -> bool
  method set_visible : bool -> unit
  method checked : unit -> bool
  method set_checked : bool -> unit
end


(** {2 Menu methods} *)

val make_menu : unit -> menu

val set_application_menu : menu -> unit

val get_application_menu : unit -> menu option

val send_action_to_first_responder : string -> unit

val build_from_template : menu_item list -> menu


(** {2 MenuItem methods} *)

type menu_item_type =
  | Normal
  | Separator
  | Submenu
  | Checkbox
  | Radio

type role =
  | Undo
  | Redo
  | Cut
  | Copy
  | Paste
  | Pasteandmatchstyle
  | Selectall
  | Delete
  | Minimize
  | Close
  | Quit
  | Togglefullscreen
  | Resetzoom
  | Zoomin
  | Zoomout
  | About
  | Hide
  | Hideothers
  | Unhide
  | Startspeaking
  | Stopspeaking
  | Front
  | Zoom
  | Window
  | Help
  | Services

val make_menu_item :
  ?click:(unit -> unit -> unit) (* TODO *) ->
  ?role:role -> ?type_:menu_item_type -> ?label:string -> ?sublabel:string ->
  ?accelerator:Accelerator.accelerator ->
  ?icon:unit ->                 (* TODO *)
  ?enabled:bool -> ?visible:bool -> ?checked:bool -> ?submenu:menu ->
  ?id:string -> ?position:string -> unit -> menu_item


(** {2 Prebuilt menu item} *)

val separator : menu_item

val basic_apple_menu_item : unit -> menu_item
