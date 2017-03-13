%{
   open Typefile
%}

/* Integer type token */
%token <int> INT
/* Boolean type tokens */
%token TRUE FALSE
/* token for variable */
%token <string> VAR
/* Unary operator tokens */
%token ABS NOT MINUS 
/* Binary logical operator token */
%token OR AND
/* Binary integer operator token */
%token ADD SUB MUL DIV MOD EXP LESS GRT LEQ GEQ EQUAL
/* Parenthesis */
%token LPAREN RPAREN
/* End of line */
%token EOL


%right LESS
%right LEQ
%right GRT
%right GEQ
%right EQUAL
%right SUB
%right ADD
%right MUL
%right DIV
%right MOD
%right EXP


%start main             /* the entry point */
%type <Typefile.syntax_tree> main
%%

main:
    expr EOL                  { $1 }
;
expr:
    | subexp_mul                  { $1 }
    | subexp_mul ADD expr         { Binop(Add,$1,$3) }
    | subexp_mul SUB expr         { Binop(Sub,$1,$3) }
    | subexp_mul OR expr          { Binop(Or,$1,$3) }
    | subexp_mul AND expr         { Binop(And,$1,$3) }
    | subexp_mul LESS expr        { Binop(Less,$1,$3) }
    | subexp_mul GRT expr         { Binop(Grt,$1,$3) }
    | subexp_mul LEQ expr         { Binop(Leq,$1,$3) }
    | subexp_mul GEQ expr         { Binop(Geq,$1,$3) }
    | subexp_mul EQUAL expr       { Binop(Equal,$1,$3) }
;

subexp_mul:
    | subexp_div                   { $1 }
    | subexp_div MUL subexp_mul        { Binop(Mul,$1,$3) }
;
subexp_div:
    | subexp_mod              { $1 }
    | subexp_mod DIV subexp_div        { Binop(Div, $1,$3) }
;
subexp_mod:
    | subexp_exp              { $1 }
    | subexp_exp MOD subexp_mod        { Binop(Mod,$1,$3) }
;
subexp_exp:
    | unary                        {$1}
    | unary EXP subexp_exp         { Binop(Exp,$1,$3) }
;
unary:
    | base                    { $1 }
    | ABS unary               { Uniop(Abs,$2) }
    | NOT unary              { Uniop(Not,$2) }
    | MINUS unary             { Uniop(Minus,$2) }
;

base:
    | LPAREN expr RPAREN      { $2 }
    | INT                     { Node(Int($1)) }
    | TRUE                    { Node(Bool(true)) }
    | FALSE                   { Node(Bool(false)) }
    | VAR                     { Node(Var($1)) }
;

