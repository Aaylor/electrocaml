
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
