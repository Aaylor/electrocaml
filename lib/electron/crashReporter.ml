
open Util

let crash_reporter_module = electron##.crashReporter

module Static = Methods(struct let i = crash_reporter_module end)
