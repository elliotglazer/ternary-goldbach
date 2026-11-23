val _ = set_goal ([],``  !k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    modu (source_pair_value (2**122) (source_raw_step (source_raw_log129 k x)) -
      (cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))) <= 1 / (2:real) pow 120``);
val _ = e (  rpt gen_tac >> strip_tac >>
  qabbrev_tac `q = source_raw_log129 k x` >>
  qabbrev_tac `u = real_of_int (~5*q) / (&((2:num)**135):real)` >>
  qabbrev_tac `theta = ~(5/64)*ln (&x:real)` >>
  `abs u <= 2 /\ abs (u-theta) <= (5/64)*(1/(2:real) pow 128)` by
    (UNABBREV_ALL_TAC >> metis_tac [source_raw_phase_range,source_raw_phase_error]) >>
  `modu ((cos u,sin u)-(cos theta,sin theta)) <= 2*((5/64)*(1/(2:real) pow 128))` by
    (mp_tac (Q.SPECL [`u:real`,`theta:real`] srs_phase_perturbation) >> RealField.REAL_ASM_ARITH_TAC) >>
  match_mp_tac REAL_LE_TRANS >> qexists_tac `1/(2:real) pow 122 + 9/2 pow 131 +
    2 pow 74 / &(FACT 73) + 2*((5/64)*(1/2 pow 128))` >> REWRITE_TAC [srs_raw_budget] >>
  mp_tac (Q.SPECL [`source_pair_value (2**122) (source_raw_step q)`,
    `source_pair_value (2**131) (source_exp_horner (2**131) (~5*q) (2**135) 72 0)`,
    `seh_ideal u 72 0`,`(cos u,sin u)`,`(cos theta,sin theta)`,
    `1/(2:real) pow 122`,`9/(2:real) pow 131`,`(2:real) pow 74 / &(FACT 73)`,
    `2*((5/64)*(1/(2:real) pow 128))`] srs_four_errors) >>
  impl_tac >- (rpt conj_tac >- MATCH_ACCEPT_TAC srs_raw_regrid9
    >- (qunabbrev_tac `u` >> match_mp_tac srs_raw_horner72 >> ASM_REWRITE_TAC [])
    >- (match_mp_tac source_raw_taylor72_error >> ASM_REWRITE_TAC []) >> ASM_REWRITE_TAC []) >>
  ASM_REWRITE_TAC []);
val source_raw_step_error = top_thm ();
print "CHECKED source_raw_step_error\n";
