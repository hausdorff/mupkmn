type t = { pt1: Point.t; pt2: Point.t; label: Regex.t }
let create pt1 pt2 label = { pt1 = pt1; pt2 = pt2; label = label }
let pt1 t = t.pt1
let pt2 t = t.pt2
let label t = t.label
