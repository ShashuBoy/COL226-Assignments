open Printf;;

type variable = Var of string;;
type opcode = CONST of int | ADD | SUB | LET of variable | ENDLET | APPLY | RETURN | CLOSURE of (opcode list) | ACCESS of variable ;;
type closure = VCL of int | CL of environment * (opcode list) and
environment = (variable * closure) list;;
type stack = closure list;;
type dump = (environment * (opcode list)) list;;

let add stk = match stk with
  (VCL x )::(VCL y :: tl) -> (VCL (x+y))::tl
| _ -> failwith "Wrong Stack"
;;

let sub stk = match stk with
  (VCL x )::(VCL y :: tl) -> (VCL (x-y))::tl
| _ -> failwith "Wrong Stack"
;;

let assign_var var env stk = match stk with
  hd::tl -> ((var,hd)::env , tl)
| [] -> failwith "Empty Stack"
;;

let pop_var env= match env with
  hd::tl -> tl
| [] -> failwith "Empty Environment"
;;

let func_call stk = match stk with
  (CL (env,opl) )::tl -> (env,opl,tl)
| _ -> failwith "Wrong stack : Invalid function call"
;;

let func_ret dmp = match dmp with
  (env,opl) ::tl -> (env,opl,tl)
| _ -> failwith "Wrong dump : Invalid function return"
;;

let rec find_var var env = match env with
[] -> failwith "Undeclared variable accessed"
| (v,cl)::tl -> if v=var then cl else find_var var tl
;;

let rec interpret_secd oplist env stk dmp = match oplist with
  [] -> stk
| (CONST i) :: tl -> interpret_secd tl env ((VCL i)::stk) dmp
| (ADD ) :: tl -> interpret_secd tl env (add stk) dmp
| (SUB ) :: tl -> interpret_secd tl env (sub stk) dmp
| (LET v) :: tl -> let (new_env,new_stk) = assign_var v env stk in interpret_secd tl new_env new_stk dmp
| (ENDLET ) :: tl -> let new_env = pop_var env in interpret_secd tl new_env stk dmp
| (CLOSURE opl ) :: tl -> interpret_secd tl env (CL (env,opl) ::stk) dmp
| (APPLY ) :: tl -> let new_env,new_opl,new_stk = func_call stk in interpret_secd new_opl new_env new_stk ((env,tl) ::dmp)
| (RETURN ) :: tl -> let new_env,new_opl,new_dmp = func_ret dmp in interpret_secd new_opl new_env stk new_dmp
| (ACCESS v) :: tl -> let cl = find_var v env in interpret_secd tl env (cl::stk) dmp
;;


(*let y = 44;;
let func_call x = x+3+y;;
let y = 99;;
let x = func_call 4;;
x+y;;*)
let y = Var "y";;
let x = Var "x";;
let func_call = Var "func_call";;
let y_44 = [CONST(44);LET(y)];;
let fn_decl = [CLOSURE([LET(x);CONST(3);ACCESS(x);ADD;ACCESS(y);ADD;RETURN]);LET(func_call)];;
let y_99 = [CONST(99);LET(y)];;
let fnc_call = [CONST(4);ACCESS(func_call);APPLY];;
let bind_x = [LET(x)];;
let add_x_y = [ACCESS(x);ACCESS(y);ADD];;
let prog = y_44@fn_decl@y_99@fnc_call@bind_x@add_x_y;;
