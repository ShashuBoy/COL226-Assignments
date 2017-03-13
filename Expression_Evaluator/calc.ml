(* File calc.ml *)
open Typefile;;

let _ =
    try
    let lexbuf = Lexing.from_channel stdin in
    while true do
        let result = Parser.main Lexer.translate lexbuf in
        print_mix result;
        print_newline(); flush stdout
    done
    with Lexer.Eof ->
    exit 0