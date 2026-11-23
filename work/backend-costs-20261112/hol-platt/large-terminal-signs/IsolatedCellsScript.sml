Theory IsolatedCells
Ancestors CofactorNeighbourhood ZeroFreeGap FullCount lim real list arithmetic
Libs realLib

Definition root_cell_def:
  root_cell f x r m y <=> x < r /\ r < y /\
    (!t. x <= t /\ t <= y ==> $contl f t) /\
    (!t. x <= t /\ t <= y /\ t <> r ==> f t <> 0) /\
    ?g e. 0 < e /\ $contl g r /\ g r <> 0 /\
          !t. abs(t-r) < e ==> f t = (t-r) pow m * g t
End

Theorem exterior_gap:
  !f x r y a b. x <= a /\ a <= b /\ b <= y /\ (b < r \/ r < a) /\
    (!t. x <= t /\ t <= y ==> $contl f t) /\
    (!t. x <= t /\ t <= y /\ t <> r ==> f t <> 0) ==>
    ZeroFreeGap$zero_free_gap f a b
Proof
  rpt gen_tac >> strip_tac >> simp_tac std_ss[ZeroFreeGapTheory.zero_free_gap_def] >>
  rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >>
  TRY (gen_tac >> disch_then strip_assume_tac) >>
  first_x_assum match_mp_tac >> REAL_ASM_ARITH_TAC
QED

Theorem inner_points:
  !(x:real) r y d. x < r /\ r < y /\ 0 < d ==>
    ?a b. x < a /\ r-d < a /\ a < r /\ r < b /\ b < r+d /\ b < y
Proof
  rpt strip_tac >> qabbrev_tac `w = min d (min (r-x) (y-r))` >>
  `0 < w /\ w <= d /\ w <= r-x /\ w <= y-r` by
    (simp[Abbr`w`,REAL_LT_MIN,REAL_MIN_LE] >> REAL_ASM_ARITH_TAC) >>
  map_every qexists_tac [`r-w/2`,`r+w/2`] >> REAL_ASM_ARITH_TAC
QED

Theorem root_cell_sign:
  !f x r m y. root_cell f x r m y ==>
    (0 < f y) = (if EVEN m then 0 < f x else ~(0 < f x))
Proof
  rpt gen_tac >> simp_tac std_ss[root_cell_def] >> strip_tac >>
  qspecl_then [`f`,`g`,`r`,`m`,`e`] (fn th =>
    mp_tac th >> impl_tac >- (rpt conj_tac >> first_assum ACCEPT_TAC)) CofactorNeighbourhoodTheory.local_factor_brackets >> strip_tac >>
  qspecl_then [`x`,`r`,`y`,`d`] (fn th =>
    mp_tac th >> impl_tac >- (rpt conj_tac >> first_assum ACCEPT_TAC)) inner_points >> strip_tac >>
  `ZeroFreeGap$bracket f a r m b` by (first_x_assum match_mp_tac >> rpt conj_tac >> first_assum ACCEPT_TAC) >>
  `ZeroFreeGap$zero_free_gap f x a /\ ZeroFreeGap$zero_free_gap f b y` by
    (conj_tac >| [qspecl_then [`f`,`x`,`r`,`y`,`x`,`a`] irule exterior_gap,
                  qspecl_then [`f`,`x`,`r`,`y`,`b`,`y`] irule exterior_gap] >>
     rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >>
     TRY (disj1_tac >> first_assum ACCEPT_TAC) >> TRY (disj2_tac >> first_assum ACCEPT_TAC) >>
     metis_tac[REAL_LE_REFL,REAL_LT_IMP_LE,REAL_LE_TRANS]) >>
  qspecl_then [`f`,`a`,`r`,`m`,`b`] mp_tac ZeroFreeGapTheory.bracket_sign >>
  qspecl_then [`f`,`x`,`a`] mp_tac ZeroFreeGapTheory.gap_sign >>
  qspecl_then [`f`,`b`,`y`] mp_tac ZeroFreeGapTheory.gap_sign >>
  Cases_on `EVEN m` >> asm_simp_tac bool_ss[] >> tautLib.TAUT_TAC
QED

Definition cells_def:
  (cells f x [] z <=> ZeroFreeGap$zero_free_gap f x z) /\
  (cells f x ((r,m,y)::xs) z <=> root_cell f x r m y /\ cells f y xs z)
End

Theorem cells_endpoint:
  !xs f x z. cells f x xs z ==>
    (0 < f z) = FullCount$endpoint (0 < f x) (MAP (FST o SND) xs)
Proof
  Induct >- (simp[cells_def,FullCountTheory.endpoint_def] >> metis_tac[ZeroFreeGapTheory.gap_sign]) >>
  gen_tac >> PairCases_on `h` >> simp[cells_def,FullCountTheory.endpoint_def] >>
  rpt gen_tac >> strip_tac >>
  qspecl_then [`f`,`x`,`h0`,`h1`,`h2`] mp_tac root_cell_sign >>
  first_x_assum (qspecl_then [`f`,`h2`,`z`] mp_tac) >> simp[]
QED

Theorem cells_parity:
  !xs f x z. cells f x xs z ==>
    ((0 < f x <=> 0 < f z) <=> EVEN (SUM (MAP (FST o SND) xs)))
Proof
  rpt strip_tac >> drule cells_endpoint >>
  Cases_on `EVEN (SUM (MAP (FST o SND) xs))` >> simp[FullCountTheory.endpoint_parity] >> metis_tac[]
QED
