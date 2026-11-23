Theory H1RawCv
Ancestors SourceRawHeadBounds SourceRawHeadBridge SourceArithmetic RawStateHandoff BlockRound C10004FullInteger cv_std integer list logroot arithmetic
Libs cv_transLib

(* CV's signed division has a nonzero-denominator side condition. *)
val rp = cv_trans_pre "h1RoundPre" BlockRoundTheory.round_scaled_def;
val lh = cv_trans_pre "h1LogHornerPre" (REWRITE_RULE [integerTheory.INT_EXP] source_log_horner_def);
val lc = cv_trans_pre "h1LogCenterPre" source_log_center_def;
val ll = cv_trans_pre "h1LogTwoPre" source_log_from_two_def;
val lr = cv_trans_pre "h1RawLogPre" source_raw_log129_def;
Theorem h1_log_horner_positive:
  !n S A B k. 0<B ==> h1LogHornerPre S A B n k
Proof
  Induct >> rpt strip_tac >> ONCE_REWRITE_TAC [lh] >> simp [rp,INT_ENTIRE]
QED
Theorem h1_log_center_positive:
  !S A B n. 0<B ==> h1LogCenterPre S A B n
Proof
  simp [lc,rp,h1_log_horner_positive,INT_ENTIRE]
QED
Theorem h1_log_positive[cv_pre]:
  !k x. h1RawLogPre k x
Proof
  rpt gen_tac >> `0 < (2:num)**k` by simp [] >> `0<x+2**k` by decide_tac >>
  simp [lr,ll,rp,INT_ENTIRE,h1_log_center_positive]
QED
val es = cv_trans_pre "h1ExpStepPre" source_exp_step_def;
val eh = cv_trans_pre "h1ExpHornerPre" source_exp_horner_def;
val rg = cv_trans_pre "h1RegridPre" source_regrid_def;
val rs = cv_trans_pre "h1RawStepPre" source_raw_step_def;
Theorem h1_exp_step_positive:
  !S p d k v. 0<d ==> h1ExpStepPre S p d k v
Proof
  simp [es,rp,INT_ENTIRE]
QED
Theorem h1_exp_horner_positive:
  !n S p d k. 0<d ==> h1ExpHornerPre S p d n k
Proof
  Induct >> rpt strip_tac >> ONCE_REWRITE_TAC [eh] >> simp [h1_exp_step_positive]
QED
Theorem h1_regrid_positive:
  !b v. h1RegridPre b v
Proof
  simp [rg,rp,INT_ENTIRE]
QED
Theorem h1_raw_step_positive[cv_pre]:
  !q. h1RawStepPre q
Proof
  simp [rs,h1_regrid_positive,h1_exp_horner_positive]
QED
val sm = cv_trans_pre "h1MulPre" source_mul_def;
Theorem h1_mul_positive[cv_pre]:
  !d u v. 0<d ==> h1MulPre d u v
Proof
  simp [sm,rp,INT_ENTIRE]
QED
val hh = cv_trans_pre "h1HeadPre" raw_head_def;
Theorem h1_head_positive[cv_pre]:
  !c u v. h1HeadPre c u v
Proof
  simp [hh,rp,INT_ENTIRE]
QED

Definition h1_log_guess_def:
 (h1_log_guess 0 (x:num) = 0) /\
 (h1_log_guess (SUC n) x = if x<2 then 0 else SUC (h1_log_guess n (x DIV 2)))
End
Definition h1_root_arg_def:
 h1_root_arg (x:num) = if x=0 then 0 else 2**196 DIV x
End
Definition h1_root_guess_def:
 (h1_root_guess (z:num) 0 a = a) /\
 (h1_root_guess z (SUC n) a = let v = a + 2**n in
     h1_root_guess z n (if v*v <= z then v else a))
End
Definition h1_gate_def:
 h1_gate (x:num) = let k=h1_log_guess 16 x; z=h1_root_arg x; m=h1_root_guess z 99 0 in
    0<x /\ 2**k<=x /\ x<2**(SUC k) /\ m**2<=z /\ z<(SUC m)**2
End
Definition h1_fast_state_def:
 h1_fast_state (x:num) = let k=h1_log_guess 16 x; m=h1_root_guess (h1_root_arg x) 99 0 in
    source_mul (2**122) ((&m:int) * &(2**22),(0:int)) (source_raw_step (source_raw_log129 k x))
End
Theorem h1_gate_positive:
  !x. h1_gate x ==> 0<x
Proof
  simp [h1_gate_def,LET_THM]
QED
Theorem h1_source_state_one:
  !s u w. source_state s u w 1 = source_mul s u w
Proof
  REWRITE_TAC [numLib.num_CONV ``1:num``,source_state_def]
QED
Theorem h1_fast_state_correct:
  !x. h1_gate x ==> h1_fast_state x = srh_state x 1
Proof
  gen_tac >> SIMP_TAC bool_ss [h1_gate_def,LET_THM] >> strip_tac >>
  `LOG 2 x = h1_log_guess 16 x` by metis_tac [logrootTheory.LOG2_UNIQUE] >>
  `ROOT 2 (h1_root_arg x) = h1_root_guess (h1_root_arg x) 99 0`
    by metis_tac [logrootTheory.ROOT_UNIQUE] >>
  `(2**98)*(2**98) = (2:num)**196 /\ 120-98 = (22:num)` by EVAL_TAC >>
  `h1_root_arg x = 2**196 DIV x` by simp [h1_root_arg_def] >>
  asm_simp_tac (srw_ss()) [h1_fast_state_def,LET_THM,srh_state_def,source_raw_initial_def,
     source_initial_def,source_inverse_root_def,source_state_def,optionTheory.THE_DEF] >>
  `1<=x` by decide_tac >> FULL_SIMP_TAC (srw_ss()) [h1_root_arg_def,h1_source_state_one]
QED
val _ = cv_auto_trans h1_log_guess_def;
val _ = cv_auto_trans h1_root_arg_def;
val _ = cv_auto_trans h1_root_guess_def;
val _ = cv_auto_trans h1_gate_def;
val fp = cv_trans_pre "h1ValuePre" h1_fast_state_def;
Theorem h1_value_positive[cv_pre]:
  !x. h1ValuePre x
Proof
  simp [fp,h1_log_positive,h1_raw_step_positive,h1_mul_positive]
QED

Definition h1_matches_def:
 (h1_matches (u:int#int) (i:num) [] = T) /\
 (h1_matches u i (v::vs) =
   let x = full_residue i in
     h1_gate x /\ raw_head 10004 u (h1_fast_state x) = v /\ h1_matches u (SUC i) vs)
End
Definition h1_table_def:
 h1_table (blocks:num list) = let hs=full_heads blocks in
   LENGTH hs=4800 /\ h1_gate 10004 /\ h1_matches (h1_fast_state 10004) 0 hs
End
val _ = cv_auto_trans h1_matches_def;
val _ = cv_auto_trans h1_table_def;
Theorem h1_matches_sound:
 !hs u i. h1_matches u i hs ==> !j. j < LENGTH hs ==>
   0 < full_residue (i+j) /\ EL j hs = raw_head 10004 u (srh_state (full_residue (i+j)) 1)
Proof
 Induct >- simp [] >> rpt gen_tac >> SIMP_TAC bool_ss [h1_matches_def,LET_THM] >>
 strip_tac >> gen_tac >> Cases_on `j` >> simp [h1_gate_positive,h1_fast_state_correct] >>
 metis_tac [arithmeticTheory.ADD_CLAUSES,h1_fast_state_correct,h1_gate_positive]
QED
Theorem h1_table_sound:
 !bs. h1_table bs ==> LENGTH (full_heads bs) = 4800 /\
   !i. i<4800 ==> 0<full_residue i /\
    EL i (full_heads bs) = raw_head 10004 (srh_state 10004 1) (srh_state (full_residue i) 1)
Proof
 gen_tac >> SIMP_TAC bool_ss [h1_table_def,LET_THM] >> strip_tac >>
 mp_tac (Q.SPECL [`full_heads bs`,`h1_fast_state 10004`,`0:num`] h1_matches_sound) >>
 asm_simp_tac (srw_ss()) [h1_fast_state_correct]
QED
