
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
  MenuStatic.any_unit "setApplicationMenu" menu instance_param

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


(* MenuItem Methods *)

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

let obj_of_menu_item_options
    ?click ?role ?type_ ?label ?sublabel ?accelerator
    ?icon ?enabled ?visible ?checked ?submenu ?id ?position () =
  let open ObjBuilder in
  let obj =
    push_callback ("click", click) @@
    push_datatype ("role", role, string_of_role) @@
    push_datatype ("type", type_, string_of_menu_item_type) @@
    push_string ("label", label) @@
    push_string ("sublabel", sublabel) @@
    push_datatype ("accelerator", accelerator, Accelerator.make_accelerator) @@
    (* push_unit ("icon", icon) @@         (\* TODO *\) *)
    push_bool ("enabled", enabled) @@
    push_bool ("visible", visible) @@
    push_bool ("checked", checked) @@
    push_instance ("submenu", submenu) @@
    push_string ("id", id) @@
    push_string ("position", position) []
  in
  Js.Unsafe.obj (Array.of_list obj)

let make_menu_item
    ?click ?role ?type_ ?label ?sublabel ?accelerator
    ?icon ?enabled ?visible ?checked ?submenu ?id ?position () : menu_item =
  let obj =
    obj_of_menu_item_options ?click ?role ?type_ ?label ?sublabel ?accelerator
      ?icon ?enabled ?visible ?checked ?submenu ?id ?position ()
  in
  let param = [| Js.Unsafe.inject obj |] in
  let instance = Js.Unsafe.new_obj menu_item_module param in
  make_menu_item_obj instance


(* Prebuilt MenuItem *)

let separator = make_menu_item ~type_:Separator ()

let basic_apple_menu_item () =
  let open Accelerator in
  let name = App.app#get_name () in
  let submenu =
    build_from_template
      [ make_menu_item ~label:(Format.sprintf "About %s" name) ~role:About ();
        separator;
        make_menu_item ~label:"Services" ~role:Services ();
        separator;
        make_menu_item
          ~label:(Format.sprintf "Hide %s" name)
          ~accelerator:([Command], [Letter 'H'])
          ~role:Hide ();
        make_menu_item
          ~label:"Hide Others"
          ~accelerator:([Command; Shift], [Letter 'H'])
          ~role:Hideothers ();
        make_menu_item ~label:"Show All" ~role:Unhide ();
        separator;
        make_menu_item
          ~label:"Quit" ~accelerator:([Command], [Letter 'Q'])
          ~click:(fun _ _ -> App.app#quit ()) ()
      ]
  in
  make_menu_item ~label:name ~submenu ()
