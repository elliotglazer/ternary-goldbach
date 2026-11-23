let ddiv_decode = prove
 (`Zvalid x /\ 0 < n ==> Zdecode (Ddiv x (numc n)) = Zdecode x div &n`,
  REWRITE_TAC [zvalid] THEN REPEAT STRIP_TAC THEN
  ASM_SIMP_TAC [ddiv_pair_decode] THEN REWRITE_TAC decode_rules);;

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

