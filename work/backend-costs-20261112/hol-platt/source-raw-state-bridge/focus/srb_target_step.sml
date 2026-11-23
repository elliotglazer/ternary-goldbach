val _ = set_goal ([],``  !x n. 0<x ==> srb_target x (5 * (&(SUC n):real)/64) =
    srb_target x (5 * (&n:real)/64) * (cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))``);
val _ = e (  rpt strip_tac >>
  `~((5 * (&(SUC n):real)/64) * ln (&x)) =
     ~((5 * (&n:real)/64) * ln (&x)) + ~(5/64)*ln (&x)` by
    (REWRITE_TAC [GSYM REAL_OF_NUM_SUC] >> RealField.REAL_ARITH_TAC) >>
  ASM_SIMP_TAC bool_ss [srb_target_components,GSYM COMPLEX_MUL_ASSOC,COMPLEX_MUL_ARG]);
val srb_target_step = top_thm ();
print "CHECKED srb_target_step\n";
