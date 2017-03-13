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
%type <Typefile.mix> main
%%

main:
    expr EOL                  { $1 }
;
expr:
    | subexp_mul                  { $1 }
    | subexp_mul ADD expr         { add $1 $3 }
    | subexp_mul SUB expr         { sub $1 $3 }
    | subexp_mul OR expr          { or_ $1 $3 }
    | subexp_mul AND expr         { and_ $1 $3 }
    | subexp_mul LESS expr        { less $1 $3 }
    | subexp_mul GRT expr         { grt $1 $3 }
    | subexp_mul LEQ expr         { leq $1 $3 }
    | subexp_mul GEQ expr         { geq $1 $3 }
    | subexp_mul EQUAL expr       { equal $1 $3 }
;

subexp_mul:
    | subexp_div                   { $1 }
    | subexp_div MUL subexp_mul        { mul $1 $3 }
;
subexp_div:
    | subexp_mod              { $1 }
    | subexp_mod DIV subexp_div        { div $1 $3 }
;
subexp_mod:
    | subexp_exp              { $1 }
    | subexp_exp MOD subexp_mod        { mod_ $1 $3 }
;
subexp_exp:
    | unary                        {$1}
    | unary EXP subexp_exp         { exp $1 $3 }
;
unary:
    | base                    { $1 }
    | ABS unary               { abs $2 }
    | NOT unary               { not_ $2 }
    | MINUS unary             { minus $2 }
;

base:
    | LPAREN expr RPAREN      { $2 }
    | INT                     { Int($1) }
    | TRUE                    { Bool(true) }
    | FALSE                   { Bool(false) }
    | VAR                     { Var($1) }
;

