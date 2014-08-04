(* A map from Point.t -> Pointset.t. Often functions as an adjacency list. *)

type t
val empty          : t
val add            : t -> Point.t -> Pointset.t -> t
val add_multi      : t -> Point.t -> Point.t -> t
val of_list_exn    : (Point.t * Pointset.t) list -> t
val to_list        : t -> (Point.t * Point.t) list
val iter           : t -> f:(Point.t -> Point.t -> unit) -> unit
val filter_edges
    : t -> f:(Point.t -> Point.t -> bool) -> (Point.t * Point.t) list
val filter_adj_pts
    : t -> Point.t -> f:(Point.t -> Point.t -> bool) -> Pointset.t
