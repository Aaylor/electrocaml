
open Util

let bw_module = electron##._BrowserWindow

type browser_instance

type windows_t =
  | Desktop
  | Dock
  | Toolbar
  | Splash
  | Notification
  | Textured

let string_of_windows_type = function
  | Desktop -> "desktop"
  | Dock -> "dock"
  | Toolbar -> "toolbar"
  | Splash -> "splash"
  | Notification -> "notification"
  | Textured -> "textured"

type title_bar_style_t =
  | Default
  | Hidden
  | Hidden_inset

let string_of_title_bar_style = function
  | Default -> "default"
  | Hidden -> "hidden"
  | Hidden_inset -> "hidden-inset"

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

let default_web_preferences =
  { dev_tools = None; node_integration = None; preload = None; session = None;
    partition = None; zoom_factor = None; javascript = None;
    web_security = None; allow_displaying_insecure_content = None;
    allow_running_insecure_content = None; images = None;
    text_areas_are_resizable = None; webgl = None; webaudio = None;
    plugins = None; experimental_features = None;
    experimental_canvas_features = None; scroll_bounce = None;
    blink_features = None; disable_blink_features = None;
    default_font_family = None; default_font_size = None;
    default_monospace_font_size = None; default_encoding = None;
    background_throttling = None; offscreen = None; }

let obj_of_web_pref wp =
  let push (key, translate, elt) acc = match elt with
    | None -> acc
    | Some elt -> (key, Js.Unsafe.inject (translate elt)) :: acc
  in
  let push_string (key, elt) acc = push (key, Js.string, elt) acc in
  let push_bool (key, elt) acc = push (key, Js.bool, elt) acc in
  let push_float (key, elt) acc = push (key, Js.float, elt) acc in
  let push_int (key, elt) acc = push (key, (fun x -> x), elt) acc in
  let obj =
    push_bool ("devTools", wp.dev_tools) @@
    push_bool ("nodeIntegration", wp.node_integration) @@
    push_string ("preload", wp.preload) @@
    (* TODO: session *)
    push_string ("partition", wp.partition) @@
    push_float ("zoomFactor", wp.zoom_factor) @@
    push_bool ("javascript", wp.javascript) @@
    push_bool ("webSecurity", wp.web_security) @@
    push_bool ("allowDisplayingInsecureContent",
      wp.allow_displaying_insecure_content) @@
    push_bool ("allowRunningInsecureContent",
      wp.allow_running_insecure_content) @@
    push_bool ("images", wp.images) @@
    push_bool ("textAreasAreResizable", wp.text_areas_are_resizable) @@
    push_bool ("webgl", wp.webgl) @@
    push_bool ("webaudio", wp.webaudio) @@
    push_bool ("plugins", wp.plugins) @@
    push_bool ("experimentalFeatures", wp.experimental_features) @@
    push_bool ("experimentalCanvasFeatures",
      wp.experimental_canvas_features) @@
    push_bool ("scrollBounce", wp.scroll_bounce) @@
    push_string ("blinkFeatures", wp.blink_features) @@
    push_string ("disableBlinkFeatures", wp.disable_blink_features) @@
    (* TODO: default_font *)
    push_int ("defaultFontSize", wp.default_font_size) @@
    push_int ("defaultMonospaceFontSize", wp.default_monospace_font_size) @@
    push_string ("defaultEncoding", wp.default_encoding) @@
    push_bool ("backgroundThrottling", wp.background_throttling) @@
    push_bool ("offscreen", wp.offscreen) []
  in
  Js.Unsafe.obj (Array.of_list obj)

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

let default_browser_windows_option =
  { width = None; height = None; x_y = None; use_content_size = None;
    center = None; min_width = None; min_height = None; max_width = None;
    max_height = None; resizable = None; movable = None; minimizable = None;
    maximizable = None; closable = None; focusable = None; always_on_top = None;
    fullscreen = None; fullscreenable = None; skip_taskbar = None; kioks = None;
    title = None; show = None; frame = None; parent = None; modal = None;
    accept_first_mouse = None; disable_auto_hide_cursor = None;
    auto_hide_menu_bar = None; enable_larger_than_screen = None;
    background_color = None; has_shadow = None; dark_theme = None;
    transparent = None; type_ = None; title_bar_style = None;
    thick_frame = None; web_preferences = None; }

let obj_of_browser_windows_opt bwo =
  let push (key, translate, elt) acc = match elt with
    | None -> acc
    | Some elt -> (key, Js.Unsafe.inject (translate elt)) :: acc
  in
  let push_string (key, elt) acc = push (key, Js.string, elt) acc in
  let push_bool (key, elt) acc = push (key, Js.bool, elt) acc in
  let push_int (key, elt) acc = push (key, (fun x -> x), elt) acc in
  let push_x_y elt acc = match elt with
    | None -> acc
    | Some (x, y) ->
      ("x", Js.Unsafe.inject x) :: ("y", Js.Unsafe.inject y) :: acc
  in
  let push_windows_t (key, elt) acc =
    push (key, (fun s -> Js.string (string_of_windows_type s)), elt) acc
  in
  let push_title_bar_style (key, elt) acc =
    push (key, (fun s -> Js.string (string_of_title_bar_style s)), elt) acc
  in
  let push_web_pref (key, elt) acc =
    push (key, (fun s -> obj_of_web_pref s), elt) acc
  in
  let push_browser (key, elt) acc =
    push (key, (fun s -> s#instance), elt) acc
  in
  let obj =
    push_int ("width", bwo.width) @@
    push_int ("height", bwo.height) @@
    push_x_y bwo.x_y @@
    push_bool ("useContentSize", bwo.use_content_size) @@
    push_bool ("center", bwo.center) @@
    push_int ("minWidth", bwo.min_width) @@
    push_int ("minHeight", bwo.min_height) @@
    push_int ("maxWidth", bwo.max_width) @@
    push_int ("maxHeight", bwo.max_height) @@
    push_bool ("resizable", bwo.resizable) @@
    push_bool ("movable", bwo.movable) @@
    push_bool ("minimizable", bwo.minimizable) @@
    push_bool ("maximizable", bwo.maximizable) @@
    push_bool ("closable", bwo.closable) @@
    push_bool ("focusable", bwo.focusable) @@
    push_bool ("alwaysOnTop", bwo.always_on_top) @@
    push_bool ("fullscreen", bwo.fullscreen) @@
    push_bool ("fullscreenable", bwo.fullscreenable) @@
    push_bool ("skipTaskbar", bwo.skip_taskbar) @@
    push_bool ("kioks", bwo.kioks) @@
    push_string ("title", bwo.title) @@
    push_bool ("show", bwo.show) @@
    push_bool ("frame", bwo.frame) @@
    push_browser ("parent", bwo.parent) @@
    push_bool ("modal", bwo.modal) @@
    push_bool ("acceptFirstMouse", bwo.accept_first_mouse) @@
    push_bool ("disableAutoHideCursor", bwo.disable_auto_hide_cursor) @@
    push_bool ("autoHideMenuBar", bwo.auto_hide_menu_bar) @@
    push_bool ("enableLargerThanScreen", bwo.enable_larger_than_screen) @@
    push_string ("backgroundColor", bwo.background_color) @@
    push_bool ("hasShadow", bwo.has_shadow) @@
    push_bool ("darkTheme", bwo.dark_theme) @@
    push_bool ("transparent", bwo.transparent) @@
    push_windows_t ("type", bwo.type_) @@
    push_title_bar_style ("titleBarStyle", bwo.title_bar_style) @@
    push_bool ("thickFrame", bwo.thick_frame) @@
    push_web_pref ("webPreferences", bwo.web_preferences) []
  in
  Js.Unsafe.obj (Array.of_list obj)

class browser_window_obj instance = object

  method id : int = instance##.id

  (* val web_contents = instance##.webContents (\* TODO *\) *)

  method instance : browser_instance Js.t = Js.Unsafe.coerce instance

  method load_url (path : string) : unit =
    Js.Unsafe.meth_call
      instance
      "loadURL"
      [| Js.Unsafe.inject (Js.string path) |]

  method get_parent_window () =
    let res = Js.Unsafe.meth_call instance "getParentWindow" no_param in
    new browser_window_obj res

end

let make windows_opt : browser_window =
  let obj = obj_of_browser_windows_opt windows_opt in
  let instance = Js.Unsafe.new_obj bw_module [| Js.Unsafe.inject obj |] in
  new browser_window_obj instance

let get_all_windows () =
  let res = Js.Unsafe.meth_call bw_module "getAllWindows" no_param in
  let res_array = Js.to_array res in
  List.map (fun i -> new browser_window_obj i) (Array.to_list res_array)

let get_focused_window () =
  let res = Js.Unsafe.meth_call bw_module "getFocusedWindow" no_param in
  new browser_window_obj res

let from_web_contents () =
  assert false (* TODO *)

let from_id id =
  let res = Js.Unsafe.meth_call bw_module "fromId" [| Js.Unsafe.inject id |] in
  new browser_window_obj res

let add_dev_tools_extension path =
  Js.Unsafe.meth_call bw_module "addDevToolsExtension"
    [| Js.Unsafe.inject (Js.string path) |]

let remove_dev_tools_extension name =
  Js.Unsafe.meth_call bw_module "removeDevToolsExtension"
    [| Js.Unsafe.inject (Js.string name) |]

let get_dev_tools_extensions () =
  assert false
