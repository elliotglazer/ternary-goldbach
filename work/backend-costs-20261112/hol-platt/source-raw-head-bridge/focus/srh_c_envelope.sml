val _ = set_goal ([],``  !n:num. n<=84200 ==> source_error_envelope (1/(2:real) pow 99) (1/2 pow 120) (1/2 pow 120) n <=
     (3/5) / (2:real) pow 98``);
val _ = e (  rpt strip_tac >> mp_tac (Q.SPECL [`1/(2:real) pow 99`,`1/(2:real) pow 120`,`84200:num`] source_envelope_linear_prefix) >>
  impl_tac >- CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> disch_then (qspec_then `n:num` mp_tac) >>
  ASM_REWRITE_TAC [] >> `(&n:real) <= 84200` by simp [] >>
  CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> RealField.REAL_ASM_ARITH_TAC);
val srh_c_envelope = top_thm ();
print "CHECKED srh_c_envelope\n";
