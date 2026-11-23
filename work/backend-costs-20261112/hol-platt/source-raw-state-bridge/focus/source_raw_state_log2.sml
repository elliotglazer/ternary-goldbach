val _ = set_goal ([],``  !x:num. 0<x /\ x<2**19 ==> ?initial. source_raw_initial x = SOME initial /\
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 (logroot$LOG 2 x) x)) j) -
      srb_target x (5 * (&j:real)/64)) < 1 / (2:real) pow 96``);
val _ = e (  rpt strip_tac >> metis_tac [srb_initial_exists,srb_log2_gate,source_raw_state_from_domain]);
val source_raw_state_log2 = top_thm ();
print "CHECKED source_raw_state_log2\n";
