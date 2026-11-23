val _ = set_goal ([],``  !n x. ((\y. FST (spt_d n y)) diffl FST (spt_d (SUC n) x)) x /\
        ((\y. SND (spt_d n y)) diffl SND (spt_d (SUC n) x)) x``);
val _ = e (  Induct
  >- simp [spt_d_def,ETA_THM,DIFF_COS,DIFF_SIN] >>
  gen_tac >> first_x_assum (qspec_then `x:real` mp_tac) >>
  REWRITE_TAC [spt_d_def,pairTheory.FST,pairTheory.SND] >> strip_tac >> conj_tac
  >- (mp_tac (Q.SPECL [`\y. SND (spt_d n y)`,`FST (spt_d n x)`,`x:real`] DIFF_NEG) >>
      BETA_TAC >> ASM_REWRITE_TAC []) >> ASM_REWRITE_TAC []);
val spt_diff = top_thm ();
print "CHECKED spt_diff\n";
