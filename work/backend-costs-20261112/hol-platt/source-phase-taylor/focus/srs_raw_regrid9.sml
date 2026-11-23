val _ = set_goal ([],``  !q:int. modu (source_pair_value (2**122) (source_raw_step q) -
    source_pair_value (2**131) (source_exp_horner (2**131) (~5*q) (2**135) 72 0)) <= 1 / (2:real) pow 122``);
val _ = e (  gen_tac >>
  mp_tac (Q.SPECL [`9:num`,`(2:num)**122`,`source_exp_horner (2**131) (~5*q) (2**135) 72 0`] srs_regrid) >>
  `0 < (2:num)**122 /\ (2:num)**9 * 2**122 = 2**131` by EVAL_TAC >>
  ASM_REWRITE_TAC [source_raw_step_def,REAL_OF_NUM_POW]);
val srs_raw_regrid9 = top_thm ();
print "CHECKED srs_raw_regrid9\n";
