(*let remove t to_rm =
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
  (Topology.bridge_to_and_from_pts t ~to_rm:to_rm)
  |> (Topology.update_to_and_from_selfloops ~to_rm:to_rm)
  |> (Topology.remove_all_to ~to_rm:to_rm)
  |> (Topology.remove_all_from ~to_rm:to_rm)*)

let points_to t pt ~f =
  let edges_to =
    Graph.filter_edges_to
      t
      pt
      ~f:f
  in
  List.map
    Edge.pt1
    edges_to

let points_from t pt ~f =
  let edges_from =
    Graph.filter_edges_from
      t
      pt
      ~f:(fun pt1 pt2 -> pt1 <> pt2)
  in
  List.map
    Edge.pt2
    edges_from

let selfloop_filter pt1 pt2 = pt1 <> pt2

let remove t ~to_rm =
  let pts_from = points_from t to_rm ~f:selfloop_filter in
  let pts_to = points_to t to_rm ~f:selfloop_filter in
  pts_to
