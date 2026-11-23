let zadd_decode = prove
 (`Zvalid x /\ Zvalid y ==> Zdecode (Zadd x y) = Zdecode x + Zdecode y`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC (zadd::decode_rules) THEN INT_ARITH_TAC);;
let zsub_decode = prove
 (`Zvalid x /\ Zvalid y ==> Zdecode (Zsub x y) = Zdecode x - Zdecode y`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC (zsub::decode_rules) THEN INT_ARITH_TAC);;
let zmul_decode = prove
 (`Zvalid x /\ Zvalid y ==> Zdecode (Zmul x y) = Zdecode x * Zdecode y`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC (zmul::decode_rules) THEN CONV_TAC INT_RING);;
let zneg_decode = prove
 (`Zvalid x ==> Zdecode (Zneg x) = --Zdecode x`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC (zneg::decode_rules) THEN INT_ARITH_TAC);;
let zlt_pair = prove
 (`Zholds (Zlt (pairc (numc a) (numc b)) (pairc (numc c) (numc d))) <=>
   (&a - &b:int) < &c - &d`,
  REWRITE_TAC [zlt;cexp_fst_def;cexp_snd_def;cexp_add_def;cexp_less_def;
               GSYM INT_OF_NUM_LT;GSYM INT_OF_NUM_ADD] THEN
  COND_CASES_TAC THEN ASM_REWRITE_TAC [zholds_num;NOT_SUC] THEN INT_ARITH_TAC);;
check_axioms ();;
print_string "ENCODING_SOUND_DONE\n";;
