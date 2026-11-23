(* The positive-base analytic power at every retained time and on the actual raw grids. *)
Theory SourceRawStateBridge
Ancestors SourceRawStep SourcePhaseRange SourceLogRange SourceInitial SourceStateBounds SourceStateError SourceArithmetic complex transc real logroot intreal integer arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Definition srb_target_def:
  srb_target (x:num) (t:real) =
    complex_exp ((~(1/2),~t) * complex_of_real (ln (&x)))
End

Theorem srb_exp_amplitude:
  !x:real. 0<x ==> exp (~(ln x/2)) = sqrt (1/x)
Proof
  rpt strip_tac >> CONV_TAC SYM_CONV >> match_mp_tac SQRT_POS_UNIQ >>
  `0 <= 1/x` by simp [REAL_LE_DIV,REAL_LT_IMP_LE] >>
  `0 <= exp (~(ln x/2))` by simp [EXP_POS_LE] >>
  `~(ln x/2) + ~(ln x/2) = ~ln x` by RealField.REAL_ARITH_TAC >>
  ASM_REWRITE_TAC [] >> REWRITE_TAC [POW_2,GSYM transcTheory.EXP_ADD] >> ASM_REWRITE_TAC [] >>
  `exp (ln x) = x` by ASM_REWRITE_TAC [transcTheory.EXP_LN] >>
  ASM_REWRITE_TAC [EXP_NEG,real_div,REAL_MUL_LID]
QED

Theorem srb_target_components:
  !x t. 0<x ==> srb_target x t = complex_of_real (sqrt (1/(&x:real))) *
    (cos (~(t*ln (&x))),sin (~(t*ln (&x))))
Proof
  rpt strip_tac >> `0 < (&x:real)` by simp [] >>
  `(~(1/2),~t) * complex_of_real (ln (&x)) = (~(ln (&x)/2),~(t*ln (&x)))` by
    (REWRITE_TAC [complex_mul,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,pairTheory.PAIR_EQ] >>
     conj_tac >> RealField.REAL_ARITH_TAC) >>
  ASM_SIMP_TAC bool_ss [srb_target_def,complex_exp,RE,IM,pairTheory.FST,pairTheory.SND,srb_exp_amplitude] >>
  REWRITE_TAC [complex_scalar_lmul,complex_mul,complex_of_real,RE,IM,pairTheory.FST,pairTheory.SND,
    REAL_MUL_LZERO,REAL_SUB_RZERO,REAL_ADD_LID,REAL_ADD_RID]
QED

Theorem srb_target_zero:
  !x. 0<x ==> srb_target x 0 = complex_of_real (sqrt (1/(&x:real)))
Proof
  rpt strip_tac >> ASM_SIMP_TAC bool_ss [srb_target_components,REAL_MUL_LZERO,REAL_NEG_0,COS_0,SIN_0,
    GSYM complex_of_real,GSYM COMPLEX_1,COMPLEX_MUL_RID]
QED

Theorem srb_target_step:
  !x n. 0<x ==> srb_target x (5 * (&(SUC n):real)/64) =
    srb_target x (5 * (&n:real)/64) * (cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))
Proof
  rpt strip_tac >>
  `~((5 * (&(SUC n):real)/64) * ln (&x)) =
     ~((5 * (&n:real)/64) * ln (&x)) + ~(5/64)*ln (&x)` by
    (REWRITE_TAC [GSYM REAL_OF_NUM_SUC] >> RealField.REAL_ARITH_TAC) >>
  ASM_SIMP_TAC bool_ss [srb_target_components,GSYM COMPLEX_MUL_ASSOC,COMPLEX_MUL_ARG]
QED

Theorem srb_initial_exists:
  !x:num. 0<x ==> ?initial. source_raw_initial x = SOME initial
Proof
  rpt strip_tac >> `1<=x` by decide_tac >> simp [source_raw_initial_def,source_initial_def]
QED

Theorem srb_log2_gate:
  !x:num. 0<x /\ x<2**19 ==> source_log_domain x 1 (logroot$LOG 2 x) /\ logroot$LOG 2 x <= 18
Proof
  gen_tac >> strip_tac >> mp_tac (Q.SPEC `x:num` LOG2_PROPERTY) >> ASM_REWRITE_TAC [] >> strip_tac >>
  conj_tac >- (fs [source_log_domain_def,EXP] >> metis_tac [LESS_IMP_LESS_OR_EQ]) >>
  `(2:num) ** (logroot$LOG 2 x) < 2**19` by
    (match_mp_tac LESS_EQ_LESS_TRANS >> qexists_tac `x:num` >> ASM_REWRITE_TAC []) >>
  `logroot$LOG 2 x < 19` by metis_tac [EXP_BASE_LT_MONO,DECIDE ``(1:num)<2``] >> decide_tac
QED

Theorem source_raw_state_from_domain:
  !k x initial. source_log_domain x 1 k /\ k <= 18 /\ source_raw_initial x = SOME initial ==>
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 k x)) j) -
      srb_target x (5 * (&j:real)/64)) < 1 / (2:real) pow 96
Proof
  rpt gen_tac >> strip_tac >> `0<x` by (drule slr_domain_bounds >> strip_tac >> ASM_REWRITE_TAC []) >>
  mp_tac (Q.SPECL [`x:num`,`1:num`,`98:num`,`120:num`,`initial:int#int`] source_initial_accuracy) >>
  ASM_REWRITE_TAC [GSYM source_raw_initial_def] >> strip_tac >>
  mp_tac (Q.SPECL [`initial:int#int`,`source_raw_step (source_raw_log129 k x)`,
    `\n:num. srb_target x (5*(&n:real)/64)`,
    `(cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))`] source_raw_state_error_lt_dyadic96) >>
  BETA_TAC >> `5*(0:real)/64 = 0` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  ASM_SIMP_TAC bool_ss [srb_target_zero,srb_target_step,MODU_UNIT,source_raw_step_error] >>
  metis_tac [REAL_LT_IMP_LE]
QED

Theorem source_raw_state_log2:
  !x:num. 0<x /\ x<2**19 ==> ?initial. source_raw_initial x = SOME initial /\
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 (logroot$LOG 2 x) x)) j) -
      srb_target x (5 * (&j:real)/64)) < 1 / (2:real) pow 96
Proof
  rpt strip_tac >> metis_tac [srb_initial_exists,srb_log2_gate,source_raw_state_from_domain]
QED

Theorem c10004_raw_state_error:
  !x:num. 1<=x /\ x<=10004 ==> ?initial. source_raw_initial x = SOME initial /\
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 (logroot$LOG 2 x) x)) j) -
      complex_exp ((~(1/2),~(5*(&j:real)/64)) * complex_of_real (ln (&x)))) < 1 / (2:real) pow 96
Proof
  rpt strip_tac >> mp_tac (Q.SPEC `x:num` source_raw_state_log2) >>
  `10004 < (2:num)**19` by EVAL_TAC >>
  `0<x /\ x<2**19` by decide_tac >> ASM_REWRITE_TAC [srb_target_def]
QED
