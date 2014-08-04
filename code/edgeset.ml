open Core.Std

type t = Edge.t Set.Poly.t

let empty = Set.Poly.empty

let add t edge = Set.Poly.add t edge
