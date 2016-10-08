
val app_module : 'a

type event

type certificate

type 'a relaunch_parameter =
  { args : 'a array option;
    execPath : string option; }

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

type app_command_line =
  < append_switch : string -> string option -> unit;
    append_argument : string -> unit; >

type app_dock =
  < bounce : bounce option -> int;
    cancel_bounce : int -> unit;
    download_finished : string -> unit;
    set_badge : string -> unit;
    get_badge : unit -> string;
    hide : unit -> unit;
    show : unit -> unit;
    is_visible : unit -> bool;
    set_menu : unit; (* TODO *)
    set_icon : unit; (* TODO *) >

type app =
  < on_accessibility_support_changed : (event -> bool Js.t -> unit) -> unit;
    (* on_activate : (event -> bool Js.t -> unit) -> unit; *)
    (* on_before_quit : (event -> unit) -> unit; *)
    (* on_browser_window_blur : (event -> BrowserWindow.browser_window Js.t -> unit) -> unit; *)
    (* on_browser_window_created : (event -> BrowserWindow.browser_window Js.t -> unit) -> unit; *)
    (* on_browser_window_focus : (event -> BrowserWindow.browser_window Js.t -> unit) -> unit; *)
    (* on_certificate_error : (unit -> unit) -> unit;  *)
    (* on_continue_activity : (event -> string Js.t -> unit Js.t -> unit) -> unit;  *)
    (* on_gpu_process_crashed : (event -> bool Js.t -> unit) -> unit; *)
    (* on_login : (unit -> unit) -> unit; *)
    (* on_open_file : (event -> string Js.t -> unit) -> unit; *)
    (* on_open_url : (event -> string Js.t -> unit) -> unit; *)
    on_quit : (event -> int Js.t -> unit) -> unit;
    on_ready : (unit -> unit) -> unit;
    (* on_select_client_certificate : (unit -> unit) -> unit; *)
    (* on_web_contents_created : (unit -> unit) -> unit;  *)
    on_will_finish_launching : (unit -> unit) -> unit;
    on_will_quit : (event -> unit) -> unit;
    on_window_all_closed : (unit -> unit) -> unit;
    quit : unit -> unit;
    exit : int option -> unit;
    relaunch : 'a. 'a relaunch_parameter -> unit;
    is_ready : unit -> bool;
    focus : unit -> unit;
    hide : unit -> unit;
    show : unit -> unit;
    get_app_path : unit -> string;
    get_path : path_parameter -> string;
    set_path : path_parameter -> string -> unit;
    get_version : unit -> string;
    get_name : unit -> string;
    set_name : string -> unit;
    get_locale : unit -> Data_structures.Locales.t;
    add_recent_document : string -> unit;
    clear_recent_documents : unit -> unit;
    set_as_default_protocol_client :
      string -> string option -> string list option -> bool;
    remove_as_default_protocol_client :
      string -> string option -> string list option -> bool;
    is_default_protocol_client :
      string -> string option -> string list option -> bool;
    set_user_tasks : task list -> bool;
    get_jump_list_settings : unit; (* TODO *)
    set_jump_list : unit;          (* TODO *)
    make_single_instance : (Js.string_array -> Js.js_string) -> unit;
    release_single_instance : unit -> unit;
    set_user_activity :
      string -> (string * Js.Unsafe.any) array -> string option -> unit;
    get_current_activity_type : unit -> string;
    set_app_user_model_id : string -> unit;
    import_certificate : unit;
    disable_hardware_acceleration : unit -> unit;
    set_badge_count : int -> bool;
    get_badge_count : unit -> int;
    is_unity_running : unit -> bool;
    get_login_item_settings : unit;
    set_login_item_settings : unit;
    is_accessibility_support_enabled : unit -> bool;
    command_line : app_command_line;
    dock : app_dock; >

val app : app
