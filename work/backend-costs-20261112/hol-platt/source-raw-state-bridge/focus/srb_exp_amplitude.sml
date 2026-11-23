val _ = set_goal ([],``  !x:real. 0<x ==> exp (~(ln x/2)) = sqrt (1/x)``);
val _ = e (  rpt strip_tac >> CONV_TAC SYM_CONV >> match_mp_tac SQRT_POS_UNIQ >>
  `0 <= 1/x` by simp [REAL_LE_DIV,REAL_LT_IMP_LE] >>
  `0 <= exp (~(ln x/2))` by simp [EXP_POS_LE] >>
  `~(ln x/2) + ~(ln x/2) = ~ln x` by RealField.REAL_ARITH_TAC >>
  ASM_REWRITE_TAC [] >> REWRITE_TAC [POW_2,GSYM transcTheory.EXP_ADD] >> ASM_REWRITE_TAC [] >>
  `exp (ln x) = x` by ASM_REWRITE_TAC [transcTheory.EXP_LN] >>
  ASM_REWRITE_TAC [EXP_NEG,real_div,REAL_MUL_LID]);
val srb_exp_amplitude = top_thm ();
print "CHECKED srb_exp_amplitude\n";
