
open Util

let bw_module = electron##._BrowserWindow

(* type browser_window = *)
(*   < load_url : string -> unit > *)

class browser_window width height = object

  val instance =
    Js.Unsafe.new_obj bw_module [| |]

  method load_url (path : string) : unit =
    Js.Unsafe.meth_call
      instance
      "loadURL"
      [| Js.Unsafe.inject (Js.string path) |]

end
