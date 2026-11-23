Theorem actual_row_angles:
  !n r k. MEM (n,r) rows /\ k<n ==>
    k*(120 DIV n)<120 /\ ang (k*(120 DIV n)) = 2*pi* &k / &n
Proof
  rpt strip_tac >>
  `MEM n (MAP FST rows)` by (mp_tac (Q.SPECL [`FST:num#(int#int)list->num`,`rows`,`(n,r)`] MEM_MAP_f) >>
                             simp[]) >>
  fs[checked_rows] >> gvs[] >> simp[ang_def, GSYM REAL_MUL] >>
  TRY decide_tac >> REAL_ARITH_TAC
QED

Theorem shifted_sine:
  !j. cos (ang (j+90)) = sin (ang j)
Proof
  gen_tac >> simp[ang_add,ang_special] >>
  `ang j + (pi/2+pi) = (ang j + pi/2) + pi` by REAL_ARITH_TAC >>
  asm_rewrite_tac[COS_PERIODIC_PI,COS_ADD,COS_PI2,SIN_PI2] >> REAL_ARITH_TAC
QED

Theorem actual_coordinates:
  !n r k. MEM (n,r) rows /\ k<n ==>
    near (FST (EL k r)) (cos (2*pi* &k / &n)) /\
    near (SND (EL k r)) (sin (2*pi* &k / &n))
Proof
  rpt gen_tac >> strip_tac >>
  `rowok (n,r)` by metis_tac[EVERY_MEM,checked_rows] >>
  `EL k r = expected n k` by fs[rowok_def] >>
  `k*(120 DIV n)<120 /\ ang (k*(120 DIV n)) = 2*pi* &k / &n`
    by metis_tac[actual_row_angles] >>
  `k*(120 DIV n)<240 /\ k*(120 DIV n)+90<240` by decide_tac >>
  asm_rewrite_tac[expected_def,LET_THM] >> BETA_TAC >>
  simp[] >> metis_tac[wave_near,shifted_sine]
QED
