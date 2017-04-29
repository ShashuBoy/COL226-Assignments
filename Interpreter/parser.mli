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

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Interpreter_secd.opcode list
