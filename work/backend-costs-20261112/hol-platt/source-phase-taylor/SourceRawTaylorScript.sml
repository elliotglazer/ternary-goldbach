(* The actual order-72 analytic polynomial with its uniform remainder. *)
Theory SourceRawTaylor
Ancestors SourcePhaseTaylor SourceExpHorner SourcePhaseRange SourceStateError RawPairRound complex transc lim real arithmetic
Libs realLib RealField

val _ = realLib.prefer_real ();

Theorem srt_cos_poly:
  !n u. sum (0,SUC n) (\j. FST (spt_d j 0) / &(FACT j) * u pow j) = RE (seh_ideal u n 0)
Proof
  rpt gen_tac >> mp_tac (Q.SPECL [`n:num`,`0:num`,`u:real`,`\j. FST (spt_d j 0)`] spt_sum_horner) >>
  simp [spt_d_def,FACT,COS_0,SIN_0,pow]
QED

Theorem srt_sin_poly:
  !n u. sum (0,SUC n) (\j. SND (spt_d j 0) / &(FACT j) * u pow j) = IM (seh_ideal u n 0)
Proof
  rpt gen_tac >> mp_tac (Q.SPECL [`n:num`,`0:num`,`u:real`,`\j. SND (spt_d j 0)`] spt_sum_horner) >>
  simp [spt_d_def,FACT,COS_0,SIN_0,pow]
QED

Theorem srt_remainder_term:
  !a u n. abs a <= 1 /\ abs u <= 2 ==>
    abs (a / &(FACT n) * u pow n) <= (2:real) pow n / &(FACT n)
Proof
  rpt gen_tac >> strip_tac >>
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
  qpat_x_assum `abs a * _ <= _` mp_tac >> REWRITE_TAC [REAL_MUL_LID]
QED

Theorem srt_taylor:
  !u n. abs u <= 2 ==>
    modu (seh_ideal u n 0 - (cos u,sin u)) <=
    2 * (2:real) pow (SUC n) / &(FACT (SUC n))
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`u:real`,`SUC n`] spt_mclaurin_cos) >>
  REWRITE_TAC [srt_cos_poly] >> disch_then (qx_choose_then `c` assume_tac) >>
  mp_tac (Q.SPECL [`u:real`,`SUC n`] spt_mclaurin_sin) >>
  REWRITE_TAC [srt_sin_poly] >> disch_then (qx_choose_then `s` assume_tac) >>
  `abs (FST (spt_d (SUC n) c)) <= 1 /\ abs (SND (spt_d (SUC n) s)) <= 1`
    by metis_tac [spt_derivative_bound] >>
  `abs (FST (spt_d (SUC n) c) / &(FACT (SUC n)) * u pow (SUC n)) <=
     (2:real) pow (SUC n) / &(FACT (SUC n)) /\
   abs (SND (spt_d (SUC n) s) / &(FACT (SUC n)) * u pow (SUC n)) <=
     (2:real) pow (SUC n) / &(FACT (SUC n))` by metis_tac [srt_remainder_term] >>
  mp_tac (Q.SPEC `seh_ideal u n 0 - (cos u,sin u)` modu_le_coordinate_sum) >>
  REWRITE_TAC [complex_sub,complex_add,complex_neg,RE,IM,pairTheory.FST,pairTheory.SND,GSYM real_sub] >>
  FULL_SIMP_TAC bool_ss [RE,IM,ABS_BOUNDS] >> RealField.REAL_ASM_ARITH_TAC
QED

Theorem source_raw_taylor72_error:
  !u. abs u <= 2 ==> modu (seh_ideal u 72 0 - (cos u,sin u)) <= (2:real) pow 74 / &(FACT 73)
Proof
  rpt strip_tac >> mp_tac (Q.SPECL [`u:real`,`72:num`] srt_taylor) >>
  `SUC 72 = 73` by EVAL_TAC >>
  `2 * (2:real) pow 73 = (2:real) pow 74` by CONV_TAC RealField.REAL_RAT_REDUCE_CONV >>
  ASM_REWRITE_TAC []
QED
