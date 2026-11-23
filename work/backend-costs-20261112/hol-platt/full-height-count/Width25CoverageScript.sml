Theory Width25Coverage
Ancestors OffLinePair ShortGuard pred_set arithmetic

(* pos and neg are the two critical-line parts of the closed zero set. *)
Theorem exact_count_from_coverage:
  !roots pos neg left reflect mult k1 k2.
    roots = (pos UNION neg) UNION (left UNION IMAGE reflect left) /\
    FINITE pos /\ FINITE neg /\ FINITE left /\
    DISJOINT pos neg /\
    DISJOINT (pos UNION neg) (left UNION IMAGE reflect left) /\
    INJ reflect left UNIV /\ DISJOINT left (IMAGE reflect left) /\
    (!z. z IN left ==> mult (reflect z) = mult z) /\
    (EVEN (SIGMA mult pos) <=> EVEN k1) /\
    (EVEN (SIGMA mult neg) <=> EVEN k2) /\
    k1 + k2 <= SIGMA mult roots /\ SIGMA mult roots < k1 + k2 + 2 ==>
    SIGMA mult roots = k1 + k2
Proof
  rpt strip_tac >>
  `SIGMA mult (left UNION IMAGE reflect left) = 2 * SIGMA mult left` by
    metis_tac[OffLinePairTheory.reflected_multiplicity_sum] >>
  `SIGMA mult roots = SIGMA mult pos + SIGMA mult neg + 2 * SIGMA mult left` by
    simp[SUM_IMAGE_DISJOINT] >>
  metis_tac[ShortGuardTheory.exact_pair_count]
QED
