
val session_module : 'a

type session_instance

class type session = object
  method instance : session_instance Js.t
  method on_will_download : unit (* TODO *)
  method get_cache_size : (int -> unit) -> unit
end

val default_session : session

val from_partition : string -> ?cache:bool -> session
