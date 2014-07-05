open Core.Std

type t
val (<|>)     : t -> t -> t
val (<.>)     : t -> t -> t
val (<*>)     : t -> t
val of_word   : string -> t
val to_string : t -> string
