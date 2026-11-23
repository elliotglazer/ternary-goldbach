e(rpt gen_tac >> strip_tac);
e(`1+cos(2*x)=2*cos x pow 2` by (mp_tac(Q.SPEC `x` SIN_CIRCLE) >> PURE_REWRITE_TAC[COS_DOUBLE] >> RealField.REAL_ASM_ARITH_TAC));
e(`0<=cos x /\ l pow 2<=cos x pow 2 /\ cos x pow 2<=h pow 2` by RealField.REAL_ASM_ARITH_TAC);
e(`l<=cos x /\ cos x<=h` by metis_tac[nonnegative_sq_order]);
e(`s*cos x<=s*h /\ t*l<=t*cos x` by metis_tac[REAL_LE_LMUL_IMP]);
e(`s*cos x<=sin x*cos x /\ sin x*cos x<=t*cos x` by (fs[SIN_DOUBLE] >> RealField.REAL_ASM_ARITH_TAC));
e(metis_tac[REAL_LE_RMUL]);
p();
