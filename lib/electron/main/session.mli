
val session_module : 'a

class type cookies = object
  method instance : Util.instance
  method on_changed : unit -> unit
  method get : unit -> unit -> unit
  method set : unit -> unit -> unit
  method remove : unit -> unit -> unit -> unit
end

class type web_request = object
  method instance : Util.instance
  method on_before_request : ?filter:unit -> unit -> unit
  method on_before_send_headers : ?filter:unit -> unit -> unit
  method on_send_headers : ?filter:unit -> unit -> unit
  method on_headers_received : ?filter:unit -> unit -> unit
  method on_response_started : ?filter:unit -> unit -> unit
  method on_before_redirect : ?filter:unit -> unit -> unit
  method on_completed : ?filter:unit -> unit -> unit
  method on_error_occurred : ?filter:unit -> unit -> unit
end

class type session = object
  method instance : Util.instance
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

val default_session : unit -> session

val from_partition : ?cache:bool -> string -> session
