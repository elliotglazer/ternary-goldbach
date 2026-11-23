Theory WeightedSample
Ancestors KernelPerturbation StencilPerturbation StencilReceipt KernelWeights intreal integer real arithmetic list
Libs realLib intLib

Definition weighted_def:
  (weighted ([]:int list) (xs:real list) = 0) /\
  (weighted (w::ws) xs = case xs of [] => 0 | v::vs => real_of_int w*v+weighted ws vs)
End

Theorem cast_abs:
  !w:int. abs(real_of_int w) = real_of_int (ABS w)
Proof
  Cases >> simp [INT_ABS,abs,real_of_int_num,real_of_int_neg]
QED

Theorem sample_step:
  !w v z y a l. abs (v-real_of_int z) <= 2 /\ abs (y-real_of_int a) <= 2*real_of_int l ==>
  abs (real_of_int w*v+y-real_of_int (w*z+a)) <= 2*real_of_int (ABS w+l)
Proof
  rpt gen_tac >> strip_tac >>
  `abs(real_of_int w*(v-real_of_int z)) <= abs(real_of_int w)*2` by
    (REWRITE_TAC [ABS_MUL] >> irule REAL_LE_MUL2 >> simp [ABS_POS]) >>
  `real_of_int w*v+y-real_of_int (w*z+a) =
    real_of_int w*(v-real_of_int z)+(y-real_of_int a)` by
    (simp [REAL_SUB_LDISTRIB] >> realLib.REAL_ARITH_TAC) >>
  mp_tac (Q.SPECL [`real_of_int w*(v-real_of_int z)`,`y-real_of_int a`] ABS_TRIANGLE) >>
  fs [cast_abs] >> realLib.REAL_ASM_ARITH_TAC
QED

Theorem coarse_samples:
  !ws vs zs. LENGTH ws = LENGTH vs /\ LIST_REL (\v z. abs(v-real_of_int z)<=2) vs zs ==>
  abs(weighted ws vs - real_of_int (StencilReceipt$dot ws zs)) <= 2*real_of_int (weight_l1 ws)
Proof
  Induct_on `ws` >- simp [weighted_def,StencilReceiptTheory.dot_def,weight_l1_def] >>
  rpt gen_tac >> Cases_on `vs` >> Cases_on `zs` >>
  simp [weighted_def,StencilReceiptTheory.dot_def,weight_l1_def] >>
  metis_tac [SIMP_RULE (srw_ss()) [] sample_step]
QED

Theorem certified_coarse_samples:
  !r off den ws vs zs. KernelWeights$kernel_ok r off (&den) ws /\ LENGTH ws = LENGTH vs /\
  LIST_REL (\v z. abs(v-real_of_int z)<=2) vs zs ==>
  abs(weighted ws vs - real_of_int (StencilReceipt$dot ws zs)) <= 10 * &den
Proof
  rpt gen_tac >> strip_tac >>
  `abs(weighted ws vs - real_of_int (StencilReceipt$dot ws zs)) <= 2*real_of_int (weight_l1 ws)`
    by metis_tac [coarse_samples] >>
  `weight_l1 ws < 5 * (&den:int)` by metis_tac [kernel_ok_l1] >>
  `real_of_int (weight_l1 ws) < real_of_int (5 * (&den:int))`
    by (PURE_REWRITE_TAC [real_of_int_lt] >> ASM_REWRITE_TAC []) >>
  pop_assum mp_tac >> PURE_REWRITE_TAC [real_of_int_mul,real_of_int_num] >>
  realLib.REAL_ASM_ARITH_TAC
QED
