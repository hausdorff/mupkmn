open Core.Std

type t
val (<|>)               : t -> t -> t
val (<.>)               : t -> t -> t
val (<*>)               : t -> t
val union_of_string_exn : string -> t
val trans_of_string_exn : string -> t
val to_string           : t -> string
