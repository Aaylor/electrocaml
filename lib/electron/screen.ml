
open Common_type
open Util

let screen_module () = electron##.screen


(* Display object *)

type rotation =
  | R_0
  | R_90
  | R_180
  | R_270

let int_of_rotation = function
  | R_0 -> 0
  | R_90 -> 90
  | R_180 -> 180
  | R_270 -> 270

let rotation_of_int = function
  | 0 -> R_0
  | 90 -> R_90
  | 180 -> R_180
  | 270 -> R_270
  | _ -> failwith "incorrect rotation"

type touch_support =
  | Available
  | Unavailable
  | Unknown

let string_of_touch_support = function
  | Available -> "available"
  | Unavailable -> "unavailable"
  | Unknown -> "unknown"

let touch_support_of_string = function
  | "available" -> Available
  | "unavailable" -> Unavailable
  | "unknown" -> Unknown
  | _ -> failwith "incorrect touch_support"

type display = {
  id : int;
  rotation : rotation;
  scale_factor : float;
  touch_support : touch_support;
  bound : unit;
  size : unit;
  workArea : unit;
  workAreaSize : unit;
}

let display_of_obj obj =
  let coerce = Js.Unsafe.coerce in
  { id = (coerce obj)##.id;
    rotation = rotation_of_int ((coerce obj)##.rotation);
    scale_factor = Js.to_float ((coerce obj)##.scale_factor);
    touch_support =
      touch_support_of_string (Js.to_string ((coerce obj)##.touch_support));
    bound = ();                 (* TODO *)
    size = ();                  (* TODO *)
    workArea = ();              (* TODO *)
    workAreaSize = () }         (* TODO *)

let obj_of_display d =
  let obj =
    [| "id", int_param d.id;
       "rotation", int_param (int_of_rotation d.rotation);
       "scale_factor", float_param d.scale_factor;
       "touch_support", string_param (string_of_touch_support d.touch_support);
       (* "bound", (); TODO *)
       (* "size", (); TODO *)
       (* "workArea", (); TODO *)
       (* "workAreaSize", (); TODO *) |]
  in
  Js.Unsafe.obj obj


(* Events *)
(* TODO *)

(* Methods *)

let get_cursor_screen_point () =
  let module M = Methods(struct let i = screen_module () end) in
  position_of_obj (M.unit_any "getCursorScreenPoint")

let get_primary_display () =
  let module M = Methods(struct let i = screen_module () end) in
  display_of_obj (M.unit_any "getPrimaryDisplay")

let get_all_displays () =
  let module M = Methods(struct let i = screen_module () end) in
  let res = Js.to_array (M.unit_any "getAllDisplays") in
  List.map display_of_obj (Array.to_list res)

let get_display_nearest_point point =
  let module M = Methods(struct let i = screen_module () end) in
  let res =
    M.call "getDisplayNearestPoint"
      [| Js.Unsafe.inject (obj_of_position point) |]
  in
  display_of_obj res

let get_display_matching rect =
  let module M = Methods(struct let i = screen_module () end) in
  let res =
    M.call "getDisplayMatching"
      [| Js.Unsafe.inject (obj_of_size_with_position rect) |]
  in
  display_of_obj res

