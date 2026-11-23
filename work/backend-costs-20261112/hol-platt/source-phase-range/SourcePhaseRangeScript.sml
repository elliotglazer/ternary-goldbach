(* Actual integer numerator and denominator supplied to the raw Horner stage. *)
Theory SourcePhaseRange
Ancestors SourceLogRange SourceArithmetic transc real intreal integer arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();
fun progress s g = (print ("phase range: " ^ s ^ "\n"); ALL_TAC g);

Theorem spr_grid:
  !q:int. real_of_int (~5*q) / (&((2:num)**135):real) =
    ~(5/64) * (real_of_int q / (2:real) pow 129)
Proof
  gen_tac >>
  REWRITE_TAC [real_of_int_mul,real_of_int_neg,real_of_int_num,GSYM REAL_OF_NUM_POW] >>
  CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  RealField.REAL_ARITH_TAC
QED

Theorem spr_log_range:
  !k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    0 <= ln (&x) /\ ln (&x) <= 19
Proof
  rpt gen_tac >> strip_tac >>
  `0 < x` by (drule slr_domain_bounds >> strip_tac >> ASM_REWRITE_TAC []) >>
  `1 <= x` by decide_tac >> progress "positive input" >>
  `(2:num)**k <= 2**18` by
    (match_mp_tac EXP_BASE_LEQ_MONO_IMP >> simp []) >> progress "exponent cap" >>
  `x <= 2 * (2:num)**k` by fs [source_log_domain_def] >>
  `2 * (2:num)**18 = 2**19` by EVAL_TAC >>
  `x <= (2:num)**19` by decide_tac >> progress "integer cap" >>
  `1 <= (&x:real) /\ 0 < (&x:real) /\ (&x:real) <= &((2:num)**19)` by simp [] >>
  `0 < (&((2:num)**19):real)` by simp [] >> progress "cast bounds" >>
  `0 <= ln (&x)` by
    (mp_tac (Q.SPECL [`1:real`,`&x:real`] LN_MONO_LE) >>
     ASM_REWRITE_TAC [LN_1,REAL_LT_01]) >>
  `ln (&x:real) <= ln (&((2:num)**19):real)` by
    (mp_tac (Q.SPECL [`&x:real`,`&((2:num)**19):real`] LN_MONO_LE) >>
     ASM_REWRITE_TAC []) >> progress "log monotonicity" >>
  `0 <= (1:real) /\ (1:real)+1=2 /\ 0 < (2:real)` by
    CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  `ln 2 <= 1` by
    (mp_tac (Q.SPEC `1:real` LN_LE) >> ASM_REWRITE_TAC []) >> progress "log two" >>
  `ln (&((2:num)**19):real) = 19 * ln 2` by
    (REWRITE_TAC [GSYM REAL_OF_NUM_POW] >> match_mp_tac LN_POW >> ASM_REWRITE_TAC []) >>
  progress "log power" >>
  conj_tac >- first_assum ACCEPT_TAC >>
  `ln (&x:real) <= 19 * ln 2` by metis_tac [] >>
  qpat_x_assum `ln (&x) <= 19 * ln 2` mp_tac >>
  qpat_x_assum `ln 2 <= 1` mp_tac >> RealField.REAL_ARITH_TAC
QED

Theorem source_raw_phase_error:
  !k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    abs (real_of_int (~5 * source_raw_log129 k x) / (&((2:num)**135):real) -
      (~(5/64) * ln (&x))) <= (5/64) * (1 / (2:real) pow 128)
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`k:num`,`x:num`] source_raw_log129_error) >>
  ASM_REWRITE_TAC [spr_grid,ABS_BOUNDS] >>
  RealField.REAL_ARITH_TAC
QED

Theorem source_raw_phase_range:
  !k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    abs (real_of_int (~5 * source_raw_log129 k x) / (&((2:num)**135):real)) <= 2
Proof
  rpt gen_tac >> strip_tac >>
  `0 <= ln (&x) /\ ln (&x) <= 19` by metis_tac [spr_log_range] >>
  mp_tac (Q.SPECL [`k:num`,`x:num`] source_raw_phase_error) >>
  ASM_REWRITE_TAC [ABS_BOUNDS] >>
  `(5/64) * (1 / (2:real) pow 128) <= 1/64` by
    CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  RealField.REAL_ASM_ARITH_TAC
QED
