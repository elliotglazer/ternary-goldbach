Theory OffLinePair
Ancestors pred_set arithmetic combin

(* Take left to be the roots strictly left of the line in the closed
   height band. Its reflected image supplies the other half. *)
Theorem reflected_multiplicity_sum:
  !left reflect mult.
    FINITE left /\ INJ reflect left UNIV /\
    DISJOINT left (IMAGE reflect left) /\
    (!z. z IN left ==> mult (reflect z) = mult z) ==>
    SIGMA mult (left UNION IMAGE reflect left) = 2 * SIGMA mult left
Proof
  rpt strip_tac >>
  `SIGMA (mult o reflect) left = SIGMA mult left` by
    (irule SUM_IMAGE_CONG >> simp[]) >>
  `SIGMA mult (IMAGE reflect left) = SIGMA (mult o reflect) left` by
    metis_tac[SUM_IMAGE_INJ_o] >>
  simp[SUM_IMAGE_DISJOINT] >> decide_tac
QED
