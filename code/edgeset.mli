type t
val empty     : t
val add       : t -> Point.t -> Point.t -> Regex.t -> t
val singleton : Point.t -> Point.t -> Regex.t -> t
val find_exn  : t -> Point.t -> Point.t -> Edge.t
val find      : t -> Point.t -> Point.t -> Edge.t option
