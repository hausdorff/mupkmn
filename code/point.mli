(* An ordered pair that represents a position on a 2D grid. *)

type t
val create : int -> int -> t
val of_tup : (int * int) -> t
val x : t -> int
val y : t -> int
val to_string : t -> string
