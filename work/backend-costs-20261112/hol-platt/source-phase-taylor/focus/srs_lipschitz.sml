val _ = set_goal ([],``  !f fp. (!x. (f diffl fp x) x /\ abs (fp x) <= 1) ==>
    !a b. abs (f b - f a) <= abs (b-a)``);
val _ = e (  rpt gen_tac >> strip_tac >> rpt gen_tac >> Cases_on `a=b` >- simp [] >>
  Cases_on `a<b` >- metis_tac [srs_lipschitz_ordered] >>
  `b<a` by RealField.REAL_ASM_ARITH_TAC >>
  mp_tac (Q.SPECL [`f:real->real`,`fp:real->real`,`b:real`,`a:real`] srs_lipschitz_ordered) >>
  ASM_REWRITE_TAC [] >> ONCE_REWRITE_TAC [ABS_SUB] >> metis_tac [ABS_SUB]);
val srs_lipschitz = top_thm ();
print "CHECKED srs_lipschitz\n";
