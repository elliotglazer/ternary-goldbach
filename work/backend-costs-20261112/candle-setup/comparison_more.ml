let zle_pair = prove
 (`Zholds (Zle (pairc (numc a) (numc b)) (pairc (numc c) (numc d))) <=>
   (&a - &b:int) <= &c - &d`,
  REWRITE_TAC [zle;cexp_fst_def;cexp_snd_def;cexp_add_def;cexp_less_def;
               GSYM INT_OF_NUM_LT;GSYM INT_OF_NUM_ADD] THEN
  COND_CASES_TAC THEN ASM_REWRITE_TAC [cexp_if_def;zholds_num;NOT_SUC;ARITH] THEN
  ASM_INT_ARITH_TAC);;
let zeq_pair = prove
 (`Zholds (Zeq (pairc (numc a) (numc b)) (pairc (numc c) (numc d))) <=>
   (&a - &b:int) = &c - &d`,
  REWRITE_TAC [zeq;cexp_fst_def;cexp_snd_def;cexp_add_def;cexp_eq_def;
               injectivity "cval";GSYM INT_OF_NUM_EQ;GSYM INT_OF_NUM_ADD] THEN
  COND_CASES_TAC THEN ASM_REWRITE_TAC [zholds_num;NOT_SUC] THEN ASM_INT_ARITH_TAC);;
let zlt_decode = prove
 (`Zvalid x /\ Zvalid y ==> (Zholds (Zlt x y) <=> Zdecode x < Zdecode y)`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC (zlt_pair::decode_rules));;
let zle_decode = prove
 (`Zvalid x /\ Zvalid y ==> (Zholds (Zle x y) <=> Zdecode x <= Zdecode y)`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC (zle_pair::decode_rules));;
let zeq_decode = prove
 (`Zvalid x /\ Zvalid y ==> (Zholds (Zeq x y) <=> Zdecode x = Zdecode y)`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC (zeq_pair::decode_rules));;
let zwithin_decode = prove
 (`Zvalid b /\ Zvalid x ==>
   (Zholds (Zwithin b x) <=> --Zdecode b <= Zdecode x /\ Zdecode x <= Zdecode b)`,
  STRIP_TAC THEN ASM_SIMP_TAC [zwithin;zand_holds;zle_decode;zneg_decode;zneg_valid]);;
check_axioms ();;
print_string "ENCODING_SOUND_DONE\n";;
