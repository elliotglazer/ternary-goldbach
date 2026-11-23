val _ = set_goal ([],``  !u n. ?t. sin u = sum (0,n) (\j. SND (spt_d j 0) / &(FACT j) * u pow j) +
                      (SND (spt_d n t) / &(FACT n)) * u pow n``);
val _ = e (  mp_tac (Q.SPECL [`sin`,`\n x. SND (spt_d n x)`] MCLAURIN_ALL_LE) >> BETA_TAC >>
  impl_tac >- (conj_tac >- simp [spt_d_def,ETA_THM] >>
    rpt gen_tac >> MATCH_ACCEPT_TAC (CONJUNCT2 (SPEC_ALL spt_diff))) >> metis_tac []);
val spt_mclaurin_sin = top_thm ();
print "CHECKED spt_mclaurin_sin\n";
