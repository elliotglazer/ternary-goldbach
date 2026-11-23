val _ = set_goal ([],``  !c:num. !U V:int#int. modu (source_pair_value (2**100) (raw_head (&c) U V) -
    (&c:real)*(conj (source_pair_value (2**120) U) * source_pair_value (2**120) V)) <= 1/(2:real) pow 100``);
val _ = e (  rpt gen_tac >> PairCases_on `U` >> PairCases_on `V` >>
  qabbrev_tac `p = (&c:int)*(U0*V0+U1*V1)` >> qabbrev_tac `q = (&c:int)*(U0*V1-U1*V0)` >>
  `0 < (&((2:num)**100):int) /\ 0 < (1393796574908163946345982392040522594123776:int)` by EVAL_TAC >>
  mp_tac (Q.SPECL [`&((2:num)**100):int`,`1393796574908163946345982392040522594123776:int`,`p:int`] round_scaled_coordinate_error) >>
  mp_tac (Q.SPECL [`&((2:num)**100):int`,`1393796574908163946345982392040522594123776:int`,`q:int`] round_scaled_coordinate_error) >>
  ASM_REWRITE_TAC [real_of_int_num,GSYM REAL_OF_NUM_POW] >> rpt strip_tac >>
  `(&c:real)*(conj (source_pair_value (2**120) (U0,U1)) * source_pair_value (2**120) (V0,V1)) =
   (real_of_int p / (1393796574908163946345982392040522594123776 * (2:real) pow 100),
    real_of_int q / (1393796574908163946345982392040522594123776 * (2:real) pow 100))` by
    (REWRITE_TAC [source_pair_value_def,pair_value_def,complex_scalar_lmul,complex_mul,conj,RE,IM,
      pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ,real_of_int_num,GSYM REAL_OF_NUM_POW] >>
     SIMP_TAC bool_ss [Abbr`p`,Abbr`q`,real_of_int_mul,real_of_int_add,real_of_int_sub,real_of_int_num] >>
     conj_tac >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> RealField.REAL_ARITH_TAC) >>
  ASM_REWRITE_TAC [] >>
  mp_tac (Q.SPEC `source_pair_value ((2:num)**100) (raw_head (&c) (U0,U1) (V0,V1)) -
    (real_of_int p / (1393796574908163946345982392040522594123776 * (2:real) pow 100),
     real_of_int q / (1393796574908163946345982392040522594123776 * (2:real) pow 100))` modu_le_coordinate_sum) >>
  REWRITE_TAC [source_pair_value_def,pair_value_def,raw_head_def,complex_sub,complex_add,complex_neg,
    RE,IM,pairTheory.FST,pairTheory.SND,real_of_int_num,GSYM REAL_OF_NUM_POW,GSYM real_sub] >>
  UNABBREV_ALL_TAC >>
  RealField.REAL_ASM_ARITH_TAC);
val srh_rounding = top_thm ();
print "CHECKED srh_rounding\n";
