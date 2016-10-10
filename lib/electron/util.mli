
type instance = [ `Instance  ] Js.t

val electron : 'a

val __directory : unit -> string

val __filename : unit -> string

val no_param : 'a array

module JSON : sig
  val parse : string -> 'a
  val stringify : 'a -> string
end

module Console : sig
  val log : string -> unit
end

val string_param : string -> Js.Unsafe.any
val int_param : int -> Js.Unsafe.any
val float_param : float -> Js.Unsafe.any
val bool_param : bool -> Js.Unsafe.any
val list_param : 'a list -> Js.Unsafe.any
val instance_param : 'a -> Js.Unsafe.any
val optional_param : 'a option -> ('a -> Js.Unsafe.any) -> Js.Unsafe.any array
val obj_param : (string * Js.Unsafe.any) array -> Js.Unsafe.any
val callback_param : ('a -> 'b) -> Js.Unsafe.any

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

module Methods (I : INSTANCE) : METHODS
