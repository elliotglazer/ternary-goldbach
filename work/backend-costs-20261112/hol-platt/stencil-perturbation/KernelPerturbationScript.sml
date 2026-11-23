Theory KernelPerturbation
Ancestors StencilPerturbation KernelWeights integer list

Theorem assess_l1:
  !ws r j first f den norm.
  KernelWeights$assess r j first f den norm ws ==>
  norm + weight_l1 ws < 5*den
Proof
  Induct_on `ws` >- simp [KernelWeightsTheory.assess_def,weight_l1_def] >>
  rpt gen_tac >>
  Cases_on `KernelWeights$basis_products r 0 j first f 1 1` >>
  simp [KernelWeightsTheory.assess_def,weight_l1_def,INT_ADD_ASSOC] >>
  metis_tac []
QED

Theorem kernel_ok_l1:
  !r off den ws. KernelWeights$kernel_ok r off den ws ==>
  weight_l1 ws < 5*den
Proof
  rpt gen_tac >> simp [KernelWeightsTheory.kernel_ok_def] >> rpt strip_tac >>
  drule assess_l1 >> simp []
QED

Theorem kernel_ok_dot_perturbation:
  !r off den ws xs ys e. KernelWeights$kernel_ok r off den ws /\
  LENGTH ws = LENGTH xs /\ 0 <= e /\
  LIST_REL (\x y. ABS (x-y) <= e) xs ys ==>
  ABS (StencilReceipt$dot ws xs - StencilReceipt$dot ws ys) <= (5*den)*e
Proof
  rpt strip_tac >>
  drule kernel_ok_l1 >> strip_tac >>
  `ABS (StencilReceipt$dot ws xs - StencilReceipt$dot ws ys) <= weight_l1 ws * e`
    by metis_tac [dot_perturbation_l1] >>
  Cases_on `e=0` >- fs [] >>
  `0<e` by intLib.ARITH_TAC >>
  `e * weight_l1 ws <= e * (5*den)` by (simp [INT_LE_MONO] >> intLib.ARITH_TAC) >>
  metis_tac [INT_MUL_COMM,INT_LE_TRANS]
QED

Theorem dot_map_scale:
  !ws ys (a:int).
  StencilReceipt$dot ws (MAP (\x. a*x) ys) = a*StencilReceipt$dot ws ys
Proof
  Induct_on `ws` >- simp [StencilReceiptTheory.dot_def] >>
  rpt gen_tac >> Cases_on `ys` >> simp [StencilReceiptTheory.dot_def] >>
  intLib.INT_RING_TAC
QED

Theorem compressed_dot_perturbation:
  !r off den ws xs ys a e. KernelWeights$kernel_ok r off den ws /\
  LENGTH ws = LENGTH xs /\ 0 <= e /\
  LIST_REL (\x y. ABS (x-y) <= e) xs (MAP (\y. a*y) ys) ==>
  ABS (StencilReceipt$dot ws xs - a*StencilReceipt$dot ws ys) <= (5*den)*e
Proof
  metis_tac [dot_map_scale,kernel_ok_dot_perturbation]
QED
