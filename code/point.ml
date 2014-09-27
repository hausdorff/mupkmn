open Core.Std

type t = (int*int)
let create x y = (x,y)
let of_tup (x,y) = (x,y)
let x t = fst t
let y t = snd t
let to_string (x,y) =
  String.concat
    ["("; Int.to_string x; ","; Int.to_string y; ")"]
