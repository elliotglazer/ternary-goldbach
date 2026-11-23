val _ = set_goal ([],``  !t. modu (srb_target 10004 t) <= 1/100``);
val _ = e (  gen_tac >> `0<(10004:num)` by EVAL_TAC >> ASM_SIMP_TAC bool_ss [srh_amplitude_norm] >>
  `sqrt ((1:real)/10000) = 1/100` by
     (match_mp_tac SQRT_POS_UNIQ >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `0 <= 1/(10004:real) /\ 1/(10004:real) <= 1/10000` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  metis_tac [SQRT_MONO_LE]);
val srh_cnorm = top_thm ();
print "CHECKED srh_cnorm\n";
