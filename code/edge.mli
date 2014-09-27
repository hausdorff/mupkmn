(* A directed edge, consisting of two points. *)

type t
val create : Point.t -> Point.t -> Regex.t -> t
val pt1 : t -> Point.t
val pt2 : t -> Point.t
val label : t -> Regex.t
val to_string : t -> string
