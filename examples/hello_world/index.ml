
open Electron.Main
open Electron.Util

let window = ref Js.null

let index = Format.sprintf "file://%s/index.html" (__directory ())

let application_start () =
  let w = BrowserWindow.make ~background_color:"#237843" () in
  window := Js.Opt.return w;
  w#load_url index

let () =
  App.app#on_ready application_start
