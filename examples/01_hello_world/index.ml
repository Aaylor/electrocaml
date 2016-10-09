
module Console = Electron.Util.Console

let app = Electron.Main.App.app

let path = Sys.getenv "PWD"

let application_start () =
  let w = Electron.Main.BrowserWindow.(make default_browser_windows_option) in
  w#load_url (Format.sprintf "file://%s/index.html" path)

let () =
  app#on_ready application_start
