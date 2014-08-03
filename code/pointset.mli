(* A set of points. *)

type t
val singleton : Point.t -> t
val add : t -> Point.t -> t
val of_list : Point.t list -> t
val iter : t -> f:(Point.t -> unit) -> unit
