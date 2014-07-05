open Core.Std

type t = | Null
         | Char of char
         | Union of t * t
         | Concat of t * t
         | Star of t

let (<|>) r1 r2 = Union (r1, r2)
let (<.>) r1 r2 = Concat (r1, r2)
let (<*>) r  = Star r

let of_char c = Char c
let of_word s =
  match (String.to_list s) with
      [] -> Null
    | c::[] -> Char c
    | c::c'::[] -> Concat (Char c, Char c')
    | c::c'::cs ->
      List.fold
        cs
        ~init:(Concat (Char c, Char c'))
        ~f:(fun acc c -> (Concat (acc, Char c)))

let to_string t =
  let rec aux acc regex = match regex with
    Null -> ""::acc
  | Char c -> (String.of_char c)::acc
  | Union (r1,r2) ->
    let leftunion = aux ("("::acc) r1 in
    let rightunion = aux ("|"::leftunion) r2 in
    (")"::rightunion)
  | Concat (r1,r2) ->
    let leftconcat = aux acc r1 in
    aux leftconcat r2
  | Star r -> ")*"::(aux ("("::acc) r)
  in
  String.concat
    (List.rev (aux [] t))
