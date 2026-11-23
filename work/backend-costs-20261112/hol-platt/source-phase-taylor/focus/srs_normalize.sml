val _ = set_goal ([],``  !g:num. !q:int#int. !v:complex. !eps:real. 0 < g /\
    modu (pair_value 1 q - (&g:real)*v) <= eps ==>
    modu (source_pair_value g q - v) <= eps / &g``);
val _ = e (  rpt gen_tac >> strip_tac >>
  `0 < (&g:real)` by simp [] >>
  `source_pair_value g q - v = (1/(&g:real)) * (pair_value 1 q - (&g:real)*v)` by
    (Cases_on `q` >> Cases_on `v` >>
     REWRITE_TAC [source_pair_value_def,pair_value_def,complex_sub,complex_add,complex_neg,
       complex_scalar_lmul,RE,IM,pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ,real_of_int_num,REAL_OVER1] >>
     conj_tac >> RealField.REAL_ASM_FIELD_TAC) >>
  `0 <= 1/(&g:real)` by simp [REAL_LE_DIV,REAL_LT_IMP_LE] >>
  `abs (1/(&g:real)) = (1:real)/ &g` by metis_tac [ABS_REFL] >>
  ASM_REWRITE_TAC [MODU_SCALAR_LMUL] >>
  `eps/(&g:real) = ((1:real)/ &g)*eps` by (REWRITE_TAC [real_div] >> RealField.REAL_ARITH_TAC) >>
  ASM_REWRITE_TAC [] >> match_mp_tac REAL_LE_LMUL_IMP >> ASM_REWRITE_TAC []);
val srs_normalize = top_thm ();
print "CHECKED srs_normalize\n";
