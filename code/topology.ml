let bridge_pts t pt1 ~to_rm pt2 =
  t
let bridge_to_and_from_pts t ~to_rm = t
let update_to_and_from_selfloops t ~to_rm = t
let remove_all_to t ~to_rm = t
let remove_all_from t ~to_rm = t

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
  (Topology.bridge_to_and_from_pts t ~to_rm:to_rm)
  |> (Topology.update_to_and_from_selfloops ~to_rm:to_rm)
  |> (Topology.remove_all_to ~to_rm:to_rm)
  |> (Topology.remove_all_from ~to_rm:to_rm)
