Theory CofactorNeighbourhood
Ancestors ZeroFreeGap lim real arithmetic
Libs realLib

Theorem continuous_cofactor_sign:
  !g r. $contl g r /\ g r <> 0 ==>
    ?d. 0 < d /\ !t. abs(t-r) < d ==>
      ((0 < g r /\ 0 < g t) \/ (g r < 0 /\ g t < 0))
Proof
  rpt gen_tac >> simp_tac std_ss[CONTL_LIM,LIM] >> strip_tac >>
  `0 < abs(g r)` by metis_tac[ABS_NZ] >>
  first_x_assum (qspec_then `abs(g r)` mp_tac) >> simp[] >> strip_tac >>
  qexists_tac `d` >> simp[] >> rpt strip_tac >>
  Cases_on `t = r` >- (fs[] >> metis_tac[REAL_LT_TOTAL]) >>
  `0 < abs(t-r)` by metis_tac[ABS_NZ,REAL_SUB_0] >>
  `abs(g t-g r) < abs(g r)` by metis_tac[] >>
  pop_assum mp_tac >> rewrite_tac[ABS_BOUNDS_LT] >>
  simp_tac std_ss[abs] >> IF_CASES_TAC >>
  rpt (pop_assum mp_tac) >> REAL_ARITH_TAC
QED

Theorem local_factor_brackets:
  !f g r m e. 0 < e /\ $contl g r /\ g r <> 0 /\
    (!t. abs(t-r) < e ==> f t = (t-r) pow m * g t) ==>
    ?d. 0 < d /\ !a b. r-d < a /\ a < r /\ r < b /\ b < r+d ==>
      ZeroFreeGap$bracket f a r m b
Proof
  rpt gen_tac >> strip_tac >>
  qspecl_then [`g`,`r`] mp_tac continuous_cofactor_sign >> simp[] >> strip_tac >>
  qexists_tac `min e d` >> simp[REAL_LT_MIN] >> rpt strip_tac >>
  `min e d <= e /\ min e d <= d` by simp[REAL_MIN_LE1,REAL_MIN_LE2] >>
  `abs(a-r) < min e d /\ abs(b-r) < min e d` by
    (rewrite_tac[ABS_BOUNDS_LT] >> rpt (pop_assum mp_tac) >> REAL_ARITH_TAC) >>
  `abs(a-r) < e /\ abs(b-r) < e /\ abs(a-r) < d /\ abs(b-r) < d` by metis_tac[REAL_LTE_TRANS] >>
  simp_tac std_ss[ZeroFreeGapTheory.bracket_def] >> simp[] >>
  map_every qexists_tac [`g a`,`g b`] >> simp[] >> metis_tac[REAL_LT_ANTISYM]
QED
