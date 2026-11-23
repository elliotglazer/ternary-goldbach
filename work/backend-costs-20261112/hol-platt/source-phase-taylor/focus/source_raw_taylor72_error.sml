val _ = set_goal ([],``  !u. abs u <= 2 ==> modu (seh_ideal u 72 0 - (cos u,sin u)) <= (2:real) pow 74 / &(FACT 73)``);
val _ = e (  rpt strip_tac >> mp_tac (Q.SPECL [`u:real`,`72:num`] srt_taylor) >>
  `SUC 72 = 73` by EVAL_TAC >>
  `2 * (2:real) pow 73 = (2:real) pow 74` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  ASM_REWRITE_TAC []);
val source_raw_taylor72_error = top_thm ();
print "CHECKED source_raw_taylor72_error\n";
