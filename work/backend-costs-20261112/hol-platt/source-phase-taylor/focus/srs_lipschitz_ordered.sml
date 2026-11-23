val _ = set_goal ([],``  !f fp a b. (!x. (f diffl fp x) x /\ abs (fp x) <= 1) /\ a < b ==>
    abs (f b - f a) <= abs (b-a)``);
val _ = e (  rpt gen_tac >> strip_tac >> mp_tac (Q.SPECL [`f:real->real`,`a:real`,`b:real`] limTheory.MVT) >>
  impl_tac >- (rpt conj_tac >> rpt strip_tac >> metis_tac [DIFF_CONT,differentiable]) >>
  strip_tac >> `l = (fp:real->real) z` by metis_tac [DIFF_UNIQ] >>
  ASM_REWRITE_TAC [ABS_MUL] >>
  mp_tac (Q.SPECL [`abs (b-a)`,`abs ((fp:real->real) z)`,`1:real`] REAL_LE_LMUL_IMP) >>
  `abs ((fp:real->real) z) <= 1` by metis_tac [] >> ASM_SIMP_TAC (srw_ss()) []);
val srs_lipschitz_ordered = top_thm ();
print "CHECKED srs_lipschitz_ordered\n";
