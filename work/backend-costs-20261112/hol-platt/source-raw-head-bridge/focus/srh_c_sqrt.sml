val _ = set_goal ([],``  abs (3168492865354689069166240814 / (2:real) pow 98 - sqrt (1/10004)) <= 1 / (2:real) pow 99``);
val _ = e (  qabbrev_tac `r = 3168492865354689069166240814 / (2:real) pow 98` >>
  qabbrev_tac `e = 1/(2:real) pow 99` >>
  `0<=r /\ 0<=r+e /\ 0<=r pow 2 /\ 0<=1/(10004:real) /\ r pow 2 <= 1/10004 /\ 1/10004 <= (r+e) pow 2` by
    (UNABBREV_ALL_TAC >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `sqrt (r pow 2) <= sqrt (1/(10004:real)) /\ sqrt (1/(10004:real)) <= sqrt ((r+e) pow 2)`
    by metis_tac [SQRT_MONO_LE] >>
  `abs r = r /\ abs (r+e) = r+e` by metis_tac [ABS_REFL] >>
  FULL_SIMP_TAC bool_ss [SQRT_POW_2_ABS,ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC);
val srh_c_sqrt = top_thm ();
print "CHECKED srh_c_sqrt\n";
