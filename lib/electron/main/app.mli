
val app_module : Util.instance
val command_line_module : Util.instance
val dock_module : Util.instance

type event

type certificate

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

type bounce =
  | Critical
  | Informational

type task = {
  program : string;
  arguments : string;
  title : string;
  description : string;
  iconPath : string;
  iconIndex : int;
}

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

val app : app
