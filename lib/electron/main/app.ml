
open Util

let app_module = electron##.app
let command_line_module = app_module##.commandLine
let dock_module = app_module##.dock

type event (* TODO *)

type certificate (* TODO *)

type path_parameter =
  | Home
  | AppData
  | UserData
  | Temp
  | Exe
  | Module
  | Desktop
  | Documents
  | Downloads
  | Music
  | Pictures
  | Videos
  | PepperFlashSystemPlugin

let string_of_path_parameter = function
  | Home -> "home"
  | AppData -> "appData"
  | UserData -> "userData"
  | Temp -> "temp"
  | Exe -> "exe"
  | Module -> "module"
  | Desktop -> "desktop"
  | Documents -> "documents"
  | Downloads -> "downloads"
  | Music -> "music"
  | Pictures -> "pictures"
  | Videos -> "videos"
  | PepperFlashSystemPlugin -> "pepperFlashSystemPlugin"

type bounce =
  | Critical
  | Informational

let string_of_bounce = function
  | Critical -> "critical"
  | Informational -> "informational"

type task = {
  program : string;
  arguments : string;
  title : string;
  description : string;
  iconPath : string;
  iconIndex : int;
}

let task_param { program; arguments; title; description; iconPath; iconIndex } =
  let mk_string s = Js.Unsafe.inject (Js.string s) in
  Js.Unsafe.obj
    [| "program", mk_string program;
       "arguments", mk_string arguments;
       "title", mk_string title;
       "description", mk_string description;
       "iconPath", mk_string iconPath;
       "iconIndex", Js.Unsafe.inject iconIndex; |]

class type app_command_line = object
  method append_switch : string -> string option -> unit
  method append_argument : string -> unit
end

class type app_dock = object
  method bounce : bounce option -> int
  method cancel_bounce : int -> unit
  method download_finished : string -> unit
  method set_badge : string -> unit
  method get_badge : unit -> string
  method hide : unit -> unit
  method show : unit -> unit
  method is_visible : unit -> bool
  method set_menu : unit (* TODO *)
  method set_icon : unit (* TODO *)
end

class type app = object
  method on_accessibility_support_changed : (event -> bool Js.t -> unit) -> unit
  (* method on_activate : (event -> bool Js.t -> unit) -> unit *)
  (* method on_before_quit : (event -> unit) -> unit *)
  (* method on_browser_window_blur : *)
  (*    (event -> BrowserWindow.browser_window Js.t -> unit) -> unit *)
  (* method on_browser_window_created : *)
  (*    (event -> BrowserWindow.browser_window Js.t -> unit) -> unit *)
  (* method on_browser_window_focus : *)
  (*    (event -> BrowserWindow.browser_window Js.t -> unit) -> unit *)
  (* method on_certificate_error : (unit -> unit) -> unit  method *)
  (* method on_continue_activity : *)
  (*    (event -> string Js.t -> unit Js.t -> unit) -> unit  method *)
  (* method on_gpu_process_crashed : (event -> bool Js.t -> unit) -> unit *)
  (* method on_login : (unit -> unit) -> unit *)
  (* method on_open_file : (event -> string Js.t -> unit) -> unit *)
  (* method on_open_url : (event -> string Js.t -> unit) -> unit *)
  method on_quit : (event -> int Js.t -> unit) -> unit
  method on_ready : (unit -> unit) -> unit
  (* method on_select_client_certificate : (unit -> unit) -> unit *)
  (* method on_web_contents_created : (unit -> unit) -> unit  method *)
  method on_will_finish_launching : (unit -> unit) -> unit
  method on_will_quit : (event -> unit) -> unit
  method on_window_all_closed : (unit -> unit) -> unit
  method quit : unit -> unit
  method exit : int option -> unit
  method relaunch : 'a. ?args:'a list -> ?exec_path:string -> unit -> unit
  method is_ready : unit -> bool
  method focus : unit -> unit
  method hide : unit -> unit
  method show : unit -> unit
  method get_app_path : unit -> string
  method get_path : path_parameter -> string
  method set_path : path_parameter -> string -> unit
  method get_version : unit -> string
  method get_name : unit -> string
  method set_name : string -> unit
  method get_locale : unit -> Locales.t
  method add_recent_document : string -> unit
  method clear_recent_documents : unit -> unit
  method set_as_default_protocol_client :
    string -> string option -> string list option -> bool
  method remove_as_default_protocol_client :
    string -> string option -> string list option -> bool
  method is_default_protocol_client :
    string -> string option -> string list option -> bool
  method set_user_tasks : task list -> bool
  method get_jump_list_settings : unit (* TODO *)
  method set_jump_list : unit          (* TODO *)
  method make_single_instance : (Js.string_array -> Js.js_string -> unit) -> unit
  method release_single_instance : unit -> unit
  method set_user_activity :
    string -> (string * Js.Unsafe.any) array -> string option -> unit
  method get_current_activity_type : unit -> string
  method set_app_user_model_id : string -> unit
  method import_certificate : unit
  method disable_hardware_acceleration : unit -> unit
  method set_badge_count : int -> bool
  method get_badge_count : unit -> int
  method is_unity_running : unit -> bool
  method get_login_item_settings : unit (* TODO *)
  method set_login_item_settings : unit (* TODO *)
  method is_accessibility_support_enabled : unit -> bool
  method command_line : app_command_line
  method dock : app_dock
end


let app : app =
  let module M : METHODS = Methods(struct let i = app_module end) in
  object(self)

    method private on_event : type a b. string -> (a -> b) -> unit =
      fun event callback ->
        M.call "on" [| string_param event; callback_param callback |]

    method on_accessibility_support_changed callback =
      self#on_event "accessibility-support-changes" callback

    (* method on_activate cback = assert false *)

    (* method on_before_quit cback = assert false *)

    (* method on_browser_window_blur cback = assert false *)

    (* method on_browser_window_created cback = assert false *)

    (* method on_browser_window_focus cback = assert false *)

    (* method on_certificate_error cback = assert false *)

    (* method on_continue_activity cback = assert false *)

    (* method on_gpu_process_crashed cback = assert false *)

    (* method on_login cback = assert false *)

    (* method on_open_file cback = assert false *)

    (* method on_open_url cback = assert false *)

    method on_quit callback =
      self#on_event "quit" callback

    method on_ready callback =
      self#on_event "ready" callback

    (* method on_select_client_certificate cback = assert false *)

    (* method on_web_contents_created cback = assert false *)

    method on_will_finish_launching callback =
      self#on_event "will-finish-launching" callback

    method on_will_quit callback =
      self#on_event "will-quit" callback

    method on_window_all_closed callback =
      self#on_event "window-all-closed" callback

    method quit () =
      M.unit_unit "quit"

    method exit return_code =
      M.call "exit" (optional_param return_code int_param)

    method relaunch : 'a. ?args:'a list -> ?exec_path:string -> unit -> unit =
      fun ?args ?exec_path () ->
        let obj =
          Util.ObjBuilder.push ("args", list_param, args) @@
          Util.ObjBuilder.push_string ("execPath", exec_path) []
        in
        M.call "relaunch" [| obj_param (Array.of_list obj) |]

    method is_ready () =
      M.unit_bool "isReady"

    method focus () =
      M.unit_unit "focus"

    method hide () =
      M.unit_unit "hide"

    method show () =
      M.unit_unit "show"

    method get_app_path () =
      M.unit_string "getAppPath"

    method get_path pp =
      Js.to_string
        (M.call "getPath" [| string_param (string_of_path_parameter pp) |])

    method set_path pp path =
      M.call "setPath"
        [| string_param (string_of_path_parameter pp);
           string_param path |]

    method get_version () =
      M.unit_string "getVersion"

    method get_name () =
      M.unit_string "getName"

    method set_name name =
      M.string_unit "setName" name

    method get_locale () =
      let res = M.unit_any "getLocale" in
      Locales.locales_of_string (Js.to_string res)

    method add_recent_document path =
      M.string_unit "addRecentDocument" path

    method clear_recent_documents () =
      M.unit_unit "clearRecentDocuments"

    method private default_protocol_client fname protocol opath oargs =
      let args = optional_param oargs list_param in
      let path = optional_param opath string_param in
      let protocol = [| string_param protocol |] in
      Js.to_bool (M.call fname Array.(concat [protocol; path; args]))

    method set_as_default_protocol_client s so slo =
      self#default_protocol_client "setAsDefaultProtocolClient" s so slo

    method remove_as_default_protocol_client s so slo =
      self#default_protocol_client "removeAsDefaultProtocolClient" s so slo

    method is_default_protocol_client s so slo =
      self#default_protocol_client "isDefaultProtocolClient" s so slo

    method set_user_tasks tasks =
      let tasks = List.map task_param tasks in
      M.call "setUserTasks" [| list_param tasks |]

    method get_jump_list_settings = () (* TODO *)

    method set_jump_list = () (* TODO *)

    method make_single_instance callback =
      M.callback_unit "makeSingleInstance" callback

    method release_single_instance () =
      M.unit_unit "releaseSingleInstance"

    method set_user_activity typ user_info webpage =
      let parameters =
        Array.append
          [| string_param typ; obj_param user_info |]
          (optional_param webpage string_param)
      in
      M.call "setUserActivity" parameters

    method get_current_activity_type () =
      M.unit_string "getCurrentActivityType"

    method set_app_user_model_id id =
      M.string_unit "setAppUserModelId" id

    method import_certificate = () (* TODO *)

    method disable_hardware_acceleration () =
      M.unit_unit "disableHardwareAcceleration"

    method set_badge_count count =
      Js.to_bool (M.call "setBadgeCount" [| int_param count |])

    method get_badge_count () =
      M.unit_int "getBadgeCount"

    method is_unity_running () =
      M.unit_bool "isUnityRunning"

    method get_login_item_settings = () (* TODO *)

    method set_login_item_settings = () (* TODO *)

    method is_accessibility_support_enabled () =
      M.unit_bool "isAccessibilitySupportEnabled"

    method command_line =
      let module CL : METHODS = Methods(struct let i = command_line_module end) in
      object
        method append_switch switch value =
          let parameters =
            Array.append
              [| string_param switch |]
              (optional_param value string_param)
          in
          CL.call "appendSwitch" parameters

        method append_argument value =
          CL.string_unit "appendArguments" value
      end

    method dock =
      let module Dock : METHODS = Methods(struct let i = dock_module end) in
      object
        method bounce opt =
          let translater b = string_param (string_of_bounce b) in
          Dock.call "bounce" (optional_param opt translater)

        method cancel_bounce id =
          Dock.int_unit "cancelBounce" id

        method download_finished path =
          Dock.string_unit "downloadFinished" path

        method set_badge txt =
          Dock.string_unit "setBadge" txt

        method get_badge () =
          Dock.unit_string "getBadge"

        method hide () =
          Dock.unit_unit "hide"

        method show () =
          Dock.unit_unit "show"

        method is_visible () =
          Dock.unit_bool "isVisible"

        method set_menu = () (* TODO *)

        method set_icon = () (* TODO *)
      end

  end
