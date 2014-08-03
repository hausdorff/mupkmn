open Core.Std

type t = { points_to: Point_assoc.t;
           points_from: Point_assoc.t }

(* The helper methods for the FSM functions. *)
module Helpers : sig
  val mk_points_to : ((int*int) * ((int*int) * 'a) list) list -> Point_assoc.t
  val mk_points_from : ((int*int) * ((int*int) * 'a) list) list -> Point_assoc.t
end = struct
  let ptset_of_transitions transitions =
    Pointset.of_list
      (List.map
         transitions
         ~f:(fun ((x,y),_) -> Point.create x y))

  let mk_points_to list =
    let ptmap_list =
      List.map
        list
        ~f:(fun ((x,y),transitions) ->
          let pt = Point.create x y in
          let ptset = ptset_of_transitions transitions in
          (pt,ptset))
    in
    Point_assoc.of_list_exn ptmap_list

  let mk_points_from list =
    List.fold
      list
      ~init:Point_assoc.empty
      ~f:(fun acc ((x,y),transitions) ->
        let pt = Point.create x y in
        List.fold
          transitions
          ~init:acc
          ~f:(fun acc' ((x',y'),_) ->
            let pt' = Point.create x' y' in
            Point_assoc.add_multi acc' pt' pt))
end

let empty = { points_to = Point_assoc.empty;
              points_from = Point_assoc.empty }

let of_list list = { points_to = Helpers.mk_points_to list;
                     points_from = Helpers.mk_points_from list }

let iter t =
  let pm = t.points_to in
  Point_assoc.iter pm ~fu:(fun pt1 pt2 ->
                          printf "%s %s\n"
                                 (Point.to_string pt1)
                                 (Point.to_string pt2))
