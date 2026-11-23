(* Real logarithm tail for the existing 45-term source schedule.
   This module proves the analytic polynomial bound. The integer Horner
   refinement and its rounding errors are separate producer obligations. *)
Theory SourceLogTail
Ancestors real transc lim arithmetic
Libs realLib RealField Diff

val _ = realLib.prefer_real ();

Definition sl_log_partial_def:
  (sl_log_partial 0 (x:real) = 0) /\
  (sl_log_partial (SUC n) x = sl_log_partial n x +
    2 * x pow (2*n+1) / &(2*n+1))
End

Definition sl_remainder_def:
  sl_remainder (n:num) = \x:real. ln (1+x) - ln (1-x) - sl_log_partial n x
End

(* Obtain only a derivative expression from the existing differentiation
   conversion, then prove its equality to the required expression by field
   arithmetic. All steps use ordinary HOL inference rules. *)
fun sl_use_diff th = W (fn (_,goal) =>
  let val (_,body) = strip_imp (concl th)
      val actual = rand (rator body)
      val wanted = rand (rator goal)
  in SUBGOAL_THEN (mk_eq (actual,wanted)) ASSUME_TAC
       >- (ASM_SIMP_TAC bool_ss [POW_ADD,POW_2] >> RealField.REAL_ASM_FIELD_TAC) >>
     mp_tac th >> ASM_SIMP_TAC real_ss []
  end);

fun sl_use_diff_clear th = W (fn (_,goal) =>
 let val (_,body) = strip_imp(concl th)
     val actual = rand(rator body)
     val wanted = rand(rator goal)
 in SUBGOAL_THEN(mk_eq(actual,wanted)) ASSUME_TAC
      >- (ASM_SIMP_TAC bool_ss [POW_ADD,POW_2] >>
          ASM_SIMP_TAC bool_ss [REAL_EQ_RDIV_EQ',REAL_SUB_RDISTRIB,REAL_DIV_RMUL] >>
          REWRITE_TAC [REAL_SUB_LDISTRIB,REAL_MUL_RID,REAL_SUB_SUB2,REAL_MUL_ASSOC]) >>
    mp_tac th >> ASM_SIMP_TAC real_ss []
 end);

val sl_log_diff_conversion = SIMP_RULE real_ss []
  (Diff.DIFF_CONV ``\y:real. ln (1+y) - ln (1-y)``);
val _ = print ("LOG_DIFFERENCE_CONVERSION," ^ thm_to_string sl_log_diff_conversion ^ "\n");

Theorem sl_log_difference_diff:
  !x:real. 0 <= x /\ x < 1 ==>
    ((\y:real. ln (1+y) - ln (1-y)) diffl (2 / (1-x pow 2))) x
Proof
  gen_tac >> strip_tac >>
  `0 < 1+x /\ 0 < 1-x` by RealField.REAL_ASM_ARITH_TAC >>
  sl_use_diff (Q.SPEC `x:real` sl_log_diff_conversion)
QED

Theorem sl_odd_term_diff:
  !n:num. !x:real.
    ((\y:real. 2 * y pow (2*n+1) / &(2*n+1)) diffl
      (2 * x pow (2*n))) x
Proof
  rpt gen_tac >>
  `0 < (&(2*n+1):real)` by simp [] >>
  sl_use_diff (Q.SPEC `x:real` (SIMP_RULE real_ss []
    (Diff.DIFF_CONV ``\y:real. 2 * y pow (2*n+1) / &(2*n+1)``)))
QED

Theorem sl_log_partial_zero:
  !n:num. sl_log_partial n 0 = 0
Proof
  Induct >> simp [sl_log_partial_def]
QED

Theorem sl_remainder_zero:
  !n:num. sl_remainder n 0 = 0
Proof
  simp [sl_remainder_def,sl_log_partial_zero,LN_1]
QED

Theorem sl_remainder_suc:
  !n:num. sl_remainder (SUC n) =
    (\x:real. sl_remainder n x - 2 * x pow (2*n+1) / &(2*n+1))
Proof
  gen_tac >> REWRITE_TAC [FUN_EQ_THM,sl_remainder_def,sl_log_partial_def] >>
  BETA_TAC >> gen_tac >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem sl_remainder_diff:
  !n:num. !x:real. 0 <= x /\ x < 1 ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x
Proof
  Induct
  >- (SIMP_TAC real_ss [sl_remainder_def,sl_log_partial_def,sl_log_difference_diff]) >>
  gen_tac >> strip_tac >>
  `(sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x`
    by metis_tac [] >>
  `((\y:real. 2 * y pow (2*n+1) / &(2*n+1)) diffl
      (2 * x pow (2*n))) x` by metis_tac [sl_odd_term_diff] >>
  `0 < 1+x /\ 0 < 1-x` by RealField.REAL_ASM_ARITH_TAC >>
  `0 < (1-x)*(1+x)` by (match_mp_tac REAL_LT_MUL >> ASM_REWRITE_TAC []) >>
  `0 < 1-x*x` by RealField.REAL_ASM_ARITH_TAC >>
  `1-x*x <> 0` by RealField.REAL_ASM_ARITH_TAC >>
  `2*SUC n = 2*n+2` by decide_tac >>
  REWRITE_TAC [sl_remainder_suc] >>
  sl_use_diff_clear (Q.SPECL [`sl_remainder (n:num)`,
    `\y:real. 2 * y pow (2*n+1) / &(2*n+1)`,
    `2 * (x:real) pow (2*n) / (1-x pow 2)`,`2 * (x:real) pow (2*n)`,`x:real`]
    limTheory.DIFF_SUB)
QED

Theorem sl_remainder_mvt:
  !n:num. !v:real. 0 < v /\ v <= 1/3 ==>
    ?c:real. 0 < c /\ c < v /\
      sl_remainder n v = v * (2 * c pow (2*n) / (1-c pow 2))
Proof
  rpt gen_tac >> strip_tac >>
  `!x:real. 0 <= x /\ x <= v ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x` by
    (rpt gen_tac >> strip_tac >> match_mp_tac sl_remainder_diff >>
     RealField.REAL_ASM_ARITH_TAC) >>
  `!x:real. 0 <= x /\ x <= v ==> sl_remainder n contl x`
    by metis_tac [limTheory.DIFF_CONT] >>
  `!x:real. 0 < x /\ x < v ==> sl_remainder n differentiable x` by
    (rpt gen_tac >> strip_tac >> REWRITE_TAC [limTheory.differentiable] >>
     qexists_tac `2 * (x:real) pow (2*n) / (1-x pow 2)` >>
     match_mp_tac sl_remainder_diff >> RealField.REAL_ASM_ARITH_TAC) >>
  mp_tac (Q.SPECL [`sl_remainder (n:num)`,`0:real`,`v:real`] limTheory.MVT) >>
  ASM_SIMP_TAC bool_ss [] >>
  DISCH_THEN (qx_choose_then `ell` (qx_choose_then `c` strip_assume_tac)) >>
  `0 <= c /\ c < 1` by RealField.REAL_ASM_ARITH_TAC >>
  `(sl_remainder n diffl (2 * c pow (2*n) / (1-c pow 2))) c`
    by metis_tac [sl_remainder_diff] >>
  `ell = 2 * c pow (2*n) / (1-c pow 2)` by metis_tac [limTheory.DIFF_UNIQ] >>
  qexists_tac `c:real` >>
  full_simp_tac bool_ss [sl_remainder_zero,REAL_SUB_RZERO]
QED

Theorem sl_remainder_derivative_bound:
  !n:num. !x:real. 0 <= x /\ x <= 1/3 ==>
    0 <= 2 * x pow (2*n) / (1-x pow 2) /\
    2 * x pow (2*n) / (1-x pow 2) <= (9/4) * (1/3) pow (2*n)
Proof
  rpt gen_tac >> strip_tac >>
  `x pow 2 <= (1/3:real) pow 2` by metis_tac [POW_LE] >>
  `(1/3:real) pow 2 = 1/9` by (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `8/9 <= 1-x pow 2 /\ 0 < 1-x pow 2` by RealField.REAL_ASM_ARITH_TAC >>
  `0 <= x pow (2*n)` by metis_tac [POW_POS] >>
  `x pow (2*n) <= (1/3:real) pow (2*n)` by metis_tac [POW_LE] >>
  `0 <= (1/3:real) pow (2*n)` by simp [POW_POS] >>
  `(8/9) * (1/3:real) pow (2*n) <= (1-x pow 2) * (1/3:real) pow (2*n)`
    by metis_tac [REAL_LE_RMUL_IMP] >>
  conj_tac
  >- (match_mp_tac REAL_LE_DIV >> simp [REAL_LE_MUL,REAL_LT_IMP_LE]) >>
  ASM_SIMP_TAC bool_ss [REAL_LE_LDIV_EQ] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem sl_remainder_bound:
  !n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (sl_remainder n v) <= (9/4) * (1/3:real) pow (2*n+1)
Proof
  rpt gen_tac >> strip_tac >> Cases_on `v = 0`
  >- (ASM_REWRITE_TAC [sl_remainder_zero,ABS_0] >>
      match_mp_tac REAL_LE_MUL >> conj_tac
      >- CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
      match_mp_tac POW_POS >> CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  `0 < v` by RealField.REAL_ASM_ARITH_TAC >>
  `?c:real. 0 < c /\ c < v /\
      sl_remainder n v = v * (2 * c pow (2*n) / (1-c pow 2))`
    by metis_tac [sl_remainder_mvt] >>
  `0 <= c /\ c <= 1/3` by RealField.REAL_ASM_ARITH_TAC >>
  `0 <= 2 * c pow (2*n) / (1-c pow 2) /\
    2 * c pow (2*n) / (1-c pow 2) <= (9/4) * (1/3:real) pow (2*n)`
    by metis_tac [sl_remainder_derivative_bound] >>
  `0 <= sl_remainder n v` by metis_tac [REAL_LE_MUL] >>
  `v * (2 * c pow (2*n) / (1-c pow 2)) <=
    (1/3) * ((9/4) * (1/3:real) pow (2*n))` by
    (match_mp_tac REAL_LE_MUL2 >> ASM_SIMP_TAC bool_ss []) >>
  `abs (sl_remainder n v) = sl_remainder n v` by metis_tac [ABS_REFL] >>
  ASM_REWRITE_TAC [POW_ADD,POW_1] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem sl_log_partial_error:
  !n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial n v)
      <= (9/4) * (1/3:real) pow (2*n+1)
Proof
  rpt gen_tac >> strip_tac >>
  `0 < 1+v /\ 0 < 1-v` by RealField.REAL_ASM_ARITH_TAC >>
  mp_tac (Q.SPECL [`n:num`,`v:real`] sl_remainder_bound) >>
  ASM_SIMP_TAC bool_ss [sl_remainder_def,LN_DIV]
QED

Theorem sl_log_partial45_error:
  !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial 45 v) <= 1 / (2:real) pow 135
Proof
  gen_tac >> strip_tac >>
  `(9/4) * (1/3:real) pow (2*45+1) <= 1 / (2:real) pow 135`
    by (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  metis_tac [sl_log_partial_error,REAL_LE_TRANS]
QED

Theorem sl_log_two45_error:
  abs (ln 2 - sl_log_partial 45 (1/3)) <= 1 / (2:real) pow 135
Proof
  `(1+(1/3:real))/(1-1/3) = 2` by (CONV_TAC RealField.REAL_RAT_REDUCE_CONV) >>
  mp_tac (Q.SPEC `1/3:real` sl_log_partial45_error) >>
  ASM_SIMP_TAC real_ss []
QED

val _ = print "SOURCE_LOG_TAIL_PROOFS_DONE\n";
