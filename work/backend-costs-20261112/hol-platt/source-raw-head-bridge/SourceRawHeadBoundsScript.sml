Theory SourceRawHeadBounds
Ancestors SourceRawHeadBridge SourceRawStateBridge SourceRawStep SourcePhaseRange SourceStateBounds SourceStateError SourceInitial SourceInverseRoot SourceArithmetic RawPairRound RawStateHandoff complex transc real intreal logroot integer arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Theorem srh_amplitude_norm:
  !x t. 0<x ==> modu (srb_target x t) = sqrt (1/(&x:real))
Proof
  rpt strip_tac >> `0 <= 1/(&x:real)` by simp [REAL_LE_DIV] >>
  `0 <= sqrt (1/(&x:real))` by metis_tac [SQRT_POS_LE] >>
  ASM_SIMP_TAC bool_ss [srb_target_components,MODU_MUL,MODU_UNIT,REAL_MUL_RID,MODU_REAL,ABS_REFL]
QED

Theorem srh_xnorm:
  !x t. 0<x ==> modu (srb_target x t) <= 1
Proof
  rpt strip_tac >> `1<=x` by decide_tac >>
  mp_tac (Q.SPECL [`x:num`,`1:num`] source_amplitude_norm) >>
  asm_simp_tac (srw_ss()) [srh_amplitude_norm,MODU_REAL,abs,SQRT_POS_LE,REAL_LE_DIV]
QED

Theorem srh_cnorm:
  !t. modu (srb_target 10004 t) <= 1/100
Proof
  gen_tac >> `0<(10004:num)` by EVAL_TAC >> ASM_SIMP_TAC bool_ss [srh_amplitude_norm] >>
  `sqrt ((1:real)/10000) = 1/100` by
     (match_mp_tac SQRT_POS_UNIQ >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `0 <= 1/(10004:real) /\ 1/(10004:real) <= 1/10000` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  metis_tac [SQRT_MONO_LE]
QED

Theorem srh_product_error:
  !U V C A:complex. !e f bound:real.
    modu (U-C) <= e /\ modu (V-A) <= f /\ modu C <= bound /\ modu A <= 1 ==>
    modu (conj U * V - conj C * A) <= e*(1+f) + bound*f
Proof
  rpt gen_tac >> strip_tac >>
  `modu V <= 1+f` by (mp_tac (Q.SPECL [`V-A:complex`,`A:complex`] ss_modu_triangle) >>
    REWRITE_TAC [COMPLEX_SUB_ADD] >> RealField.REAL_ASM_ARITH_TAC) >>
  `conj U * V - conj C * A = conj (U-C) * V + conj C * (V-A)` by
    (REWRITE_TAC [COMPLEX_RE_IM_EQ,complex_mul,conj,complex_sub,
       complex_add,complex_neg,RE,IM,pairTheory.FST,pairTheory.SND] >> conj_tac >> RealField.REAL_ARITH_TAC) >>
  `modu (U-C) * modu V <= e*(1+f)` by (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]) >>
  `modu C * modu (V-A) <= bound*f` by (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]) >>
  mp_tac (Q.SPECL [`conj (U-C) * V:complex`,`conj C * (V-A):complex`] ss_modu_triangle) >>
  ASM_REWRITE_TAC [MODU_MUL,MODU_CONJ] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem srh_head_error:
  !c:num. !U V:int#int. !C A:complex. !e f bound:real.
    modu (source_pair_value (2**120) U-C) <= e /\ modu (source_pair_value (2**120) V-A) <= f /\
    modu C <= bound /\ modu A <= 1 ==>
    modu (source_pair_value (2**100) (raw_head (&c) U V) - (&c:real)*(conj C*A)) <=
      1/(2:real) pow 100 + &c*(e*(1+f)+bound*f)
Proof
  rpt gen_tac >> strip_tac >>
  `modu (conj (source_pair_value (2**120) U) * source_pair_value (2**120) V - conj C*A) <= e*(1+f)+bound*f`
    by metis_tac [srh_product_error] >>
  `(&c:real)*modu (conj (source_pair_value (2**120) U) * source_pair_value (2**120) V - conj C*A)
    <= &c*(e*(1+f)+bound*f)` by (match_mp_tac REAL_LE_LMUL_IMP >> simp []) >>
  `abs (&c:real) = &c` by simp [abs] >>
  mp_tac (Q.SPECL [`source_pair_value (2**100) (raw_head (&c) U V)`,
    `(&c:real)*(conj (source_pair_value (2**120) U)*source_pair_value (2**120) V)`,
    `(&c:real)*(conj C*(A:complex))`] ss_modu_sub_triangle) >>
  ASM_REWRITE_TAC [GSYM COMPLEX_SUB_SCALAR_LMUL,MODU_SCALAR_LMUL] >>
  mp_tac (Q.SPECL [`c:num`,`U:int#int`,`V:int#int`] srh_rounding) >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem srh_c_root:
  source_inverse_root 10004 1 (2**98) = 3168492865354689069166240814
Proof
  REWRITE_TAC [source_inverse_root_def] >> match_mp_tac ROOT_UNIQUE >> EVAL_TAC
QED

Theorem srh_c_sqrt:
  abs (3168492865354689069166240814 / (2:real) pow 98 - sqrt (1/10004)) <= 1 / (2:real) pow 99
Proof
  qabbrev_tac `r = 3168492865354689069166240814 / (2:real) pow 98` >>
  qabbrev_tac `e = 1/(2:real) pow 99` >>
  `0<=r /\ 0<=r+e /\ 0<=r pow 2 /\ 0<=1/(10004:real) /\ r pow 2 <= 1/10004 /\ 1/10004 <= (r+e) pow 2` by
    (UNABBREV_ALL_TAC >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `sqrt (r pow 2) <= sqrt (1/(10004:real)) /\ sqrt (1/(10004:real)) <= sqrt ((r+e) pow 2)`
    by metis_tac [SQRT_MONO_LE] >>
  `abs r = r /\ abs (r+e) = r+e` by metis_tac [ABS_REFL] >>
  FULL_SIMP_TAC bool_ss [SQRT_POW_2_ABS,ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem srh_c_initial:
  !u. source_raw_initial 10004 = SOME u ==>
    modu (source_pair_value (2**120) u - srb_target 10004 0) <= 1 / (2:real) pow 99
Proof
  rpt strip_tac >> mp_tac (Q.SPECL [`10004:num`,`1:num`,`98:num`,`120:num`,`u:int#int`] source_initial_value) >>
  ASM_REWRITE_TAC [GSYM source_raw_initial_def,srh_c_root] >> strip_tac >>
  `0<(10004:num)` by EVAL_TAC >>
  ASM_SIMP_TAC bool_ss [srb_target_zero,COMPLEX_OF_REAL_SUB,MODU_REAL,srh_c_sqrt]
QED

Theorem srh_c_envelope:
  !n:num. n<=84200 ==> source_error_envelope (1/(2:real) pow 99) (1/2 pow 120) (1/2 pow 120) n <=
     (3/5) / (2:real) pow 98
Proof
  rpt strip_tac >> mp_tac (Q.SPECL [`1/(2:real) pow 99`,`1/(2:real) pow 120`,`84200:num`] source_envelope_linear_prefix) >>
  impl_tac >- CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> disch_then (qspec_then `n:num` mp_tac) >>
  ASM_REWRITE_TAC [] >> `(&n:real) <= 84200` by simp [] >>
  CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem srh_c_state:
  !n:num. n<=84200 ==>
    modu (source_pair_value (2**120) (srh_state 10004 n) - srb_target 10004 (5*(&n:real)/64)) <= (3/5)/(2:real) pow 98
Proof
  rpt strip_tac >> `0<(10004:num) /\ 10004<2**19` by EVAL_TAC >>
  mp_tac (Q.SPEC `10004:num` srb_initial_exists) >> ASM_REWRITE_TAC [] >> strip_tac >>
  qabbrev_tac `k = logroot$LOG 2 10004` >> qabbrev_tac `theta = ~(5/64)*ln (10004:real)` >>
  `source_log_domain 10004 1 k /\ k<=18` by (qunabbrev_tac `k` >> metis_tac [srb_log2_gate]) >>
  `modu (source_pair_value (2**122) (source_raw_step (source_raw_log129 k 10004)) - (cos theta,sin theta)) <=
    1/(2:real) pow 120` by (qunabbrev_tac `theta` >> metis_tac [source_raw_step_error]) >>
  `0 < (2:num)**120 /\ 0 < (2:num)**122` by EVAL_TAC >>
  `0 <= 1/(2:real) pow 99 /\ 0 <= 1/(2:real) pow 120 /\ 5*(0:real)/64 = 0`
    by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  `modu (source_pair_value (2**120) initial - srb_target 10004 0) <= 1/(2:real) pow 99`
    by metis_tac [srh_c_initial] >>
  `modu (srb_target 10004 0) <= 1` by metis_tac [srh_xnorm] >>
  mp_tac (Q.SPECL [`(2:num)**120`,`(2:num)**122`,`initial:int#int`,
    `source_raw_step (source_raw_log129 k 10004)`,`\j:num. srb_target 10004 (5*(&j:real)/64)`,
    `(cos theta,sin theta)`,`1/(2:real) pow 99`,`1/(2:real) pow 120`] source_state_error_from_initial_and_step) >>
  BETA_TAC >> impl_tac >- (ASM_REWRITE_TAC [MODU_UNIT] >> qunabbrev_tac `theta` >> ASM_SIMP_TAC bool_ss [srb_target_step]) >>
  disch_then (qspec_then `n:num` mp_tac) >>
  ASM_SIMP_TAC bool_ss [srh_state_def,optionTheory.THE_DEF,GSYM REAL_OF_NUM_POW] >>
  mp_tac (Q.SPEC `n:num` srh_c_envelope) >> ASM_REWRITE_TAC [] >>
  qunabbrev_tac `k` >> RealField.REAL_ARITH_TAC
QED

Theorem c10004_raw_head_error:
  !a h:num. 1<=a /\ a<=10004 /\ h<=84200 ==>
    modu (source_pair_value (2**100) (raw_head 10004 (srh_state 10004 h) (srh_state a h)) -
      complex_exp ((~(1/2),~(5*(&h:real)/64))*complex_of_real (ln ((&a:real)/10004)))) < 1/(2:real) pow 85
Proof
  rpt gen_tac >> strip_tac >> `0<a /\ h<=90000` by decide_tac >>
  `0<(10004:num) /\ 10004 < (2:num)**19` by EVAL_TAC >> `a<2**19` by decide_tac >>
  qabbrev_tac `t = 5*(&h:real)/64` >>
  mp_tac (Q.SPECL [`10004:num`,`srh_state 10004 h`,`srh_state a h`,`srb_target 10004 t`,`srb_target a t`,
    `(3/5)/(2:real) pow 98`,`1/(2:real) pow 96`,`1/(100:real)`] srh_head_error) >>
  impl_tac >- (qunabbrev_tac `t` >> ASM_SIMP_TAC bool_ss [srh_c_state,srh_state_error,srh_cnorm,srh_xnorm]) >>
  ASM_SIMP_TAC bool_ss [srh_target] >>
  `1/(2:real) pow 100 + 10004*((3/5)/2 pow 98*(1+1/2 pow 96) + (1/100)*(1/2 pow 96)) < 1/2 pow 85`
    by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >> RealField.REAL_ASM_ARITH_TAC
QED
