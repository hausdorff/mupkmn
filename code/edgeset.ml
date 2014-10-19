open Core.Std

type t = (Point.t * Point.t, Regex.t) Map.Poly.t

let empty = Map.Poly.empty

let add t pt1 pt2 regex = Map.Poly.add t ~key:(pt1,pt2) ~data:regex

let find_exn t pt1 pt2 =
  Edge.create
    pt1
    pt2
    (Map.Poly.find_exn t (pt1,pt2))
