val _ = set_goal ([],``  !n:num. n<=84200 ==>
    modu (source_pair_value (2**120) (srh_state 10004 n) - srb_target 10004 (5*(&n:real)/64)) <= (3/5)/(2:real) pow 98``);
val _ = e (  rpt strip_tac >> `0<(10004:num) /\ 10004<2**19` by EVAL_TAC >>
  mp_tac (Q.SPEC `10004:num` srb_initial_exists) >> ASM_REWRITE_TAC [] >> strip_tac >>
  qabbrev_tac `k = logroot$LOG 2 10004` >> qabbrev_tac `theta = ~(5/64)*ln (10004:real)` >>
  `source_log_domain 10004 1 k /\ k<=18` by (qunabbrev_tac `k` >> metis_tac [srb_log2_gate]) >>
  `modu (source_pair_value (2**122) (source_raw_step (source_raw_log129 k 10004)) - (cos theta,sin theta)) <=
    1/(2:real) pow 120` by (qunabbrev_tac `theta` >> metis_tac [source_raw_step_error]) >>
  `0 < (2:num)**120 /\ 0 < (2:num)**122` by EVAL_TAC >>
  `0 <= 1/(2:real) pow 99 /\ 0 <= 1/(2:real) pow 120 /\ 5*(0:real)/64 = 0`
    by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  `modu (source_pair_value (2**120) initial - srb_target 10004 0) <= 1/(2:real) pow 99`
    by metis_tac [srh_c_initial] >>
  `modu (srb_target 10004 0) <= 1` by metis_tac [srh_xnorm] >>
  mp_tac (Q.SPECL [`(2:num)**120`,`(2:num)**122`,`initial:int#int`,
    `source_raw_step (source_raw_log129 k 10004)`,`\j:num. srb_target 10004 (5*(&j:real)/64)`,
    `(cos theta,sin theta)`,`1/(2:real) pow 99`,`1/(2:real) pow 120`] source_state_error_from_initial_and_step) >>
  BETA_TAC >> impl_tac >- (ASM_REWRITE_TAC [MODU_UNIT] >> qunabbrev_tac `theta` >> ASM_SIMP_TAC bool_ss [srb_target_step]) >>
  disch_then (qspec_then `n:num` mp_tac) >>
  ASM_SIMP_TAC bool_ss [srh_state_def,optionTheory.THE_DEF,GSYM REAL_OF_NUM_POW] >>
  mp_tac (Q.SPEC `n:num` srh_c_envelope) >> ASM_REWRITE_TAC [] >>
  qunabbrev_tac `k` >> RealField.REAL_ARITH_TAC);
val srh_c_state = top_thm ();
print "CHECKED srh_c_state\n";
