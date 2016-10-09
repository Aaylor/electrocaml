
open Util

let session_module = electron##.session

type session_instance

class type session = object
  method instance : session_instance Js.t
  method on_will_download : unit (* TODO *)
  method get_cache_size : (int -> unit) -> unit
end

class session_obj instance : session = object(self)
  method private call : type ret. string -> Js.Unsafe.any array -> ret =
      Js.Unsafe.meth_call session_module

  method instance : session_instance Js.t = Js.Unsafe.coerce instance

  (* Events *)

  method on_will_download = ()

  (* Methods *)

  method get_cache_size cback =
    self#call "getCacheSize" [| Js.Unsafe.(inject (meth_callback cback)) |]

end

let default_session () =
  new session_obj session_module##.defaultSession

let from_partition partition ?cache =
  let cache = match cache with
    | None -> no_param
    | Some cache ->
      let cache_obj = Js.Unsafe.(obj [| "cache", inject (Js.bool cache) |]) in
      [| Js.Unsafe.inject cache_obj |]
  in
  Js.Unsafe.meth_call session_module "fromPartition"
    Array.(append [| Js.Unsafe.inject (Js.string partition) |] cache)

