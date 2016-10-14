
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

type web_preferences_t

let make_web_preferences
    ?dev_tools ?node_integration ?preload ?session ?partition ?zoom_factor
    ?javascript ?web_security ?allow_displaying_insecure_content
    ?allow_running_insecure_content ?images ?text_areas_are_resizable
    ?webgl ?webaudio ?plugins ?experimental_features
    ?experimental_canvas_features ?scroll_bounce ?blink_features
    ?disable_blink_features ?default_font_family ?default_font_size
    ?default_monospace_font_size ?default_encoding ?background_throttling
    ?offscreen () : web_preferences_t =
  let open Util.ObjBuilder in
  let obj =
    push_bool ("devTools", dev_tools) @@
    push_bool ("nodeIntegration", node_integration) @@
    push_string ("preload", preload) @@
    push_instance ("session", session) @@
    push_string ("partition", partition) @@
    push_float ("zoomFactor", zoom_factor) @@
    push_bool ("javascript", javascript) @@
    push_bool ("webSecurity", web_security) @@
    push_bool ("allowDisplayingInsecureContent",
      allow_displaying_insecure_content) @@
    push_bool ("allowRunningInsecureContent",
      allow_running_insecure_content) @@
    push_bool ("images", images) @@
    push_bool ("textAreasAreResizable", text_areas_are_resizable) @@
    push_bool ("webgl", webgl) @@
    push_bool ("webaudio", webaudio) @@
    push_bool ("plugins", plugins) @@
    push_bool ("experimentalFeatures", experimental_features) @@
    push_bool ("experimentalCanvasFeatures",
      experimental_canvas_features) @@
    push_bool ("scrollBounce", scroll_bounce) @@
    push_string ("blinkFeatures", blink_features) @@
    push_string ("disableBlinkFeatures", disable_blink_features) @@
    (* TODO: default_font *)
    push_int ("defaultFontSize", default_font_size) @@
    push_int ("defaultMonospaceFontSize", default_monospace_font_size) @@
    push_string ("defaultEncoding", default_encoding) @@
    push_bool ("backgroundThrottling", background_throttling) @@
    push_bool ("offscreen", offscreen) []
  in
  Js.Unsafe.obj (Array.of_list obj)


module Static = Methods(struct let i = bw_module end)

let make
    ?width ?height ?x_y ?use_content_size ?center ?min_width ?min_height
    ?max_width ?max_height ?resizable ?movable ?minimizable ?maximizable
    ?closable ?focusable ?always_on_top ?fullscreen ?fullscreenable
    ?skip_taskbar ?kioks ?title ?show ?frame ?parent ?modal ?accept_first_mouse
    ?disable_auto_hide_cursor ?auto_hide_menu_bar ?enable_larger_than_screen
    ?background_color ?has_shadow ?dark_theme ?transparent ?type_
    ?title_bar_style ?thick_frame ?web_preferences () : browser_window =
  let open Util.ObjBuilder in
  let push_x_y elt acc =
    match elt with
    | None -> acc
    | Some (x, y) -> ("x", int_param x) :: ("y", int_param y) :: acc
  in
  let obj =
    push_int ("width", width) @@
    push_int ("height", height) @@
    push_x_y x_y @@
    push_bool ("useContentSize", use_content_size) @@
    push_bool ("center", center) @@
    push_int ("minWidth", min_width) @@
    push_int ("minHeight", min_height) @@
    push_int ("maxWidth", max_width) @@
    push_int ("maxHeight", max_height) @@
    push_bool ("resizable", resizable) @@
    push_bool ("movable", movable) @@
    push_bool ("minimizable", minimizable) @@
    push_bool ("maximizable", maximizable) @@
    push_bool ("closable", closable) @@
    push_bool ("focusable", focusable) @@
    push_bool ("alwaysOnTop", always_on_top) @@
    push_bool ("fullscreen", fullscreen) @@
    push_bool ("fullscreenable", fullscreenable) @@
    push_bool ("skipTaskbar", skip_taskbar) @@
    push_bool ("kioks", kioks) @@
    push_string ("title", title) @@
    push_bool ("show", show) @@
    push_bool ("frame", frame) @@
    push_instance ("parent", parent) @@
    push_bool ("modal", modal) @@
    push_bool ("acceptFirstMouse", accept_first_mouse) @@
    push_bool ("disableAutoHideCursor", disable_auto_hide_cursor) @@
    push_bool ("autoHideMenuBar", auto_hide_menu_bar) @@
    push_bool ("enableLargerThanScreen", enable_larger_than_screen) @@
    push_string ("backgroundColor", background_color) @@
    push_bool ("hasShadow", has_shadow) @@
    push_bool ("darkTheme", dark_theme) @@
    push_bool ("transparent", transparent) @@
    push_datatype ("type", type_, string_of_windows_type) @@
    push_datatype
      ("titleBarStyle", title_bar_style, string_of_title_bar_style) @@
    push_bool ("thickFrame", thick_frame) @@
    push ("webPreferences", (fun x -> Js.Unsafe.inject x), web_preferences) []
  in
  let obj = Js.Unsafe.obj (Array.of_list obj) in
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
