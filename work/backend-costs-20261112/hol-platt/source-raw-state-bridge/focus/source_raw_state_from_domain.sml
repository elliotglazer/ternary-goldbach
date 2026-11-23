val _ = set_goal ([],``  !k x initial. source_log_domain x 1 k /\ k <= 18 /\ source_raw_initial x = SOME initial ==>
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 k x)) j) -
      srb_target x (5 * (&j:real)/64)) < 1 / (2:real) pow 96``);
val _ = e (  rpt gen_tac >> strip_tac >> `0<x` by (drule slr_domain_bounds >> strip_tac >> ASM_REWRITE_TAC []) >>
  mp_tac (Q.SPECL [`x:num`,`1:num`,`98:num`,`120:num`,`initial:int#int`] source_initial_accuracy) >>
  ASM_REWRITE_TAC [GSYM source_raw_initial_def] >> strip_tac >>
  mp_tac (Q.SPECL [`initial:int#int`,`source_raw_step (source_raw_log129 k x)`,
    `\n:num. srb_target x (5*(&n:real)/64)`,
    `(cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))`] source_raw_state_error_lt_dyadic96) >>
  BETA_TAC >> `5*(0:real)/64 = 0` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  ASM_SIMP_TAC bool_ss [srb_target_zero,srb_target_step,MODU_UNIT,source_raw_step_error] >>
  metis_tac [REAL_LT_IMP_LE]);
val source_raw_state_from_domain = top_thm ();
print "CHECKED source_raw_state_from_domain\n";
