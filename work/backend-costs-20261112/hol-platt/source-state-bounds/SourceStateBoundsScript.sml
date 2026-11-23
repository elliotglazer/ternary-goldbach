(* Uniform bounds for the actual persistent source recurrence. The linear
   bootstrap avoids evaluating a real power or unfolding 90000 updates.
   Initial and step producers remain separate explicit obligations. *)
Theory SourceStateBounds
Ancestors SourceStateError SourceArithmetic complex real arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Theorem source_envelope_linear_prefix:
  !initialError delta (N:num).
    0 <= delta /\ initialError + 3 * &N * delta <= 1 ==>
    !n. n <= N ==>
      source_error_envelope initialError delta delta n
        <= initialError + 3 * &n * delta
Proof
  rpt gen_tac >> strip_tac >> Induct >> strip_tac
  >- simp [source_error_envelope_def] >>
  `n <= N` by decide_tac >>
  `source_error_envelope initialError delta delta n
     <= initialError + 3 * &n * delta` by metis_tac [] >>
  `(&n:real) <= &N` by simp [REAL_OF_NUM_LE] >>
  `(&n:real)*delta <= &N*delta` by metis_tac [REAL_LE_RMUL_IMP] >>
  `source_error_envelope initialError delta delta n <= 1`
    by RealField.REAL_ASM_ARITH_TAC >>
  `delta * source_error_envelope initialError delta delta n <= delta`
    by metis_tac [REAL_LE_LMUL_IMP,REAL_MUL_RID] >>
  REWRITE_TAC [source_error_envelope_def,GSYM REAL_OF_NUM_SUC] >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem source_raw_envelope_lt_dyadic96:
  !n. n <= 90000 ==>
    source_error_envelope (1 / (2:real) pow 98)
      (1 / (2:real) pow 120) (1 / (2:real) pow 120) n
      < 1 / (2:real) pow 96
Proof
  gen_tac >> strip_tac >>
  `0 <= 1 / (2:real) pow 120` by
    (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `1 / (2:real) pow 98 + 3 * &90000 * (1 / (2:real) pow 120) <= 1` by
    (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `source_error_envelope (1 / (2:real) pow 98)
      (1 / (2:real) pow 120) (1 / (2:real) pow 120) n
    <= 1 / (2:real) pow 98 + 3 * &n * (1 / (2:real) pow 120)`
    by metis_tac [source_envelope_linear_prefix] >>
  `(&n:real) <= &90000` by simp [REAL_OF_NUM_LE] >>
  `(&n:real)*(1 / (2:real) pow 120)
     <= &90000*(1 / (2:real) pow 120)` by metis_tac [REAL_LE_RMUL_IMP] >>
  `1 / (2:real) pow 98 + 3 * &90000 * (1 / (2:real) pow 120)
     < 1 / (2:real) pow 96` by
    (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem source_raw_state_error_lt_dyadic96:
  !initial step (exact:num->complex) (w:complex).
    modu (exact 0) <= 1 /\ modu w = 1 /\
    (!n. exact (SUC n) = exact n * w) /\
    modu (source_pair_value (2 ** 120) initial-exact 0) <= 1 / (2:real) pow 98 /\
    modu (source_pair_value (2 ** 122) step-w) <= 1 / (2:real) pow 120 ==>
    !n. n <= 90000 ==>
      modu (source_pair_value (2 ** 120)
        (source_state (2 ** 122) initial step n)-exact n) < 1 / (2:real) pow 96
Proof
  rpt gen_tac >> strip_tac >>
  `0 < (2 ** 120:num) /\ 0 < (2 ** 122:num)` by EVAL_TAC >>
  `0 <= 1 / (2:real) pow 98 /\ 0 <= 1 / (2:real) pow 120` by
    (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `1 / (&(2 ** 120):real) = 1 / (2:real) pow 120`
    by REWRITE_TAC [REAL_POW] >>
  `!n. modu (source_pair_value (2 ** 120)
        (source_state (2 ** 122) initial step n)-exact n)
      <= source_error_envelope (1 / (2:real) pow 98)
        (1 / (2:real) pow 120) (1 / (2:real) pow 120) n`
    by metis_tac [source_state_error_from_initial_and_step] >>
  metis_tac [source_raw_envelope_lt_dyadic96,REAL_LET_TRANS]
QED

val _ = print "SOURCE_STATE_BOUNDS_PROOFS_DONE_CONDITIONAL_PRODUCERS\n";
