
open Util

let web_contents_module = electron##.webContents

(* Class Debugger *)

class type debugger = object
  method instance : instance
end

let make_debugger_obj instance : debugger =
  let module M = Methods(struct let i = instance end) in
  object
    method instance = instance
  end


(* Class WebContents *)

class type web_contents = object
  method instance : instance
  method id : int
  method session : Session.session
  method host_web_contents : web_contents option
  method dev_tools_web_contents : web_contents option
  method debugger : debugger

  method load_url : unit -> unit -> unit
  method download_url : unit -> unit
  method get_url : unit -> unit
  method get_title : unit -> unit
  method is_destroyed : unit -> unit
  method is_focused : unit -> unit
  method is_loading : unit -> unit
  method is_loading_main_frame : unit -> unit
  method is_waiting_for_response : unit -> unit
  method stop : unit -> unit
  method reload : unit -> unit
  method reload_ignoring_cache : unit -> unit
  method can_go_back : unit -> unit
  method can_go_forward : unit -> unit
  method can_go_to_offset : unit -> unit
  method clear_history : unit -> unit
  method go_back : unit -> unit
  method go_forward : unit -> unit
  method go_to_index : unit -> unit
  method go_to_offset : unit -> unit
  method is_crashed : unit -> unit
  method set_user_agent : unit -> unit
  method get_user_agent : unit -> unit
  method insert_c_s_s : unit -> unit
  method execute_java_script : unit -> unit -> unit -> unit
  method set_audio_muted : unit -> unit
  method is_audio_muted : unit -> unit
  method set_zoom_factor : unit -> unit
  method get_zoom_factor : unit -> unit
  method set_zoom_level : unit -> unit
  method get_zoom_level : unit -> unit
  method set_zoom_level_limits : unit -> unit -> unit
  method undo : unit -> unit
  method redo : unit -> unit
  method cut : unit -> unit
  method copy : unit -> unit
  method copy_image_at : unit -> unit -> unit
  method paste : unit -> unit
  method paste_and_match_style : unit -> unit
  method delete : unit -> unit
  method select_all : unit -> unit
  method unselect : unit -> unit
  method replace : unit -> unit
  method replace_misspelling : unit -> unit
  method insert_text : unit -> unit
  method find_in_page : unit -> unit -> unit
  method stop_find_in_page : unit -> unit
  method capture_page : unit -> unit -> unit
  method has_service_worker : unit -> unit
  method unregister_service_worker : unit -> unit
  method print : unit -> unit
  method print_to_pdf : unit -> unit -> unit
  method add_work_space : unit -> unit
  method remove_work_space : unit -> unit
  method open_dev_tools : unit -> unit
  method close_dev_tools : unit -> unit
  method is_dev_tools_opened : unit -> unit
  method is_dev_tools_focused : unit -> unit
  method toggle_dev_tools : unit -> unit
  method inspect_element : unit -> unit -> unit
  method inspect_service_worker : unit -> unit
  method send : unit -> unit -> unit -> unit -> unit
  method enable_device_emulation : unit -> unit
  method disable_device_emulation : unit -> unit
  method send_input_event : unit -> unit
  method begin_frame_subscription : unit -> unit -> unit
  method end_frame_subscription : unit -> unit
  method start_drag : unit -> unit
  method save_page : unit -> unit -> unit ->unit
  method show_definition_for_selection : unit -> unit
  method is_offscreen : unit -> unit
  method start_painting : unit -> unit
  method stop_painting : unit -> unit
  method is_painting : unit -> unit
  method set_frame_rate : unit -> unit
  method get_frame_rate : unit -> unit
  method invalidate : unit -> unit

end

let rec make_web_contents_obj instance : web_contents =
  let module M = Methods(struct let i = instance end) in
  object
    method instance = instance

    (* Properties *)

    method id = (Js.Unsafe.coerce instance)##.id

    method session =
      Session.make_session_obj (Js.Unsafe.coerce instance)##.session

    method host_web_contents =
      match Js.Opt.to_option (Js.Unsafe.coerce instance)##.hostWebContents with
      | None -> None
      | Some elt -> Some (make_web_contents_obj elt)

    method dev_tools_web_contents =
      match Js.Opt.to_option (Js.Unsafe.coerce instance)##.hostWebContents with
      | None -> None
      | Some elt -> Some (make_web_contents_obj elt)

    method debugger = make_debugger_obj (Js.Unsafe.coerce instance)##.debugger

    (* Events *)

    (* Methods *)

    method load_url url options = ()
    method download_url url = ()
    method get_url () = ()
    method get_title () = ()
    method is_destroyed () = ()
    method is_focused () = ()
    method is_loading () = ()
    method is_loading_main_frame () = ()
    method is_waiting_for_response () = ()
    method stop () = ()
    method reload () = ()
    method reload_ignoring_cache () = ()
    method can_go_back () = ()
    method can_go_forward () = ()
    method can_go_to_offset offset = ()
    method clear_history () = ()
    method go_back () = ()
    method go_forward () = ()
    method go_to_index index = ()
    method go_to_offset offset = ()
    method is_crashed () = ()
    method set_user_agent user_agent = ()
    method get_user_agent () = ()
    method insert_c_s_s css = ()
    method execute_java_script code user_gesture callback = ()
    method set_audio_muted muted = ()
    method is_audio_muted () = ()
    method set_zoom_factor factor = ()
    method get_zoom_factor callback = ()
    method set_zoom_level level = ()
    method get_zoom_level callback = ()
    method set_zoom_level_limits minimum_level maximum_level = ()
    method undo () = ()
    method redo () = ()
    method cut () = ()
    method copy () = ()
    method copy_image_at x y = ()
    method paste () = ()
    method paste_and_match_style () = ()
    method delete () = ()
    method select_all () = ()
    method unselect () = ()
    method replace text = ()
    method replace_misspelling text = ()
    method insert_text text = ()
    method find_in_page text options = ()
    method stop_find_in_page action = ()
    method capture_page rect callback = ()
    method has_service_worker callback = ()
    method unregister_service_worker callback = ()
    method print options = ()
    method print_to_pdf options callback = ()
    method add_work_space path = ()
    method remove_work_space path = ()
    method open_dev_tools options = ()
    method close_dev_tools () = ()
    method is_dev_tools_opened () = ()
    method is_dev_tools_focused () = ()
    method toggle_dev_tools () = ()
    method inspect_element x y = ()
    method inspect_service_worker () = ()
    method send channel arg1 arg2 parameters = ()
    method enable_device_emulation parameters = ()
    method disable_device_emulation () = ()
    method send_input_event event = ()
    method begin_frame_subscription only_dirty callback = ()
    method end_frame_subscription () = ()
    method start_drag item = ()
    method save_page full_path save_type callback = ()
    method show_definition_for_selection () = ()
    method is_offscreen () = ()
    method start_painting () = ()
    method stop_painting () = ()
    method is_painting () = ()
    method set_frame_rate fps = ()
    method get_frame_rate () = ()
    method invalidate () = ()

  end


(* Static Methods *)

module Static = Methods(struct let i = web_contents_module end)

let get_all_web_contents () =
  assert false

let get_focused_web_contents () =
  assert false

let from_id id =
  assert false
