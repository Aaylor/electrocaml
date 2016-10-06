
open Util

let app_module = electron##.app

type event (* TODO *)

type certificate (* TODO *)

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

let js_string_of_path_parameter pp =
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
  in
  Js.string (string_of_path_parameter pp)

type bounce =
  | Critical
  | Informational

let string_of_bounce = function
  | Critical -> "critical"
  | Informational -> "informational"

type app_command_line =
  < append_switch : unit;
    append_argument : unit; >

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
    set_user_tasks : unit;         (* TODO *)
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
    get_login_item_settings : unit; (* TODO *)
    set_login_item_settings : unit; (* TODO *)
    is_accessibility_support_enabled : unit -> bool;
    command_line : app_command_line;
    dock : app_dock; >


let app : app = object(self)

  method private call : type ret. string -> Js.Unsafe.any array -> ret =
    fun fun_name parameters ->
      Js.Unsafe.meth_call app_module fun_name parameters

  method private on_procedure event cback =
    self#call "on"
      [| Js.Unsafe.inject event;
         Js.Unsafe.(inject (meth_callback cback)) |]

  method private call_str_param fname str =
    self#call fname [| Js.Unsafe.inject (Js.string str) |]

  method on_accessibility_support_changed cback =
    self#call "on"
      [| Js.Unsafe.inject "accessibility-support-changed";
         Js.Unsafe.(inject (meth_callback cback)) |]

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

  method on_quit cback =
    self#call "on"
      [| Js.Unsafe.inject "quit";
         Js.Unsafe.(inject (meth_callback cback)) |]

  method on_ready cback =
    self#on_procedure "ready" cback

  (* method on_select_client_certificate cback = assert false *)

  (* method on_web_contents_created cback = assert false *)

  method on_will_finish_launching cback =
    self#on_procedure "will-finish-launching" cback

  method on_will_quit cback =
    self#call "on"
      [| Js.Unsafe.inject "will-quit";
         Js.Unsafe.(inject (meth_callback cback)) |]

  method on_window_all_closed cback =
    self#on_procedure "window-all-closed" cback

  method quit () =
    self#call "quit" no_param

  method exit return_code =
    let return_code = match return_code with
      | None -> no_param
      | Some r -> [| Js.Unsafe.inject r |]
    in
    self#call "exit" return_code

  method relaunch : type a. a relaunch_parameter -> unit = fun opt ->
    let parameter =
      let push acc (string, elt) = match elt with
        | None -> acc
        | Some elt -> (string, Js.Unsafe.inject elt) :: acc
      in
      let parameters =
        push
          (push [] ("args", opt.args))
          ("execPath", opt.execPath)
      in
      match parameters with
      | [] -> no_param
      | xs -> [| Js.Unsafe.inject (Js.Unsafe.obj (Array.of_list parameters)) |]
    in
    self#call "relaunch" parameter

  method is_ready () =
    Js.to_bool (self#call "isReady" no_param)

  method focus () =
    self#call "focus" no_param

  method hide () =
    self#call "hide" no_param

  method show () =
    self#call "show" no_param

  method get_app_path () =
    Js.to_string (self#call "getAppPath" no_param)

  method get_path pp =
    let param = [| Js.Unsafe.inject (js_string_of_path_parameter pp) |] in
    Js.to_string (self#call "getPath" param)

  method set_path pp path =
    self#call "setPath"
      [| Js.Unsafe.inject (js_string_of_path_parameter pp);
         Js.Unsafe.inject (Js.string path) |]

  method get_version () =
    Js.to_string (self#call "getVersion" no_param)

  method get_name () =
    Js.to_string (self#call "getName" no_param)

  method set_name name =
    self#call "setName" [| Js.Unsafe.inject (Js.string name) |]

  method get_locale () =
    let result = Js.to_string (self#call "getLocale" no_param) in
    Data_structures.Locales.locales_of_string result

  method add_recent_document path =
    self#call_str_param "addRecentDocument" path

  method clear_recent_documents () =
    self#call "clearRecentDocuments" no_param

  method private default_protocol_client fname protocol opath oargs =
    let args = match oargs with
      | None -> no_param
      | Some args -> [| Js.Unsafe.inject (Js.array (Array.of_list args)) |]
    in
    let path = match opath with
      | None -> no_param
      | Some path -> [| Js.Unsafe.inject (Js.string path) |]
    in
    let protocol = [| Js.Unsafe.inject (Js.string protocol) |] in
    Js.to_bool (self#call fname Array.(concat [protocol; path; args]))

  method set_as_default_protocol_client s so slo =
    self#default_protocol_client "setAsDefaultProtocolClient" s so slo

  method remove_as_default_protocol_client s so slo =
    self#default_protocol_client "removeAsDefaultProtocolClient" s so slo

  method is_default_protocol_client s so slo =
    self#default_protocol_client "isDefaultProtocolClient" s so slo

  method set_user_tasks = () (* TODO *)
  method get_jump_list_settings = () (* TODO *)
  method set_jump_list = () (* TODO *)

  method make_single_instance callback =
    self#call "makeSingleInstance" [| Js.Unsafe.inject callback |]

  method release_single_instance () =
    self#call "releaseSingleInstance" no_param

  method set_user_activity typ user_info webpage =
    let webpage = match webpage with
      | None -> no_param
      | Some wp -> [| Js.Unsafe.inject (Js.string wp) |]
    in
    self#call "setUserActivity"
      Array.(concat [
        [| Js.Unsafe.inject (Js.string typ);
           Js.Unsafe.inject (Js.Unsafe.obj user_info) |];
        webpage
      ])

  method get_current_activity_type () =
    Js.to_string (self#call "getCurrentActivityType" no_param)

  method set_app_user_model_id id =
    self#call_str_param "setAppUserModelId" id

  method import_certificate = () (* TODO *)

  method disable_hardware_acceleration () =
    self#call "disableHardwareAcceleration" no_param

  method set_badge_count count =
    Js.to_bool (self#call "setBadgeCount" [| Js.Unsafe.inject count |])

  method get_badge_count () =
    self#call "getBadgeCount" no_param

  method is_unity_running () =
    Js.to_bool (self#call "isUnityRunning" no_param)

  method get_login_item_settings = () (* TODO *)
  method set_login_item_settings = () (* TODO *)

  method is_accessibility_support_enabled () =
    Js.to_bool (self#call "isAccessibilitySupportEnabled" no_param)

  method command_line = object
    method append_switch = () (* TODO *)
    method append_argument = () (* TODO *)
  end

  method dock = object
    method bounce opt =
      let param = match opt with
        | None -> no_param
        | Some bounce ->
          [| Js.Unsafe.inject (Js.string (string_of_bounce bounce)) |]
      in
      self#call "bouce" param

    method cancel_bounce id =
      self#call "cancelBounce" [| Js.Unsafe.inject id |]

    method download_finished path =
      self#call_str_param "downloadFinished" path

    method set_badge txt =
      self#call_str_param "setBadge" txt

    method get_badge () =
      Js.to_string (self#call "getBadge" no_param)

    method hide () =
      self#call "hide" no_param

    method show () =
      self#call "show" no_param

    method is_visible () =
      Js.to_bool (self#call "isVisible" no_param)

    method set_menu = () (* TODO *)
    method set_icon = () (* TODO *)
  end

end
