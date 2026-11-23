Theory ZeroFreeGap
Ancestors RootSignChain FullCount lim real list arithmetic

Definition zero_free_gap_def:
  zero_free_gap f a b <=> a <= b /\ f a <> 0 /\ f b <> 0 /\
    (!t. a <= t /\ t <= b ==> $contl f t) /\
    (!t. a < t /\ t < b ==> f t <> 0)
End

Theorem gap_sign:
  !f a b. zero_free_gap f a b ==> (0 < f a <=> 0 < f b)
Proof
  rw_tac std_ss[zero_free_gap_def] >>
  `!t. a <= t /\ t <= b ==> f t <> 0` by metis_tac[REAL_LE_LT] >>
  qspecl_then [`f`,`a`,`b`,`0:real`] mp_tac IVT >>
  qspecl_then [`f`,`a`,`b`,`0:real`] mp_tac IVT2 >>
  metis_tac[REAL_NOT_LT,REAL_LT_IMP_LE]
QED

Definition bracket_def:
  bracket f a r m b <=> a < r /\ r < b /\
    ?u v. ((0 < u /\ 0 < v) \/ (u < 0 /\ v < 0)) /\
          f a = (a-r) pow m * u /\ f b = (b-r) pow m * v
End

Theorem bracket_sign:
  !f a r m b. bracket f a r m b ==>
    (0 < f b) = (if EVEN m then 0 < f a else ~(0 < f a))
Proof
  rpt gen_tac >> simp[bracket_def] >> strip_tac >>
  qspecl_then [`a`,`r`,`b`,`u`,`v`,`m`] mp_tac RootSignChainTheory.factored_crossing >> simp[]
QED

Definition ordered_brackets_def:
  (ordered_brackets f x [] z <=> zero_free_gap f x z) /\
  (ordered_brackets f x ((a,r,m,b)::xs) z <=>
    zero_free_gap f x a /\ bracket f a r m b /\ ordered_brackets f b xs z)
End

Theorem ordered_endpoint:
  !xs f x z. ordered_brackets f x xs z ==>
    (0 < f z) = FullCount$endpoint (0 < f x) (MAP (FST o SND o SND) xs)
Proof
  Induct >- (simp[ordered_brackets_def,FullCountTheory.endpoint_def] >> metis_tac[gap_sign]) >>
  gen_tac >> PairCases_on `h` >>
  simp[ordered_brackets_def,FullCountTheory.endpoint_def] >> rpt gen_tac >> strip_tac >>
  `((0:real) < f x) = (0 < f h0)` by metis_tac[gap_sign] >>
  `((0:real) < f h3) = (if EVEN h2 then 0 < f h0 else ~(0 < f h0))` by
    (qspecl_then [`f`,`h0`,`h1`,`h2`,`h3`] mp_tac bracket_sign >> simp[]) >>
  first_x_assum (qspecl_then [`f`,`h3`,`z`] mp_tac) >> simp[]
QED

Theorem ordered_parity:
  !xs f x z. ordered_brackets f x xs z ==>
    ((0 < f x <=> 0 < f z) <=> EVEN (SUM (MAP (FST o SND o SND) xs)))
Proof
  rpt strip_tac >> drule ordered_endpoint >>
  Cases_on `EVEN (SUM (MAP (FST o SND o SND) xs))` >>
  simp[FullCountTheory.endpoint_parity] >> metis_tac[]
QED
