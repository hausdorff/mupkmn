open Core.Std

(*let regex_test =
  let open Regex in
      let r1 = Regex.trans_of_string_exn "LRU" in
      let exp = r1 <|> (r1 <.> r1) in
      let s = Regex.to_string exp in
      printf "%s\n" s*)

let fsm_test =
  let fsm =
    Graph.of_list
      [
        (0,0), [(0,0), "(L|U|D)"; (1,0), "R"];
        (1,1), [(1,1), "(R|D|L)"; (1,0), "U"];
        (1,0), [(0,0), "L"; (1,0), "U"; (1,1), "D"; (2,0), "R"];
        (2,0), [(1,0), "L"; (2,0), "(U|R|D)"];
      ]
  in
  Graph.print_edges fsm
  (*let to_pts = Graph.links_from fsm (0,0) ~f:(fun pt -> pt <> (0,0)) in
  match to_pts with
      None -> printf "no results. sad cow.\n"
    | Some states -> (List.iter states ~f:(fun (x,y) -> printf "(%d,%d)\n" x y))*)

let () =
  fsm_test
  (*match (Graph.lookup_regex fsm (0,0) (0,0)) with
      None -> printf "no result\n"
    | Some x -> printf "%s\n" x*)
  (*Graph.iter_backlinks fsm ~iterfunc:(fun (x1,y1) (x2,y2) -> printf "(%d,%d) (%d,%d)\n" x1 y1 x2 y2)*)
