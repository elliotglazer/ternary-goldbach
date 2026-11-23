Theory C10004RootAnalytic
Ancestors transc arithmetic real
Libs realLib RealField

Theorem sin_step:
  !a t:real. sin (a+t) = 2*cos t*sin a - sin (a-t)
Proof
  rw[real_sub, SIN_ADD, SIN_NEG, COS_NEG] >> REAL_ARITH_TAC
QED

Definition chebU_def:
  (chebU 0 (x:real) = 1) /\
  (chebU (SUC 0) x = 2*x) /\
  (chebU (SUC (SUC n)) x = 2*x*chebU (SUC n) x - chebU n x)
End

Theorem chebU_sin_pair:
  !t n. sin t * chebU n (cos t) = sin (&(SUC n)*t) /\
        sin t * chebU (SUC n) (cos t) = sin (&(SUC (SUC n))*t)
Proof
  gen_tac >> Induct_on `n`
  >- (simp[chebU_def] >> `2*(t:real) = t+t` by REAL_ARITH_TAC >>
      asm_rewrite_tac[SIN_ADD] >> REAL_ARITH_TAC) >>
  fs[] >> REWRITE_TAC[chebU_def] >>
  `!p q r:real. p * (q*r) = q*(p*r)` by REAL_ARITH_TAC >>
  PURE_ONCE_REWRITE_TAC[REAL_SUB_LDISTRIB] >>
  qpat_x_assum `!p q r. _`
    (fn th => CONV_TAC (LAND_CONV (LAND_CONV (REWR_CONV th)))) >>
  asm_rewrite_tac[] >>
  mp_tac (Q.SPECL [`t * &(SUC (SUC n))`,`t`] sin_step) >>
  simp[GSYM REAL_OF_NUM_SUC, REAL_ADD_LDISTRIB] >>
  PURE_REWRITE_TAC[GSYM REAL_OF_NUM_ADD, GSYM REAL_OF_NUM_SUC,
                   REAL_ADD_LDISTRIB, REAL_MUL_RID] >>
  `!a b:real. a+b-b=a` by REAL_ARITH_TAC >> asm_rewrite_tac[] >> metis_tac[]
QED

Theorem chebU_sin:
  !n t. sin t * chebU n (cos t) = sin (&(SUC n)*t)
Proof
  metis_tac[chebU_sin_pair]
QED




Theorem chebU59_cos_root:
  !j:num. 0 < j /\ j < 60 ==> chebU 59 (cos (&j*pi/60)) = 0
Proof
  rpt strip_tac >> `0:real < &j /\ &j < 60` by simp[] >>
  `0 < &j*pi/60 /\ &j*pi/60 < pi`
    by (simp[REAL_LT_RDIV_EQ, REAL_LT_LDIV_EQ, REAL_LT_MUL, PI_POS] >>
        metis_tac[REAL_LT_RMUL, PI_POS, REAL_MUL_COMM]) >>
  `60 * (&j*pi/60) = &j*pi` by REAL_ARITH_TAC >>
  mp_tac (SIMP_RULE std_ss [] (Q.SPECL [`59`,`&j*pi/60`] chebU_sin)) >>
  asm_rewrite_tac[SIN_NPI, REAL_ENTIRE] >> metis_tac[SIN_POS_PI, REAL_LT_REFL]
QED
