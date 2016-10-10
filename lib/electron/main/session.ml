
open Util

let session_module = electron##.session


(* Cookie object *)

class type cookies = object
  method instance : instance
  method on_changed : unit -> unit
  method get : unit -> unit -> unit
  method set : unit -> unit -> unit
  method remove : unit -> unit -> unit -> unit
end

let make_cookies_obj instance : cookies =
  let module M = Methods(struct let i = instance end) in
  object(self)
    method instance = instance

    (* Events *)

    method on_changed () = ()

    method get filter callback = ()

    method set details callback = ()

    method remove url name callback = ()
  end


(* WebRequest object *)

class type web_request = object
  method instance : instance
  method on_before_request : ?filter:unit -> unit -> unit
  method on_before_send_headers : ?filter:unit -> unit -> unit
  method on_send_headers : ?filter:unit -> unit -> unit
  method on_headers_received : ?filter:unit -> unit -> unit
  method on_response_started : ?filter:unit -> unit -> unit
  method on_before_redirect : ?filter:unit -> unit -> unit
  method on_completed : ?filter:unit -> unit -> unit
  method on_error_occurred : ?filter:unit -> unit -> unit
end

let make_web_request_obj instance : web_request =
  let module M = Methods(struct let i = instance end) in
  object(self)
    method instance = instance
    method on_before_request ?filter listener = ()
    method on_before_send_headers ?filter listener = ()
    method on_send_headers ?filter listener = ()
    method on_headers_received ?filter listener = ()
    method on_response_started ?filter listener = ()
    method on_before_redirect ?filter listener = ()
    method on_completed ?filter listener = ()
    method on_error_occurred ?filter listener = ()
  end


(* Session object *)

class type session = object
  method instance : instance
  method cookies : cookies
  method web_request : web_request
  method protocol : unit
  method on_will_download : unit (* TODO *)
  method get_cache_size : (int -> unit) -> unit
  method clear_cache : unit -> unit
  method clear_storage_data : ?options:unit -> ?callback:unit -> unit -> unit
  method flush_storage_data : unit -> unit
  method resolve_proxy : unit -> unit -> unit
  method set_download_path : unit -> unit
  method enable_network_emulation : unit -> unit
  method disable_network_emulation : unit -> unit
  method set_certificate_verify_proc : unit -> unit
  method set_permission_request_handler : unit -> unit
  method clear_host_resolver_cache : ?callback: unit -> unit -> unit
  method allow_ntlm_credentials_for_domains : unit -> unit
  method get_user_agent : unit -> unit
  method get_blob_data : unit -> unit -> unit
end

let make_session_obj instance : session =
  let module M = Methods(struct let i = instance end) in
  object (self)
    method instance = instance

    (* Instances *)

    method cookies =
      make_cookies_obj ((Js.Unsafe.coerce instance)##.cookies)

    method web_request =
      make_web_request_obj ((Js.Unsafe.coerce instance)##.webRequest)

    method protocol = ()

    (* Events *)

    method on_will_download = ()

    (* Methods *)

    method get_cache_size callback =
      M.callback_unit "getCacheSize" callback

    method clear_cache callback = ()

    method clear_storage_data ?options ?callback () = ()

    method flush_storage_data () = ()

    method resolve_proxy url callback = ()

    method set_download_path path = ()

    method enable_network_emulation options = ()

    method disable_network_emulation () = ()

    method set_certificate_verify_proc proc = ()

    method set_permission_request_handler handler = ()

    method clear_host_resolver_cache ?callback () = ()

    method allow_ntlm_credentials_for_domains domains = ()

    method get_user_agent () = ()

    method get_blob_data identifier callback = ()

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
