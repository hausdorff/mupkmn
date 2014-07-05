open Core.Std

type t

val empty          : t
val create         : ((int * int) * (((int * int) * string) list)) list -> t
val lookup_regex   : t -> (int * int) -> (int * int) -> string option
val remove         : t -> (int * int) -> t
val iter           : t -> iterfunc:((int * int) -> (int * int) -> unit) -> unit
val iter_backlinks : t -> iterfunc:((int * int) -> (int * int) -> unit) -> unit

val links_to       : ?f:((int*int) -> bool) -> t -> (int*int) -> (int*int) list option
val links_from     : ?f:((int*int) -> bool) -> t -> (int*int) -> (int*int) list option
