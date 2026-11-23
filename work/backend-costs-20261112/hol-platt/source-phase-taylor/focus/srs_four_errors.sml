val _ = set_goal ([],``  !a b c d e:complex. !w x y z:real.
    modu (a-b) <= w /\ modu (b-c) <= x /\ modu (c-d) <= y /\ modu (d-e) <= z ==>
    modu (a-e) <= w+x+y+z``);
val _ = e (  rpt gen_tac >> strip_tac >> mp_tac (Q.SPECL [`a:complex`,`b:complex`,`e:complex`] ss_modu_sub_triangle) >>
  mp_tac (Q.SPECL [`b:complex`,`c:complex`,`e:complex`] ss_modu_sub_triangle) >>
  mp_tac (Q.SPECL [`c:complex`,`d:complex`,`e:complex`] ss_modu_sub_triangle) >> RealField.REAL_ASM_ARITH_TAC);
val srs_four_errors = top_thm ();
print "CHECKED srs_four_errors\n";
