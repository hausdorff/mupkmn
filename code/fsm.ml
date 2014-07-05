open Core.Std

module Point : sig
  type t
  val create : int -> int -> t
end = struct
  type t = (int*int)
  let create x y = (x,y)
end

module Edge : sig
  type t
  val create : Point.t -> Point.t -> Regex.t -> t
end = struct
  type t = { pt1: Point.t; pt2: Point.t; label: Regex.t }
  let create pt1 pt2 label = { pt1 = pt1; pt2 = pt2; label = label }
end


type t = { edges: Regex.t }

let empty = { edges = Regex.of_word "cow" }
