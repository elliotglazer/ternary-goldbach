val _ = set_goal ([],``  !a c:num. !t:real. 0<a /\ 0<c ==>
    (&c:real) * (conj (srb_target c t) * srb_target a t) =
    complex_exp ((~(1/2),~t) * complex_of_real (ln ((&a:real) / &c)))``);
val _ = e (  rpt gen_tac >> strip_tac >> `0 < (&c:real) /\ 0 < (&a:real)` by simp [] >>
  ONCE_REWRITE_TAC [srh_embed_mul] >>
  `complex_of_real (&c:real) = complex_exp (complex_of_real (ln (&c)))` by metis_tac [srh_log_exp] >>
  ASM_SIMP_TAC bool_ss [srb_target_def,srh_conj_exp,GSYM COMPLEX_EXP_ADD,LN_DIV] >> AP_TERM_TAC >>
  REWRITE_TAC [complex_add,complex_mul,conj,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ] >>
  conj_tac >> RealField.REAL_ARITH_TAC);
val srh_target = top_thm ();
print "CHECKED srh_target\n";
