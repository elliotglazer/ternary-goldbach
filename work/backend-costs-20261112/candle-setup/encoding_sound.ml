let zvalid = new_definition
 `Zvalid x <=> ?a b. x = pairc (numc a) (numc b)`;;
let zholds = new_definition `Zholds x <=> ?n. x = numc (SUC n)`;;
let zholds_num = prove
 (`Zholds (numc n) <=> ~(n = 0)`,
  REWRITE_TAC [zholds;injectivity "cval"] THEN MESON_TAC [num_CASES;NOT_SUC]);;
let zholds_pair = prove
 (`~Zholds (pairc p q)`,
  REWRITE_TAC [zholds;distinctness "cval"]);;
let zand_holds = prove
 (`Zholds (Zand p q) <=> Zholds p /\ Zholds q`,
  STRUCT_CASES_TAC (SPEC `p:cval` (cases "cval")) THEN
  REWRITE_TAC [zand;cexp_if_def;zholds_pair] THEN
  STRUCT_CASES_TAC (SPEC `a:num` num_CASES) THEN
  REWRITE_TAC [cexp_if_def;zholds_num;NOT_SUC]);;
let zvalid_pair = prove
 (`Zvalid (pairc (numc a) (numc b))`,
  REWRITE_TAC [zvalid] THEN MESON_TAC []);;
let zadd_valid = prove
 (`Zvalid x /\ Zvalid y ==> Zvalid (Zadd x y)`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC [zadd;cexp_fst_def;cexp_snd_def;cexp_add_def] THEN MESON_TAC []);;
let zsub_valid = prove
 (`Zvalid x /\ Zvalid y ==> Zvalid (Zsub x y)`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC [zsub;cexp_fst_def;cexp_snd_def;cexp_add_def] THEN MESON_TAC []);;
let zmul_valid = prove
 (`Zvalid x /\ Zvalid y ==> Zvalid (Zmul x y)`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC [zmul;cexp_fst_def;cexp_snd_def;cexp_add_def;cexp_mul_def] THEN MESON_TAC []);;
let zneg_valid = prove
 (`Zvalid x ==> Zvalid (Zneg x)`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC [zneg;cexp_fst_def;cexp_snd_def] THEN MESON_TAC []);;
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
  COND_CASES_TAC THEN ASM_REWRITE_TAC [zholds_num;NOT_SUC] THEN ASM_INT_ARITH_TAC);;
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
