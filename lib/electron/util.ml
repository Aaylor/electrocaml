
type instance = [ `Instance  ] Js.t

let electron =
  Js.Unsafe.fun_call
    (Js.Unsafe.js_expr "require")
    [| Js.Unsafe.inject (Js.string "electron") |]

let __directory () =
  Js.to_string (Js.Unsafe.eval_string "__dirname")

let __filename () =
  Js.to_string (Js.Unsafe.eval_string "__filename")

let no_param = [| |]

module JSON = struct
  let parse str =
    Js._JSON##parse (Js.string str)
  let stringify jso =
    Js.to_string (Js._JSON##stringify jso)
end

module Console = struct
  let console = Js.Unsafe.js_expr "console"
  let log str =
    Js.Unsafe.meth_call
      console "log" [| Js.Unsafe.inject (Js.string str) |]
  let log_any elt =
    Js.Unsafe.meth_call console "log" [| Js.Unsafe.inject elt |]
end


let string_param s = Js.Unsafe.inject (Js.string s)
let int_param i = Js.Unsafe.inject i
let float_param f = Js.Unsafe.inject (Js.float f)
let bool_param b = Js.Unsafe.inject (Js.bool b)
let list_param l = Js.Unsafe.inject (Js.array (Array.of_list l))
let instance_param i = Js.Unsafe.inject i#instance
let callback_param cb = Js.Unsafe.(inject (meth_callback cb))
let obj_param p = Js.Unsafe.(inject (obj p))
let optional_param o t = match o with
  | None -> no_param
  | Some o -> [| t o |]

module type METHODS = sig
  val call : string -> Js.Unsafe.any array -> 'a
  val unit_any : string -> 'a
  val unit_unit : string -> unit
  val unit_int : string -> int
  val unit_bool : string -> bool
  val unit_float : string -> float
  val unit_string : string -> string
  val int_unit : string -> int -> unit
  val bool_unit : string -> bool -> unit
  val float_unit : string -> float -> unit
  val string_unit : string -> string -> unit
  val callback_unit : string -> ('a -> 'b) -> unit
  val any_unit : string -> 'a -> ('a -> Js.Unsafe.any) -> unit
end

module type INSTANCE = sig
  val i : instance
end

module Methods (I : INSTANCE) : METHODS = struct
  let call fname params =
    Js.Unsafe.meth_call I.i fname params

  let unit_any fname = call fname no_param
  let unit_unit fname = unit_any fname
  let unit_int fname = unit_any fname
  let unit_bool fname = Js.to_bool (unit_any fname)
  let unit_float fname = Js.to_float (unit_any fname)
  let unit_string fname = Js.to_string (unit_any fname)

  let any_unit fname p tp : unit = call fname [| tp p |]
  let int_unit fname i = any_unit fname i int_param
  let bool_unit fname b = any_unit fname b bool_param
  let float_unit fname f = any_unit fname f float_param
  let string_unit fname s = any_unit fname s string_param
  let callback_unit fname callback = any_unit fname callback callback_param
end


module ObjBuilder = struct

  type 'a push_fun =
    (string * 'a option) ->
    (string * Js.Unsafe.any) list ->
    (string * Js.Unsafe.any) list

  let push (key, translate, elt) acc = match elt with
    | None -> acc
    | Some elt -> (key, translate elt) :: acc

  let push_string (key, elt) acc = push (key, string_param, elt) acc

  let push_bool (key, elt) acc = push (key, bool_param, elt) acc

  let push_int (key, elt) acc = push (key, int_param, elt) acc

  let push_float (key, elt) acc = push (key, float_param, elt) acc

  let push_instance (key, elt) acc =
    push (key, (fun s -> Js.Unsafe.inject s#instance), elt) acc

  let push_callback (key, elt) acc = push (key, callback_param, elt) acc

  let push_datatype  (key, elt, mk) acc = match elt with
    | None -> acc
    | Some elt -> (key, string_param (mk elt)) :: acc

end
