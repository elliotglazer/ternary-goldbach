val _ = set_goal ([],``  !x:num. 0<x /\ x<2**19 ==> source_log_domain x 1 (logroot$LOG 2 x) /\ logroot$LOG 2 x <= 18``);
val _ = e (  gen_tac >> strip_tac >> mp_tac (Q.SPEC `x:num` LOG2_PROPERTY) >> ASM_REWRITE_TAC [] >> strip_tac >>
  conj_tac >- (fs [source_log_domain_def,EXP] >> metis_tac [LESS_IMP_LESS_OR_EQ]) >>
  `(2:num) ** (logroot$LOG 2 x) < 2**19` by
    (match_mp_tac LESS_EQ_LESS_TRANS >> qexists_tac `x:num` >> ASM_REWRITE_TAC []) >>
  `logroot$LOG 2 x < 19` by metis_tac [EXP_BASE_LT_MONO,DECIDE ``(1:num)<2``] >> decide_tac);
val srb_log2_gate = top_thm ();
print "CHECKED srb_log2_gate\n";
