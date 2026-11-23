(* The kernel's S-expression printer expands deep binary numerals. Express
   large numerals by balanced arithmetic trees, proving every equality before
   changing the theorem. This changes no kernel function or logical axiom. *)
let rec export_bitlength n =
  if eq_num n (Num.num_of_int 0) then 0
  else 1 + export_bitlength (quo_num n (Num.num_of_int 2));;
let export_binop op l r = mk_comb (mk_comb (op,l),r);;
let rec export_numeral_term n =
  if lt_num n (Num.num_of_int 65536) then mk_numeral n else
  let k = export_bitlength n / 2 in
  let divisor = power_num (Num.num_of_int 2) (Num.num_of_int k) in
  let hi = export_numeral_term (quo_num n divisor) in
  let lo = export_numeral_term (mod_num n divisor) in
  let pow = export_binop (mk_const ("EXP",[]))
    (mk_numeral (Num.num_of_int 2)) (mk_numeral (Num.num_of_int k)) in
  export_binop (mk_const ("+",[]))
    (export_binop (mk_const ("*",[])) hi pow) lo;;
let export_numeral_conv tm =
  let n = dest_numeral tm in
  if lt_num n (Num.num_of_int 65536) then failwith "small export numeral" else
  let th = NUM_REDUCE_CONV (export_numeral_term n) in
  if rand (concl th) = tm then SYM th
  else failwith "export numeral mismatch";;
bench_mark "compact_conclusion_start";;
let compact_residual_fixture =
  CONV_RULE (ONCE_DEPTH_CONV export_numeral_conv) certified_residual_fixture;;
bench_mark "compact_conclusion_end";;
let rec export_has_large_numeral tm =
  if is_numeral tm then ge_num (dest_numeral tm) (Num.num_of_int 65536)
  else if is_comb tm then
    export_has_large_numeral (rator tm) || export_has_large_numeral (rand tm)
  else if is_abs tm then export_has_large_numeral (snd (dest_abs tm))
  else false;;
let _ = if concl compact_residual_fixture = concl certified_residual_fixture
  then failwith "compact conversion did not change the conclusion" else ();;
let _ = if export_has_large_numeral (concl compact_residual_fixture)
  then failwith "large export numeral remains" else ();;
let _ = if hyp compact_residual_fixture = [] then ()
  else failwith "open compact theorem";;
check_axioms ();;
print_string "COMPACT_PROOF_DONE\n";;
bench_mark "compact_export_start";;
Kernel.print_thm compact_residual_fixture;;
bench_mark "compact_export_end";;
print_string "COMPACT_EXPORT_DONE\n";;
