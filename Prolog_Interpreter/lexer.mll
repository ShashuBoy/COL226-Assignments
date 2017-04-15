{
  open Parser
  exception Eof
}

let end = '.'
let sep = ":-"
let equal = "="
let not_equal = ("\\=" | "\\==")
let not = ("not")
let var = (['A'-'Z']['a'-'z''A'-'Z''0'-'9''_']*)
let cons = (['a'-'z']['a'-'z''A'-'Z''0'-'9''_']*)
let comma = ','
let o_paren = '('
let c_paren = ')'
let o_sq = '['
let c_sq = ']'
let or = '|'
let eol = '\n'
let whitespace = [' ''\t']

rule translate = parse
| end   {(*let () = Printf.printf "END\n" in *) END}
| sep   {(*let () = Printf.printf "SEP\n" in *) SEP}
| not   {(*let () = Printf.printf "COMMA\n" in *) NOT}
| var as variable   {(*let () = Printf.printf "VAR(variable)\n" in *) VAR(variable)}
| cons as const   {(*let () = Printf.printf "CONS(const)\n" in *) CONS(const)}
| equal   {(*let () = Printf.printf "CONS(const)\n" in *) EQUAL}
| not_equal   {(*let () = Printf.printf "CONS(const)\n" in *) NOT_EQUAL}
| comma   {(*let () = Printf.printf "COMMA\n" in *) COMMA}
| o_paren   {(*let () = Printf.printf "O_PAREN\n" in *) O_PAREN}
| c_paren   {(*let () = Printf.printf "C_PAREN\n" in *) C_PAREN}
| o_sq    {(*let () = Printf.printf "O_SQ\n" in *) O_SQ}
| c_sq    {(*let () = Printf.printf "C_SQ\n" in *) C_SQ}
| or    {(*let () = Printf.printf "OR\n" in *) OR}
| eol   { (*let () = Printf.printf "EOL \n" in *) translate lexbuf }
| whitespace    { (*let () = Printf.printf "Whitespace \n" in *) translate lexbuf }
| eof   { (*let () = Printf.printf "EOF \n" in *) EOF }