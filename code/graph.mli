open Core.Std

type t
val empty               : t
val of_list             : ((int*int) * ((int*int) * string) list) list -> t
val iter_edges          : t -> f:(Point.t -> Point.t -> unit) -> unit
val print_edges         : t -> unit
val filter_edges_from
    : t ->
      Point.t ->
      f:(Point.t -> Point.t -> bool) ->
      Edge.t list
val filter_edges_to
    : t ->
      Point.t ->
      f:(Point.t -> Point.t -> bool) ->
      Edge.t list
