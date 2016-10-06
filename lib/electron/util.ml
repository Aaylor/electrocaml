
let electron =
  Js.Unsafe.fun_call
    (Js.Unsafe.js_expr "require")
    [| Js.Unsafe.inject (Js.string "electron") |]

let __directory () =
  Js.to_string (Js.Unsafe.eval_string "__dirname")

let __filename () =
  Js.to_string (Js.Unsafe.eval_string "__filename")

let no_param = [| |]

module JSON = struct
  let parse str =
    Js._JSON##parse (Js.string str)
  let stringify jso =
    Js.to_string (Js._JSON##stringify jso)
end

module Console = struct

  let console = Js.Unsafe.js_expr "console"

  let log str =
    Js.Unsafe.meth_call
      console "log" [| Js.Unsafe.inject (Js.string str) |]

end
