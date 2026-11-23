(* Exact integer signs only; no analytic sign or zero-count claim. *)
Theory RawCompactSigns
Ancestors RawStateHandoff integer list option
Libs intLib cv_transLib

Definition raw_sign_code_def:
  raw_sign_code (x:int) =
    if x < 0 then (0:num) else if x = 0 then 1 else 2
End

Definition raw_sign_digit_def:
  raw_sign_digit (r:int,i:int) = raw_sign_code r + 3 * raw_sign_code i
End

(* Time zero occupies the least significant base-nine digit. *)
Definition raw_sign_pack_def:
  (raw_sign_pack [] = (0:num)) /\
  (raw_sign_pack (p::ps) = raw_sign_digit p + 9 * raw_sign_pack ps)
End

(* This relation exposes every coordinate comparison, not a hash contract. *)
Definition raw_sign_mask_rel_def:
  (raw_sign_mask_rel [] n <=> n = (0:num)) /\
  (raw_sign_mask_rel (p::ps) n <=>
    ?tail. n = raw_sign_digit p + 9 * tail /\
           raw_sign_mask_rel ps tail)
End

Definition raw_compact_of_def:
  (raw_compact_of NONE = NONE) /\
  (raw_compact_of (SOME rows) = SOME (MAP raw_sign_pack rows))
End

Definition raw_sign_summary_rel_def:
  (raw_sign_summary_rel NONE NONE <=> T) /\
  (raw_sign_summary_rel NONE (SOME masks) <=> F) /\
  (raw_sign_summary_rel (SOME rows) NONE <=> F) /\
  (raw_sign_summary_rel (SOME rows) (SOME masks) <=>
    LIST_REL raw_sign_mask_rel rows masks)
End

Definition raw_compact_def:
  raw_compact bases c n sources =
    raw_compact_of (raw_pipeline bases c n sources)
End

Theorem raw_sign_code_meaning:
  !x. (raw_sign_code x = 0 <=> x < 0) /\
      (raw_sign_code x = 1 <=> x = 0) /\
      (raw_sign_code x = 2 <=> 0 < x)
Proof
  gen_tac >> Cases_on `x < 0` >> Cases_on `x = 0` >>
  simp [raw_sign_code_def] >> intLib.ARITH_TAC
QED

Theorem raw_sign_digit_bound:
  !r i. raw_sign_digit (r,i) < 9
Proof
  rpt gen_tac >> rw [raw_sign_digit_def,raw_sign_code_def]
QED

Theorem raw_sign_mask_rel_iff:
  !row n. raw_sign_mask_rel row n <=> n = raw_sign_pack row
Proof
  Induct >> simp [raw_sign_mask_rel_def,raw_sign_pack_def]
QED

Theorem raw_sign_rows_correct:
  !rows. LIST_REL raw_sign_mask_rel rows (MAP raw_sign_pack rows)
Proof
  Induct >> simp [raw_sign_mask_rel_iff]
QED

Theorem raw_compact_of_correct:
  !output. raw_sign_summary_rel output (raw_compact_of output)
Proof
  Cases >> simp [raw_compact_of_def,raw_sign_summary_rel_def,
                 raw_sign_rows_correct]
QED

Theorem raw_compact_correct:
  !bases c n sources.
    raw_sign_summary_rel (raw_pipeline bases c n sources)
      (raw_compact bases c n sources)
Proof
  simp [raw_compact_def,raw_compact_of_correct]
QED

val _ = cv_trans raw_sign_code_def;
val _ = cv_trans raw_sign_digit_def;
val _ = cv_trans raw_sign_pack_def;
val _ = cv_auto_trans raw_compact_of_def;
val _ = cv_trans raw_compact_def;
val _ = print "RAW_COMPACT_GENERIC_INTEGER_SIGNS_DONE\n";
