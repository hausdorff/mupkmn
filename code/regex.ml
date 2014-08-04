open Core.Std

module Transition : sig
  type t

  val of_char : char -> t

  val to_string : t -> string
end = struct
  type t = | U | D | L | R | A | B | S | T | N

  let of_char c = match c with
      'U' -> U | 'D' -> D | 'L' -> L | 'R' -> R | 'A' -> A | 'B' -> B | 'S' -> S
    | 'T' -> T | 'N' -> N
    | _   -> raise (Failure
                      (String.concat
                         [String.of_char c; " is not a valid transition"]))

  let to_string trans = match trans with
      U -> "U" | D -> "D" | L -> "L" | R -> "R" | A -> "A" | B -> "B" | S -> "S"
    | T -> "T" | N -> "N"
end

type t = | Null
         | Char of Transition.t
         | Union of t * t
         | Concat of t * t
         | Star of t

let (<|>) r1 r2 = Union (r1, r2)

let (<.>) r1 r2 = Concat (r1, r2)

let (<*>) r  = Star r

let of_char c = Char (Transition.of_char c)

let union_of_string_exn s =
  let chars = String.to_list s in
  let filtered =
    List.filter
      chars
      ~f:(fun c -> (c <> '(') && (c <> ')') && (c <> '|'))
  in
  match filtered with
      []        -> Null
    | c::[]     -> of_char c
    | c::c'::[] -> Union (of_char c, of_char c')
    | c::c'::cs ->
      List.fold
        cs
        ~init:(Union (of_char c, of_char c'))
        ~f:(fun acc c -> (Union (acc, of_char c)))

let trans_of_string_exn s =
  match (String.to_list s) with
      []        -> Null
    | c::[]     -> of_char c
    | c::c'::[] -> Concat (of_char c, of_char c')
    | c::c'::cs ->
      List.fold
        cs
        ~init:(Concat (of_char c, of_char c'))
        ~f:(fun acc c -> (Concat (acc, of_char c)))

let to_string t =
  let rec aux acc regex = match regex with
    Null -> ""::acc
  | Char c -> (Transition.to_string c)::acc
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
