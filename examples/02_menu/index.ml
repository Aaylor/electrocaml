
open Electron.Main.Accelerator

let dirname = Electron.Util.__directory ()
let app = Electron.Main.App.app

let main_window = ref Js.null

let app_ready () =
  let open Electron.Main.BrowserWindow in
  let w = make default_browser_windows_option in
  main_window := Js.Opt.return w;
  w#load_url (Format.sprintf "file://%s/index.html" dirname);
  let menu =
    let open Electron.Main.Menu in
    let open Electron.Main.Accelerator in
    build_from_template
      [  basic_apple_menu_item ();
         make_menu_item
           { default_menu_item_options with
            label = Some "menu1";
            submenu = Some
                (build_from_template
                   [ make_menu_item
                       { default_menu_item_options with
                         label = Some "Undo";
                         accelerator = Some([CommandOrControl], [Letter 'Z']);
                         role = Some Undo };
                     make_menu_item
                       { default_menu_item_options with
                         label = Some "Open";
                         accelerator = Some([CommandOrControl], [Letter 'O']);
                         click = Some (fun _ _ -> Electron.Util.Console.log "Hey") };
                     make_menu_item
                       { default_menu_item_options with
                         label = Some "submenu1";
                         submenu = Some
                             (build_from_template
                                [ make_menu_item
                                    { default_menu_item_options with
                                      label = Some "item1";
                                      click =
                                        Some (fun _ _ ->
                                          Electron.Util.Console.log "Hey2") };
                                  make_menu_item
                                    { default_menu_item_options with
                                      label = Some "item2";
                                      click =
                                        Some (fun _ _ ->
                                          Electron.Util.Console.log "Hey3") }; ] )
                       }
                   ])
          }
      ]
  in
  (* let menu = create_menu () in *)
  Electron.Main.Menu.set_application_menu menu;
  Electron.Util.Console.log "-------";
  Electron.Util.Console.log (string_of_bool (w#is_menu_bar_visible ()));
  (* w#set_menu menu; *)
  let menu' = Electron.Main.Menu.get_application_menu () in
  match menu' with
  | None -> Electron.Util.Console.log "NO MENU"
  | Some m -> Electron.Util.Console.log_any m#instance
  (* Js.Unsafe.meth_call (Js.Unsafe.js_expr "console") "log" *)
  (*   [| Js.Unsafe.inject menu#instance |] *)


let () =
  app#on_window_all_closed (fun () -> app#quit ());
  app#on_ready app_ready
