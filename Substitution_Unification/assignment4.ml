exception NOT_UNIFIABLE;;
let failwith msg = raise (Failure msg);;

type variable = Var of string;;
type symbol = Sym of string;;
type term = V of variable | Node of symbol*(term list);;
type substitution = (variable * term) list;;

let rec is_present elem = function
    [] -> false
|   (sym,arity)::xs -> if sym = elem then true else (is_present elem xs)
;;

let rec search_sig elem = function
    [] -> (false,(Sym(""),-1))
|   (sym,arity)::xs -> if sym = elem then (true,(sym,arity)) else (search_sig elem xs)
;;

let rec search_subs var = function
    [] -> failwith "Variable not found"
|   (key,value)::xs -> if key = var then value else search_subs var xs
;; 

(* Usage check_sig [] < Signature of Sym*int list > *)
let rec check_sig sym_list = function
    [] -> true
|   (Sym(sym),arity)::rest -> if (arity >= 0) && ((is_present (Sym sym) sym_list) = false) then (check_sig ((Sym sym,arity)::sym_list) rest) else false
;;

(* applies fn to a list of args and takes logical and of all the result *)
let rec and_loop fn = function
    [] -> true
|   x::xs -> if (fn x) = true then (and_loop fn xs) else false
;;

let rec wfterm signature = function
    V(x) -> true
|   Node(s,lst) -> match (search_sig s signature) with
                            (false,_) -> false
                        |   (true,(symb,arity)) -> if (List.length lst) = arity then (and_loop (wfterm signature) lst) else false
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
    V(x) -> search_subs x sigma
|   Node(sym,lst) -> Node(sym, List.map (subst sigma) lst )
;;

(* Evaluates sigma1 ( sigma2 ) *)
let rec compose sigma1 sigma2 = List.map ((fun sigma (var,tree) -> (var, subst sigma tree)) sigma1) sigma2;;

let identity_unifier t1 t2 = List.map (fun a ->  (a, V(a) )) ( _vars ( _vars [] t1 ) t2 ) ;;

let rec _mgu t1 t2 identity = match (t1,t2) with
    (Node(x,lst1),Node(y,lst2)) -> if (x <> y) || ((List.length lst1) <> (List.length lst2)) then raise NOT_UNIFIABLE
                                   else List.fold_left2 (fun s a b -> compose (_mgu (subst s a) (subst s b) identity) s ) identity lst1 lst2
|   (V(x),V(y)) -> List.map (fun (var, tree) -> if var = x then (var,V(y)) else (var,tree) ) identity
|   (V(x),Node(f,lst)) -> if (List.exists ((fun b a -> b = a) x) (vars (Node(f,lst))) ) then raise NOT_UNIFIABLE else (List.map (fun (var, tree) -> if var = x then (var,Node(f,lst)) else (var,tree) ) identity)
|   (Node(f,lst),V(x)) -> _mgu (V x) (Node (f,lst)) identity
;;

let mgu t1 t2 = _mgu t1 t2 (identity_unifier t1 t2) ;;