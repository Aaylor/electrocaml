
type size =
  { width : int;
    height : int; }

let obj_of_size size =
  Js.Unsafe.obj
    [| "width", Js.Unsafe.inject size.width;
       "height", Js.Unsafe.inject size.height |]

let size_of_obj obj =
  { width = (Js.Unsafe.coerce obj)##.width;
    height = (Js.Unsafe.coerce obj)##.height; }


type position =
  { x : int;
    y : int; }

let obj_of_position position =
  Js.Unsafe.obj
    [| "x", Js.Unsafe.inject position.x;
       "y", Js.Unsafe.inject position.y; |]

let position_of_obj obj =
  { x = (Js.Unsafe.coerce obj)##.x;
    y = (Js.Unsafe.coerce obj)##.y; }


type size_with_position =
  { position : position;
    size : size; }

let obj_of_size_with_position swc =
  Js.Unsafe.obj
    [| ("x", Js.Unsafe.inject swc.position.x);
       ("y", Js.Unsafe.inject swc.position.y);
       ("width", Js.Unsafe.inject swc.size.width);
       ("height", Js.Unsafe.inject swc.size.height) |]

let size_with_position_of_obj obj =
  { position =
      { x = (Js.Unsafe.coerce obj)##.x;
        y = (Js.Unsafe.coerce obj)##.y };
    size =
      { width = (Js.Unsafe.coerce obj)##.width;
        height = (Js.Unsafe.coerce obj)##.height } }
