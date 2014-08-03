open Core.Std

type t = Point.t Set.Poly.t
let singleton pt = Set.Poly.singleton pt
let add t pt = Set.Poly.add t pt
let of_list list = Set.Poly.of_list list
let iter t ~f = Set.Poly.iter t ~f:f
let fold t ~init ~f = Set.Poly.fold t ~init:init ~f:f
