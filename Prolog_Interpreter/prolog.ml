open Parser;;
open Printf;;
module SS = Set.Make(String);;

let load_rule fl = 
  let decl = open_in fl in
  let lexbuf = Lexing.from_channel decl in
  Parser.main Lexer.translate lexbuf
;;


let handle_query prog str = 
  let lexbuf = Lexing.from_string str in
  let goals = Parser.goal Lexer.translate lexbuf in
  let vars = List.fold_left (fun a b -> Structure.vars_atm a b) SS.empty goals in
  let ans = Structure.solve false vars (Structure.idty_subst) prog goals in match ans with
    Structure.False -> Printf.printf "false\n"
  | Structure.True sub -> Printf.printf "true\n"
;;

let rec main prog =
    Printf.printf "?- ";
    let inp = try read_line() with End_of_file -> Printf.printf "\nExiting\n" ;exit 0 in
    (*let () = Printf.printf ("stage\n") in*)
    let () = flush stdout in            
    let len = String.length inp in
    if (inp.[(len-1)] <> '.') then
      let () = (Printf.printf "Every instruction must end with \'.\'\n") in
      main prog
    else
      (*let () = Printf.printf "Reached here 1\n" in      *)
      if (inp = "halt.") then exit 0
      else
        (*let () = Printf.printf "Reached here 2\n%s\n" inp in*)
        (*let () = flush stdout in                           *)
        if ((String.sub inp 0 2) = "[\"") && ((String.sub inp (len - 3) 3) = "\"].") then
          (*let () = Printf.printf "Reached here\n" in*)
          (*let () = flush stdout in                                   *)
          let name = String.sub inp 2 (len - 5) in 
          let new_prog = try load_rule name with
            | Parsing.Parse_error -> let () = Printf.printf("Error in rule file given.\n") in prog
            | _ -> let () = Printf.printf("Wrong file path provided.\n") in prog
          in main new_prog
        else
          (*let () = Printf.printf ("reached query stage\n") in*)
          (*let () = flush stdout in                                             *)
          let () = try (handle_query prog inp)
          with
          | Parsing.Parse_error -> Printf.printf "Invalid command\n"
          in main prog
;;


if !Sys.interactive then () else main [];;
    