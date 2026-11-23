val _ = set_goal ([],``  !x t. 0<x ==> modu (srb_target x t) <= 1``);
val _ = e (  rpt strip_tac >> `1<=x` by decide_tac >>
  mp_tac (Q.SPECL [`x:num`,`1:num`] source_amplitude_norm) >>
  asm_simp_tac (srw_ss()) [srh_amplitude_norm,MODU_REAL,abs,SQRT_POS_LE,REAL_LE_DIV]);
val srh_xnorm = top_thm ();
print "CHECKED srh_xnorm\n";
