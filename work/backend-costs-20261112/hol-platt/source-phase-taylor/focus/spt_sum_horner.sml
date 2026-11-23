val _ = set_goal ([],``  !n k u (d:num->real). (!j. d (SUC (SUC j)) = ~(d j)) ==>
    sum (k,SUC n) (\j. d j / &(FACT j) * u pow j) =
    u pow k / &(FACT k) * (d k * RE (seh_ideal u n k) + d (SUC k) * IM (seh_ideal u n k))``);
val _ = e (  Induct
  >- (rpt gen_tac >> strip_tac >>
      REWRITE_TAC [spt_sum_head,realTheory.sum,seh_ideal_def,RE,IM,pairTheory.FST,pairTheory.SND] >>
      BETA_TAC >> RealField.REAL_ARITH_TAC) >>
  rpt gen_tac >> strip_tac >>
  first_x_assum (qspecl_then [`SUC k`,`u:real`,`d:num->real`] mp_tac) >>
  ASM_REWRITE_TAC [] >> disch_tac >>
  ONCE_REWRITE_TAC [spt_sum_head] >> BETA_TAC >>
  ASM_REWRITE_TAC [seh_ideal_def,seh_affine_def,RE,IM,pairTheory.FST,pairTheory.SND,FACT,pow,
    GSYM REAL_OF_NUM_MUL,GSYM ADD1] >>
  `0 < (&(SUC k):real) /\ 0 < (&(FACT k):real)` by simp [FACT_LESS] >>
  RealField.REAL_ASM_FIELD_TAC);
val spt_sum_horner = top_thm ();
print "CHECKED spt_sum_horner\n";
