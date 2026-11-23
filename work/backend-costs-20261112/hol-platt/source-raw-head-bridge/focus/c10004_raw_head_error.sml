val _ = set_goal ([],``  !a h:num. 1<=a /\ a<=10004 /\ h<=84200 ==>
    modu (source_pair_value (2**100) (raw_head 10004 (srh_state 10004 h) (srh_state a h)) -
      complex_exp ((~(1/2),~(5*(&h:real)/64))*complex_of_real (ln ((&a:real)/10004)))) < 1/(2:real) pow 85``);
val _ = e (  rpt gen_tac >> strip_tac >> `0<a /\ h<=90000` by decide_tac >>
  `0<(10004:num) /\ 10004 < (2:num)**19` by EVAL_TAC >> `a<2**19` by decide_tac >>
  qabbrev_tac `t = 5*(&h:real)/64` >>
  mp_tac (Q.SPECL [`10004:num`,`srh_state 10004 h`,`srh_state a h`,`srb_target 10004 t`,`srb_target a t`,
    `(3/5)/(2:real) pow 98`,`1/(2:real) pow 96`,`1/(100:real)`] srh_head_error) >>
  impl_tac >- (qunabbrev_tac `t` >> ASM_SIMP_TAC bool_ss [srh_c_state,srh_state_error,srh_cnorm,srh_xnorm]) >>
  ASM_SIMP_TAC bool_ss [srh_target] >>
  `1/(2:real) pow 100 + 10004*((3/5)/2 pow 98*(1+1/2 pow 96) + (1/100)*(1/2 pow 96)) < 1/2 pow 85`
    by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> RealField.REAL_ASM_ARITH_TAC);
val c10004_raw_head_error = top_thm ();
print "CHECKED c10004_raw_head_error\n";
