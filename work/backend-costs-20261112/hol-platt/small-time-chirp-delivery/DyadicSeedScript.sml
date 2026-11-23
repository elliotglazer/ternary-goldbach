Theory DyadicSeed
Ancestors transc real
Libs realLib RealField
val _=realLib.prefer_real();
Theorem nonnegative_sq_order:
 !a b:real. 0<=a /\ 0<=b /\ a pow 2<=b pow 2 ==> a<=b
Proof
 rpt strip_tac >> mp_tac(Q.SPECL [`a pow 2`,`b pow 2`] SQRT_MONO_LE) >> simp[REAL_LE_POW2,POW_2_SQRT]
QED
Theorem halve_box:
 !x cl cu sl su l h s t:real.
  0<cos x /\ 0<=l /\ 0<=h /\ 0<=s /\ 0<=t /\
  cl<=cos(2*x) /\ cos(2*x)<=cu /\ sl<=sin(2*x) /\ sin(2*x)<=su /\
  2*l pow 2<=1+cl /\ 1+cu<=2*h pow 2 /\ 2*(s*h)<=sl /\ su<=2*(t*l) ==>
  l<=cos x /\ cos x<=h /\ s<=sin x /\ sin x<=t
Proof
 rpt gen_tac >> strip_tac >>
 `1+cos(2*x)=2*cos x pow 2` by
   (mp_tac(Q.SPEC `x` SIN_CIRCLE) >> PURE_REWRITE_TAC[COS_DOUBLE] >> RealField.REAL_ASM_ARITH_TAC) >>
 `0<=cos x /\ l pow 2<=cos x pow 2 /\ cos x pow 2<=h pow 2` by RealField.REAL_ASM_ARITH_TAC >>
 `l<=cos x /\ cos x<=h` by metis_tac[nonnegative_sq_order] >>
 `s*cos x<=s*h /\ t*l<=t*cos x` by metis_tac[REAL_LE_LMUL_IMP] >>
 `s*cos x<=sin x*cos x /\ sin x*cos x<=t*cos x` by
     (mp_tac(Q.SPEC `x` SIN_DOUBLE) >> RealField.REAL_ASM_ARITH_TAC) >>
 metis_tac[REAL_LE_RMUL]
QED
Definition ang_def:
 (ang 0 = pi/2) /\ (ang (SUC n)=ang n/2)
End
Theorem ang_pos:
 !n. 0<ang n /\ ang n<=pi/2
Proof
 Induct >> simp[ang_def] >> mp_tac PI_POS >> RealField.REAL_ASM_ARITH_TAC
QED
Theorem next_box:
 !k (cl:real) cu sl su l h s t.
  0<=l /\ 0<=h /\ 0<=s /\ 0<=t /\
  cl<=cos(ang k) /\ cos(ang k)<=cu /\ sl<=sin(ang k) /\ sin(ang k)<=su /\
  2*l pow 2<=1+cl /\ 1+cu<=2*h pow 2 /\ 2*(s*h)<=sl /\ su<=2*(t*l) ==>
  l<=cos(ang(SUC k)) /\ cos(ang(SUC k))<=h /\ s<=sin(ang(SUC k)) /\ sin(ang(SUC k))<=t
Proof
 rpt gen_tac >> strip_tac >>
 `0<cos(ang (SUC k))` by
  (irule COS_POS_PI >> mp_tac (Q.SPEC `k` ang_pos) >>
   simp[ang_def] >> mp_tac PI_POS >> RealField.REAL_ASM_ARITH_TAC) >>
 `2*ang(SUC k)=ang k` by (simp[ang_def] >> RealField.REAL_ARITH_TAC) >>
 mp_tac(Q.SPECL [`ang(SUC k)`,`cl`,`cu`,`sl`,`su`,`l`,`h`,`s`,`t`] halve_box) >> asm_rewrite_tac[]
QED

Theorem ang_closed:
 !k. ang k=pi / (2 pow (SUC k))
Proof
 Induct >> simp[ang_def,pow] >> RealField.REAL_ASM_FIELD_TAC
QED
