(** Implementation of the BrowserWindow module. *)

(** {2 Module} *)

val bw_module : 'a


(** {2 Types} *)

type windows_t =
  | Desktop
  | Dock
  | Toolbar
  | Splash
  | Notification
  | Textured

type title_bar_style_t =
  | Default
  | Hidden
  | Hidden_inset

type size = {
  width : int;
  height : int;
}

type position = {
  x : int;
  y : int;
}

type size_with_position = {
  position : position;
  size : size;
}

type top_level =
  | Normal
  | Floating
  | Torn_off_menu
  | Modal_panel
  | Main_menu
  | Status
  | Pop_up_menu
  | Screen_saver
  | Dock

class type browser_window = object
  method instance : Util.instance
  method id : int
  method destroy : unit -> unit
  method close : unit -> unit
  method focus : unit -> unit
  method blur : unit -> unit
  method is_focused : unit -> bool
  method is_destroyed : unit -> bool
  method show : unit -> unit
  method show_inactive : unit -> unit
  method hide : unit -> unit
  method is_visible : unit -> bool
  method is_modal : unit -> bool
  method maximize : unit -> unit
  method unmaximize : unit -> unit
  method is_maximized : unit -> bool
  method minimize : unit -> unit
  method restore : unit -> unit
  method is_minimized : unit -> bool
  method set_full_screen : bool -> unit
  method is_full_screen : unit -> bool
  method set_aspect_ratio : float -> ?extra_size:size -> unit
  method set_bounds : size_with_position -> ?animate:bool -> unit
  method get_bounds : unit -> size_with_position
  method set_content_bounds : size_with_position -> ?animate:bool -> unit
  method get_content_bounds : unit -> size_with_position
  method set_size : size -> ?animate:bool -> unit
  method get_size : unit -> size
  method set_content_size : size -> ?animate:bool -> unit
  method get_content_size : unit -> size
  method set_minimum_size : size -> unit
  method get_minimum_size : unit -> size
  method set_maximum_size : size -> unit
  method get_maximum_size : unit -> size
  method set_resizable : bool -> unit
  method is_resizable : unit -> bool
  method set_movable : bool -> unit
  method is_movable : unit -> bool
  method set_minimizable : bool -> unit
  method is_minimizable : unit -> bool
  method set_maximizable : bool -> unit
  method is_maximizable : unit -> bool
  method set_full_screenable : bool -> unit
  method is_full_screenable : unit -> bool
  method set_closable : bool -> unit
  method is_closable : unit -> bool
  method set_always_on_top : bool -> ?level:top_level -> unit
  method is_always_on_top : unit -> bool
  method center : unit -> unit
  method set_position : position -> ?animate:bool -> unit
  method get_position : unit -> position
  method set_title : string -> unit
  method get_title : unit -> string
  method set_sheet_offset : float -> ?offset_x:float -> unit
  method flash_frame : bool -> unit
  method set_skip_taskbar : bool -> unit
  method set_kiosk : bool -> unit
  method is_kiosk : unit -> bool
  method get_native_window_handle : unit -> unit (* TODO *)
  method hook_window_message : int -> (unit -> unit) -> unit
  method is_window_message_hooked : int -> bool
  method unhook_window_message : int -> unit
  method unhook_all_window_messages : unit -> unit
  method set_represented_filename : string -> unit
  method get_represented_filename : unit -> string
  method set_document_edited : bool -> unit
  method is_document_edited : unit -> bool
  method focus_on_web_view : unit -> unit
  method blur_web_view : unit -> unit
  method capture_page : ?rect:size_with_position -> (unit -> unit) -> unit
  method load_url : string -> unit
  method reload : unit -> unit
  method set_menu : unit -> unit (* TODO: Main.Menu *)
  method set_progress_bar : unit -> unit (* TODO: Double ? *)
  method set_overlay_icon : unit -> unit (* TODO: Both.NativeImage *)
  method set_has_shadow : bool -> unit
  method has_shadow : unit -> bool
  method set_thumbar_buttons : unit -> unit (* TODO: Both.NativeImage *)
  method set_thumbnail_clip : size_with_position -> unit
  method set_thumbnail_tool_tip : string -> unit
  method show_definition_for_selection : unit -> unit
  method set_icon : unit -> unit (* TODO: Both.NativeImage *)
  method set_auto_hide_menu_bar : bool -> unit
  method is_menu_bar_auto_hide : unit -> bool
  method set_menu_bar_visibility : bool -> unit
  method is_menu_bar_visible : unit -> bool
  method set_visible_on_all_workspaces : bool -> unit
  method is_visible_on_all_workspaces : unit -> bool
  method set_ignore_mouse_events : bool -> unit
  method set_content_protection : bool -> unit
  method set_focusable : bool -> unit
  method set_parent_window : browser_window -> unit
  method get_parent_window : unit -> browser_window
  method get_child_windows : unit -> browser_window list
end

type web_preferences_t = {
  dev_tools : bool option;
  node_integration : bool option;
  preload : string option;
  session : Session.session option;
  partition : string option;
  zoom_factor : float option;
  javascript : bool option;
  web_security : bool option;
  allow_displaying_insecure_content : bool option;
  allow_running_insecure_content : bool option;
  images : bool option;
  text_areas_are_resizable : bool option;
  webgl : bool option;
  webaudio : bool option;
  plugins : bool option;
  experimental_features : bool option;
  experimental_canvas_features : bool option;
  scroll_bounce : bool option;
  blink_features : string option;
  disable_blink_features : string option;
  default_font_family : unit option;   (* TODO: Font Object *)
  default_font_size : int option;
  default_monospace_font_size : int option;
  default_encoding : string option;
  background_throttling : bool option;
  offscreen : bool option;
}

type browser_window_option = {
  width : int option;
  height : int option;
  x_y : (int * int) option;
  use_content_size : bool option;
  center : bool option;
  min_width : int option;
  min_height : int option;
  max_width : int option;
  max_height : int option;
  resizable : bool option;
  movable : bool option;
  minimizable : bool option;
  maximizable : bool option;
  closable : bool option;
  focusable : bool option;
  always_on_top : bool option;
  fullscreen : bool option;
  fullscreenable : bool option;
  skip_taskbar : bool option;
  kioks : bool option;
  title : string option;
  show : bool option;
  frame : bool option;
  parent : browser_window option;
  modal : bool option;
  accept_first_mouse : bool option;
  disable_auto_hide_cursor : bool option;
  auto_hide_menu_bar : bool option;
  enable_larger_than_screen : bool option;
  background_color : string option;
  has_shadow : bool option;
  dark_theme : bool option;
  transparent : bool option;
  type_ : windows_t option;
  title_bar_style : title_bar_style_t option;
  thick_frame : bool option;
  web_preferences : web_preferences_t option;
}


(** {2 Static Method} *)

val default_web_preferences : web_preferences_t

val default_browser_windows_option : browser_window_option

val make : browser_window_option -> browser_window

val get_all_windows : unit -> browser_window list

val get_focused_window : unit -> browser_window

val from_web_contents : unit -> unit (* TODO *)

val from_id : int -> browser_window

val add_dev_tools_extension : string -> unit

val remove_dev_tools_extension : string -> unit

val get_dev_tools_extensions : unit -> unit (* TODO *)
