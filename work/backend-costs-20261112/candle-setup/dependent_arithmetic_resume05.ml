let dround_residual = prove
 (`!s r:int. &0 < s ==>
   --s <= &2 * (r - ((&2*r+s) div (&2*s))*s) /\
   &2 * (r - ((&2*r+s) div (&2*s))*s) < s`,
  REPEAT GEN_TAC THEN DISCH_TAC THEN
  SUBGOAL_THEN `~(&2*s:int = &0)` ASSUME_TAC THENL
    [ASM_INT_ARITH_TAC;ALL_TAC] THEN
  MP_TAC (SPECL [`&2*r+s:int`;`&2*s:int`] INT_DIVISION) THEN
  ASM_SIMP_TAC [INT_ABS_REFL;INT_ARITH `&0 < s ==> &0 <= &2*s`] THEN
  INT_ARITH_TAC);;
check_axioms ();;
print_string "DEPENDENT_ARITHMETIC_SOUND_DONE\n";;

