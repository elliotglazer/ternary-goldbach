Theory RootSignChain
Ancestors real FullCount list arithmetic
Libs realLib

(* u and v are the nonzero cofactor values at two points straddling r. *)
Theorem factored_crossing:
  !(x:real) r y u v m.
    x < r /\ r < y /\
    ((0 < u /\ 0 < v) \/ (u < 0 /\ v < 0)) ==>
    ((0 < (y-r) pow m * v) =
     (if EVEN m then 0 < (x-r) pow m * u else ~(0 < (x-r) pow m * u)))
Proof
  rpt gen_tac >> strip_tac >>
  `(0:real) < y-r /\ ~(y-r < 0) /\ x-r < 0 /\ ~(0 < x-r)` by
    (rpt (pop_assum mp_tac) >> REAL_ARITH_TAC) >>
  Cases_on `m = 0` >> Cases_on `EVEN m` >>
  fs[REAL_MUL_POS_LT,REAL_POW_POS,REAL_POW_NEG,ODD_EVEN] >>
  metis_tac[EVEN,REAL_LT_ANTISYM]
QED

Definition certified_crossings_def:
  (certified_crossings f x [] z <=> (0 < f x <=> 0 < f z)) /\
  (certified_crossings f x ((r,m,y)::xs) z <=>
    (?u v. x < r /\ r < y /\ ((0 < u /\ 0 < v) \/ (u < 0 /\ v < 0)) /\
           f x = (x-r) pow m * u /\ f y = (y-r) pow m * v) /\
    certified_crossings f y xs z)
End

Theorem crossing_chain_endpoint:
  !xs f x z. certified_crossings f x xs z ==>
    (0 < f z) = FullCount$endpoint (0 < f x) (MAP (FST o SND) xs)
Proof
  Induct >> simp[certified_crossings_def,FullCountTheory.endpoint_def] >>
  gen_tac >> PairCases_on `h` >>
  simp[certified_crossings_def,FullCountTheory.endpoint_def] >>
  rpt gen_tac >> strip_tac >>
  `(((0:real) < f h2) = (if EVEN h1 then 0 < f x else ~(0 < f x)))` by
    (qspecl_then [`x`,`h0`,`h2`,`u`,`v`,`h1`] mp_tac factored_crossing >> simp[]) >>
  pop_assum (fn th => PURE_ONCE_REWRITE_TAC[GSYM th]) >>
  first_x_assum (qspecl_then [`f`,`h2`,`z`] irule) >> first_assum ACCEPT_TAC
QED

Theorem crossing_chain_parity:
  !xs f x z. certified_crossings f x xs z ==>
    ((0 < f x <=> 0 < f z) <=> EVEN (SUM (MAP (FST o SND) xs)))
Proof
  rpt strip_tac >> drule crossing_chain_endpoint >>
  Cases_on `EVEN (SUM (MAP (FST o SND) xs))` >>
  simp[FullCountTheory.endpoint_parity] >> metis_tac[]
QED
