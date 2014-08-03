(* A map from Point.t -> Pointset.t. Often functions as an adjacency list. *)

type t
val empty       : t
val add         : t -> Point.t -> Pointset.t -> t
val add_multi   : t -> Point.t -> Point.t -> t
val of_list_exn : (Point.t * Pointset.t) list -> t
val iter        : t -> f:(Point.t -> Point.t -> unit) -> unit
