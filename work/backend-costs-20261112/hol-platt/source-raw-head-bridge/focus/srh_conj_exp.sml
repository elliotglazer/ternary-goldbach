val _ = set_goal ([],``  !z:complex. conj (complex_exp z) = complex_exp (conj z)``);
val _ = e (  gen_tac >> Cases_on `z` >> REWRITE_TAC [complex_exp,complex_scalar_lmul,conj,RE,IM,
    pairTheory.FST,pairTheory.SND,COS_NEG,SIN_NEG,REAL_NEG_RMUL]);
val srh_conj_exp = top_thm ();
print "CHECKED srh_conj_exp\n";
