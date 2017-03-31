#use "assignment4.ml";;

let x = mgu (V(Var("x"))) (V(Var("y")));;
print_subst (V(Var("x"))) (V(Var("y"))) x;;

let x = mgu ( Node( Sym("a") , [V(Var("x"))] ) ) ( Node( Sym("b") , [V(Var("x"))] ) );;
print_subst ( Node( Sym("a") , [V(Var("x"))] ) ) ( Node( Sym("b") , [V(Var("x"))] ) ) x;;

let x = mgu ( Node( Sym("a") , [V(Var("x")) ; V(Var("x"))] ) ) ( Node( Sym("a") , [V(Var("y")) ; V(Var("z"))] ) );;
print_subst ( Node( Sym("a") , [V(Var("x")) ; V(Var("x"))] ) ) ( Node( Sym("a") , [V(Var("y")) ; V(Var("z"))] ) ) x;;

let x = mgu ( V(Var("x")) ) ( Node( Sym("a") , [V(Var("y")) ; V(Var("z"))] ) );;
print_subst ( V(Var("x")) ) ( Node( Sym("a") , [V(Var("y")) ; V(Var("z"))] ) ) x;;

let x = mgu ( V(Var("x")) ) ( Node( Sym("a") , [V(Var("x")) ; V(Var("z"))] ) );;
print_subst ( V(Var("x")) ) ( Node( Sym("a") , [V(Var("x")) ; V(Var("z"))] ) ) x;;

let x = mgu ( Node( Sym("a") , [] ) ) ( Node( Sym("a") , [] ) );;
print_subst ( Node( Sym("a") , [] ) ) ( Node( Sym("a") , [] ) ) x;;

let x = mgu ( Node( Sym("b") , [] ) ) ( Node( Sym("a") , [] ) );;
print_subst ( Node( Sym("b") , [] ) ) ( Node( Sym("a") , [] ) ) x;;

