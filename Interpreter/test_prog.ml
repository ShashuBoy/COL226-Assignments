(*let y = 44;;
let func_call = func x -> (x+3+y);;
let y = false;;
if(y=true) then (let x = func_call ( 4 )) else (let x=3) ;;
x+ if(y=false) then (3) else (4);;*)
(*let fact = func x -> (if(x=1) then (1) else (x*(fact(x-1))) );;*)
(*fact(5);;*)

let f1 = func x -> (func y -> (x + y) );;
let f2 = f1 ( 2 );;
let f3 = f1 ( 9 );;