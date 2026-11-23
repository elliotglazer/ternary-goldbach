Theory StencilPerturbation
Ancestors StencilReceipt integer list
Libs intLib

Definition weight_l1_def:
  (weight_l1 ([]:int list) = 0:int) /\
  (weight_l1 (w::ws) = ABS w + weight_l1 ws)
End

Theorem perturb_step:
  !w x y u v e l:int.
  ABS (x-y) <= e /\ ABS (u-v) <= l*e ==>
  ABS ((w*x+u)-(w*y+v)) <= (ABS w + l)*e
Proof
  rpt strip_tac >>
  `(w*x+u)-(w*y+v) = w*(x-y)+(u-v)` by
    (simp [INT_SUB_LDISTRIB] >> intLib.ARITH_TAC) >>
  `ABS w * ABS (x-y) <= ABS w*e` by
    (Cases_on `w=0` >> fs [INT_LE_MONO]) >>
  `ABS (w*(x-y)) <= ABS w * e` by fs [INT_ABS_MUL] >>
  `ABS (w*(x-y)+(u-v)) <= ABS (w*(x-y)) + ABS (u-v)` by
    metis_tac [INT_ABS_TRIANGLE] >>
  fs [INT_RDISTRIB] >> intLib.ARITH_TAC
QED

Theorem dot_perturbation_l1:
  !ws xs ys e. LENGTH ws = LENGTH xs /\
    LIST_REL (\x y. ABS (x-y) <= e) xs ys ==>
    ABS (StencilReceipt$dot ws xs - StencilReceipt$dot ws ys) <= weight_l1 ws * e
Proof
  Induct_on `ws` >- simp [StencilReceiptTheory.dot_def,weight_l1_def] >>
  rpt gen_tac >> Cases_on `xs` >> Cases_on `ys` >>
  simp [StencilReceiptTheory.dot_def,weight_l1_def] >>
  metis_tac [perturb_step]
QED

