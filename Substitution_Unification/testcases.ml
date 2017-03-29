#use "assignment4.ml";;

mgu (V(Var("x"))) (V(Var("y")));;
mgu ( Node( Sym("a") , [V(Var("x"))] ) ) ( Node( Sym("b") , [V(Var("x"))] ) );;
mgu ( Node( Sym("a") , [V(Var("x")) ; V(Var("x"))] ) ) ( Node( Sym("a") , [V(Var("y")) ; V(Var("z"))] ) );;
mgu ( V(Var("x")) ) ( Node( Sym("a") , [V(Var("y")) ; V(Var("z"))] ) );;
mgu ( V(Var("x")) ) ( Node( Sym("a") , [V(Var("x")) ; V(Var("z"))] ) );;
mgu ( Node( Sym("a") , [] ) ) ( Node( Sym("a") , [] ) );;
mgu ( Node( Sym("b") , [] ) ) ( Node( Sym("a") , [] ) );;
