val _ = set_goal ([],``  !a u n. abs a <= 1 /\ abs u <= 2 ==>
    abs (a / &(FACT n) * u pow n) <= (2:real) pow n / &(FACT n)``);
val _ = e (  rpt gen_tac >> strip_tac >>
  `0 < (&(FACT n):real)` by simp [FACT_LESS] >>
  `(&(FACT n):real) <> 0` by RealField.REAL_ASM_ARITH_TAC >>
  `abs (&(FACT n):real) = &(FACT n)` by simp [abs] >>
  `abs u pow n <= (2:real) pow n` by (match_mp_tac POW_LE >> simp []) >>
  `abs a * abs (u pow n) <= 1 * (2:real) pow n` by
    (match_mp_tac REAL_LE_MUL2 >> ASM_SIMP_TAC (srw_ss()) [GSYM POW_ABS]) >>
  ASM_SIMP_TAC bool_ss [ABS_MUL,ABS_DIV,REAL_MUL_LID] >>
  `abs a / &(FACT n) * abs (u pow n) = (abs a * abs (u pow n)) / &(FACT n)`
    by (REWRITE_TAC [real_div] >> RealField.REAL_ARITH_TAC) >>
  ASM_SIMP_TAC bool_ss [REAL_LE_RDIV_CANCEL] >>
  qpat_x_assum `abs a * _ <= _` mp_tac >> REWRITE_TAC [REAL_MUL_LID]);
val srt_remainder_term = top_thm ();
print "CHECKED srt_remainder_term\n";
