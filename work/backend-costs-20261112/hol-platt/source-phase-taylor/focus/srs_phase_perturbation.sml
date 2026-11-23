val _ = set_goal ([],``  !u v. modu ((cos u,sin u) - (cos v,sin v)) <= 2 * abs (u-v)``);
val _ = e (  rpt gen_tac >>
  `abs (cos u-cos v) <= abs (u-v)` by
    (mp_tac (Q.SPECL [`cos`,`\x. ~sin x`] srs_lipschitz) >>
     simp [DIFF_COS,SIN_BOUND]) >>
  `abs (sin u-sin v) <= abs (u-v)` by
    (mp_tac (Q.SPECL [`sin`,`cos`] srs_lipschitz) >> simp [DIFF_SIN,COS_BOUND]) >>
  mp_tac (Q.SPEC `(cos u,sin u) - (cos v,sin v)` modu_le_coordinate_sum) >>
  REWRITE_TAC [complex_sub,complex_add,complex_neg,RE,IM,pairTheory.FST,pairTheory.SND,GSYM real_sub] >>
  RealField.REAL_ASM_ARITH_TAC);
val srs_phase_perturbation = top_thm ();
print "CHECKED srs_phase_perturbation\n";
