
open Util

(* Modules *)

let menu_module = electron##._Menu
let menu_item_module = electron##._MenuItem

(* Class Menu and MenuItem *)

class type menu = object
  method instance : instance
  method items : menu_item list
  method popup : unit -> unit -> unit -> unit -> unit
  method append : menu_item -> unit
  method insert : int -> menu_item -> unit
end
and menu_item = object
  method instance : instance
  method enabled : unit -> bool
  method set_enabled : bool -> unit
  method visible : unit -> bool
  method set_visible : bool -> unit
  method checked : unit -> bool
  method set_checked : bool -> unit
end

let make_menu_item_obj instance : menu_item =
  let module M = Methods(struct let i = instance end) in
  object
    method instance = instance
    method enabled () = Js.to_bool (Js.Unsafe.coerce instance)##.enabled
    method set_enabled b = (Js.Unsafe.coerce instance)##.enabled := Js.bool b
    method visible () = Js.to_bool (Js.Unsafe.coerce instance)##.visible
    method set_visible b = (Js.Unsafe.coerce instance)##.visible := Js.bool b
    method checked () = Js.to_bool (Js.Unsafe.coerce instance)##.checked
    method set_checked b = (Js.Unsafe.coerce instance)##.checked := Js.bool b
  end

let make_menu_obj instance : menu =
  let module M = Methods(struct let i = instance end) in
  object
    method instance = instance

    method items =
      let items = Js.to_array ((Js.Unsafe.coerce instance)##.items) in
      List.map make_menu_item_obj (Array.to_list items)

    method popup () () () () = () (* TODO *)

    method append menu_item =
      M.call "append" [| Js.Unsafe.inject menu_item#instance |]

    method insert i menu_item =
      let parameters = [| int_param i; Js.Unsafe.inject menu_item#instance |] in
      M.call "insert" parameters
  end



(* Menu Static Methods *)

module MenuStatic = Methods(struct let i = menu_module end)

let make_menu () : menu =
  let instance = Js.Unsafe.new_obj menu_module no_param in
  make_menu_obj instance

let set_application_menu menu : unit =
  Js.Unsafe.meth_call
    menu_module
    "setApplicationMenu"
    [| Js.Unsafe.inject menu#instance |]

let get_application_menu () =
  match Js.Opt.to_option (MenuStatic.unit_any "getApplicationMenu") with
  | None -> None
  | Some obj -> Some (make_menu_obj obj)

let send_action_to_first_responder action =
  MenuStatic.string_unit "sendActionToFirstResponder" action

let build_from_template template =
  let template = Array.of_list (List.map (fun m -> m#instance) template) in
  let instance =
    MenuStatic.call "buildFromTemplate"
      [| Js.Unsafe.inject (Js.array template) |]
  in
  make_menu_obj instance


(* MenuItem Creation Methods *)

(* Type used by MenuItem *)

type menu_item_type =
  | Normal
  | Separator
  | Submenu
  | Checkbox
  | Radio

let string_of_menu_item_type = function
  | Normal -> "normal"
  | Separator -> "separator"
  | Submenu -> "submenu"
  | Checkbox -> "checkbox"
  | Radio -> "radio"

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

let string_of_role = function
  | Undo -> "undo"
  | Redo -> "redo"
  | Cut -> "cut"
  | Copy -> "copy"
  | Paste -> "paste"
  | Pasteandmatchstyle -> "pasteandmatchstyle"
  | Selectall -> "selectall"
  | Delete -> "delete"
  | Minimize -> "minimize"
  | Close -> "close"
  | Quit -> "quit"
  | Togglefullscreen -> "togglefullscreen"
  | Resetzoom -> "resetzoom"
  | Zoomin -> "zoomin"
  | Zoomout -> "zoomout"
  | About -> "about"
  | Hide -> "hide"
  | Hideothers -> "hideothers"
  | Unhide -> "unhide"
  | Startspeaking -> "startspeaking"
  | Stopspeaking -> "stopspeaking"
  | Front -> "front"
  | Zoom -> "zoom"
  | Window -> "window"
  | Help -> "help"
  | Services -> "services"

type menu_item_options =
  { click : (unit -> unit -> unit) option; (* TODO *)
    role : role option;
    type_ : menu_item_type option;
    label : string option;
    sublabel : string option;
    accelerator : Accelerator.accelerator option;
    icon : unit option;         (* TODO *)
    enabled : bool option;
    visible : bool option;
    checked : bool option;
    submenu : menu option;
    id : string option;
    position : string option }

let default_menu_item_options =
  { click = None; role = None; type_ = None; label = None;
    sublabel = None; accelerator = None; icon = None; enabled = None;
    visible = None; checked = None; submenu = None; id = None; position = None }

let obj_of_menu_item_options mi =
  let push (key, translate, elt) acc = match elt with
    | None -> acc
    | Some elt -> (key, translate elt) :: acc
  in
  let push_string (key, elt) acc = push (key, string_param, elt) acc in
  let push_bool (key, elt) acc = push (key, bool_param, elt) acc in
  let push_menu (key, elt) acc =
    push (key, (fun s -> Js.Unsafe.inject s#instance), elt) acc
  in
  let push_fun (key, elt) acc = push (key, callback_param, elt) acc in
  let push_role (key, elt) acc =
    push (key, (fun s -> string_param (string_of_role s)), elt) acc
  in
  let push_type (key, elt) acc =
    push (key, (fun s -> string_param (string_of_menu_item_type s)), elt) acc
  in
  let obj =
    push_fun ("click", mi.click) @@
    push_role ("role", mi.role) @@
    push_type ("type", mi.type_) @@
    push_string ("label", mi.label) @@
    push_string ("sublabel", mi.sublabel) @@
    push
      ("accelerator",
       (fun s -> string_param (Accelerator.make_accelerator s)),
       mi.accelerator) @@
    (* push_unit ("icon", mi.icon) @@         (\* TODO *\) *)
    push_bool ("enabled", mi.enabled) @@
    push_bool ("visible", mi.visible) @@
    push_bool ("checked", mi.checked) @@
    push_menu ("submenu", mi.submenu) @@
    push_string ("id", mi.id) @@
    push_string ("position", mi.position) []
  in
  Js.Unsafe.obj (Array.of_list obj)

let make_menu_item opt : menu_item =
  let param = [| Js.Unsafe.inject (obj_of_menu_item_options opt) |] in
  let instance = Js.Unsafe.new_obj menu_item_module param in
  make_menu_item_obj instance

let separator =
  make_menu_item { default_menu_item_options with type_ = Some Separator }

let basic_apple_menu_item () =
  let open Accelerator in
  let name = App.app#get_name () in
  let submenu =
    build_from_template
      [ make_menu_item
          { default_menu_item_options with
            label = Some (Format.sprintf "About %s" name);
            role = Some About };
        separator;
        make_menu_item
          { default_menu_item_options with
            label = Some "Services";
            role = Some Services };
        separator;
        make_menu_item
          { default_menu_item_options with
            label = Some (Format.sprintf "Hide %s" name);
            accelerator = Some ([Command], [Letter 'H']);
            role = Some Hide };
        make_menu_item
          { default_menu_item_options with
            label = Some "Hide Others";
            accelerator = Some ([Command; Shift], [Letter 'H']);
            role = Some Hideothers };
        make_menu_item
          { default_menu_item_options with
            label = Some "Show All";
            role = Some Unhide };
        separator;
        make_menu_item
          { default_menu_item_options with
            label = Some "Quit";
            accelerator = Some ([Command], [Letter 'Q']);
            click = Some (fun _ _ -> App.app#quit ()) }; ]
  in
  make_menu_item
    { default_menu_item_options with
      label = Some name;
      submenu = Some submenu }
