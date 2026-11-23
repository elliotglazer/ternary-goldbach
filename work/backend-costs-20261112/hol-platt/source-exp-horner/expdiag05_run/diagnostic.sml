fun checked name expected tactic =
  ((set_goal ([],expected); e tactic;
    let val th = top_thm ()
    in if null (hyp th) andalso aconv (concl th) expected
       then (print ("EXP_HORNER_DIAGNOSTIC_PASS," ^ name ^ "\n"); th)
       else raise Fail (name ^ ": root mismatch") end)
   handle ex => (print ("EXP_HORNER_DIAGNOSTIC_FAIL," ^ name ^ "," ^ General.exnMessage ex ^ "\n");
                 OS.Process.exit OS.Process.failure));
val seh_round_pair_error = checked "seh_round_pair_error" ``!s r t:int. 0 < s ==>
    modu (pair_value 1 (round_scaled s r,round_scaled s t) - pair_value s (r,t)) <= 1`` (
  rpt gen_tac >> strip_tac >>
  `abs (real_of_int (round_scaled s r)-real_of_int r/real_of_int s) <= 1/2 /\
   abs (real_of_int (round_scaled s t)-real_of_int t/real_of_int s) <= 1/2`
    by metis_tac [round_scaled_real_error] >>
  mp_tac (Q.SPEC `pair_value 1 (round_scaled s r,round_scaled s t) - pair_value s (r,t)`
    modu_le_coordinate_sum) >>
  REWRITE_TAC [pair_value_def,real_of_int_num,REAL_OVER1,complex_sub,complex_add,complex_neg,
    RE,IM,pairTheory.FST,pairTheory.SND,GSYM real_sub] >>
  RealField.REAL_ASM_ARITH_TAC
);
val seh_affine_distance = checked "seh_affine_distance" ``!a t:real. !u v:complex.
    modu (seh_affine a t u-seh_affine a t v) = abs t * modu (u-v)`` (
  rpt gen_tac >>
  `seh_affine a t u-seh_affine a t v = t * (i * (u-v))` by
    (REWRITE_TAC [seh_affine_def,COMPLEX_RE_IM_EQ,complex_sub,complex_add,complex_neg,
      complex_mul,complex_scalar_lmul,i,RE,IM,pairTheory.FST,pairTheory.SND] >>
     conj_tac >> RealField.REAL_ARITH_TAC) >>
  `modu i = 1` by
    REWRITE_TAC [modu,i,RE,IM,POW_2,REAL_MUL_LZERO,REAL_MUL_LID,REAL_ADD_LID,SQRT_1] >>
  ASM_REWRITE_TAC [MODU_SCALAR_LMUL,MODU_MUL,REAL_MUL_LID]
);
val seh_affine_scale = checked "seh_affine_scale" ``!a t:real. !z:complex. seh_affine a t (a*z) = a * seh_affine 1 t z`` (
  rpt gen_tac >>
  REWRITE_TAC [seh_affine_def,COMPLEX_RE_IM_EQ,complex_scalar_lmul,RE,IM,
    pairTheory.FST,pairTheory.SND] >> conj_tac >> RealField.REAL_ARITH_TAC
);
val seh_den_positive = checked "seh_den_positive" ``!d k:num. 0 < d ==> 0 < ((&d:int) * &(k+1))`` (
  rpt gen_tac >> strip_tac >> simp []
);
val seh_exact_affine = checked "seh_exact_affine" ``!grid d k:num. !p:int. !u:int#int. 0 < d ==>
    seh_affine (&grid) (real_of_int p / (&d:real) / &(k+1)) (pair_value 1 u) =
    pair_value ((&d:int)* &(k+1))
      ((&grid:int)*((&d:int)* &(k+1))-p*SND u,p*FST u)`` (
  rpt gen_tac >> strip_tac >> Cases_on `u` >>
  `0 < (&d:real) /\ 0 < (&(k+1):real)` by simp [] >>
  REWRITE_TAC [seh_affine_def,pair_value_def,real_of_int_num,real_of_int_mul,
    real_of_int_sub,REAL_OVER1,RE,IM,pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ] >>
  conj_tac >> RealField.REAL_ASM_FIELD_TAC
);
val seh_actual_step_error = checked "seh_actual_step_error" ``!grid d k:num. !p:int. !u:int#int. 0 < d ==>
    modu (pair_value 1 (source_exp_step grid p d k u) -
      seh_affine (&grid) (real_of_int p / (&d:real) / &(k+1)) (pair_value 1 u)) <= 1`` (
  rpt gen_tac >> strip_tac >>
  `0 < ((&d:int)* &(k+1))` by metis_tac [seh_den_positive] >>
  ASM_SIMP_TAC bool_ss [seh_exact_affine] >> Cases_on `u` >>
  REWRITE_TAC [source_exp_step_def,LET_THM,pairTheory.FST,pairTheory.SND] >>
  BETA_TAC >>
  match_mp_tac seh_round_pair_error >> ASM_REWRITE_TAC []
);
val seh_update_error = checked "seh_update_error" ``!a t eps:real. !z u v:complex.
    modu (z-seh_affine a t u) <= 1 /\ modu (u-v) <= eps ==>
    modu (z-seh_affine a t v) <= 1 + abs t * eps`` (
  rpt gen_tac >> strip_tac >>
  `abs t * modu (u-v) <= abs t * eps` by
    (match_mp_tac REAL_LE_LMUL_IMP >> simp []) >>
  mp_tac (Q.SPECL [`z:complex`,`seh_affine a t u`,`seh_affine a t v`] ss_modu_sub_triangle) >>
  REWRITE_TAC [seh_affine_distance] >> RealField.REAL_ASM_ARITH_TAC
);
val seh_bound_nonnegative = checked "seh_bound_nonnegative" ``!k:num. 0 <= seh_bound k`` (
  gen_tac >> REWRITE_TAC [seh_bound_def] >> BasicProvers.every_case_tac >>
  CONV_TAC RealField.REAL_RAT_REDUCE_CONV
);
val seh_bound_step = checked "seh_bound_step" ``!k:num. !phase:real. abs phase <= 2 ==>
    1 + abs (phase / &(k+1)) * seh_bound (SUC k) <= seh_bound k`` (
  rpt gen_tac >> strip_tac >>
  Cases_on `k=0`
  >- (ASM_SIMP_TAC std_ss [seh_bound_def,REAL_OVER1] >> RealField.REAL_ASM_ARITH_TAC) >>
  Cases_on `k=1`
  >- (ASM_SIMP_TAC std_ss [seh_bound_def,REAL_ABS_DIV] >> RealField.REAL_ASM_ARITH_TAC) >>
  `2 <= k /\ ~(SUC k=0) /\ ~(SUC k=1)` by decide_tac >>
  `3 <= (&(k+1):real) /\ 0 < (&(k+1):real)` by simp [] >>
  `abs (&(k+1):real) = &(k+1)` by simp [] >>
  `abs (phase / &(k+1)) <= 2/3` by
    (ASM_SIMP_TAC bool_ss [REAL_ABS_DIV,REAL_LE_LDIV_EQ] >> RealField.REAL_ASM_ARITH_TAC) >>
  ASM_SIMP_TAC bool_ss [seh_bound_def] >> RealField.REAL_ASM_ARITH_TAC
);
val seh_initial_exact = checked "seh_initial_exact" ``!grid k:num. !phase:real.
    pair_value 1 ((&grid:int),0) = (&grid:real) * seh_ideal phase 0 k`` (
  REWRITE_TAC [pair_value_def,seh_ideal_def,real_of_int_num,REAL_OVER1,complex_scalar_lmul,
    RE,IM,pairTheory.FST,pairTheory.SND,REAL_MUL_RID,REAL_MUL_RZERO]
);
val source_exp_horner_error = checked "source_exp_horner_error" ``!grid d:num. !p:int. 0 < d /\ abs (real_of_int p / (&d:real)) <= 2 ==>
    !n k:num.
      modu (pair_value 1 (source_exp_horner grid p d n k) -
        (&grid:real) * seh_ideal (real_of_int p / (&d:real)) n k) <= seh_bound k`` (
  rpt gen_tac >> strip_tac >> Induct >> gen_tac
  >- (REWRITE_TAC [source_exp_horner_def,seh_initial_exact,COMPLEX_SUB_REFL,MODU_0] >>
      match_mp_tac seh_bound_nonnegative) >>
  `modu (pair_value 1 (source_exp_step grid p d k (source_exp_horner grid p d n (SUC k))) -
    seh_affine (&grid) (real_of_int p / (&d:real) / &(k+1))
      ((&grid:real) * seh_ideal (real_of_int p / (&d:real)) n (SUC k))) <=
    1 + abs (real_of_int p / (&d:real) / &(k+1)) * seh_bound (SUC k)` by
    (match_mp_tac seh_update_error >>
     qexists_tac `pair_value 1 (source_exp_horner grid p d n (SUC k))` >>
     ASM_SIMP_TAC bool_ss [seh_actual_step_error]) >>
  `1 + abs (real_of_int p / (&d:real) / &(k+1)) * seh_bound (SUC k) <= seh_bound k`
    by metis_tac [seh_bound_step] >>
  ONCE_REWRITE_TAC [source_exp_horner_def,seh_ideal_def] >>
  REWRITE_TAC [GSYM seh_affine_scale] >> RealField.REAL_ASM_ARITH_TAC
);
val source_exp_horner_zero_error = checked "source_exp_horner_zero_error" ``!grid d:num. !p:int. 0 < d /\ abs (real_of_int p / (&d:real)) <= 2 ==>
    !n:num. modu (pair_value 1 (source_exp_horner grid p d n 0) -
      (&grid:real) * seh_ideal (real_of_int p / (&d:real)) n 0) <= 9`` (
  rpt gen_tac >> strip_tac >> gen_tac >>
  mp_tac (Q.SPECL [`grid:num`,`d:num`,`p:int`] source_exp_horner_error) >>
  ASM_REWRITE_TAC [] >> DISCH_THEN (MP_TAC o Q.SPECL [`n:num`,`0:num`]) >>
  REWRITE_TAC [seh_bound_def]
);
val _ = print "EXP_HORNER_DIAGNOSTIC_ALL_DONE\n";
val _ = OS.Process.exit OS.Process.success;
