Theory C10004RootNorm
Ancestors C10004RootRows RootRows complex transc intreal real list
Libs realLib
val _ = realLib.prefer_real();

Theorem near_decoded:
  !q x. near q x ==> abs (real_of_int q/scale-x) < 1/(2*scale)
Proof
  rw[near_def,scale_def,abs] >> REAL_ASM_ARITH_TAC
QED

Theorem pair_error:
  !x y:real. abs x < 1/(2*scale) /\ abs y < 1/(2*scale) ==> modu (x,y) < 1/scale
Proof
  rpt strip_tac >>
  `!z:real. abs z < 1/(2*scale) ==> z pow 2 < (1/(2*scale)) pow 2`
    by (rpt strip_tac >> mp_tac (Q.SPECL [`2`,`abs z`,`1/(2*scale)`] REAL_POW_LT2) >>
        asm_rewrite_tac[REAL_ABS_POS,REAL_POW2_ABS] >> simp[]) >>
  `x pow 2 < (1/(2*scale)) pow 2 /\ y pow 2 < (1/(2*scale)) pow 2` by metis_tac[] >>
  `x pow 2 + y pow 2 < (1/scale) pow 2` by (fs[scale_def] >> REAL_ASM_ARITH_TAC) >>
  `0 <= x pow 2 + y pow 2` by metis_tac[REAL_LE_POW2,REAL_LE_ADD] >>
  `0 <= 1/scale` by simp[scale_def] >>
  mp_tac (Q.SPECL [`x pow 2 + y pow 2`,`(1/scale) pow 2`] SQRT_MONO_LT) >>
  simp[modu,RE,IM,POW_2_SQRT]
QED

Theorem actual_complex_error:
  !n r k. MEM (n,r) rows /\ k<n ==>
    modu ((real_of_int (FST (EL k r))/scale,real_of_int (SND (EL k r))/scale) -
          (cos (2*pi* &k / &n),sin (2*pi* &k / &n))) < 1/scale
Proof
  rpt gen_tac >> strip_tac >>
  `!a b c d:real. (a,b)-(c,d)=(a-c,b-d)` by simp[complex_sub,complex_add,complex_neg,RE,IM,real_sub] >>
  asm_rewrite_tac[] >> irule pair_error >>
  mp_tac (Q.SPECL [`n:num`,`r:(int#int)list`,`k:num`] actual_coordinates) >>
  metis_tac[near_decoded]
QED
