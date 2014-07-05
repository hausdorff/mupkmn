open Core.Std

type t = { transitions : ((int * int), ((int * int), string) Map.Poly.t) Map.Poly.t;
           backlinks : ((int * int), (int * int) list) Map.Poly.t }

let empty = { transitions = Map.Poly.empty; backlinks = Map.Poly.empty }

(* ((int*int) * ((int*int)*string)) list ->
   ((int*int), (int*int) list) Map.Poly.t *)
let mk_backlinks pt_to_pt =
  List.fold
    pt_to_pt
    ~init:Map.Poly.empty
    ~f:(fun acc (pt1,transitions) ->
      List.fold
        transitions
        ~init:acc
        ~f:(fun acc (pt2,_) -> Map.Poly.add_multi acc ~key:pt2 ~data:pt1))

(* ((int*int) * ((int*int)*string)) ->
   ((int*int), ((int*int), string) Map.Poly.t) Map.Poly.t *)
let create pt_to_pt =
  let transitions =
    List.map
      pt_to_pt
      ~f:(fun (pt, pt_to_regex) -> (pt, Map.Poly.of_alist_exn pt_to_regex))
  in
  let backlinks = mk_backlinks pt_to_pt in
  { transitions = Map.Poly.of_alist_exn transitions; backlinks = backlinks }
  
(* t -> (int*int) -> (int*int) -> string option *)
let lookup_regex t pt1 pt2 = match (Map.Poly.find t.transitions pt1) with
    None -> None
  | Some map2 -> Map.Poly.find map2 pt2

(* t -> (int*int) -> ((int*int) -> bool) -> (int*int) list option *)
let links_to ?(f=(fun _ -> true)) t pt =
  match (Map.Poly.find t.backlinks pt) with
      None -> None
    | Some pts -> Some (List.filter pts ~f:f)
  
(* t -> (int*int) -> ((int*int) -> bool) -> (int*int) list option *)
let links_from ?(f=(fun _ -> true)) t pt =
  match (Map.Poly.find t.transitions pt) with
      None -> None
    | Some pts_to_regexes ->
      let pts_to_regexes_list = Map.Poly.to_alist pts_to_regexes in
      Some
        (List.filter_map
           pts_to_regexes_list
           ~f:(fun (pt,_) -> if f pt then Some pt else None))

let bridge_edge pt1 ctr pt2 t =
  t

let remove_edge pt1 pt2 t =
  t

(* t -> (int*int) -> t *)
let remove t pt =
  let links_to_pt_opt = links_to ~f:(fun pt' -> pt <> pt') t pt in
  let links_from_pt_opt = links_from ~f:(fun pt' -> pt <> pt') t pt in
  match (links_to_pt_opt,links_from_pt_opt) with
      (None,_) | (_,None) -> t
    | (Some links_to_pt, Some links_from_pt) ->
      List.fold
        links_to_pt
        ~init:t
        ~f:(fun acc to_pt ->
          List.fold
            links_from_pt
            ~init:acc
            ~f:(fun acc' from_pt ->
              bridge_edge to_pt pt from_pt acc
                   |> remove_edge to_pt pt
                   |> remove_edge pt from_pt))

let iter t ~iterfunc =
  Map.Poly.iter
    t.transitions
    ~f:(fun ~key ~data ->
      let pt1 = key in
      Map.Poly.iter
        data
        ~f:(fun ~key ~data ->
          let pt2 = key in
          iterfunc pt1 pt2))

let iter_backlinks t ~iterfunc =
  Map.Poly.iter
    t.backlinks
    ~f:(fun ~key ~data ->
      let pt1 = key in
      List.iter
        data
        ~f:(fun pt2 -> iterfunc pt1 pt2))
