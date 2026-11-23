val _ = set_goal ([],``  !bits g:num. !q:int#int. 0<g ==>
    modu (source_pair_value g (source_regrid bits q) - source_pair_value ((2**bits)*g) q) <= 1/(&g:real)``);
val _ = e (  rpt gen_tac >> strip_tac >> Cases_on `q` >>
  `0 < (&g:int) /\ 0 < (&((2:num)**bits):int)` by simp [EXP_POS] >>
  mp_tac (Q.SPECL [`&g:int`,`&((2:num)**bits):int`,`q:int`] round_scaled_coordinate_error) >>
  mp_tac (Q.SPECL [`&g:int`,`&((2:num)**bits):int`,`r:int`] round_scaled_coordinate_error) >>
  ASM_REWRITE_TAC [real_of_int_num] >> rpt strip_tac >>
  mp_tac (Q.SPEC `source_pair_value g (source_regrid bits (q,r)) -
     source_pair_value (((2:num)**bits)*g) (q,r)` modu_le_coordinate_sum) >>
  REWRITE_TAC [source_pair_value_def,source_regrid_def,pair_value_def,complex_sub,complex_add,
    complex_neg,RE,IM,pairTheory.FST,pairTheory.SND,real_of_int_num,GSYM REAL_OF_NUM_MUL,GSYM real_sub] >>
  `1 / (2 * (&g:real)) + 1 / (2 * &g) = 1 / &g` by
    (`0 < (&g:real)` by simp [] >> RealField.REAL_ASM_FIELD_TAC) >>
  ALL_TAC);
val srs_regrid = top_thm ();
print "CHECKED srs_regrid\n";
