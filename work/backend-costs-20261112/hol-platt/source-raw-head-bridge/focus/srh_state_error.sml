val _ = set_goal ([],``  !x n:num. 0<x /\ x<2**19 /\ n<=90000 ==>
    modu (source_pair_value (2**120) (srh_state x n) - srb_target x (5*(&n:real)/64)) <= 1/(2:real) pow 96``);
val _ = e (  rpt strip_tac >> mp_tac (Q.SPEC `x:num` source_raw_state_log2) >> ASM_REWRITE_TAC [] >> strip_tac >>
  ASM_REWRITE_TAC [srh_state_def,optionTheory.THE_DEF] >> metis_tac [REAL_LT_IMP_LE]);
val srh_state_error = top_thm ();
print "CHECKED srh_state_error\n";
