
open Electron.Main
open Electron.Util
open Accelerator

let main_window = ref Js.null

let index = Format.sprintf "file://%s/index.html" (__directory ())

let init_menu () =
  let submenu1 =
    Menu.build_from_template
      [ Menu.make_menu_item
          ~label:"item1"
          ~click:(fun _ _ -> Console.log "click on item1") ();
        Menu.make_menu_item
          ~label:"item2"
          ~click:(fun _ _ -> Console.log "click on item2") () ]
  in
  let menu1 =
    Menu.build_from_template
      [ Menu.make_menu_item
          ~label:"Undo" ~role:Menu.Undo
          ~accelerator:([CommandOrControl], [Letter 'Z']) ();
        Menu.make_menu_item
          ~label:"Open"
          ~accelerator:([CommandOrControl], [Letter 'O'])
          ~click:(fun _ _ -> Console.log "Hey!") ();
        Menu.make_menu_item ~label:"submenu1" ~submenu:submenu1 () ]
  in
  let menu =
    Menu.build_from_template
      [ Menu.basic_apple_menu_item ();
        Menu.make_menu_item ~label:"menu1" ~submenu:menu1 () ]
  in
  Menu.set_application_menu menu

let app_ready () =
  let w = BrowserWindow.make () in
  main_window := Js.Opt.return w;
  w#load_url index;
  init_menu ()

let () =
  App.app#on_window_all_closed (fun () -> App.app#quit ());
  App.app#on_ready app_ready
