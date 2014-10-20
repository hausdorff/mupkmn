open Core.Std

type t = (Point.t * Point.t, Regex.t) Map.Poly.t

let empty = Map.Poly.empty

let add t pt1 pt2 regex = Map.Poly.add t ~key:(pt1,pt2) ~data:regex

let singleton pt1 pt2 regex = add empty pt1 pt2 regex

let find_exn t pt1 pt2 =
  Edge.create
    pt1
    pt2
    (Map.Poly.find_exn t (pt1,pt2))

let find t pt1 pt2 = match (Map.Poly.find t (pt1,pt2)) with
    None -> None
  | Some e -> Some (Edge.create pt1 pt2 e)
