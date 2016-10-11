
open Util

let shell_module = electron##.shell

module Static = Methods(struct let i = shell_module end)
