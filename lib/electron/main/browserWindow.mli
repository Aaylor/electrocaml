
val bw_module : 'a

type browser_instance

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

type web_preferences_t = {
  dev_tools : bool option;
  node_integration : bool option;
  preload : string option;
  session : unit option;               (* TODO: Session object type *)
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

and browser_window =
  < instance : browser_instance Js.t;
    id : int;
    load_url : string -> unit;
    get_parent_window : unit -> browser_window >

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
