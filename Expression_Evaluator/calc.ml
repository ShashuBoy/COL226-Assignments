(* File calc.ml *)
open Typefile;;

let _ =
    try
    let lexbuf = Lexing.from_channel stdin in
    while true do
        let result = Parser.main Lexer.translate lexbuf in
        let hash_map = make_kai [] result in
        Printf.printf "%s\n%s\n" (string_of_parse_tree result) (string_of_mix ( eval_parse_tree hash_map result));
        flush stdout
    done
    with Lexer.Eof ->
    exit 0