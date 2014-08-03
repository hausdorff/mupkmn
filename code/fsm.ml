open Core.Std

module Point : sig
  type t
  val create : int -> int -> t
  val x : t -> int
  val y : t -> int
  val to_string : t -> string
end = struct
  type t = (int*int)
  let create x y = (x,y)
  let x t = fst t
  let y t = snd t
  let to_string (x,y) =
    String.concat
      ["("; Int.to_string x; ","; Int.to_string y; ")"]
end

module Edge : sig
  type t
  val create : Point.t -> Point.t -> Regex.t -> t
  val pt1 : t -> Point.t
  val pt2 : t -> Point.t
  val label : t -> Regex.t
end = struct
  type t = { pt1: Point.t; pt2: Point.t; label: Regex.t }
  let create pt1 pt2 label = { pt1 = pt1; pt2 = pt2; label = label }
  let pt1 t = t.pt1
  let pt2 t = t.pt2
  let label t = t.label
end

module Pointset : sig
  type t
  val singleton : Point.t -> t
  val add : t -> Point.t -> t
  val of_list : Point.t list -> t
  val iter : t -> f:(Point.t -> unit) -> unit
end = struct
  type t = Point.t Set.Poly.t
  let singleton pt = Set.Poly.singleton pt
  let add t pt = Set.Poly.add t pt
  let of_list list = Set.Poly.of_list list
  let iter t ~f = Set.Poly.iter t ~f:f
end

module PointAssoc : sig
  type t
  val empty : t
  val add : t -> Point.t -> Pointset.t -> t
  val add_multi : t -> Point.t -> Point.t -> t
  val of_list_exn : (Point.t * Pointset.t) list -> t
  val iter : t -> fu:(Point.t -> Point.t -> unit) -> unit
end = struct
  type t = (Point.t, Pointset.t) Map.Poly.t
  let empty = Map.Poly.empty
  let add t pt points_linked_to = Map.Poly.add t ~key:pt ~data:points_linked_to
  let add_multi t pt1 pt2 =
    let new_ptset = match (Map.Poly.find t pt1) with
        None -> Pointset.singleton pt2
      | Some ptset -> Pointset.add ptset pt2
    in
    Map.Poly.add t ~key:pt1 ~data:new_ptset
  let of_list_exn list = Map.Poly.of_alist_exn list

  let iter t ~fu =
    Map.Poly.iter
      t
      ~f:(fun ~key ~data ->
          let point1 = key in
          let pointset = data in
          Pointset.iter
            pointset
            ~f:(fun point2 -> fu point1 point2))
end

type t = { points_to: PointAssoc.t;
           points_from: PointAssoc.t
         }

module Helpers : sig
  val mk_points_to : ((int*int) * ((int*int) * 'a) list) list -> PointAssoc.t
  val mk_points_from : ((int*int) * ((int*int) * 'a) list) list -> PointAssoc.t
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
    PointAssoc.of_list_exn ptmap_list

  let mk_points_from list =
    List.fold
      list
      ~init:PointAssoc.empty
      ~f:(fun acc ((x,y),transitions) ->
        let pt = Point.create x y in
        List.fold
          transitions
          ~init:acc
          ~f:(fun acc' ((x',y'),_) ->
            let pt' = Point.create x' y' in
            PointAssoc.add_multi acc' pt' pt))
end

module Topology : sig
  val bridge_pts : t -> Point.t -> to_rm:Point.t -> Point.t -> t
  val bridge_to_and_from_pts : t -> to_rm:Point.t -> t
  val update_to_and_from_selfloops : t -> to_rm:Point.t -> t
  val remove_all_to : t -> to_rm:Point.t -> t
  val remove_all_from : t -> to_rm:Point.t -> t
end = struct
  let bridge_pts t pt1 ~to_rm pt2 =
    t
  let bridge_to_and_from_pts t ~to_rm = t
  let update_to_and_from_selfloops t ~to_rm = t
  let remove_all_to t ~to_rm = t
  let remove_all_from t ~to_rm = t
end

let empty = { points_to = PointAssoc.empty;
              points_from = PointAssoc.empty }

let of_list list = { points_to = Helpers.mk_points_to list;
                     points_from = Helpers.mk_points_from list }

let iter t =
  let pm = t.points_to in
  PointAssoc.iter pm ~fu:(fun pt1 pt2 ->
                          printf "%s %s\n"
                                 (Point.to_string pt1)
                                 (Point.to_string pt2))

let remove t to_rm =
  (*
   * TODO:
   * Grab every point that has an edge pointing at to_rm, *except* to_rm.
   * Grab every point that has an edge pointing from to_rm, *except* to_rm.
   * Grab every point that has an edge pointing to to_rm, and which to_rm points
     back to, *except* to_rm.
   * Bridge each point from each of those groups.
   * Remove each edge pointing to to_rm.
   * Remove each edge pointing out of to_rm
  *)
  (*let loops_through_to_rm = c in
  let points_at_to_rm = a in
  let points_away_from_to_rm = b in*)
  Topology.bridge_to_and_from_pts t ~to_rm:to_rm
         |> Topology.update_to_and_from_selfloops ~to_rm:to_rm
         |> Topology.remove_all_to ~to_rm:to_rm
         |> Topology.remove_all_from ~to_rm:to_rm
