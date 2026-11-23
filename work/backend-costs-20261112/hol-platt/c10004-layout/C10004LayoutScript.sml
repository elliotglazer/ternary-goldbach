(* Source-only candidate. Root must build/check before accepting any result.
   No character, DFT, interpolation or analytic identity is asserted. *)
Theory C10004Layout
Ancestors C10004Map arithmetic list sorting
Libs cv_transLib

val _ = numLib.prefer_num ();

Definition old_to_tensor_def:
  old_to_tensor i = 2 * (40 * (i MOD 60) + (i DIV 60) MOD 40) + i DIV 2400
End
Definition tensor_to_old_def:
  tensor_to_old t = 2400 * (t MOD 2) + 60 * ((t DIV 2) MOD 40) + t DIV 80
End
Definition tensor_residue_def:
  tensor_residue t =
    (2501 * (if t MOD 2 = 0 then 1 else 3) +
     4880 * local41 ((t DIV 2) MOD 40) + 2624 * local61 (t DIV 80)) MOD 10004
End
Definition fine_cell_def:
  fine_cell a = (2048 * a + 10003) DIV 20008
End
Definition old_checks_def:
  old_checks i <=>
    i DIV 2400 < 2 /\ (i DIV 60) MOD 40 < 40 /\ i MOD 60 < 60 /\
    i = 2400 * (i DIV 2400) + 60 * ((i DIV 60) MOD 40) + i MOD 60 /\
    old_to_tensor i < 4800 /\ tensor_to_old (old_to_tensor i) = i /\
    tensor_residue (old_to_tensor i) = residue i
End
Definition tensor_checks_def:
  tensor_checks t <=>
    t MOD 2 < 2 /\ (t DIV 2) MOD 40 < 40 /\ t DIV 80 < 60 /\
    t = 2 * (40 * (t DIV 80) + (t DIV 2) MOD 40) + t MOD 2 /\
    tensor_to_old t < 4800 /\ old_to_tensor (tensor_to_old t) = t /\
    tensor_residue t = residue (tensor_to_old t) /\
    0 < tensor_residue t /\ tensor_residue t < 10004 /\
    fine_cell (tensor_residue t) <= 1024 /\
    2 * fine_cell (tensor_residue t) * 10004 < 2048 * tensor_residue t + 10004 /\
    2048 * tensor_residue t <= (2 * fine_cell (tensor_residue t) + 1) * 10004
End
Definition layout_finite_checks_def:
  layout_finite_checks <=>
    EVERY old_checks (GENLIST I 4800) /\
    EVERY tensor_checks (GENLIST I 4800)
End

val _ = cv_auto_trans layout_finite_checks_def;
val evaluated = cv_eval ``layout_finite_checks``;
val _ = if null (hyp evaluated) andalso
           aconv (boolSyntax.lhs (concl evaluated)) ``layout_finite_checks`` andalso
           aconv (boolSyntax.rhs (concl evaluated)) ``T`` then ()
        else raise Fail "layout finite checks did not close true";
val layout_checked = Theory.save_thm ("layout_checked", EQT_ELIM evaluated);

Theorem layout_old_properties:
  !i. i < 4800 ==> old_checks i
Proof
  metis_tac [layout_checked, layout_finite_checks_def, EVERY_MEM, MEM_GENLIST, combinTheory.I_THM]
QED
Theorem layout_tensor_properties:
  !t. t < 4800 ==> tensor_checks t
Proof
  metis_tac [layout_checked, layout_finite_checks_def, EVERY_MEM, MEM_GENLIST, combinTheory.I_THM]
QED
Theorem old_to_tensor_injective:
  !i j. i < 4800 /\ j < 4800 /\ old_to_tensor i = old_to_tensor j ==> i = j
Proof
  metis_tac [layout_old_properties, old_checks_def]
QED
Theorem layout_coverage:
  !t. t < 4800 <=> ?i. i < 4800 /\ old_to_tensor i = t
Proof
  metis_tac [layout_old_properties, old_checks_def,
             layout_tensor_properties, tensor_checks_def]
QED
Theorem layout_exactly_once:
  !t. t < 4800 ==> ?!i. i < 4800 /\ old_to_tensor i = t
Proof
  simp [EXISTS_UNIQUE_THM] >>
  metis_tac [layout_coverage, old_to_tensor_injective]
QED
Theorem tensor_positions_distinct:
  ALL_DISTINCT (GENLIST old_to_tensor 4800)
Proof
  SIMP_TAC bool_ss [ALL_DISTINCT_GENLIST] >> metis_tac [old_to_tensor_injective]
QED
Theorem tensor_positions_members:
  !t. MEM t (GENLIST old_to_tensor 4800) <=> MEM t (GENLIST I 4800)
Proof
  SIMP_TAC bool_ss [MEM_GENLIST,combinTheory.I_THM] >> metis_tac [layout_coverage]
QED
Theorem layout_permutation:
  PERM (GENLIST old_to_tensor 4800) (GENLIST I 4800)
Proof
  `ALL_DISTINCT (GENLIST I 4800)` by
    SIMP_TAC bool_ss [ALL_DISTINCT_GENLIST,combinTheory.I_THM] >>
  metis_tac [PERM_ALL_DISTINCT, tensor_positions_distinct, tensor_positions_members]
QED
Theorem layout_preserves_residue:
  !i. i < 4800 ==> tensor_residue (old_to_tensor i) = residue i
Proof
  metis_tac [layout_old_properties, old_checks_def]
QED
Theorem tensor_source_residue:
  !t. t < 4800 ==> tensor_residue t = residue (tensor_to_old t)
Proof
  metis_tac [layout_tensor_properties, tensor_checks_def]
QED
Theorem fine_cell_checked:
  !t. t < 4800 ==>
    0 < tensor_residue t /\ tensor_residue t < 10004 /\
    fine_cell (tensor_residue t) <= 1024 /\
    2 * fine_cell (tensor_residue t) * 10004 < 2048 * tensor_residue t + 10004 /\
    2048 * tensor_residue t <= (2 * fine_cell (tensor_residue t) + 1) * 10004
Proof
  metis_tac [layout_tensor_properties, tensor_checks_def]
QED

val _ = print "C10004_LAYOUT_CHECKED,4800,1025,2,40,60\n";
