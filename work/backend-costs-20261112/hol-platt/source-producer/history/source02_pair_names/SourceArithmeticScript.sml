(* Candidate numerical source code only. No concrete evaluation is performed.
   Analytic error and rational-domain transport are not asserted by this file.
   All rounding uses the original nearest-ties-to-positive-infinity rule. *)
Theory SourceArithmetic
Ancestors BlockRound arithmetic integer list option logroot

(* This is the literal RawLogHorner recurrence, with natural rational A/B. *)
Definition source_log_horner_def:
  (source_log_horner (S:num) (A:num) (B:num) 0 k = (0:int)) /\
  (source_log_horner S A B (SUC n) k =
    round_scaled (&(2*k+1) * &B ** 2)
      (&S * &B ** 2 + &(2*k+1) * &A ** 2 *
        source_log_horner S A B n (SUC k)))
End

Definition source_log_center_def:
  source_log_center S A B n =
    round_scaled (&B) (2 * &A * source_log_horner S A B n 0)
End

(* The actual logarithm input is x=A/D. Natural subtraction below is valid
   only under this range gate. An exponent is a checked integer input, not
   an assumed logarithm or a supplied approximate phase. *)
Definition source_log_domain_def:
  source_log_domain (A:num) (D:num) k <=>
    0 < D /\ 2 ** k * D <= A /\ A <= 2 * 2 ** k * D
End

Definition source_log_from_two_def:
  source_log_from_two S n out_div (l2:int) k A D =
    round_scaled (&out_div)
      (&k * l2 + source_log_center S (A - 2 ** k * D)
        (A + 2 ** k * D) n)
End

Definition source_log_checked_def:
  source_log_checked S n out_div l2 k A D =
    if 0 < S /\ 0 < out_div /\ source_log_domain A D k then
      SOME (source_log_from_two S n out_div l2 k A D)
    else NONE
End

(* Exact reproduction of the raw program's 45 terms, inner grid137 and
   eight-bit output regrid. No error theorem is imported from Lean. *)
Definition source_raw_log129_def:
  source_raw_log129 k x =
    source_log_from_two (2 ** 137) 45 256
      (source_log_center (2 ** 137) 1 3 45) k x 1
End

(* Phase is i*(p/d). The terminal one and every affine update match Lean. *)
Definition source_exp_step_def:
  source_exp_step (S:num) (p:int) (d:num) k (wr:int,wi:int) =
    let den = &d * &(k+1) in
      (round_scaled den (&S * den - p * wi),
       round_scaled den (p * wr))
End

Definition source_exp_horner_def:
  (source_exp_horner S p d 0 k = (&S, (0:int))) /\
  (source_exp_horner S p d (SUC n) k =
    source_exp_step S p d k (source_exp_horner S p d n (SUC k)))
End

Definition source_regrid_def:
  source_regrid bits (wr:int,wi:int) =
    (round_scaled (&(2 ** bits)) wr, round_scaled (&(2 ** bits)) wi)
End

Definition source_raw_step_def:
  source_raw_step (q:int) =
    source_regrid 9
      (source_exp_horner (2 ** 131) (~5*q) (2 ** 135) 72 0)
End

(* Baseline p138 cis branch for the EM step. l145 approximates log(x) on
   grid145 and pi161 approximates pi on grid161. Their required error
   contracts are NOT consequences of these types. No constants are supplied.
   Keep the signed period reduction and BOTH final regrids:151->144->142. *)
Definition source_em_step_from_log_pi_def:
  source_em_step_from_log_pi (l145:int) (pi161:int) =
    if 0 < pi161 then
      let phase161 = ~5 * l145 * &(2 ** 10);
          turns = round_scaled (2*pi161) phase161;
          reduced161 = phase161 - 2*turns*pi161;
          inner = source_exp_horner (2 ** 151) reduced161
                    (2 ** 161) 82 0
      in SOME (source_regrid 2 (source_regrid 7 inner))
    else NONE
End

(* ROOT 2 has existing numeral computation equations in logroot. This is
   the rational extension of Nat.sqrt((S*S)/x), not an external root oracle.
   The adjacent-square/real approximation proof remains a separate task. *)
Definition source_inverse_root_def:
  source_inverse_root (A:num) (D:num) (S:num) =
    ROOT 2 ((D*S*S) DIV A)
End

Definition source_initial_def:
  source_initial A D amplitude_bits state_bits =
    if 0 < D /\ D <= A /\ amplitude_bits <= state_bits then
      SOME ((&(source_inverse_root A D (2 ** amplitude_bits)) *
                &(2 ** (state_bits-amplitude_bits)), (0:int)))
    else NONE
End

Definition source_raw_initial_def:
  source_raw_initial x = source_initial x 1 98 120
End

(* x=(512+k)/512; the pool caller must also enforce k<=113152. *)
Definition source_em_initial_def:
  source_em_initial k = source_initial (512+k) 512 123 140
End

(* Left input/output grid is persistent; step_scale is the right operand's grid. *)
Definition source_mul_def:
  source_mul (step_scale:num) (ur:int,ui:int) (vr:int,vi:int) =
    (round_scaled (&step_scale) (ur*vr-ui*vi),
     round_scaled (&step_scale) (ur*vi+ui*vr))
End

Definition source_state_def:
  (source_state step_scale initial step 0 = initial) /\
  (source_state step_scale initial step (SUC j) =
    source_mul step_scale (source_state step_scale initial step j) step)
End

(* entries are (persistent state, fixed step); no lower-grid feedback. *)
Definition source_pool_tick_def:
  source_pool_tick step_scale entries =
    MAP (\entry. (source_mul step_scale (FST entry) (SND entry), SND entry)) entries
End

Theorem source_log_checked_domain:
  !S n out_div l2 k A D q.
    source_log_checked S n out_div l2 k A D = SOME q ==>
    0 < S /\ 0 < out_div /\ source_log_domain A D k
Proof
  rw [source_log_checked_def] >> fs []
QED

Theorem source_pool_tick_length:
  !step_scale entries. LENGTH (source_pool_tick step_scale entries) = LENGTH entries
Proof
  simp [source_pool_tick_def]
QED

Theorem source_mul_residuals:
  !step_scale ur ui vr vi. 0 < (&step_scale:int) ==>
    -(&step_scale) <= 2*((ur*vr-ui*vi) - FST (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) /\
    2*((ur*vr-ui*vi) - FST (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) < &step_scale /\
    -(&step_scale) <= 2*((ur*vi+ui*vr) - SND (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) /\
    2*((ur*vi+ui*vr) - SND (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) < &step_scale
Proof
  rpt gen_tac >> strip_tac >>
  simp_tac bool_ss [source_mul_def, FST, SND] >>
  metis_tac [round_scaled_residual]
QED

(* No cv_eval, concrete theorem, external numerical literal, or analytic axiom.
   CV translation is deliberately a later, separately reviewed build task. *)
