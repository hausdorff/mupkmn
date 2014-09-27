open Core.Std

type t = { pt1: Point.t; pt2: Point.t; label: Regex.t }
let create pt1 pt2 label = { pt1 = pt1; pt2 = pt2; label = label }
let pt1 t = t.pt1
let pt2 t = t.pt2
let label t = t.label
let to_string t =
  String.concat [ (Point.to_string t.pt1);
                  " -> ";
                  (Point.to_string t.pt2);
                  " : ";
                  (Regex.to_string t.label); ]
