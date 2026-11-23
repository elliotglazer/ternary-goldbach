val _ = set_goal ([],``  !c:real. 0<c ==> complex_of_real c = complex_exp (complex_of_real (ln c))``);
val _ = e (  rpt strip_tac >> `exp (ln c) = c` by ASM_REWRITE_TAC [transcTheory.EXP_LN] >>
  ASM_REWRITE_TAC [complex_exp,complex_scalar_lmul,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,
    SIN_0,COS_0,REAL_MUL_RID,REAL_MUL_RZERO]);
val srh_log_exp = top_thm ();
print "CHECKED srh_log_exp\n";
