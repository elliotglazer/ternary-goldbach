let darithmetic_normalize = DEPTH_CONV (CHANGED_CONV (fun tm ->
  if type_of tm = `:int` then INT_POLY_CONV tm else failwith "not integer"));;
let dround_residual = prove
 (`!s r:int. &0 < s ==>
   --s <= &2 * (r - ((&2*r+s) div (&2*s))*s) /\
   &2 * (r - ((&2*r+s) div (&2*s))*s) < s`,
  REPEAT GEN_TAC THEN DISCH_TAC THEN
  SUBGOAL_THEN `~(&2*s:int = &0)` ASSUME_TAC THENL
    [ASM_INT_ARITH_TAC;ALL_TAC] THEN
  SUBGOAL_THEN `abs (&2*s:int) = &2*s` ASSUME_TAC THENL
    [ASM_INT_ARITH_TAC;ALL_TAC] THEN
  MP_TAC (SPECL [`&2*r+s:int`;`&2*s:int`] INT_DIVISION) THEN
  ASM_REWRITE_TAC [] THEN STRIP_TAC THEN
  RULE_ASSUM_TAC (CONV_RULE darithmetic_normalize) THEN
  CONV_TAC darithmetic_normalize THEN ASM_INT_ARITH_TAC);;
check_axioms ();;
print_string "DEPENDENT_ARITHMETIC_SOUND_DONE\n";;

