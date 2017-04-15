%{
  open Structure
  open Printf
%}

%token END
%token SEP
%token <string> VAR CONS
%token COMMA
%token O_PAREN
%token C_PAREN
%token O_SQ
%token C_SQ
%token OR
%token EOL
%token WHITESPACE
%token EOF

%start main
%start goal
%type <Structure.program> main
%type <Structure.goal> goal
%%

main:
  | EOF                    { [] }
  | clause main            { ($1)::($2) }
;

goal:
  | atom_list END          { $1 }

clause:
  | atom END               { Fact(Head($1)) }
  | atom SEP atom_list END     { Rule(Head($1),Body($3)) }
;

atom:
  | CONS O_PAREN term_list C_PAREN         { Atom(Sym($1),$3) }
;

atom_list:
  | atom                   { [$1] }
  | atom COMMA atom_list   { ($1)::($3) }
;

term_list:
  | term                   { [$1] }
  | term COMMA term_list   { ($1)::($3) }
;

term:
  | VAR                    { Var($1) }
  | CONS                   { Cons($1) }
  | atom                   { Node($1) }
;