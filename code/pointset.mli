(* A set of points. *)

type t
val empty     : t
val singleton : Point.t -> t
val add       : t -> Point.t -> t
val of_list   : Point.t list -> t
val iter      : t -> f:(Point.t -> unit) -> unit
val fold      : t -> init:'accum -> f:('accum -> Point.t -> 'accum) -> 'accum
val filter    : t -> f:(Point.t -> bool) -> t
val to_list   : t -> Point.t list
