(*let y = 44;;
let func_call = func x -> (x+3+y);;
let y = false;;
if(y=true) then (let x = func_call ( 4 )) else (let x=3) ;;
x+ if(y=false) then (3) else (4);;*)
let rec_call = func x -> (if(x=1) then (1) else (x*(rec_call(x-1))) );;
rec_call(5);;