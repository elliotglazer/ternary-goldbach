val _ = set_goal ([],``  !x:num. 1<=x /\ x<=10004 ==> ?initial. source_raw_initial x = SOME initial /\
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 (logroot$LOG 2 x) x)) j) -
      complex_exp ((~(1/2),~(5*(&j:real)/64)) * complex_of_real (ln (&x)))) < 1 / (2:real) pow 96``);
val _ = e (  rpt strip_tac >> mp_tac (Q.SPEC `x:num` source_raw_state_log2) >>
  `10004 < (2:num)**19` by EVAL_TAC >>
  `0<x /\ x<2**19` by decide_tac >> ASM_REWRITE_TAC [srb_target_def]);
val c10004_raw_state_error = top_thm ();
print "CHECKED c10004_raw_state_error\n";
