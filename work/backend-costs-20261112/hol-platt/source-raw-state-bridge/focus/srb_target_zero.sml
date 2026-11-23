val _ = set_goal ([],``  !x. 0<x ==> srb_target x 0 = complex_of_real (sqrt (1/(&x:real)))``);
val _ = e (  rpt strip_tac >> ASM_SIMP_TAC bool_ss [srb_target_components,REAL_MUL_LZERO,REAL_NEG_0,COS_0,SIN_0,
    GSYM complex_of_real,GSYM COMPLEX_1,COMPLEX_MUL_RID]);
val srb_target_zero = top_thm ();
print "CHECKED srb_target_zero\n";
