exception Err;;
let failwith msg = raise (Failure msg);;

type mix = Int of int | Bool of bool | Var of string;;
type binary_op = Add | Sub | Div | Mul | Mod | Exp | Less | Grt | Leq | Geq | Equal | Or | And;;
type unary_op = Not | Abs | Minus;;
type syntax_tree = Node of mix | Binop of binary_op * syntax_tree * syntax_tree | Uniop of unary_op * syntax_tree;;

let print_mix arg = match arg with
    |   Int(x) -> print_int(x)
    |   Var(x) -> print_string(x)
    |   Bool(x) -> Printf.printf "%b" x
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
let abs arg1 = match arg1 with
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
