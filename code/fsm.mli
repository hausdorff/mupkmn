open Core.Std

type t

val empty : t
val of_list : ((int*int) * ((int*int) * 'a) list) list -> t
val iter : t -> unit
