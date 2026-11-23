val _ = set_goal ([],``  !q:int. abs (real_of_int (~5*q) / (&((2:num)**135):real)) <= 2 ==>
    modu (source_pair_value (2**131) (source_exp_horner (2**131) (~5*q) (2**135) 72 0) -
      seh_ideal (real_of_int (~5*q) / (&((2:num)**135):real)) 72 0) <= 9 / (2:real) pow 131``);
val _ = e (  rpt strip_tac >>
  `0 < (2:num)**135 /\ 0 < (2:num)**131` by EVAL_TAC >>
  mp_tac (Q.SPECL [`(2:num)**131`,`(2:num)**135`,`~5*q:int`] source_exp_horner_zero_error) >>
  ASM_REWRITE_TAC [] >> disch_then (qspec_then `72:num` assume_tac) >>
  REWRITE_TAC [REAL_OF_NUM_POW] >> match_mp_tac srs_normalize >> ASM_REWRITE_TAC []);
val srs_raw_horner72 = top_thm ();
print "CHECKED srs_raw_horner72\n";
