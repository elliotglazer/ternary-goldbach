Theory C10004RootOrder
Ancestors C10004RootAnalytic transc arithmetic real
Libs realLib

Theorem cosine_decreasing:
  !a b. 0 <= a /\ a < b /\ b <= pi ==> cos b < cos a
Proof
  rpt strip_tac >>
  qabbrev_tac `m = (a+b)/2` >> qabbrev_tac `h = (b-a)/2` >>
  `0 < m /\ m < pi /\ 0 < h /\ h < pi` by
    (unabbrev_all_tac >> REAL_ASM_ARITH_TAC) >>
  `0 < sin m * sin h` by metis_tac[SIN_POS_PI, REAL_LT_MUL] >>
  `b = m+h /\ a = m + -h` by (unabbrev_all_tac >> REAL_ASM_ARITH_TAC) >>
  asm_rewrite_tac[COS_ADD,COS_NEG,SIN_NEG] >> REAL_ASM_ARITH_TAC
QED

Theorem chebU_root_angle:
  !x. 0 < x /\ x < 1 /\ chebU 59 x = 0 ==>
      ?j:num. 0 < j /\ j < 30 /\ x = cos (&j*pi/60)
Proof
  rpt strip_tac >>
  `-1 < x /\ -1 <= x /\ x <= 1` by REAL_ASM_ARITH_TAC >>
  `cos (acs x) = x /\ 0 < acs x /\ acs x < pi`
    by metis_tac[ACS_COS, ACS_BOUNDS_LT] >>
  `acs x < pi/2` by
    (CCONTR_TAC >> Cases_on `acs x = pi/2` >- metis_tac[COS_PI2,REAL_LT_REFL] >>
     `0 <= pi/2 /\ pi/2 < acs x /\ acs x <= pi` by
       (mp_tac PI_POS >> REAL_ASM_ARITH_TAC) >>
     metis_tac[cosine_decreasing,COS_PI2,REAL_LT_ANTISYM]) >>
  mp_tac (SIMP_RULE std_ss [] (Q.SPECL [`59`,`acs x`] chebU_sin)) >>
  asm_rewrite_tac[REAL_MUL_RZERO] >> strip_tac >>
  `0 <= 60*acs x` by REAL_ASM_ARITH_TAC >>
  `?n. EVEN n /\ 60*acs x = &n*(pi/2)` by metis_tac[SIN_ZERO_LEMMA] >>
  fs[EVEN_EXISTS] >> qexists_tac `m` >> qpat_x_assum `n = _` SUBST_ALL_TAC >>
  `60*acs x = &m*pi` by (qpat_x_assum `120*_ = _` mp_tac >>
    PURE_REWRITE_TAC[GSYM REAL_MUL] >> REAL_ARITH_TAC) >>
  `0 < &m*pi /\ &m*pi < 30*pi` by REAL_ASM_ARITH_TAC >>
  `0:real < &m /\ &m < 30` by
    (mp_tac (Q.SPECL [`0`,`&m`,`pi`] REAL_LT_RMUL) >>
     mp_tac (Q.SPECL [`&m`,`30`,`pi`] REAL_LT_RMUL) >>
     asm_simp_tac std_ss [PI_POS,REAL_MUL_LZERO]) >>
  fs[] >> `acs x = pi * &m / 60` by REAL_ASM_ARITH_TAC >> metis_tac[]
QED
Theorem increasing_index_gap:
  !f:num->num. !N. (!i j. 0 < i /\ i < j /\ j <= N ==> f i < f j) ==>
    !d i. 0 < i /\ i+d <= N ==> f i+d <= f (i+d)
Proof
  rpt gen_tac >> strip_tac >> Induct_on `d` >- simp[] >>
  rpt strip_tac >>
  `f i + d <= f (i+d)` by (first_x_assum match_mp_tac >> decide_tac) >>
  `f (i+d) < f (i+SUC d)` by (first_x_assum match_mp_tac >> decide_tac) >>
  decide_tac
QED

Theorem increasing_index_identity:
  !f:num->num. !N.
    (!i. 0 < i /\ i <= N ==> 0 < f i /\ f i <= N) /\
    (!i j. 0 < i /\ i < j /\ j <= N ==> f i < f j) ==>
    !i. 0 < i /\ i <= N ==> f i = i
Proof
  rpt strip_tac >>
  `0:num < 1 /\ 1 <= N /\ 0 < N /\ N <= N` by decide_tac >>
  `0 < f 1 /\ f N <= N` by metis_tac[] >>
  mp_tac (Q.SPECL [`f`, `N`] increasing_index_gap) >> impl_tac >- metis_tac[] >>
  disch_then (fn th => mp_tac (Q.SPECL [`i-1`,`1`] th) >>
                        mp_tac (Q.SPECL [`N-i`,`i`] th)) >>
  `i+(N-i)=N /\ 1+(i-1)=i` by decide_tac >> asm_rewrite_tac[] >> decide_tac
QED

Theorem cos_index_decreasing:
  !i j:num. 0<i /\ i<j /\ j<=29 ==> cos (&j*pi/60) < cos (&i*pi/60)
Proof
  rpt strip_tac >> irule cosine_decreasing >>
  `0:real < &i /\ &i < &j /\ &j <= 29` by simp[] >>
  `&i*pi < &j*pi /\ 0 < &i*pi /\ &j*pi <= 29*pi`
    by simp[REAL_LT_RMUL,REAL_LE_RMUL,REAL_LT_MUL,PI_POS] >>
  mp_tac PI_POS >> REAL_ASM_ARITH_TAC
QED

Theorem sorted_chebU59_roots:
  !w:num->real.
    (!i. 0<i /\ i<=29 ==> 0<w i /\ w i<1 /\ chebU 59 (w i)=0) /\
    (!i j. 0<i /\ i<j /\ j<=29 ==> w j<w i) ==>
    !i. 0<i /\ i<=29 ==> w i=cos (&i*pi/60)
Proof
  gen_tac >> strip_tac >>
  `!i:num. ?j:num. 0<i /\ i<=29 ==> 0<j /\ j<=29 /\ w i = cos (&j*pi/60)`
    by (gen_tac >> Cases_on `0<i /\ i<=29`
        >- (qpat_x_assum `!i. _ ==> _ /\ _ /\ _` (mp_tac o Q.SPEC `i:num`) >>
            asm_rewrite_tac[] >> strip_tac >> drule_all_then strip_assume_tac chebU_root_angle >>
            qexists_tac `j` >> asm_rewrite_tac[] >> decide_tac) >> metis_tac[]) >>
  pop_assum (strip_assume_tac o SIMP_RULE std_ss [SKOLEM_THM]) >>
  `!i j. 0<i /\ i<j /\ j<=29 ==> f i < f j`
    by (rpt strip_tac >> `0<j /\ i<=29` by decide_tac >>
        qpat_x_assum `!i. _ ==> _ /\ _ /\ w i = _`
          (fn th => mp_tac (Q.SPEC `i:num` th) >> mp_tac (Q.SPEC `j:num` th)) >>
        asm_rewrite_tac[] >> rpt strip_tac >> `w j < w i` by metis_tac[] >>
        Cases_on `f i < f j` >- asm_rewrite_tac[] >>
        Cases_on `f i = f j` >- metis_tac[REAL_LT_REFL] >>
        `f j < f i` by decide_tac >> metis_tac[cos_index_decreasing,REAL_LT_ANTISYM]) >>
  mp_tac (Q.SPECL [`f`,`29`] increasing_index_identity) >> impl_tac >- metis_tac[] >> metis_tac[]
QED
Theorem chebU_ge_one:
  !x:real. 1<=x ==> !n. 1<=chebU n x /\ chebU n x <= chebU (SUC n) x
Proof
  gen_tac >> strip_tac >> Induct >- (simp[chebU_def] >> REAL_ASM_ARITH_TAC) >>
  strip_tac >> `0 <= chebU (SUC n) x` by REAL_ASM_ARITH_TAC >>
  `0 <= (x-1)*chebU (SUC n) x` by (irule REAL_LE_MUL >> REAL_ASM_ARITH_TAC) >>
  PURE_ONCE_REWRITE_TAC[chebU_def] >> REAL_ASM_ARITH_TAC
QED

Theorem chebU59_positive_roots:
  !x. (0<x /\ chebU 59 x = 0) <=> ?j:num. 0<j /\ j<30 /\ x=cos (&j*pi/60)
Proof
  gen_tac >> eq_tac >> strip_tac
  >- (irule chebU_root_angle >> asm_rewrite_tac[] >> CCONTR_TAC >>
      `1<=x` by REAL_ASM_ARITH_TAC >>
      mp_tac (Q.SPEC `59` (MATCH_MP (Q.SPEC `x` chebU_ge_one) (ASSUME ``1<=x:real``))) >>
      asm_rewrite_tac[] >> REAL_ARITH_TAC) >>
  asm_rewrite_tac[] >> conj_tac
  >- (irule COS_POS_PI2 >> `0:real < &j /\ &j < 30` by simp[] >>
      `0 < &j*pi /\ &j*pi < 30*pi` by simp[REAL_LT_MUL, REAL_LT_RMUL, PI_POS] >>
      REAL_ASM_ARITH_TAC) >>
  irule chebU59_cos_root >> decide_tac
QED
