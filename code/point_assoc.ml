open Core.Std

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

let to_list (t:t) =
  Map.Poly.fold
    t
    ~init:[]
    ~f:(fun ~key ~data accum ->
        let point1 = key in
        let pointset = data in
        Pointset.fold
          pointset
          ~init:accum
          ~f:(fun accum point2 -> (point1,point2)::accum))

let iter (t:t) ~f =
  List.iter
    (to_list t)
    ~f:(fun (pt1,pt2) -> f pt1 pt2)

let filter_edges t ~f =
  List.filter
    (to_list t)
    ~f:(fun (pt1,pt2) -> f pt1 pt2)

let filter_adj_pts (t:t) pt ~f =
  match Map.Poly.find t pt with
    None -> Pointset.empty
  | Some ptset -> Pointset.filter ptset ~f:(f pt)
