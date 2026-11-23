(* Source-only candidate. Status 0=inconclusive, 1=strict positive,
   2=strict negative, 3=explicit continuity/domain break. Status bits are
   NOT certificates of actual function values. No concrete signs are supplied. *)
Theory SignBracketStream
Ancestors arithmetic list
Libs cv_transLib

Definition opposite_def:
  opposite s t <=> (s = 1 /\ t = 2) \/ (s = 2 /\ t = 1)
End
Definition next_anchor_def:
  next_anchor a s i t =
    if t = 0 then (a,s) else if t = 3 then (i,0) else (i,t)
End
Definition brackets_def:
  (brackets a s [] = []) /\
  (brackets a s ((i,t)::xs) =
    let (a',s') = next_anchor a s i t in
    if opposite s t then (a,i)::brackets a' s' xs
    else brackets a' s' xs)
End
Definition final_anchor_def:
  (final_anchor a s [] = (a,s)) /\
  (final_anchor a s ((i,t)::xs) =
    let (a',s') = next_anchor a s i t in final_anchor a' s' xs)
End
(* Independent proposed output is consumed exactly once, in stream order.
   Exhausted input must leave no unconsumed proposed bracket. *)
Definition consumes_def:
  (consumes a s [] bs <=> bs = []) /\
  (consumes a s ((i,t)::xs) bs <=>
    let (a',s') = next_anchor a s i t in
    if opposite s t then
      case bs of [] => F
      | b::rest => b = (a,i) /\ consumes a' s' xs rest
    else consumes a' s' xs bs)
End
Definition ordered_def:
  (ordered [] <=> T) /\
  (ordered [x] <=> T) /\
  (ordered (x::y::xs) <=> FST x < FST y /\ ordered (y::xs))
End
Definition chain_def:
  (chain lower upper [] <=> T) /\
  (chain lower upper ((u,v)::bs) <=>
    lower <= u /\ u < v /\ v <= upper /\ chain v upper bs)
End
Definition accept_def:
  accept lower upper xs bs <=>
    lower <= upper /\ ordered xs /\
    EVERY (\row. lower <= FST row /\ FST row <= upper /\ SND row <= 3) xs /\
    consumes lower 0 xs bs /\ chain lower upper bs
End
Definition auxiliary_accept_def:
  auxiliary_accept lower upper xs bs <=>
    accept lower upper xs bs /\
    EVERY (\b. lower < FST b /\ SND b < upper) bs
End
Definition lower_count_def:
  lower_count bs = LENGTH bs
End
Definition weight_ticks_def:
  (weight_ticks upper [] = 0) /\
  (weight_ticks upper ((u,v)::bs) = upper - v + weight_ticks upper bs)
End

Theorem consumes_iff_brackets:
  !xs a s bs. consumes a s xs bs <=> bs = brackets a s xs
Proof
  Induct >> simp [consumes_def, brackets_def] >>
  PairCases_on `h` >> rpt gen_tac >>
  simp [consumes_def, brackets_def, next_anchor_def] >>
  rpt COND_CASES_TAC >> simp [] >> Cases_on `bs` >> simp []
QED
Theorem accepted_exact_output:
  accept lower upper xs bs ==>
    bs = brackets lower 0 xs /\ chain lower upper bs /\ ordered xs
Proof
  simp [accept_def, consumes_iff_brackets]
QED
Theorem inconclusive_preserves_anchor:
  next_anchor a s i 0 = (a,s) /\
  brackets a s ((i,0)::xs) = brackets a s xs
Proof
  simp [next_anchor_def, brackets_def, opposite_def]
QED
Theorem explicit_break_clears_anchor:
  next_anchor a s i 3 = (i,0) /\
  brackets a s ((i,3)::xs) = brackets i 0 xs
Proof
  simp [next_anchor_def, brackets_def, opposite_def]
QED
Theorem empty_claim_count:
  lower_count [] = 0 /\ weight_ticks upper [] = 0
Proof
  simp [lower_count_def, weight_ticks_def]
QED

(* No actual data evaluation here. Translation is a future bounded build gate. *)
val _ = cv_auto_trans accept_def;
val _ = cv_auto_trans auxiliary_accept_def;
val _ = cv_auto_trans lower_count_def;
val _ = cv_auto_trans weight_ticks_def;
val _ = cv_auto_trans brackets_def;
val _ = cv_auto_trans final_anchor_def;
