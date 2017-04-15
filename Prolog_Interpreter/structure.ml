open Printf;;

type symbol = Sym of string;;
type term = Var of string | Cons of string | Node of atom
and atom = Atom of symbol * (term list);;
type goal = atom list;;
type body = Body of atom list;;
type head = Head of atom;;
type clause = Fact of head | Rule of head * body;;
type program = clause list;;
type 'a answer = True of 'a | False;;

exception NOT_UNIFIABLE;;
module SS = Set.Make(String);;

let rec _check_sig sym_list = function
    [] -> true
|   (Sym(sym),arity)::rest -> if (arity >= 0) && ((List.exists (fun sy -> sy=sym) sym_list) = false) then (_check_sig (sym::sym_list) rest) else false
;;
let check_sig signature = _check_sig [] signature;;

let rec wfterm signature = function
    Var(x) -> true
|   Cons(x) -> true
|   Node(Atom(s,lst)) -> try let (_,arity) = List.find (fun (x,arity) -> x = s) signature in if (List.length lst) = arity then (List.for_all (wfterm signature) lst) else false
                   with Not_found -> false
;;

let rec ht = function
    Var(x) -> 1
|   Cons(x) -> 1
|   Node(Atom(sym,lst)) -> List.fold_left (fun a b -> max a ((ht b) + 1)) 1 lst
;;

let rec sz acc_size = function
    Var(x) -> 1+acc_size
|   Cons(x) -> 1+acc_size
|   Node(Atom(sym,lst)) -> List.fold_left (fun a b -> sz a b) (acc_size+1) lst
;;
let size x = sz 0 x;;

let rec _vars set = function
    Var(x) -> SS.add x set
|   Cons(x) -> set
|   Node(Atom(sym,args)) -> List.fold_left (fun a b -> _vars a b) set args
;;
let vars term = _vars SS.empty term;;

let vars_atm set (Atom (_,trm_list)) = List.fold_left (fun a b -> _vars a b) set trm_list;;

(*
  (bytes -> term) -> term -> term = <fun>
*)
let rec subst sigma = function
    Var(x) -> sigma x
|   Cons(x) -> Cons(x)
|   Node(Atom(sym,lst)) -> Node(Atom(sym, List.map (subst sigma) lst ) )
;;

let subst_atm sigma (Atom (sy,lst) ) = Atom( sy, List.map (subst sigma) lst);;

(* Evaluates sigma1 ( sigma2 ) *)
let rec compose sigma1 sigma2 = fun x -> subst sigma1 (sigma2 x );;

(*bytes -> term = <fun> *)
let idty_subst = fun x -> Var(x) ;;

let rec mgu t1 t2 = match (t1,t2) with
    ( (Node (Atom(x,lst1)) ), (Node (Atom(y,lst2)) ) ) -> if (x <> y) || ((List.length lst1) <> (List.length lst2)) then raise NOT_UNIFIABLE
                                   else List.fold_left2 (fun s a b -> compose (mgu (subst s a) (subst s b)) s ) idty_subst lst1 lst2
|   (Var(x),Var(y)) -> fun var -> if var = x then (Var y) else (Var var)
|   (Var(x),Cons(y)) -> fun var -> if var = x then (Cons y) else (Var var)
|   (Cons(x),Var(y)) -> mgu (Var y) (Cons x)
|   (Cons(x),Cons(y)) -> if (x <> y) then raise NOT_UNIFIABLE else idty_subst
|   (Var(x),Node(Atom(f,lst))) -> if SS.exists (fun a -> a=x) (vars (Node ( Atom(f,lst) ) ) ) then raise NOT_UNIFIABLE else (fun var -> if var = x then (Node(Atom(f,lst))) else (Var var) )
|   _ -> raise NOT_UNIFIABLE
;;

let mgu_atm (Atom (sy1,lst1)) (Atom (sy2,lst2) ) =  if (sy1 <> sy2) || ((List.length lst1) <> (List.length lst2)) then raise NOT_UNIFIABLE
                                   else List.fold_left2 (fun s a b -> compose (mgu (subst s a) (subst s b)) s ) idty_subst lst1 lst2
;;


let print_subst t1 t2 subs = let var1 = vars t1 in let var2 = _vars var1 t2 in SS.fold (fun x lst -> (Var(x),(subs x))::lst ) var2 [];; 
let print_vars t = let v = vars t in SS.fold (fun x lst -> (Var x)::lst ) v [];;


let rec find_feasible fn = function
  [] -> False
| hd::tl -> (
                match (fn hd) with
                  False -> find_feasible fn tl
                | True ans -> (True ans)
              )
;;

(*
  Modify_prog changes the variable names in the prog to _+<var_name>
  This is done to ensure that variables names do not mix during unification
*)

let rec modify_prog program = function
  [] -> program
| cl :: tl -> modify_prog ((modify_clause cl)::program) tl
and modify_clause = function
| Fact ( Head atm ) -> (Fact (Head (modify_atm atm)) )
| Rule (( Head head_atm ),( Body atm_list )) -> Rule ((Head (modify_atm head_atm)),(Body (List.map modify_atm atm_list) ))
and modify_atm (Atom (sy,term_list)) = (Atom (sy, List.map modify_term term_list) )
and modify_term = function
| Var s -> Var ("_"^s)
| Cons s -> Cons s
| Node at -> Node (modify_atm at)
;;

let rec solve unifier program goals = match goals with
  [] -> (True unifier)
| g_head :: g_tail ->  find_feasible (fun clause -> try (solve_clause unifier program goals clause) with NOT_UNIFIABLE -> False ) (modify_prog [] program)
and solve_clause unifier program (g_1::g_rest) clause = match clause with
  Fact (Head atm) -> let unif2 = (compose (mgu_atm (subst_atm unifier atm) (subst_atm unifier g_1)) unifier ) in solve unif2 program g_rest
| Rule ((Head atm),(Body atm_list)) -> let unif2 = (compose (mgu_atm (subst_atm unifier atm) (subst_atm unifier g_1)) unifier ) in solve unif2 program (g_rest @ atm_list)
;;

let rec string_of_atom (Atom ((Sym sy),trm_list)) = let base = Printf.sprintf "%s( " sy in
                                                  Printf.sprintf "%s)" (List.fold_left (fun a b -> Printf.sprintf "%s%s, " a (string_of_term b) ) base trm_list)
and string_of_term trm = match trm with
  Var str -> Printf.sprintf "Var(%s)" str
| Cons str -> Printf.sprintf "Cons(%s)" str
| Node atm -> Printf.sprintf "(%s)" (string_of_atom atm)
;;

let print_term trm = Printf.printf "%s\n" (string_of_term trm);;

