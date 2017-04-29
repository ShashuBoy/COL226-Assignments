type token =
  | SEP_
  | O_PAREN_
  | C_PAREN_
  | IF_
  | THEN_
  | ELSE_
  | LET_
  | FUNC_
  | ARROW_
  | VAR_ of (string)
  | INTEGER_ of (int)
  | BOOLEAN_ of (bool)
  | OR_
  | AND_
  | EQUAL_
  | ADD_
  | SUB_
  | MUL_
  | NOT_EQUAL_
  | NOT_
  | WHITESPACE_
  | EOF

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Types
  open Printf
# 31 "parser.ml"
let yytransl_const = [|
  257 (* SEP_ *);
  258 (* O_PAREN_ *);
  259 (* C_PAREN_ *);
  260 (* IF_ *);
  261 (* THEN_ *);
  262 (* ELSE_ *);
  263 (* LET_ *);
  264 (* FUNC_ *);
  265 (* ARROW_ *);
  269 (* OR_ *);
  270 (* AND_ *);
  271 (* EQUAL_ *);
  272 (* ADD_ *);
  273 (* SUB_ *);
  274 (* MUL_ *);
  275 (* NOT_EQUAL_ *);
  276 (* NOT_ *);
  277 (* WHITESPACE_ *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  266 (* VAR_ *);
  267 (* INTEGER_ *);
  268 (* BOOLEAN_ *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\003\000\000\000"

let yylen = "\002\000\
\001\000\003\000\004\000\001\000\001\000\001\000\003\000\003\000\
\003\000\003\000\003\000\003\000\001\000\012\000\004\000\004\000\
\003\000\006\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\
\005\000\001\000\019\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\017\000\000\000\000\000\000\000\000\000\002\000\
\000\000\000\000\010\000\000\000\000\000\000\000\000\000\000\000\
\003\000\000\000\015\000\016\000\000\000\000\000\000\000\018\000\
\000\000\000\000\000\000\000\000\000\000\014\000"

let yydgoto = "\002\000\
\011\000\012\000\013\000"

let yysindex = "\006\000\
\001\000\000\000\164\255\006\255\000\255\001\255\011\255\000\000\
\000\000\000\000\000\000\015\255\012\255\090\255\164\255\009\255\
\016\255\164\255\001\000\164\255\164\255\164\255\164\255\164\255\
\164\255\164\255\000\000\097\255\164\255\025\255\106\255\000\000\
\243\254\243\254\000\000\247\254\247\254\019\255\113\255\030\255\
\000\000\164\255\000\000\000\000\034\255\122\255\164\255\000\000\
\129\255\031\255\039\255\164\255\138\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\037\255\000\000\
\000\000\000\000\000\000\000\000\044\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\147\255\156\255\000\000\068\255\085\255\062\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\023\000\253\255\000\000"

let yytablesize = 269
let yytable = "\014\000\
\010\000\022\000\023\000\024\000\025\000\022\000\001\000\015\000\
\025\000\016\000\017\000\028\000\018\000\026\000\031\000\019\000\
\033\000\034\000\035\000\036\000\037\000\038\000\039\000\029\000\
\030\000\041\000\042\000\020\000\021\000\022\000\023\000\024\000\
\025\000\022\000\045\000\047\000\051\000\006\000\046\000\006\000\
\052\000\032\000\000\000\049\000\013\000\000\000\013\000\000\000\
\053\000\006\000\006\000\006\000\006\000\006\000\006\000\000\000\
\013\000\013\000\013\000\013\000\013\000\013\000\007\000\000\000\
\007\000\000\000\000\000\000\000\008\000\000\000\008\000\000\000\
\000\000\000\000\007\000\007\000\000\000\007\000\007\000\007\000\
\008\000\008\000\000\000\008\000\008\000\009\000\000\000\009\000\
\000\000\000\000\000\000\000\000\027\000\000\000\000\000\000\000\
\000\000\009\000\009\000\040\000\009\000\009\000\020\000\021\000\
\022\000\023\000\024\000\025\000\043\000\020\000\021\000\022\000\
\023\000\024\000\025\000\044\000\000\000\000\000\020\000\021\000\
\022\000\023\000\024\000\025\000\048\000\020\000\021\000\022\000\
\023\000\024\000\025\000\050\000\000\000\000\000\020\000\021\000\
\022\000\023\000\024\000\025\000\054\000\020\000\021\000\022\000\
\023\000\024\000\025\000\011\000\000\000\011\000\020\000\021\000\
\022\000\023\000\024\000\025\000\012\000\000\000\012\000\011\000\
\011\000\000\000\000\000\000\000\000\000\003\000\000\000\004\000\
\012\000\012\000\005\000\006\000\000\000\007\000\008\000\009\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\003\000\000\000\004\000\000\000\000\000\005\000\
\006\000\000\000\007\000\008\000\009\000"

let yycheck = "\003\000\
\000\000\015\001\016\001\017\001\018\001\015\001\001\000\002\001\
\018\001\010\001\010\001\015\000\002\001\002\001\018\000\001\001\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\015\001\
\009\001\029\000\002\001\013\001\014\001\015\001\016\001\017\001\
\018\001\015\001\005\001\002\001\006\001\001\001\042\000\003\001\
\002\001\019\000\255\255\047\000\001\001\255\255\003\001\255\255\
\052\000\013\001\014\001\015\001\016\001\017\001\018\001\255\255\
\013\001\014\001\015\001\016\001\017\001\018\001\001\001\255\255\
\003\001\255\255\255\255\255\255\001\001\255\255\003\001\255\255\
\255\255\255\255\013\001\014\001\255\255\016\001\017\001\018\001\
\013\001\014\001\255\255\016\001\017\001\001\001\255\255\003\001\
\255\255\255\255\255\255\255\255\003\001\255\255\255\255\255\255\
\255\255\013\001\014\001\003\001\016\001\017\001\013\001\014\001\
\015\001\016\001\017\001\018\001\003\001\013\001\014\001\015\001\
\016\001\017\001\018\001\003\001\255\255\255\255\013\001\014\001\
\015\001\016\001\017\001\018\001\003\001\013\001\014\001\015\001\
\016\001\017\001\018\001\003\001\255\255\255\255\013\001\014\001\
\015\001\016\001\017\001\018\001\003\001\013\001\014\001\015\001\
\016\001\017\001\018\001\001\001\255\255\003\001\013\001\014\001\
\015\001\016\001\017\001\018\001\001\001\255\255\003\001\013\001\
\014\001\255\255\255\255\255\255\255\255\002\001\255\255\004\001\
\013\001\014\001\007\001\008\001\255\255\010\001\011\001\012\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\002\001\255\255\004\001\255\255\255\255\007\001\
\008\001\255\255\010\001\011\001\012\001"

let yynames_const = "\
  SEP_\000\
  O_PAREN_\000\
  C_PAREN_\000\
  IF_\000\
  THEN_\000\
  ELSE_\000\
  LET_\000\
  FUNC_\000\
  ARROW_\000\
  OR_\000\
  AND_\000\
  EQUAL_\000\
  ADD_\000\
  SUB_\000\
  MUL_\000\
  NOT_EQUAL_\000\
  NOT_\000\
  WHITESPACE_\000\
  EOF\000\
  "

let yynames_block = "\
  VAR_\000\
  INTEGER_\000\
  BOOLEAN_\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 49 "parser.mly"
                           ( [] )
# 210 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 50 "parser.mly"
                                    ( (_1)@(_3) )
# 218 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 54 "parser.mly"
                                     ((_4)@[LET( Var(_2) )])
# 226 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 55 "parser.mly"
                                    ([INTEGER(_1)])
# 233 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 56 "parser.mly"
                                    ([BOOL(_1)])
# 240 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 57 "parser.mly"
                                    ([ACCESS( Var(_1) )])
# 247 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 58 "parser.mly"
                                    ((_1)@(_3)@[MUL])
# 255 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 59 "parser.mly"
                                    ((_1)@(_3)@[ADD])
# 263 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 60 "parser.mly"
                                    ((_1)@(_3)@[SUB])
# 271 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 61 "parser.mly"
                                    ((_1)@(_3)@[EQUAL])
# 279 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 62 "parser.mly"
                                    ((_1)@(_3)@[OR])
# 287 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 63 "parser.mly"
                                    ((_1)@(_3)@[AND])
# 295 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Types.opcode list) in
    Obj.repr(
# 64 "parser.mly"
                                    ( _1 )
# 302 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 9 : Types.opcode list) in
    let _7 = (Parsing.peek_val __caml_parser_env 5 : Types.opcode list) in
    let _11 = (Parsing.peek_val __caml_parser_env 1 : Types.opcode list) in
    Obj.repr(
# 65 "parser.mly"
                                                                                                           ((_3)@[ ( IF_THEN_ELSE ( (_7) , (_11) ) ) ])
# 311 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Types.opcode list) in
    Obj.repr(
# 66 "parser.mly"
                                      ( (_3)@([ACCESS( Var(_1) )])@[APPLY] )
# 319 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : Types.opcode list) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Types.opcode list) in
    Obj.repr(
# 67 "parser.mly"
                                          ( (_3)@(_1)@[APPLY] )
# 327 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Types.opcode list) in
    Obj.repr(
# 68 "parser.mly"
                                    ( _2 )
# 334 "parser.ml"
               : Types.opcode list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : Types.opcode list) in
    Obj.repr(
# 72 "parser.mly"
                                                        ([ CLOSURE( [LET( Var(_2) )] @ (_5) @ [RETURN] ) ])
# 342 "parser.ml"
               : Types.opcode list))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Types.opcode list)
