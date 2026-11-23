val _ = set_goal ([],``  !x t. 0<x ==> srb_target x t = complex_of_real (sqrt (1/(&x:real))) *
    (cos (~(t*ln (&x))),sin (~(t*ln (&x))))``);
val _ = e (  rpt strip_tac >> `0 < (&x:real)` by simp [] >>
  `(~(1/2),~t) * complex_of_real (ln (&x)) = (~(ln (&x)/2),~(t*ln (&x)))` by
    (REWRITE_TAC [complex_mul,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ] >>
     conj_tac >> RealField.REAL_ARITH_TAC) >>
  ASM_SIMP_TAC bool_ss [srb_target_def,complex_exp,RE,IM,pairTheory.FST,pairTheory.SND,srb_exp_amplitude] >>
  REWRITE_TAC [complex_scalar_lmul,complex_mul,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,
    REAL_MUL_LZERO,REAL_SUB_RZERO,REAL_ADD_LID,REAL_ADD_RID]);
val srb_target_components = top_thm ();
print "CHECKED srb_target_components\n";
