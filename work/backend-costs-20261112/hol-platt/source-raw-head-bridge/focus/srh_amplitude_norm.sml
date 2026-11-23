val _ = set_goal ([],``  !x t. 0<x ==> modu (srb_target x t) = sqrt (1/(&x:real))``);
val _ = e (  rpt strip_tac >> `0 <= 1/(&x:real)` by simp [REAL_LE_DIV] >>
  `0 <= sqrt (1/(&x:real))` by metis_tac [SQRT_POS_LE] >>
  ASM_SIMP_TAC bool_ss [srb_target_components,MODU_MUL,MODU_UNIT,REAL_MUL_RID,MODU_REAL,ABS_REFL]);
val srh_amplitude_norm = top_thm ();
print "CHECKED srh_amplitude_norm\n";
