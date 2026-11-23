(* Successive cosine and sine derivatives, matched to the actual Horner recurrence. *)
Theory SourcePhaseTaylor
Ancestors SourceExpHorner SourcePhaseRange SourceStateError RawPairRound complex transc lim real arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Definition spt_d_def:
  (spt_d 0 (x:real) : real # real = (cos x,sin x)) /\
  (spt_d (SUC n) x = (~SND (spt_d n x),FST (spt_d n x)))
End

Theorem spt_diff:
  !n x. ((\y. FST (spt_d n y)) diffl FST (spt_d (SUC n) x)) x /\
        ((\y. SND (spt_d n y)) diffl SND (spt_d (SUC n) x)) x
Proof
  Induct
  >- simp [spt_d_def,ETA_THM,DIFF_COS,DIFF_SIN] >>
  gen_tac >> first_x_assum (qspec_then `x:real` mp_tac) >>
  REWRITE_TAC [spt_d_def,pairTheory.FST,pairTheory.SND] >> strip_tac >> conj_tac
  >- (mp_tac (Q.SPECL [`\y. SND (spt_d n y)`,`FST (spt_d n x)`,`x:real`] DIFF_NEG) >>
      BETA_TAC >> ASM_REWRITE_TAC []) >> ASM_REWRITE_TAC []
QED

Theorem spt_derivative_bound:
  !n x. abs (FST (spt_d n x)) <= 1 /\ abs (SND (spt_d n x)) <= 1
Proof
  Induct >> simp [spt_d_def,COS_BOUND,SIN_BOUND]
QED

Theorem spt_sum_head:
  !f (k:num) n. sum(k,SUC n) f = f k + sum(SUC k,n) f
Proof
  rpt gen_tac >> mp_tac (Q.SPECL [`f:num->real`,`k:num`,`1:num`,`n:num`] SUM_SPLIT) >>
  simp [SUM_1,ADD1,ADD_COMM]
QED

Theorem spt_sum_horner:
  !n k u (d:num->real). (!j. d (SUC (SUC j)) = ~(d j)) ==>
    sum (k,SUC n) (\j. d j / &(FACT j) * u pow j) =
    u pow k / &(FACT k) * (d k * RE (seh_ideal u n k) + d (SUC k) * IM (seh_ideal u n k))
Proof
  Induct
  >- (rpt gen_tac >> strip_tac >>
      REWRITE_TAC [spt_sum_head,realTheory.sum,seh_ideal_def,RE,IM,pairTheory.FST,pairTheory.SND] >>
      BETA_TAC >> RealField.REAL_ARITH_TAC) >>
  rpt gen_tac >> strip_tac >>
  first_x_assum (qspecl_then [`SUC k`,`u:real`,`d:num->real`] mp_tac) >>
  ASM_REWRITE_TAC [] >> disch_tac >>
  ONCE_REWRITE_TAC [spt_sum_head] >> BETA_TAC >>
  ASM_REWRITE_TAC [seh_ideal_def,seh_affine_def,RE,IM,pairTheory.FST,pairTheory.SND,FACT,pow,
    GSYM REAL_OF_NUM_MUL,GSYM ADD1] >>
  `0 < (&(SUC k):real) /\ 0 < (&(FACT k):real)` by simp [FACT_LESS] >>
  RealField.REAL_ASM_FIELD_TAC
QED

Theorem spt_mclaurin_cos:
  !u n. ?t. cos u = sum (0,n) (\j. FST (spt_d j 0) / &(FACT j) * u pow j) +
                      (FST (spt_d n t) / &(FACT n)) * u pow n
Proof
  mp_tac (Q.SPECL [`cos`,`\n x. FST (spt_d n x)`] MCLAURIN_ALL_LE) >> BETA_TAC >>
  impl_tac >- (conj_tac >- simp [spt_d_def,ETA_THM] >>
    rpt gen_tac >> MATCH_ACCEPT_TAC (CONJUNCT1 (SPEC_ALL spt_diff))) >> metis_tac []
QED

Theorem spt_mclaurin_sin:
  !u n. ?t. sin u = sum (0,n) (\j. SND (spt_d j 0) / &(FACT j) * u pow j) +
                      (SND (spt_d n t) / &(FACT n)) * u pow n
Proof
  mp_tac (Q.SPECL [`sin`,`\n x. SND (spt_d n x)`] MCLAURIN_ALL_LE) >> BETA_TAC >>
  impl_tac >- (conj_tac >- simp [spt_d_def,ETA_THM] >>
    rpt gen_tac >> MATCH_ACCEPT_TAC (CONJUNCT2 (SPEC_ALL spt_diff))) >> metis_tac []
QED
