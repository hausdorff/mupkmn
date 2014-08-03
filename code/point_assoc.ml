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
let iter t ~fu =
  Map.Poly.iter
    t
    ~f:(fun ~key ~data ->
        let point1 = key in
        let pointset = data in
        Pointset.iter
          pointset
          ~f:(fun point2 -> fu point1 point2))
