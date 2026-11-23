val _ = set_goal ([],``  !u. source_raw_initial 10004 = SOME u ==>
    modu (source_pair_value (2**120) u - srb_target 10004 0) <= 1 / (2:real) pow 99``);
val _ = e (  rpt strip_tac >> mp_tac (Q.SPECL [`10004:num`,`1:num`,`98:num`,`120:num`,`u:int#int`] source_initial_value) >>
  ASM_REWRITE_TAC [GSYM source_raw_initial_def,srh_c_root] >> strip_tac >>
  `0<(10004:num)` by EVAL_TAC >>
  ASM_SIMP_TAC bool_ss [srb_target_zero,COMPLEX_OF_REAL_SUB,MODU_REAL,srh_c_sqrt]);
val srh_c_initial = top_thm ();
print "CHECKED srh_c_initial\n";
