#use "assignment4.ml";;
let t1 = (Var("x"));;
let t2 = (Var("y"));;
let t3 = ( Node( Atom( Sym("a") , [Var("x")] ) ));;
let t4 = ( Node( Atom( Sym("b") , [Var("x")] ) ));;
let t5 = ( Node( Atom( Sym("a") , [Var("x") ; Var("x")] ) ));;
let t6 = ( Node( Atom( Sym("a") , [Var("x") ; Var("z")] ) ));;
let t7 = ( Node( Atom( Sym("a") , [Var("y") ; Var("z")] ) ));;
let t8 = ( Node( Atom( Sym("b") , [Var("y") ; Var("z")] ) ));;

let sig3 = [(Sym("a"),2);(Sym("b"),0)];;
let sig4 = [(Sym("a"),1);(Sym("b"),2)];;
let sig5 = [(Sym("x"),2);(Sym("y"),2);(Sym("z"),0)];;

check_sig sig3;;
check_sig sig4;;
check_sig sig5;;

wfterm sig1 t1;;
wfterm sig1 t3;;
wfterm sig3 t3;;
wfterm sig3 t5;;
wfterm sig3 t0;;

ht t1;;
size t1;;
print_vars t1;;

ht t2;;
size t2;;
print_vars t2;;

ht t3;;
size t3;;
print_vars t3;;

ht t4;;
size t4;;
print_vars t4;;

ht t5;;
size t5;;
print_vars t5;;

ht t6;;
size t6;;
print_vars t6;;

ht t7;;
size t7;;
print_vars t7;;

ht t8;;
size t8;;
print_vars t8;;

ht t9;;
size t9;;
print_vars t9;;

ht t0;;
size t0;;
print_vars t0;;

let x = mgu t1 t2 in
print_subst t1 t2 x;;

let x = mgu t3 t4 in
print_subst t3 t4 x;;

let x = mgu t5 t5 in 
print_subst t5 t5 x;;

let x = mgu t1 t6 in
print_subst t1 t6 x;;

let x = mgu t8 t7 in
print_subst t8 t7 x;;

let x = mgu t9 t9 in
print_subst t9 t9 x;;

let x = mgu t0 t9 in
print_subst t0 t9 x;;

let x = mgu t11 t12 in
print_subst t11 t12 x;;

let x = mgu t13 t14 in
print_subst t13 t14 x;;



(*
  male(suyash).
  male(suman).
  female(foo).
  boy(X) :- male(X).

  ?- boy(X).
*)


let s_atom_1 = Atom ((Sym "male"),[(Cons "suyash")]) ;;
let s_atom_2 = Atom ((Sym "male"),[(Cons "suman")]) ;;
let s_atom_3 = Atom ((Sym "female"),[(Cons "foo")]) ;;
let s_atom_4 = Atom ((Sym "boy"),[(Var "X")]) ;;
let s_atom_5 = Atom ((Sym "male"),[(Var "X")]) ;;

let clause_1 = Fact (Head s_atom_1) ;;
let clause_2 = Fact (Head s_atom_2) ;;
let clause_3 = Fact (Head s_atom_3) ;;
let clause_4 = Rule ((Head s_atom_4),(Body [s_atom_5])) ;;

let s_prog = [clause_1;clause_2;clause_3;clause_4] ;;
let s_goal = [s_atom_4] ;;
