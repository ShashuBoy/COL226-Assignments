exception NOT_UNIFIABLE;;
type variable = Var of string;;
type symbol = Sym of string;;
type term = V of variable | Node of symbol*(term list);;

let rec is_present elem = function
    [] -> false
|   (sym,arity)::xs -> if sym = elem then true else (is_present elem xs)
;;

let rec search_sig elem = function
    [] -> (false,(Sym(""),-1))
|   (sym,arity)::xs -> if sym = elem then (true,(sym,arity)) else (search_sig elem xs)
;;

(* Usage check_sig [] < Signature of Sym*int list > *)
let rec check_sig sym_list = function
    [] -> true
|   (Sym(sym),arity)::rest -> if (arity >= 0) && ((is_present (Sym sym) sym_list) = false) then (check_sig ((Sym sym,arity)::sym_list) rest) else false
;;

let rec wfterm signature = function
    V(x) -> true
|   Node(s,lst) -> match (search_sig s signature) with
                            (false,_) -> false
                        |   (true,(symb,arity)) -> if (List.length lst) = arity then (List.for_all (wfterm signature) lst) else false
;;

let rec ht = function
    V(x) -> 1
|   Node(sym,lst) -> List.fold_left (fun a b -> max a ((ht b) + 1)) 1 lst
;;

(*Assuming that symbols with arity > 0 are not counted for size*)
let rec sz acc_size = function
    V(x) -> 1+acc_size
|   Node(sym,[]) -> 1+acc_size
|   Node(sym,(x::xs)) -> List.fold_left (fun a b -> sz a b) acc_size (x::xs)
;;

let size x = sz 0 x;;

let rec _vars lst = function
    V(x) -> if (List.exists ((fun b a -> b = a) x) lst) then lst else (x::lst)
|   Node(sym,args) -> List.fold_left (fun a b -> _vars a b) lst args
;;

let vars term = _vars [] term;;

let rec subst sigma = function
    V(x) -> sigma x
|   Node(sym,lst) -> Node(sym, List.map (subst sigma) lst )
;;

(* Evaluates sigma1 ( sigma2 ) *)
let rec compose sigma1 sigma2 = fun x -> subst sigma1 (sigma2 x );;

(*let identity_unifier t1 t2 = List.map (fun a ->  (a, V(a) )) ( _vars ( _vars [] t1 ) t2 ) ;;*)
let idty_subst = fun x -> V(x) ;;

let rec mgu t1 t2 = match (t1,t2) with
    (Node(x,lst1),Node(y,lst2)) -> if (x <> y) || ((List.length lst1) <> (List.length lst2)) then raise NOT_UNIFIABLE
                                   else List.fold_left2 (fun s a b -> compose (mgu (subst s a) (subst s b)) s ) idty_subst lst1 lst2
|   (V(x),V(y)) -> fun var -> if var = x then (V y) else (V var)
|   (V(x),Node(f,lst)) -> if (List.exists ((fun b a -> b = a) x) (vars (Node(f,lst))) ) then raise NOT_UNIFIABLE else (fun var -> if var = x then (Node(f,lst)) else (V var) )
|   (Node(f,lst),V(x)) -> mgu (V x) (Node (f,lst))
;;

let print_subst t1 t2 subst = let var1 = _vars [] t1 in let var2 = _vars var1 t2 in List.map (fun x -> (x,(subst x))) var2;; 
