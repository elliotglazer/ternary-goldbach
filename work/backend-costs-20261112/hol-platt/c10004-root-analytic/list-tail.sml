Definition binroot_def:
  binroot c = @x. endpoint (2*c-1) < x /\ x < endpoint (2*c+1) /\ chebU 59 x=0
End

Theorem binroot_bounds:
  !c. signok c ==> 0 < binroot c /\ binroot c < 1 /\
    endpoint (2*c-1) < binroot c /\ binroot c < endpoint (2*c+1) /\ chebU 59 (binroot c)=0
Proof
  gen_tac >> strip_tac >> drule_then strip_assume_tac signok_interval >>
  `endpoint (2*c-1) < binroot c /\ binroot c < endpoint (2*c+1) /\ chebU 59 (binroot c)=0`
    by (PURE_REWRITE_TAC[binroot_def] >> SELECT_ELIM_TAC >> metis_tac[]) >>
  metis_tac[REAL_LT_TRANS]
QED

Theorem bins_members:
  !cs i. bins cs /\ i<LENGTH cs ==> signok (EL i cs)
Proof
  Induct >> simp[bins_def] >> Cases_on `i` >> simp[bins_def,EL]
QED

Theorem bins_gap:
  !cs i. bins cs /\ SUC i<LENGTH cs ==> EL (SUC i) cs + 1 < EL i cs
Proof
  Induct >> simp[] >> Cases_on `i`
  >- (Cases_on `cs` >> simp[bins_def,EL]) >> simp[bins_def,EL]
QED

Theorem bins_order:
  !cs d i. bins cs /\ i+SUC d<LENGTH cs ==> EL (i+SUC d) cs + 1 < EL i cs
Proof
  gen_tac >> Induct >- (simp[ADD_CLAUSES,bins_gap] >> metis_tac[bins_gap]) >>
  rpt strip_tac >>
  `i+SUC d<LENGTH cs /\ SUC (i+SUC d)<LENGTH cs` by decide_tac >>
  `EL (i+SUC d) cs + 1 < EL i cs` by metis_tac[] >>
  `EL (SUC (i+SUC d)) cs + 1 < EL (i+SUC d) cs` by metis_tac[bins_gap] >>
  `i+SUC (SUC d) = SUC (i+SUC d)` by decide_tac >> asm_rewrite_tac[] >> intLib.ARITH_TAC
QED

Theorem all_center_intervals:
  !i:num. 0<i /\ i<=29 ==>
    endpoint (2*EL (i-1) centers-1) < cos (&i*pi/60) /\
    cos (&i*pi/60) < endpoint (2*EL (i-1) centers+1)
Proof
  `!i:num. 0<i /\ i<=29 ==> signok (EL (i-1) centers)`
    by (rpt strip_tac >> irule bins_members >> simp[checked_centers] >> decide_tac) >>
  mp_tac (BETA_RULE (Q.SPEC `\i:num. binroot (EL (i-1) centers)` sorted_chebU59_roots)) >>
  impl_tac
  >- (conj_tac >- metis_tac[binroot_bounds] >> rpt strip_tac >>
      `0<j /\ i<=29 /\ (i-1)+SUC (j-i-1)=j-1 /\ j-1<LENGTH centers`
        by (simp[checked_centers] >> decide_tac) >>
      mp_tac (Q.SPECL [`centers`,`j-i-1`,`i-1`] bins_order) >>
      asm_rewrite_tac[checked_centers] >> strip_tac >>
      `2*EL (j-1) centers+1 < 2*EL (i-1) centers-1` by intLib.ARITH_TAC >>
      `endpoint (2*EL (j-1) centers+1) < endpoint (2*EL (i-1) centers-1)`
        by simp[endpoint_def,real_div,REAL_LT_RMUL,REAL_LT_INV_EQ,grid_pos] >>
      metis_tac[binroot_bounds,REAL_LT_TRANS]) >>
  metis_tac[binroot_bounds]
QED
