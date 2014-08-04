open Core.Std

(*let regex_test =
  let open Regex in
      let r1 = Regex.trans_of_string_exn "LRU" in
      let exp = r1 <|> (r1 <.> r1) in
      let s = Regex.to_string exp in
      printf "%s\n" s*)

let print_list l =
  List.iter
    l
    ~f:(fun (pt1,pt2) ->
        printf "%s -> %s\n"
               (Point.to_string pt1)
               (Point.to_string pt2))

let graph_test =
  Graph.of_list
    [
      (0,0), [(0,0), "LUD"; (1,0), "R"];
      (1,1), [(1,1), "RDL"; (1,0), "U"];
      (1,0), [(0,0), "L"; (1,0), "U"; (1,1), "D"; (2,0), "R"];
      (2,0), [(1,0), "L"; (2,0), "URD"];
    ]

let fsm_test () =
  Graph.print_edges graph_test
  (*let to_pts = Graph.links_from fsm (0,0) ~f:(fun pt -> pt <> (0,0)) in
  match to_pts with
      None -> printf "no results. sad cow.\n"
    | Some states -> (List.iter states ~f:(fun (x,y) -> printf "(%d,%d)\n" x y))*)

let graph_adj_test () =
  let pt = Point.create 1 0 in
  let edges =
    Graph.filter_edges_to
      graph_test
      pt
      ~f:(fun pt1 pt2 -> not (pt1 = pt2))
  in
  print_list edges

let () =
  printf "cow\n";
  graph_adj_test ()
  (*match (Graph.lookup_regex fsm (0,0) (0,0)) with
      None -> printf "no result\n"
    | Some x -> printf "%s\n" x*)
  (*Graph.iter_backlinks fsm ~iterfunc:(fun (x1,y1) (x2,y2) -> printf "(%d,%d) (%d,%d)\n" x1 y1 x2 y2)*)
