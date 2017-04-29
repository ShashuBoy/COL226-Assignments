let y = 44;;
let func_call = func x -> (x+3+y);;
let y = 99;;
let x = func_call ( 4 );;
x+y;;