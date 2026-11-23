val _ = set_goal ([],``  !u n. ?t. cos u = sum (0,n) (\j. FST (spt_d j 0) / &(FACT j) * u pow j) +
                      (FST (spt_d n t) / &(FACT n)) * u pow n``);
val _ = e (  mp_tac (Q.SPECL [`cos`,`\n x. FST (spt_d n x)`] MCLAURIN_ALL_LE) >> BETA_TAC >>
  impl_tac >- (conj_tac >- simp [spt_d_def,ETA_THM] >>
    rpt gen_tac >> MATCH_ACCEPT_TAC (CONJUNCT1 (SPEC_ALL spt_diff))) >> metis_tac []);
val spt_mclaurin_cos = top_thm ();
print "CHECKED spt_mclaurin_cos\n";
