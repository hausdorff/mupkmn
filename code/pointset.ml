open Core.Std

type t = Point.t Set.Poly.t
let empty = Set.Poly.empty
let singleton pt = Set.Poly.singleton pt
let add t pt = Set.Poly.add t pt
let of_list list = Set.Poly.of_list list
let iter t ~f = Set.Poly.iter t ~f:f
let fold t ~init ~f = Set.Poly.fold t ~init:init ~f:f
let filter t ~f = Set.Poly.filter t ~f:f
let to_list t = Set.Poly.fold t ~init:[] ~f:(fun accum pt -> pt::accum)
