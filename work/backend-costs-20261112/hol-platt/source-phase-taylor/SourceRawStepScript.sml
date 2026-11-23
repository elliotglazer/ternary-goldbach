(* Error in the executable raw step on its actual output grid. *)
Theory SourceRawStep
Ancestors SourceRawTaylor SourcePhaseTaylor SourcePhaseRange SourceExpHorner SourceStateError SourceArithmetic RawPairRound complex transc lim real intreal integer arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Theorem srs_lipschitz_ordered:
  !f fp a b. (!x. (f diffl fp x) x /\ abs (fp x) <= 1) /\ a < b ==>
    abs (f b - f a) <= abs (b-a)
Proof
  rpt gen_tac >> strip_tac >> mp_tac (Q.SPECL [`f:real->real`,`a:real`,`b:real`] limTheory.MVT) >>
  impl_tac >- (rpt conj_tac >> rpt strip_tac >> metis_tac [DIFF_CONT,differentiable]) >>
  strip_tac >> `l = (fp:real->real) z` by metis_tac [DIFF_UNIQ] >>
  ASM_REWRITE_TAC [ABS_MUL] >>
  mp_tac (Q.SPECL [`abs (b-a)`,`abs ((fp:real->real) z)`,`1:real`] REAL_LE_LMUL_IMP) >>
  `abs ((fp:real->real) z) <= 1` by metis_tac [] >> ASM_SIMP_TAC (srw_ss()) []
QED

Theorem srs_lipschitz:
  !f fp. (!x. (f diffl fp x) x /\ abs (fp x) <= 1) ==>
    !a b. abs (f b - f a) <= abs (b-a)
Proof
  rpt gen_tac >> strip_tac >> rpt gen_tac >> Cases_on `a=b` >- simp [] >>
  Cases_on `a<b` >- metis_tac [srs_lipschitz_ordered] >>
  `b<a` by RealField.REAL_ASM_ARITH_TAC >>
  mp_tac (Q.SPECL [`f:real->real`,`fp:real->real`,`b:real`,`a:real`] srs_lipschitz_ordered) >>
  ASM_REWRITE_TAC [] >> ONCE_REWRITE_TAC [ABS_SUB] >> metis_tac [ABS_SUB]
QED

Theorem srs_phase_perturbation:
  !u v. modu ((cos u,sin u) - (cos v,sin v)) <= 2 * abs (u-v)
Proof
  rpt gen_tac >>
  `abs (cos u-cos v) <= abs (u-v)` by
    (mp_tac (Q.SPECL [`cos`,`\x. ~sin x`] srs_lipschitz) >>
     simp [DIFF_COS,SIN_BOUND]) >>
  `abs (sin u-sin v) <= abs (u-v)` by
    (mp_tac (Q.SPECL [`sin`,`cos`] srs_lipschitz) >> simp [DIFF_SIN,COS_BOUND]) >>
  mp_tac (Q.SPEC `(cos u,sin u) - (cos v,sin v)` modu_le_coordinate_sum) >>
  REWRITE_TAC [complex_sub,complex_add,complex_neg,RE,IM,pairTheory.FST,pairTheory.SND,GSYM real_sub] >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem srs_normalize:
  !g:num. !q:int#int. !v:complex. !eps:real. 0 < g /\
    modu (pair_value 1 q - (&g:real)*v) <= eps ==>
    modu (source_pair_value g q - v) <= eps / &g
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (&g:real)` by simp [] >>
  `source_pair_value g q - v = (1/(&g:real)) * (pair_value 1 q - (&g:real)*v)` by
    (Cases_on `q` >> Cases_on `v` >>
     REWRITE_TAC [source_pair_value_def,pair_value_def,complex_sub,complex_add,complex_neg,
       complex_scalar_lmul,RE,IM,pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ,real_of_int_num,REAL_OVER1] >>
     conj_tac >> RealField.REAL_ASM_FIELD_TAC) >>
  `0 <= 1/(&g:real)` by simp [REAL_LE_DIV,REAL_LT_IMP_LE] >>
  `abs (1/(&g:real)) = (1:real)/ &g` by metis_tac [ABS_REFL] >>
  ASM_REWRITE_TAC [MODU_SCALAR_LMUL] >>
  `eps/(&g:real) = ((1:real)/ &g)*eps` by (REWRITE_TAC [real_div] >> RealField.REAL_ARITH_TAC) >>
  ASM_REWRITE_TAC [] >> match_mp_tac REAL_LE_LMUL_IMP >> ASM_REWRITE_TAC []
QED

Theorem srs_regrid:
  !bits g:num. !q:int#int. 0<g ==>
    modu (source_pair_value g (source_regrid bits q) - source_pair_value ((2**bits)*g) q) <= 1/(&g:real)
Proof
  rpt gen_tac >> strip_tac >> PairCases_on `q` >>
  `0 < (&g:int) /\ 0 < (&((2:num)**bits):int)` by simp [EXP_POS] >>
  mp_tac (Q.SPECL [`&g:int`,`&((2:num)**bits):int`,`q0:int`] round_scaled_coordinate_error) >>
  mp_tac (Q.SPECL [`&g:int`,`&((2:num)**bits):int`,`q1:int`] round_scaled_coordinate_error) >>
  ASM_REWRITE_TAC [real_of_int_num] >> rpt strip_tac >>
  mp_tac (Q.SPEC `source_pair_value g (source_regrid bits (q0,q1)) -
     source_pair_value (((2:num)**bits)*g) (q0,q1)` modu_le_coordinate_sum) >>
  REWRITE_TAC [source_pair_value_def,source_regrid_def,pair_value_def,complex_sub,complex_add,
    complex_neg,RE,IM,pairTheory.FST,pairTheory.SND,real_of_int_num,GSYM REAL_OF_NUM_MUL,GSYM real_sub] >>
  `1 / (2 * (&g:real)) + 1 / (2 * &g) = 1 / &g` by
    (`0 < (&g:real)` by simp [] >> RealField.REAL_ASM_FIELD_TAC) >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem srs_raw_horner72:
  !q:int. abs (real_of_int (~5*q) / (&((2:num)**135):real)) <= 2 ==>
    modu (source_pair_value (2**131) (source_exp_horner (2**131) (~5*q) (2**135) 72 0) -
      seh_ideal (real_of_int (~5*q) / (&((2:num)**135):real)) 72 0) <= 9 / (2:real) pow 131
Proof
  rpt strip_tac >>
  `0 < (2:num)**135 /\ 0 < (2:num)**131` by EVAL_TAC >>
  mp_tac (Q.SPECL [`(2:num)**131`,`(2:num)**135`,`~5*q:int`] source_exp_horner_zero_error) >>
  ASM_REWRITE_TAC [] >> disch_then (qspec_then `72:num` assume_tac) >>
  REWRITE_TAC [REAL_OF_NUM_POW] >> match_mp_tac srs_normalize >> ASM_REWRITE_TAC []
QED

Theorem srs_raw_regrid9:
  !q:int. modu (source_pair_value (2**122) (source_raw_step q) -
    source_pair_value (2**131) (source_exp_horner (2**131) (~5*q) (2**135) 72 0)) <= 1 / (2:real) pow 122
Proof
  gen_tac >>
  mp_tac (Q.SPECL [`9:num`,`(2:num)**122`,`source_exp_horner (2**131) (~5*q) (2**135) 72 0`] srs_regrid) >>
  `0 < (2:num)**122 /\ (2:num)**9 * 2**122 = 2**131` by EVAL_TAC >>
  ASM_REWRITE_TAC [source_raw_step_def,REAL_OF_NUM_POW]
QED

Theorem srs_raw_budget:
  1/(2:real) pow 122 + 9/2 pow 131 + 2 pow 74 / &(FACT 73) + 2*((5/64)*(1/2 pow 128)) <= 1/2 pow 120
Proof
  REWRITE_TAC [EVAL ``FACT 73``] >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV
QED

Theorem srs_four_errors:
  !a b c d e:complex. !w x y z:real.
    modu (a-b) <= w /\ modu (b-c) <= x /\ modu (c-d) <= y /\ modu (d-e) <= z ==>
    modu (a-e) <= w+x+y+z
Proof
  rpt gen_tac >> strip_tac >> mp_tac (Q.SPECL [`a:complex`,`b:complex`,`e:complex`] ss_modu_sub_triangle) >>
  mp_tac (Q.SPECL [`b:complex`,`c:complex`,`e:complex`] ss_modu_sub_triangle) >>
  mp_tac (Q.SPECL [`c:complex`,`d:complex`,`e:complex`] ss_modu_sub_triangle) >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem source_raw_step_error:
  !k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    modu (source_pair_value (2**122) (source_raw_step (source_raw_log129 k x)) -
      (cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))) <= 1 / (2:real) pow 120
Proof
  rpt gen_tac >> strip_tac >>
  qabbrev_tac `q = source_raw_log129 k x` >>
  qabbrev_tac `u = real_of_int (~5*q) / (&((2:num)**135):real)` >>
  qabbrev_tac `theta = ~(5/64)*ln (&x:real)` >>
  `abs u <= 2 /\ abs (u-theta) <= (5/64)*(1/(2:real) pow 128)` by
    (UNABBREV_ALL_TAC >> metis_tac [source_raw_phase_range,source_raw_phase_error]) >>
  `modu ((cos u,sin u)-(cos theta,sin theta)) <= 2*((5/64)*(1/(2:real) pow 128))` by
    (mp_tac (Q.SPECL [`u:real`,`theta:real`] srs_phase_perturbation) >> RealField.REAL_ASM_ARITH_TAC) >>
  match_mp_tac REAL_LE_TRANS >> qexists_tac `1/(2:real) pow 122 + 9/2 pow 131 +
    2 pow 74 / &(FACT 73) + 2*((5/64)*(1/2 pow 128))` >> REWRITE_TAC [srs_raw_budget] >>
  mp_tac (Q.SPECL [`source_pair_value (2**122) (source_raw_step q)`,
    `source_pair_value (2**131) (source_exp_horner (2**131) (~5*q) (2**135) 72 0)`,
    `seh_ideal u 72 0`,`(cos u,sin u)`,`(cos theta,sin theta)`,
    `1/(2:real) pow 122`,`9/(2:real) pow 131`,`(2:real) pow 74 / &(FACT 73)`,
    `2*((5/64)*(1/(2:real) pow 128))`] srs_four_errors) >>
  impl_tac >- (rpt conj_tac >- MATCH_ACCEPT_TAC srs_raw_regrid9
    >- (qunabbrev_tac `u` >> match_mp_tac srs_raw_horner72 >> ASM_REWRITE_TAC [])
    >- (match_mp_tac source_raw_taylor72_error >> ASM_REWRITE_TAC []) >> ASM_REWRITE_TAC []) >>
  ASM_REWRITE_TAC []
QED
