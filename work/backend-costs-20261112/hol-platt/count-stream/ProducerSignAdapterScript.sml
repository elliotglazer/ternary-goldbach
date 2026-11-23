(* Explicit boundary between C10004 enclosure codes and stream codes.
   No analytic assumption is proved by decoding a natural number. *)
Theory ProducerSignAdapter
Ancestors SignBracketStream option list
Libs cv_transLib

Definition decode_producer_def:
  decode_producer (code:num) =
    if code = 0 then SOME 2
    else if code = 1 then SOME 0
    else if code = 2 then SOME 1 else NONE
End
Definition producer_meaning_def:
  producer_meaning negative positive code <=>
    code <= 2 /\ (code = 0 ==> negative) /\ (code = 2 ==> positive)
End
Definition stream_meaning_def:
  stream_meaning negative positive code <=>
    code <= 2 /\ (code = 2 ==> negative) /\ (code = 1 ==> positive)
End
Definition adapt_rows_def:
  (adapt_rows [] = SOME []) /\
  (adapt_rows ((i,code)::xs) =
    case decode_producer code of
      NONE => NONE
    | SOME status =>
        case adapt_rows xs of
          NONE => NONE
        | SOME ys => SOME ((i,status)::ys))
End
Definition producer_accept_def:
  producer_accept lower upper xs bs <=>
    case adapt_rows xs of NONE => F
    | SOME ys => accept lower upper ys bs
End
Definition producer_has_strict_def:
  producer_has_strict xs <=>
    EXISTS (\row. SND row = 0 \/ SND row = 2) xs
End

Theorem decode_exact:
  decode_producer code = SOME status <=>
    (code = 0 /\ status = 2) \/
    (code = 1 /\ status = 0) \/
    (code = 2 /\ status = 1)
Proof
  rw [decode_producer_def] >> rpt COND_CASES_TAC >> simp [] >> metis_tac []
QED
Theorem malformed_rejected:
  2 < code ==> decode_producer code = NONE
Proof
  simp [decode_producer_def]
QED
Theorem strict_meaning_preserved:
  decode_producer code = SOME status /\
  producer_meaning negative positive code ==>
  stream_meaning negative positive status
Proof
  simp [decode_exact, producer_meaning_def, stream_meaning_def] >> metis_tac []
QED
Theorem strict_implications_preserved:
  decode_producer code = SOME status /\
  (code = 0 ==> negative) /\ (code = 2 ==> positive) ==>
  (status = 2 ==> negative) /\ (status = 1 ==> positive)
Proof
  simp [decode_exact] >> metis_tac []
QED
Theorem unknown_exact:
  decode_producer code = SOME 0 <=> code = 1
Proof
  simp [decode_exact]
QED
Theorem no_implicit_break:
  decode_producer code <> SOME 3
Proof
  simp [decode_exact]
QED
Theorem adapter_preserves_indices:
  !xs ys. adapt_rows xs = SOME ys ==> MAP FST ys = MAP FST xs
Proof
  Induct >> simp [adapt_rows_def] >> PairCases_on `h` >>
  rpt gen_tac >> simp [adapt_rows_def] >>
  Cases_on `decode_producer h1` >> simp [] >>
  Cases_on `adapt_rows xs` >> simp [] >> metis_tac []
QED
Theorem malformed_head_rejected:
  2 < code ==> adapt_rows ((i,code)::xs) = NONE
Proof
  simp [adapt_rows_def, malformed_rejected]
QED
Theorem all_unknown_adapted:
  !indices. adapt_rows (MAP (\i. (i,1)) indices) =
            SOME (MAP (\i. (i,0)) indices)
Proof
  Induct >> simp [adapt_rows_def, decode_producer_def]
QED
Theorem all_unknown_no_brackets:
  !indices a s. brackets a s (MAP (\i. (i,0)) indices) = []
Proof
  Induct >> simp [inconclusive_preserves_anchor, brackets_def]
QED
Theorem all_unknown_no_strict_output:
  !indices. ~producer_has_strict (MAP (\i. (i,1)) indices)
Proof
  Induct >> simp [producer_has_strict_def]
QED
Theorem all_unknown_accepted_count_zero:
  producer_accept lower upper (MAP (\i. (i,1)) indices) bs ==>
    bs = [] /\ lower_count bs = 0
Proof
  simp [producer_accept_def, all_unknown_adapted] >> strip_tac >>
  imp_res_tac accepted_exact_output >>
  fs [all_unknown_no_brackets, lower_count_def]
QED

val _ = cv_auto_trans decode_producer_def;
val _ = cv_auto_trans adapt_rows_def;
val _ = cv_auto_trans producer_accept_def;
val _ = cv_auto_trans producer_has_strict_def;
