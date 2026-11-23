let ddiv_pair = prove
 (`Ddiv (pairc (numc a) (numc b)) (numc n) =
   if a < b then
     pairc (numc 0) (numc ((b-a) DIV n +
       (if (b-a) MOD n = 0 then 0 else 1)))
   else pairc (numc ((a-b) DIV n)) (numc 0)`,
  REWRITE_TAC [ddiv;LET_DEF;LET_END_DEF;cexp_fst_def;cexp_snd_def;
    cexp_sub_def;cexp_div_def;cexp_mod_def;cexp_less_def;
    cexp_eq_def;injectivity "cval"] THEN
  REPEAT COND_CASES_TAC THEN
  ASM_REWRITE_TAC [cexp_if_def;cexp_add_def;ONE] THEN ASM_MESON_TAC []);;
let ddiv_valid = prove
 (`Zvalid x ==> Zvalid (Ddiv x (numc n))`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC [ddiv_pair] THEN COND_CASES_TAC THEN MESON_TAC []);;
let ddiv_pair_decode = prove
 (`0 < n ==> Zdecode (Ddiv (pairc (numc a) (numc b)) (numc n)) =
     (&a - &b) div &n`,
  DISCH_TAC THEN REWRITE_TAC [ddiv_pair] THEN COND_CASES_TAC THENL
  [SUBGOAL_THEN `(&a - &b:int) = -- &(b-a)` SUBST1_TAC THENL
    [ASM_SIMP_TAC [GSYM INT_OF_NUM_SUB;ARITH_RULE `a < b ==> a <= b`] THEN
     INT_ARITH_TAC; ALL_TAC] THEN
   ASM_REWRITE_TAC (INT_DIV_LNEG::INT_OF_NUM_DIV::INT_OF_NUM_REM::
     INT_OF_NUM_EQ::INT_SGN::INT_OF_NUM_LT::decode_rules) THEN
   REPEAT COND_CASES_TAC THEN ASM_REWRITE_TAC [GSYM INT_OF_NUM_ADD] THEN
   ASM_INT_ARITH_TAC;
   SUBGOAL_THEN `(&a - &b:int) = &(a-b)` SUBST1_TAC THENL
    [ASM_SIMP_TAC [GSYM INT_OF_NUM_SUB;ARITH_RULE `~(a < b) ==> b <= a`];
     REWRITE_TAC (INT_OF_NUM_DIV::decode_rules) THEN INT_ARITH_TAC]]);;
let ddiv_decode = prove
 (`Zvalid x /\ 0 < n ==> Zdecode (Ddiv x (numc n)) = Zdecode x div &n`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_REWRITE_TAC decode_rules THEN ASM_SIMP_TAC [ddiv_pair_decode]);;

let dround = new_definition
 `Dround s r = Ddiv
    (Zadd (Zmul (pairc (numc 2) (numc 0)) r) (pairc s (numc 0)))
    ((numc 2) * s)`;;
let dround_valid = prove
 (`Zvalid r ==> Zvalid (Dround (numc n) r)`,
  STRIP_TAC THEN REWRITE_TAC [dround;cexp_mul_def] THEN
  MATCH_MP_TAC ddiv_valid THEN
  ASM_SIMP_TAC [zadd_valid;zmul_valid;zvalid_pair]);;
let dround_decode = prove
 (`Zvalid r /\ 0 < n ==>
   Zdecode (Dround (numc n) r) =
     (&2 * Zdecode r + &n) div (&2 * &n)`,
  STRIP_TAC THEN REWRITE_TAC [dround;cexp_mul_def] THEN
  ASM_SIMP_TAC [ddiv_decode;zadd_valid;zmul_valid;zvalid_pair;
    zadd_decode;zmul_decode;ARITH_RULE `0 < n ==> 0 < 2*n`] THEN
  REWRITE_TAC decode_rules THEN REWRITE_TAC [INT_SUB_RZERO]);;

let dround_residual = prove
 (`!s r:int. &0 < s ==>
   --s <= &2 * (r - ((&2*r+s) div (&2*s))*s) /\
   &2 * (r - ((&2*r+s) div (&2*s))*s) < s`,
  REPEAT GEN_TAC THEN DISCH_TAC THEN
  SUBGOAL_THEN `~(&2*s:int = &0)` ASSUME_TAC THENL
    [ASM_INT_ARITH_TAC;ALL_TAC] THEN
  MP_TAC (SPEC `&2*r+s:int`
    (MATCH_MP (SPEC `&2*s:int` INT_DIVISION)
      (ASSUME `~(&2*s:int = &0)`))) THEN
  ASM_SIMP_TAC [INT_ABS_REFL;INT_ARITH `&0 < s ==> &0 <= &2*s`] THEN
  INT_ARITH_TAC);;
check_axioms ();;
print_string "DEPENDENT_ARITHMETIC_SOUND_DONE\n";;

