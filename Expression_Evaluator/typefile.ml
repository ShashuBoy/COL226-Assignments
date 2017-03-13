exception Err;;
let failwith msg = raise (Failure msg);;

type mix = Int of int | Bool of bool | Var of string;;
type binary_op = Add | Sub | Div | Mul | Mod | Exp | Less | Grt | Leq | Geq | Equal | Or | And;;
type unary_op = Not | Abs | Minus;;
type syntax_tree = Node of mix | Binop of binary_op * syntax_tree * syntax_tree | Uniop of unary_op * syntax_tree ;;

let string_of_mix arg = match arg with
    |   Int(x) -> string_of_int(x)
    |   Var(x) -> x
    |   Bool(x) -> Printf.sprintf "%b" x
;;


let rec pow a = function
    |   0 -> 1
    |   1 -> a
    |   n -> if n > 0 then let b = pow a (n/2) in b * b * (if n mod 2 = 0 then 1 else a) else (1/a)
;;
let add arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Int(a+b)
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s + %s )" (string_of_int a ) b ) )
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s + %s )" a (string_of_int b) ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s + %s )" a b ) )
    | _ -> failwith "Error: Addition of boolean is not permitted"
;;
let sub arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Int(a-b)
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s - %s )" (string_of_int a ) b ) )
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s - %s )" a (string_of_int b) ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s - %s )" a b ) )
    | _ -> failwith "Error: Subtraction of boolean is not permitted"
;;
let div arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Int(a/b)
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s / %s )" (string_of_int a ) b ) )
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s / %s )" a (string_of_int b) ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s / %s )" a b ) )
    | _ -> failwith "Error: Division of boolean is not permitted"
;;
let mul arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Int(a*b)
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s * %s )" (string_of_int a ) b ) )
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s * %s )" a (string_of_int b) ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s * %s )" a b ) )
    | _ -> failwith "Error: Multiplication of boolean is not permitted"
;;
let mod_ arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Int(a mod b)
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s mod %s )" (string_of_int a ) b ) )
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s mod %s )" a (string_of_int b) ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s mod %s )" a b ) )
    | _ -> failwith "Error: Mod of boolean is not permitted"
;;
let or_ arg1 arg2 = match (arg1,arg2) with
    | (Bool(a),Bool(b)) -> Bool(a || b)
    | (Bool(a),Var(b)) -> Var ( (Printf.sprintf "( %b or %s )" a b ) )
    | (Var(a),Bool(b)) -> Var ( (Printf.sprintf "( %s or %b )" a b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s or %s )" a b ) )
    | _ -> failwith "Error: Logic operation for Integers is not permitted"
;;
let and_ arg1 arg2 = match (arg1,arg2) with
    | (Bool(a),Bool(b)) -> Bool(a && b)
    | (Bool(a),Var(b)) -> Var ( (Printf.sprintf "( %b and %s )" a b ) )
    | (Var(a),Bool(b)) -> Var ( (Printf.sprintf "( %s and %b )" a b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s and %s )" a b ) )
    | _ -> failwith "Error: Logic operation for Integers is not permitted"
;;
let less arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Bool(a<b)
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s < %s )" a (string_of_int b) ) )
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s < %s )" (string_of_int a) b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s < %s )" ( a) ( b) ) )
    | _ -> failwith "Error: Comparison operation for Boolean is not permitted"
;;
let grt arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Bool(a>b)
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s > %s )" a (string_of_int b) ) )
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s > %s )" (string_of_int a) b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s > %s )" (a) (b) ) )
    | _ -> failwith "Error: Comparison operation for Boolean is not permitted"
;;
let leq arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Bool(a<=b)
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s <= %s )" a (string_of_int b) ) )
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s <= %s )" (string_of_int a) b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s <= %s )" (a) (b) ) )
    | _ -> failwith "Error: Comparison operation for Boolean is not permitted"
;;
let geq arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Bool(a >= b)
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s >= %s )" a (string_of_int b) ) )
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s >= %s )" (string_of_int a) b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s >= %s )" a b ) )
    | _ -> failwith "Error: Comparison operation for Boolean is not permitted"
;;
let equal arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Bool(a = b)
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s = %s )" a (string_of_int b) ) )
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s = %s )" (string_of_int a) b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s = %s )" (a) (b) ) )
    | _ -> failwith "Error: Comparison operation for Boolean is not permitted"
;;
let exp arg1 arg2 = match (arg1,arg2) with
    | (Int(a),Int(b)) -> Int((pow a b ))
    | (Var(a),Int(b)) -> Var( ( Printf.sprintf "( %s exp %s )" a (string_of_int b) ) )
    | (Int(a),Var(b)) -> Var( ( Printf.sprintf "( %s exp %s )" (string_of_int a) b ) )
    | (Var(a),Var(b)) -> Var( ( Printf.sprintf "( %s exp %s )" (a) (b) ) )
    | _ -> failwith "Error: Arithmetic operation for Boolean is not permitted"
;;
let abs_ arg1 = match arg1 with
    | Int(a) -> Int(abs(a))
    | Var(a) -> Var( ( Printf.sprintf "( abs %s )" a) )
    | _ -> failwith "Error: Arithmetic operation for Boolean is not permitted"
;;
let not_ arg1 = match arg1 with
    | Bool(a) -> Bool(not a)
    | Var(a) -> Var( ( Printf.sprintf "( not %s )" a) )
    | _ -> failwith "Error: Logic operation for Integer is not permitted"
;;
let minus arg1 = match arg1 with
    | Int(a) -> Int(-1*a)
    | Var(a) -> Var( ( Printf.sprintf "( -1 * %s )" a) )
    | _ -> failwith "Error: Arithmetic operation for Boolean is not permitted"
;;

let rec string_of_syntax_tree = function
    | Node(x) -> string_of_mix(x)
    | Binop(op,tree1,tree2) -> (
                            match op with
                            | Add -> Printf.sprintf "( + , %s , %s )" (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Sub -> Printf.sprintf "( - , %s , %s )" (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Div -> Printf.sprintf "( / , %s , %s )" (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Mul -> Printf.sprintf "( * , %s , %s )" (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Exp -> Printf.sprintf "( ^ , %s , %s )" (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Mod -> Printf.sprintf "( mod , %s , %s )" (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Less -> Printf.sprintf "( < , %s , %s )"  (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Grt -> Printf.sprintf "( > , %s , %s )"  (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Leq -> Printf.sprintf "( <= , %s , %s )"  (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Geq -> Printf.sprintf "( >= , %s , %s )"  (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Equal -> Printf.sprintf "( = , %s , %s )"  (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | And -> Printf.sprintf "( /\\ , %s , %s )"  (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            | Or -> Printf.sprintf "( \\/ , %s , %s )"  (string_of_syntax_tree tree1) (string_of_syntax_tree tree2)
                            )
    | Uniop(op,tree) -> match op with
                        | Not -> Printf.sprintf "(not , %s )" (string_of_syntax_tree tree)
                        | Abs -> Printf.sprintf "(abs , %s )" (string_of_syntax_tree tree)
                        | Minus -> Printf.sprintf "(~ , %s )" (string_of_syntax_tree tree)
;;
let rec eval_syntax_tree = function
    | Node(x) -> x
    | Binop(op,tree1,tree2) -> (
                            match op with
                            | Add -> add (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Sub -> sub (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Div -> div (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Mul -> mul (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Exp -> exp (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Mod -> mod_ (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Less -> less (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Grt -> grt (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Leq -> leq (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Geq -> geq (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Equal -> equal (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | And -> and_ (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            | Or -> or_ (eval_syntax_tree tree1) (eval_syntax_tree tree2)
                            )
    | Uniop(op,tree) -> match op with
                        | Not -> not_ (eval_syntax_tree tree)
                        | Abs -> abs_ (eval_syntax_tree tree)
                        | Minus -> minus (eval_syntax_tree tree)
;;
