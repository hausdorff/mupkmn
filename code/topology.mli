(* Points for messing with the list at a higher level than points and edges. *)

val bridge_pts
    : Fsm.t -> Point.t -> to_rm:Point.t -> Point.t -> Fsm.t
val bridge_to_and_from_pts       : Fsm.t -> to_rm:Point.t -> Fsm.t
val update_to_and_from_selfloops : Fsm.t -> to_rm:Point.t -> Fsm.t
val remove_all_to                : Fsm.t -> to_rm:Point.t -> Fsm.t
val remove_all_from              : Fsm.t -> to_rm:Point.t -> Fsm.t
