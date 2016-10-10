
val session_module : 'a

class type session = object
  method instance : Util.instance
  method on_will_download : unit (* TODO *)
  method get_cache_size : (int -> unit) -> unit
end

val default_session : unit -> session

val from_partition : ?cache:bool -> string -> session
