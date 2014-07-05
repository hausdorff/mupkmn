open Core.Std

let () =
  printf "cow\n"
  (*let fsm =
    Fsm.create
      [
        (0,0), [(0,0), "(L|U|D)"; (1,0), "R"];
        (1,1), [(1,1), "(R|D|L)"; (1,0), "U"];
        (1,0), [(0,0), "L"; (1,0), "U"; (1,1), "D"; (2,0), "R"];
        (2,0), [(1,0), "L"; (2,0), "(U|R|D)"];
      ]
  in
  let to_pts = Fsm.links_from fsm (0,0) ~f:(fun pt -> pt <> (0,0)) in
  match to_pts with
      None -> printf "no results. sad cow.\n"
    | Some states -> (List.iter states ~f:(fun (x,y) -> printf "(%d,%d)\n" x y))*)
  (*match (Fsm.lookup_regex fsm (0,0) (0,0)) with
      None -> printf "no result\n"
    | Some x -> printf "%s\n" x*)
  (*Fsm.iter_backlinks fsm ~iterfunc:(fun (x1,y1) (x2,y2) -> printf "(%d,%d) (%d,%d)\n" x1 y1 x2 y2)*)
