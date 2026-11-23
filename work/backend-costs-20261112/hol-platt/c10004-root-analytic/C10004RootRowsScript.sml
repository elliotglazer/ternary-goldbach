Theory C10004RootRows
Ancestors C10004RootIntervals C10004RootBridge RootRows RootBins intreal real transc list arithmetic
Libs realLib intLib
val _ = realLib.prefer_real();

Definition scale_def:
  scale = (2417851639229258349412352:real)
End
Definition near_def:
  near q x <=> abs (real_of_int q - scale*x) < 1/2
End
Definition ang_def:
  ang (i:num) = &i*pi/60
End

Theorem pick_el:
  !xs i. i<LENGTH xs ==> pick i xs = EL i xs
Proof
  Induct >> simp[] >> Cases_on `i` >> simp[pick_def,EL]
QED

Theorem quadrant_near:
  !i. i<=30 ==> near (pick i quadrant) (cos (ang i))
Proof
  rpt strip_tac >> Cases_on `i=0`
  >- simp[quadrant_def,pick_def,near_def,ang_def,scale_def,COS_0] >>
  Cases_on `i=30`
  >- (asm_rewrite_tac[] >>
      `ang 30 = pi/2` by (rw[ang_def] >> REAL_ARITH_TAC) >>
      `pick 30 quadrant = 0` by EVAL_TAC >>
      asm_rewrite_tac[COS_PI2,near_def] >> simp[]) >>
  `0<i /\ i<=29` by decide_tac >>
  `i < LENGTH quadrant` by (simp[quadrant_def,checked_centers] >> decide_tac) >>
  `pick i quadrant = EL (i-1) centers`
    by (simp[pick_el,quadrant_def] >> Cases_on `i` >>
        fs[EL,EL_APPEND_EQN,checked_centers]) >>
  mp_tac (Q.SPEC `i:num` all_center_intervals) >> asm_rewrite_tac[] >>
  simp[endpoint_def,grid_def,ang_def,scale_def,near_def,abs] >> REAL_ARITH_TAC
QED

Theorem near_neg:
  !q x. near (-q) (-x) <=> near q x
Proof
  rpt gen_tac >> PURE_REWRITE_TAC[near_def,real_of_int_neg] >> `-real_of_int q-scale * -x = -(real_of_int q-scale*x)` by REAL_ARITH_TAC >>
  asm_rewrite_tac[ABS_NEG]
QED

Theorem ang_add:
  !i j. ang (i+j) = ang i + ang j
Proof
  rpt gen_tac >> PURE_REWRITE_TAC[ang_def,GSYM REAL_OF_NUM_ADD] >> REAL_ARITH_TAC
QED

Theorem ang_special:
  ang 60 = pi /\ ang 120 = 2*pi /\ ang 90 = pi/2+pi
Proof
  rw[ang_def] >> REAL_ARITH_TAC
QED

Theorem wave_base:
  !i. i<120 ==> near (wave i) (cos (ang i))
Proof
  rpt strip_tac >> simp[wave_def,LESS_MOD] >> Cases_on `i<=30` >> asm_rewrite_tac[]
  >- metis_tac[quadrant_near] >>
  Cases_on `i<=60` >> asm_rewrite_tac[]
  >- (`60-i<=30 /\ (60-i)+i=60` by decide_tac >>
      `ang i = -ang (60-i)+pi` by
        (mp_tac (Q.SPECL [`60-i`,`i:num`] ang_add) >> asm_rewrite_tac[ang_special] >> REAL_ARITH_TAC) >>
      asm_rewrite_tac[COS_PERIODIC_PI,COS_NEG,near_neg] >> metis_tac[quadrant_near]) >>
  Cases_on `i<=90` >> asm_rewrite_tac[]
  >- (`i-60<=30 /\ (i-60)+60=i` by decide_tac >>
      `ang i = ang (i-60)+pi` by metis_tac[ang_add,ang_special] >>
      once_asm_rewrite_tac[] >> simp[COS_PERIODIC_PI,near_neg,quadrant_near]) >>
  `120-i<=30 /\ (120-i)+i=120` by decide_tac >>
  `ang i = -ang (120-i)+2*pi` by
    (mp_tac (Q.SPECL [`120-i`,`i:num`] ang_add) >> asm_rewrite_tac[ang_special] >> REAL_ARITH_TAC) >>
  asm_rewrite_tac[COS_PERIODIC,COS_NEG] >> metis_tac[quadrant_near]
QED

Theorem wave_near:
  !i. i<240 ==> near (wave i) (cos (ang i))
Proof
  rpt strip_tac >> Cases_on `i<120` >- metis_tac[wave_base] >>
  `i-120<120 /\ (i-120)+120=i` by decide_tac >>
  `ang i = ang (i-120)+2*pi` by metis_tac[ang_add,ang_special] >>
  `i MOD 120=(i-120) MOD 120` by metis_tac[ADD_MODULUS] >>
  `wave i = wave (i-120)` by asm_rewrite_tac[wave_def] >>
  metis_tac[COS_PERIODIC,wave_base]
QED
Theorem actual_row_angles:
  !n r k. MEM (n,r) rows /\ k<n ==>
    k*(120 DIV n)<120 /\ ang (k*(120 DIV n)) = 2*pi* &k / &n
Proof
  rpt gen_tac >> strip_tac >>
  `MEM n (MAP FST rows)` by
    (mp_tac (ISPECL [``FST : (num # ((int # int) list)) -> num``, ``rows``,
                     ``(n:num,r:(int#int)list)``] MEM_MAP_f) >> simp[]) >>
  fs[checked_rows] >> gvs[] >> simp[ang_def] >> TRY decide_tac
QED

Theorem shifted_sine:
  !j. cos (ang (j+90)) = sin (ang j)
Proof
  gen_tac >> PURE_REWRITE_TAC[ang_add,ang_special] >>
  `ang j + (pi/2+pi) = (ang j + pi/2) + pi` by REAL_ARITH_TAC >>
  asm_rewrite_tac[COS_PERIODIC_PI,COS_ADD,COS_PI2,SIN_PI2] >> REWRITE_TAC[SIN_PERIODIC_PI,SIN_PI2] >> REAL_ARITH_TAC
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
  PURE_REWRITE_TAC[pairTheory.FST,pairTheory.SND] >> metis_tac[wave_near,shifted_sine]
QED

