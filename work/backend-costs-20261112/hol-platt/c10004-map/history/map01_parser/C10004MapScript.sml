(* Candidate finite map. No evaluations/builds performed by the author.
   Exact checks must pass before any selected-root/map claim is accepted. *)
Theory C10004Map
Ancestors arithmetic list sorting gcd
Libs cv_transLib

Definition local41_def:
  local41 b = (6 ** b) MOD 41
End
Definition local61_def:
  local61 c = (2 ** c) MOD 61
End
Definition residue_def:
  residue i =
    (2501 * (if i DIV 2400 = 0 then 1 else 3) +
     4880 * local41 ((i DIV 60) MOD 40) + 2624 * local61 (i MOD 60)) MOD 10004
End
Definition unit_map_def:
  unit_map = GENLIST residue 4800
End
Definition expected_units_def:
  expected_units = FILTER (\r. gcd r 10004 = 1) (GENLIST I 10004)
End
Definition inv_input_def:
  inv_input i = (i DIV 2400) * 2400 +
    ((40 - ((i DIV 60) MOD 40)) MOD 40) * 60 +
    ((60 - (i MOD 60)) MOD 60)
End
Definition retained_label_def:
  retained_label i = (1, 1 + i DIV 59, 1 + i MOD 59)
End
Definition inv_label_def:
  inv_label i = 2300 - i
End
Definition label_ok_def:
  label_ok i =
    i < 2301 /\ inv_label i < 2301 /\ inv_label (inv_label i) = i /\
    retained_label (inv_label i) =
      (1, (40 - (1 + i DIV 59)) MOD 40,
          (60 - (1 + i MOD 59)) MOD 60)
End
Definition coordinate_ok_def:
  coordinate_ok i =
    residue i MOD 4 = (if i DIV 2400 = 0 then 1 else 3) /\
    residue i MOD 41 = local41 ((i DIV 60) MOD 40) /\
    residue i MOD 61 = local61 (i MOD 60) /\
    inv_input i < 4800 /\ inv_input (inv_input i) = i /\
    (residue i * residue (inv_input i)) MOD 10004 = 1
End
Definition finite_checks_def:
  finite_checks <=>
    10004 = 4 * 41 * 61 /\
    local41 40 = 1 /\ local61 60 = 1 /\
    ALL_DISTINCT (GENLIST local41 40) /\
    ALL_DISTINCT (GENLIST local61 60) /\
    QSORT ($<=) (GENLIST local41 40) = GENLIST (\i. i+1) 40 /\
    QSORT ($<=) (GENLIST local61 60) = GENLIST (\i. i+1) 60 /\
    LENGTH unit_map = 4800 /\ LENGTH expected_units = 4800 /\
    QSORT ($<=) unit_map = expected_units /\
    EVERY coordinate_ok (GENLIST I 4800) /\
    EVERY label_ok (GENLIST I 2301) /\
    LENGTH (GENLIST retained_label 2301) = 2301 /\
    EVERY (\i. let (a,b,c) = retained_label i in
      a = 1 /\ 1 <= b /\ b <= 39 /\ 1 <= c /\ c <= 59 /\
      (b-1)*59+(c-1) = i) (GENLIST I 2301)
End

(* Higher-order calls specialize to the displayed fixed functions. Translation
   and all preconditions must succeed through the stock library. *)
val _ = cv_auto_trans finite_checks_def;
val evaluated = cv_eval ``finite_checks``;
val _ = if null (hyp evaluated) andalso
           aconv (lhs (concl evaluated)) ``finite_checks`` andalso
           aconv (rhs (concl evaluated)) ``T`` then ()
        else raise Fail "finite map checker did not close true";
val finite_map_checked = save_thm("finite_map_checked", EQT_ELIM evaluated);

Theorem map_sorted_units:
  QSORT ($<=) unit_map = expected_units
Proof
  metis_tac [finite_map_checked, finite_checks_def]
QED
Theorem map_permutation:
  PERM unit_map expected_units
Proof
  metis_tac [map_sorted_units, QSORT_PERM]
QED
Theorem expected_units_distinct:
  ALL_DISTINCT expected_units
Proof
  rw [expected_units_def] >> irule FILTER_ALL_DISTINCT >>
  simp [ALL_DISTINCT_GENLIST]
QED
Theorem unit_map_distinct:
  ALL_DISTINCT unit_map
Proof
  metis_tac [map_permutation, expected_units_distinct, ALL_DISTINCT_PERM]
QED
Theorem unit_map_complete:
  !r. MEM r unit_map <=> r < 10004 /\ gcd r 10004 = 1
Proof
  gen_tac >>
  `MEM r unit_map = MEM r expected_units` by metis_tac [map_sorted_units, QSORT_MEM] >>
  simp [expected_units_def, MEM_FILTER, MEM_GENLIST]
QED
Theorem coordinates_checked:
  !i. i < 4800 ==> coordinate_ok i
Proof
  metis_tac [finite_map_checked, finite_checks_def, EVERY_MEM, MEM_GENLIST, I_THM]
QED
Theorem labels_checked:
  !i. i < 2301 ==> label_ok i
Proof
  metis_tac [finite_map_checked, finite_checks_def, EVERY_MEM, MEM_GENLIST, I_THM]
QED

val _ = print "C10004_MAP_CHECKED,4800,2301,2,40,60\n";
