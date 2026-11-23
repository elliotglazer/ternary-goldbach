val _ = set_goal ([],``  !u n. abs u <= 2 ==>
    modu (seh_ideal u n 0 - (cos u,sin u)) <=
    2 * (2:real) pow (SUC n) / &(FACT (SUC n))``);
val _ = e (  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`u:real`,`SUC n`] spt_mclaurin_cos) >>
  REWRITE_TAC [srt_cos_poly] >> disch_then (qx_choose_then `c` assume_tac) >>
  mp_tac (Q.SPECL [`u:real`,`SUC n`] spt_mclaurin_sin) >>
  REWRITE_TAC [srt_sin_poly] >> disch_then (qx_choose_then `s` assume_tac) >>
  `abs (FST (spt_d (SUC n) c)) <= 1 /\ abs (SND (spt_d (SUC n) s)) <= 1`
    by metis_tac [spt_derivative_bound] >>
  `abs (FST (spt_d (SUC n) c) / &(FACT (SUC n)) * u pow (SUC n)) <=
     (2:real) pow (SUC n) / &(FACT (SUC n)) /\
   abs (SND (spt_d (SUC n) s) / &(FACT (SUC n)) * u pow (SUC n)) <=
     (2:real) pow (SUC n) / &(FACT (SUC n))` by metis_tac [srt_remainder_term] >>
  mp_tac (Q.SPEC `seh_ideal u n 0 - (cos u,sin u)` modu_le_coordinate_sum) >>
  REWRITE_TAC [complex_sub,complex_add,complex_neg,RE,IM,pairTheory.FST,pairTheory.SND,GSYM real_sub] >>
  FULL_SIMP_TAC bool_ss [RE,IM,ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC);
val srt_taylor = top_thm ();
print "CHECKED srt_taylor\n";
