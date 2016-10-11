
open Util

let native_image_module = electron##.nativeImage


(* Class Native Image *)

class type native_image = object
  method instance : instance
end

let make_native_image_obj instance : native_image =
  let module M = Methods(struct let i = instance end) in
  object
    method instance = instance
  end


(* Static methods *)

module Static = Methods(struct let i = native_image_module end)
