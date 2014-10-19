open Core.Std

type t = { points_to: Point_assoc.t;
           points_from: Point_assoc.t;
           edges: Edgeset.t }

(* The helper methods for the FSM functions. *)
module Helpers : sig
  val mk_points_to
      : ((int*int) * ((int*int) * string) list) list -> Point_assoc.t
  val mk_points_from
      : ((int*int) * ((int*int) * string) list) list -> Point_assoc.t
  val mk_edges
      : ((int*int) * ((int*int) * string) list) list -> Edgeset.t
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

  let mk_edges list =
    List.fold
      list
      ~init:Edgeset.empty
      ~f:(fun acc ((x,y),transitions) ->
          let pt = Point.create x y in
          List.fold
            transitions
            ~init:acc
            ~f:(fun acc' ((x',y'),(regex_str:string)) ->
                let pt' = Point.create x' y' in
                let regex = Regex.union_of_string_exn regex_str in
                Edgeset.add acc' pt pt' regex))
end

let empty = { points_to = Point_assoc.empty;
              points_from = Point_assoc.empty;
              edges = Edgeset.empty }

let of_list list = { points_to = Helpers.mk_points_to list;
                     points_from = Helpers.mk_points_from list;
                     edges = Helpers.mk_edges list }

let iter_edges t ~f =
  Point_assoc.iter t.points_to ~f:f

let print_edges t =
  iter_edges t ~f:(fun pt1 pt2 ->
                   printf "%s -> %s\n"
                          (Point.to_string pt1)
                          (Point.to_string pt2))

let filter_edges_from t pt ~f =
  let adj_pts =
    Point_assoc.filter_adj_pts
      t.points_from
      pt
      ~f:f
  in
  List.bind
    (Pointset.to_list adj_pts)
    (fun pt' ->
     [Edgeset.find_exn t.edges pt pt'])

let filter_edges_to t pt ~f =
  let adj_pts =
    Point_assoc.filter_adj_pts
      t.points_to
      pt
      ~f:f
  in
  List.bind
    (Pointset.to_list adj_pts)
    (fun pt' ->
     [Edgeset.find_exn t.edges pt' pt])
