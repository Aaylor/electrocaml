(** NativeImage implementation *)


val native_image_module : Util.instance


(** {2 Class NativeImage} *)

class type native_image = object
  method instance : Util.instance
end


(** {2 Static methods} *)
