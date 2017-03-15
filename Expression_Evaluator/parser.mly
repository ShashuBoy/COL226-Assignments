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

%left LESS
%left LEQ
%left GRT
%left GEQ
%left EQUAL
%left OR
%left AND
%left SUB
%left ADD
%left MUL
%left DIV
%left MOD
%left EXP
%start main             /* the entry point */
%type <Typefile.parse_tree> main
%%

main:
    expr EOL                  { $1 }
;
expr:
    | subexp_1                  { Elepar("expr",$1) }
    | expr ADD subexp_1         { Bipar("expr",Add,$1,$3) }
    | expr SUB subexp_1         { Bipar("expr",Sub,$1,$3) }
    | expr OR subexp_1          { Bipar("expr",Or,$1,$3) }
    | expr LESS subexp_1        { Bipar("expr",Less,$1,$3) }
    | expr GRT subexp_1         { Bipar("expr",Grt,$1,$3) }
    | expr LEQ subexp_1         { Bipar("expr",Leq,$1,$3) }
    | expr GEQ subexp_1         { Bipar("expr",Geq,$1,$3) }
    | expr EQUAL subexp_1       { Bipar("expr",Equal,$1,$3) }
;

subexp_1:
    | subexp_2                   { Elepar("subexp_1",$1) }
    | subexp_1 MUL subexp_2        { Bipar("subexp_1",Mul,$1,$3) }
    | subexp_1 AND subexp_2         { Bipar("expr",And,$1,$3) }
    
;
subexp_2:
    | subexp_3              { Elepar("subexp_2",$1) }
    | subexp_2 DIV subexp_3        { Bipar("subexp_2",Div, $1,$3) }
;
subexp_3:
    | subexp_4              { Elepar("subexp_3",$1) }
    | subexp_3 MOD subexp_4        { Bipar("subexp_3",Mod,$1,$3) }
;
subexp_4:
    | unary                        { Elepar("subexp_4",$1)}
    | subexp_4 EXP unary         { Bipar("subexp_4",Exp,$1,$3) }
;
unary:
    | base                    { Elepar("unary",$1) }
    | ABS unary               { Unipar("unary",Abs,$2) }
    | NOT unary               { Unipar("unary",Not,$2) }
    | MINUS unary             { Unipar("unary",Minus,$2) }
;

base:
    | LPAREN expr RPAREN      { Elepar("base",$2) }
    | SUB INT                 { Elepar("base",Base(Int(-1 * $2))) }
    | INT                     { Elepar("base",Base(Int($1))) }
    | TRUE                    { Elepar("base",Base(Bool(true))) }
    | FALSE                   { Elepar("base",Base(Bool(false))) }
    | VAR                     { Elepar("base",Base(Var($1))) }
;

