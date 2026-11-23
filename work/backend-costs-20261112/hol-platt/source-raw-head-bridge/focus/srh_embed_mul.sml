val _ = set_goal ([],``  !x:real. !z:complex. x*z = complex_of_real x * z``);
val _ = e (  rpt gen_tac >> REWRITE_TAC [complex_scalar_lmul,complex_mul,complex_of_real,RE,IM,
    pairTheory.FST,pairTheory.SND,REAL_MUL_LZERO,REAL_ADD_RID,REAL_ADD_LID,REAL_SUB_RZERO]);
val srh_embed_mul = top_thm ();
print "CHECKED srh_embed_mul\n";
