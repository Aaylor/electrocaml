
open Common_type
open Util

let bw_module = electron##._BrowserWindow



(* TYPES *)

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

let string_of_top_level = function
  | Normal -> "normal"
  | Floating -> "floating"
  | Torn_off_menu -> "torn-off-menu"
  | Modal_panel -> "modal-panel"
  | Main_menu -> "main-menu"
  | Status -> "status"
  | Pop_up_menu -> "pop-up-menu"
  | Screen_saver -> "screen-saver"
  | Dock -> "dock"

class type browser_window = object
  method instance : instance
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
  method set_menu : Menu.menu -> unit
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
  let push_s (key, elt) acc = push (key, (fun s -> s#instance), elt) acc in
  let obj =
    push_bool ("devTools", wp.dev_tools) @@
    push_bool ("nodeIntegration", wp.node_integration) @@
    push_string ("preload", wp.preload) @@
    push_s ("session", wp.session) @@
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



(* METHODS *)

let rec make_bw_obj instance : browser_window =
  let module M = Methods(struct let i = instance end) in
  object(self)
    method id : int = (Js.Unsafe.coerce instance)##.id

    (* val web_contents = instance##.webContents (\* TODO *\) *)

    method instance = instance

    (* Events *)

    (* Methods *)

    method destroy () =
      M.unit_unit "destroy"

    method close () =
      M.unit_unit "close"

    method focus () =
      M.unit_unit "focus"

    method blur () =
      M.unit_unit "blur"

    method is_focused () =
      M.unit_bool "isFocused"

    method is_destroyed () =
      M.unit_bool "isDestroyed"

    method show () =
      M.unit_unit "show"

    method show_inactive () =
      M.unit_unit "showInactive"

    method hide () =
      M.unit_unit "hide"

    method is_visible () =
      M.unit_bool "isVisible"

    method is_modal () =
      M.unit_bool "isModal"

    method maximize () =
      M.unit_unit "maximize"

    method unmaximize () =
      M.unit_unit "unmaximize"

    method is_maximized () =
      M.unit_bool "isMaximized"

    method minimize () =
      M.unit_unit "minimize"

    method restore () =
      M.unit_unit "restore"

    method is_minimized () =
      M.unit_bool "isMinimized"

    method set_full_screen flag =
      M.bool_unit "setFullScreen" flag

    method is_full_screen () =
      M.unit_bool "isFullScreen"

    method set_aspect_ratio aspect_ratio ?extra_size =
      let extra_size = match extra_size with
        | None -> no_param
        | Some size -> [| Js.Unsafe.inject (obj_of_size size) |]
      in
      M.call "setAspectRatio"
        (Array.append [| Js.Unsafe.inject (Js.float aspect_ratio) |] extra_size)

    method private generic_set_bounds fname options ?animate =
      let animate = optional_param animate bool_param in
      M.call fname
        (Array.append
           [| Js.Unsafe.inject (obj_of_size_with_position options) |]
           animate)

    method private generic_get_bounds fname =
      let bounds = M.call fname no_param in
      size_with_position_of_obj bounds

    method set_bounds options ?animate =
      self#generic_set_bounds "setBounds" options animate

    method get_bounds () =
      self#generic_get_bounds "getBounds"

    method set_content_bounds options ?animate =
      self#generic_set_bounds "setContentBounds" options animate

    method get_content_bounds () =
      self#generic_get_bounds "getContentBounds"

    method private generic_set_size fname (size : size) ?animate =
      let animate = optional_param animate bool_param in
      M.call fname
        (Array.append
           [| int_param size.width; int_param size.height; |]
           animate)

    method private generic_get_size fname =
      let size = M.call fname no_param in
      let get where : int = match Js.Optdef.to_option (Js.array_get size 0) with
        | None -> assert false
        | Some i -> i
      in
      { width = get 0; height = get 1 }

    method set_size size ?animate =
      self#generic_set_size "setSize" size animate

    method get_size () =
      self#generic_get_size "getSize"

    method set_content_size size ?animate =
      self#generic_set_size "setContentSize" size animate

    method get_content_size () =
      self#generic_get_size "getContentSize"

    method set_minimum_size size =
      self#generic_set_size "setMinimumSize" size None

    method get_minimum_size () =
      self#generic_get_size "getMinimumSize"

    method set_maximum_size size =
      self#generic_set_size "setMaximumSize" size None

    method get_maximum_size () =
      self#generic_get_size "getMaximumSize"

    method set_resizable resizable =
      M.bool_unit "setResizable" resizable

    method is_resizable () =
      M.unit_bool "isResizable"

    method set_movable movable =
      M.bool_unit "setMovable" movable

    method is_movable () =
      M.unit_bool "isMovable"

    method set_minimizable minimizable =
      M.bool_unit "setMinimizable" minimizable

    method is_minimizable () =
      M.unit_bool "isMinimizable"

    method set_maximizable maximizable =
      M.bool_unit "setMaximizable" maximizable

    method is_maximizable () =
      M.unit_bool "isMaximizable"

    method set_full_screenable fullscreenable =
      M.bool_unit "setFullScreenable" fullscreenable

    method is_full_screenable () =
      M.unit_bool "isFullScreenable"

    method set_closable closable =
      M.bool_unit "setClosable" closable

    method is_closable () =
      M.unit_bool "isClosable"

    method set_always_on_top flag ?level =
      let level =
        optional_param level
          (fun s -> string_param (string_of_top_level s))
      in
      M.call "setAlwaysOnTop" (Array.append [| bool_param flag |] level)

    method is_always_on_top () =
      M.unit_bool "isAlwaysOnTop"

    method center () =
      M.unit_unit "center"

    method set_position position ?animate =
      let animate = optional_param animate bool_param in
      M.call "setPosition"
        (Array.append
           [| int_param position.x; int_param position.y |]
           animate)

    method get_position () =
      let position = M.unit_any "getPosition" in
      let get i : int = match Js.Optdef.to_option (Js.array_get position i) with
        | None -> assert false
        | Some v -> v
      in
      { x = get 0; y = get 1 }

    method set_title title =
      M.string_unit "setTitle" title

    method get_title () =
      M.unit_string "getTitle"

    method set_sheet_offset offset_y ?offset_x =
      let offset_x = optional_param offset_x float_param in
      M.call "setSheetOffset" (Array.append [| float_param offset_y |] offset_x)

    method flash_frame flag =
      M.bool_unit "flashFrame" flag

    method set_skip_taskbar skip =
      M.bool_unit "setSkipTaskbar" skip

    method set_kiosk flag =
      M.bool_unit "setKiosk" flag

    method is_kiosk () =
      M.unit_bool "isKiosk"

    method get_native_window_handle () = ()

    method hook_window_message message cback =
      M.call "hookWindowMessage"
        [| int_param message; callback_param cback |]

    method is_window_message_hooked message =
      Js.to_bool (M.call "isWindowMessageHooked" [| int_param message |])

    method unhook_window_message message =
      M.int_unit "unhookWindowMessage" message

    method unhook_all_window_messages () =
      M.unit_unit "unhookAllWindowMessages"

    method set_represented_filename filename =
      M.string_unit "setRepresentedFilename" filename

    method get_represented_filename () =
      M.unit_string "getRepresentedFilename"

    method set_document_edited edited =
      M.bool_unit "setDocumentEdited" edited

    method is_document_edited () =
      M.unit_bool "isDocumentEdited"

    method focus_on_web_view () =
      M.unit_unit "focusOnWebView"

    method blur_web_view () =
      M.unit_unit "blurWebView"

    method capture_page ?rect cback =
      let rect =
        optional_param rect
          (fun s -> Js.Unsafe.inject (obj_of_size_with_position s))
      in
      M.call "capturePage" (Array.append rect [| callback_param cback |])

    method load_url path =
      M.string_unit "loadURL" path

    method reload () =
      M.unit_unit "reload"

    method set_menu menu =
      Util.Console.log "set_menu";
      M.call "setMenu" [| Js.Unsafe.inject menu#instance |]

    method set_progress_bar () (* progress options *) = ()

    method set_overlay_icon () (* overlay description *) = ()

    method set_has_shadow has_shadow =
      M.bool_unit "setHasShadow" has_shadow

    method has_shadow () =
      M.unit_bool "hasShadow"

    method set_thumbar_buttons () (* buttons *) = ()

    method set_thumbnail_clip region =
      M.call "setThumbnailClip"
        [| Js.Unsafe.inject (obj_of_size_with_position region) |]

    method set_thumbnail_tool_tip tool_tip =
      M.string_unit "setThumbnailToolTip" tool_tip

    method show_definition_for_selection () =
      M.unit_unit "showDefinitionForSelection"

    method set_icon () (* icon *) = ()

    method set_auto_hide_menu_bar hide =
      M.bool_unit "setAutoHideMenuBar" hide

    method is_menu_bar_auto_hide () =
      M.unit_bool "isMenuBarAutoHide"

    method set_menu_bar_visibility visible =
      M.bool_unit "setMenuBarVisibility" visible

    method is_menu_bar_visible () =
      M.unit_bool "isMenuBarVisible"

    method set_visible_on_all_workspaces visible =
      M.bool_unit "setVisibleOnAllWorkspaces" visible

    method is_visible_on_all_workspaces () =
      M.unit_bool "isVisibleOnAllWorkspaces"

    method set_ignore_mouse_events ignore_ =
      M.bool_unit "setIgnoreMouseEvents" ignore_

    method set_content_protection enable =
      M.bool_unit "setContentProtection" enable

    method set_focusable focusable =
      M.bool_unit "setFocusable" focusable

    method set_parent_window parent =
      M.call "setParentWindow" [| Js.Unsafe.inject parent#instance |]

    method get_parent_window () =
      let res = M.unit_any "getParentWindow" in
      make_bw_obj res

    method get_child_windows () =
      let res = M.unit_any "getChildWindows" in
      let res_array = Js.to_array res in
      List.map make_bw_obj (Array.to_list res_array)

  end




(* STATIC METHODS *)

module Static = Methods(struct let i = bw_module end)

let make windows_opt : browser_window =
  let obj = obj_of_browser_windows_opt windows_opt in
  let instance = Js.Unsafe.new_obj bw_module [| Js.Unsafe.inject obj |] in
  make_bw_obj instance

let get_all_windows () =
  let res = Js.Unsafe.meth_call bw_module "getAllWindows" no_param in
  let res_array = Js.to_array res in
  List.map make_bw_obj (Array.to_list res_array)

let get_focused_window () =
  let res = Js.Unsafe.meth_call bw_module "getFocusedWindow" no_param in
  make_bw_obj res

let from_web_contents () =
  assert false (* TODO *)

let from_id id =
  let res = Js.Unsafe.meth_call bw_module "fromId" [| Js.Unsafe.inject id |] in
  make_bw_obj res

let add_dev_tools_extension path =
  Js.Unsafe.meth_call bw_module "addDevToolsExtension"
    [| Js.Unsafe.inject (Js.string path) |]

let remove_dev_tools_extension name =
  Js.Unsafe.meth_call bw_module "removeDevToolsExtension"
    [| Js.Unsafe.inject (Js.string name) |]

let get_dev_tools_extensions () =
  assert false
