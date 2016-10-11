
open Util

let clipboard_module = electron##.clipboard

module Static = Methods(struct let i = clipboard_module end)
