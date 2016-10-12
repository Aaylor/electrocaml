
type size =
  { width : int;
    height : int; }

val obj_of_size : size -> 'a

val size_of_obj : 'a Js.t -> size


type position =
  { x : int;
    y : int; }

val obj_of_position : position -> 'a

val position_of_obj : 'a Js.t -> position


type size_with_position =
  { position : position;
    size : size; }

val obj_of_size_with_position : size_with_position -> 'a

val size_with_position_of_obj : 'a Js.t -> size_with_position
