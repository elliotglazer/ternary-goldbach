#use "hol.ml";;
let smoke_thm = compute [] `numc 123 * numc 456`;;
Kernel.print_thm smoke_thm;;
print_string "CANDLE_SMOKE_DONE\n";;
