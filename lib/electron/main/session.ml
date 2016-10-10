
open Util

let session_module = electron##.session


(* METHODS *)

class type session = object
  method instance : instance
  method on_will_download : unit (* TODO *)
  method get_cache_size : (int -> unit) -> unit
end

let make_session_obj instance : session =
  let module M : METHODS = Methods(struct let i = instance end) in
  object (self)
    method instance = instance

    (* Events *)

    method on_will_download = ()

    (* Methods *)

    method get_cache_size callback =
      M.callback_unit "getCacheSize" callback
  end



(* STATIC METHODS AND FIELDS *)

module Static = Methods(struct let i = session_module end)

let default_session () =
  make_session_obj session_module##.defaultSession

let from_partition ?cache partition =
  let cache =
    optional_param cache
      (fun cache -> obj_param [| "cache", bool_param cache |])
  in
  let session =
    Static.call "fromPartition"
      (Array.append [| string_param partition |] cache)
  in
  make_session_obj session
