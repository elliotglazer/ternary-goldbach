Theory C10004RootBridge
Ancestors C10004RootOrder C10004RootAnalytic RootBins lim intreal real arithmetic list
Libs realLib intLib

val _ = realLib.prefer_real();
val cont2 = BETA_RULE (MATCH_MP
  (Q.SPECL [`\z:real. 2:real`,`\z:real. z`,`x:real`] CONT_MUL)
  (CONJ (Q.SPECL [`2`,`x`] CONT_CONST) (MATCH_MP
    (Q.SPECL [`\z:real. z`,`1`,`x`] DIFF_CONT) (Q.SPEC `x` DIFF_X))));

Theorem chebU_continuous:
  !x n. $contl (chebU n) x /\ $contl (chebU (SUC n)) x
Proof
  gen_tac >> Induct
  >- (`chebU 0 = (\z. 1) /\ chebU (SUC 0) = (\z. 2*z)`
        by simp[FUN_EQ_THM,chebU_def] >> asm_rewrite_tac[CONT_CONST,cont2]) >>
  fs[] >> `chebU (SUC (SUC n)) = (\z. 2*z*chebU (SUC n) z-chebU n z)`
    by simp[FUN_EQ_THM,chebU_def] >> asm_rewrite_tac[] >>
  mp_tac (BETA_RULE (Q.SPECL [`\z. 2*z`, `chebU (SUC n)`,`x`] CONT_MUL)) >>
  asm_rewrite_tac[cont2] >> strip_tac >>
  mp_tac (BETA_RULE (Q.SPECL [`\z. 2*z*chebU (SUC n) z`, `chebU n`,`x`] CONT_SUB)) >>
  asm_rewrite_tac[]
QED

Theorem chebU_sign_root:
  !l h. l<h /\ chebU 59 l * chebU 59 h < 0 ==> ?x. l<x /\ x<h /\ chebU 59 x=0
Proof
  rpt strip_tac >> `l<=h` by REAL_ASM_ARITH_TAC >>
  `!x. l<=x /\ x<=h ==> $contl (chebU 59) x` by metis_tac[chebU_continuous] >>
  `!u v:real. u*v<0 ==> (u<0 /\ 0<v) \/ (v<0 /\ 0<u)`
    by (rpt strip_tac >> Cases_on `u<0` >> Cases_on `v<0` >> Cases_on `u=0` >>
        Cases_on `v=0` >> fs[] >> metis_tac[REAL_LE_MUL, REAL_NOT_LT,REAL_NEG_MUL2,
                                            REAL_NEG_GE0,REAL_LT_IMP_LE,REAL_LE_LT]) >>
  `?x. l<=x /\ x<=h /\ chebU 59 x=0` by
    (mp_tac (Q.SPECL [`chebU 59`,`l`,`h`,`0`] IVT) >>
     mp_tac (Q.SPECL [`chebU 59`,`l`,`h`,`0`] IVT2) >> metis_tac[REAL_LT_IMP_LE]) >>
  qexists_tac `x` >> metis_tac[REAL_LE_LT,REAL_LT_REFL]
QED

Definition grid_def:
  grid = (4835703278458516698824704:real)
End

Theorem run_value:
  !n k a x y t.
    real_of_int a = grid*t /\ real_of_int x = grid pow k * chebU k t /\
    real_of_int y = grid pow (SUC k) * chebU (SUC k) t ==>
    real_of_int (run n a x y) = grid pow (n+SUC k) * chebU (n+SUC k) t
Proof
  Induct >- simp[run_def] >> rpt strip_tac >> PURE_ONCE_REWRITE_TAC[run_def] >>
  `SUC n + SUC k = n + SUC (SUC k)` by decide_tac >> asm_rewrite_tac[] >>
  first_x_assum irule >> asm_rewrite_tac[] >>
  PURE_REWRITE_TAC [real_of_int_sub,real_of_int_mul,real_of_int_num,GSYM grid_def] >>
  asm_rewrite_tac[chebU_def,pow] >> REAL_ARITH_TAC
QED

