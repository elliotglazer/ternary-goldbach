Theory ZetaEtaSign
Ancestors seq transc real arithmetic
Libs realLib

Definition term_def:
  term s (n:num) = exp (-s * ln (&n+1))
End
Definition paired_def:
  paired s n = term s (2*n) - term s (2*n+1)
End

Theorem term_strict:
  !s i j. 0<s /\ i<j ==> term s j < term s i
Proof
  rpt strip_tac >> PURE_REWRITE_TAC[term_def] >>
  `0:real < &i+1 /\ 0 < &j+1 /\ &i+1 < &j+1` by simp[] >>
  `ln (&i+1) < ln (&j+1)` by metis_tac[LN_MONO_LT] >>
  `ln (&i+1)*s < ln (&j+1)*s` by metis_tac[REAL_LT_RMUL] >>
  simp[EXP_MONO_LT] >> REAL_ASM_ARITH_TAC
QED

Theorem paired_positive:
  !s n. 0<s ==> 0<paired s n
Proof
  rpt strip_tac >> PURE_REWRITE_TAC[paired_def] >> `2*n < 2*n+1` by decide_tac >>
  `term s (2*n+1) < term s (2*n)` by metis_tac[term_strict] >> REAL_ASM_ARITH_TAC
QED

Theorem paired_bounded:
  !s. 0<s ==> !n. sum (0,n) (paired s) + term s (2*n) <= term s 0
Proof
  gen_tac >> strip_tac >> Induct >- simp[sum] >>
  `2*SUC n = 2*n+2 /\ 2*n+1 < 2*n+2` by decide_tac >>
  `term s (2*n+2) < term s (2*n+1)` by metis_tac[term_strict] >>
  PURE_REWRITE_TAC[sum,ADD_CLAUSES,paired_def] >> asm_rewrite_tac[] >> REAL_ASM_ARITH_TAC
QED

Theorem positive_eta:
  !s. 0<s ==> summable (paired s) /\ 0<suminf (paired s)
Proof
  gen_tac >> strip_tac >>
  `!n. 0<term s n` by simp[term_def,EXP_POS_LT] >>
  `!n. sum (0,n) (paired s) <= term s 0` by
    (gen_tac >> mp_tac (Q.SPECL [`s:real`] paired_bounded) >> asm_rewrite_tac[] >>
     disch_then (mp_tac o Q.SPEC `n:num`) >> first_x_assum (mp_tac o Q.SPEC `2*n`) >>
     REAL_ARITH_TAC) >>
  `summable (paired s)` by (irule POS_SUMMABLE >> metis_tac[paired_positive,REAL_LT_IMP_LE]) >>
  asm_rewrite_tac[] >> mp_tac (Q.SPECL [`paired s`,`0`] SER_POS_LT) >>
  simp[sum,paired_positive]
QED


Theorem eta_quotient_negative:
  !s:real. 0<s /\ s<1 ==> suminf (paired s) / (1-exp((1-s)*ln 2)) < 0
Proof
  rpt strip_tac >>
  `0 < ln 2` by (mp_tac (Q.SPECL [`1`,`2`] LN_MONO_LT) >> simp[LN_1]) >>
  `0 < 1-s` by REAL_ASM_ARITH_TAC >>
  `0 < (1-s)*ln 2` by metis_tac[REAL_LT_MUL] >>
  `1 < exp((1-s)*ln 2)` by metis_tac[transcTheory.EXP_0,EXP_MONO_LT] >>
  `0 < exp((1-s)*ln 2)-1` by REAL_ASM_ARITH_TAC >>
  `0 < suminf (paired s) / (exp((1-s)*ln 2)-1)` by metis_tac[REAL_LT_DIV,positive_eta] >>
  `1-exp((1-s)*ln 2) = -(exp((1-s)*ln 2)-1)` by REAL_ARITH_TAC >>
  pop_assum SUBST1_TAC >> qpat_x_assum `0 < _ / _` mp_tac >>
  `exp ((1-s)*ln 2)-1 <> 0` by REAL_ASM_ARITH_TAC >>
  asm_rewrite_tac[real_div,REAL_MUL_RNEG] >>
  qpat_x_assum `_ <> 0` (fn th => PURE_REWRITE_TAC[GSYM (MATCH_MP REAL_NEG_INV th),REAL_MUL_RNEG]) >>
  REAL_ARITH_TAC
QED
