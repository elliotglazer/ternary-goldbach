Theory PreDiagonal
Ancestors complex real
Libs realLib RealField
val _ = realLib.prefer_real ();

Theorem ss_modu_add_square:
  !z w:complex.
    modu (z+w) pow 2 = modu z pow 2 + modu w pow 2 + 2*RE (z*conj w)
Proof
  rpt gen_tac >>
  REWRITE_TAC [MODU_POW2,complex_add,complex_mul,conj,RE,IM,
               pairTheory.FST,pairTheory.SND,POW_2] >>
  RealField.REAL_ASM_ARITH_TAC
QED

Theorem ss_modu_triangle:
  !z w:complex. modu (z+w) <= modu z + modu w
Proof
  rpt gen_tac >>
  `RE (z*conj w) <= modu z * modu w` by
    (metis_tac [RE_IM_LE_MODU,ABS_LE,MODU_MUL,MODU_CONJ,REAL_LE_TRANS]) >>
  `modu (z+w) pow 2 <= (modu z + modu w) pow 2` by
    (REWRITE_TAC [ss_modu_add_square,POW_2] >> RealField.REAL_ASM_ARITH_TAC) >>
  `0 <= modu (z+w) /\ 0 <= modu z + modu w` by
    (simp [MODU_POS,REAL_LE_ADD]) >>
  mp_tac (Q.SPECL [`modu (z+w) pow 2`,`(modu z + modu w) pow 2`] SQRT_MONO_LE) >>
  ASM_SIMP_TAC bool_ss [REAL_LE_POW2,POW_2_SQRT]
QED

Theorem ss_modu_sub_triangle:
  !x y z:complex. modu (x-z) <= modu (x-y) + modu (y-z)
Proof
  rpt gen_tac >>
  mp_tac (Q.SPECL [`x-y`,`y-z`] ss_modu_triangle) >>
  REWRITE_TAC [COMPLEX_SUB_TRIANGLE]
QED
Theorem unit_unpost:
  !c u z:complex. modu c = 1 ==> modu (u - conj c*z) = modu (c*u-z)
Proof
  rpt strip_tac >>
  `c * conj c = (1:complex)` by
    (asm_rewrite_tac [COMPLEX_MUL_RCONJ1,complex_of_num] >> simp[]) >>
  `c * (u - conj c*z) = c*u-z` by
    asm_rewrite_tac [COMPLEX_SUB_LDISTRIB,COMPLEX_MUL_ASSOC,COMPLEX_MUL_LID] >>
  metis_tac [MODU_MUL,REAL_MUL_LID]
QED

Theorem remove_diagonal:
  !c h u v z:complex. !d r e b:real.
    modu c = 1 /\ modu (c-h) <= d /\ modu u <= b /\
    modu (h*u-v) <= r /\ modu (v-z) <= e ==>
    modu (u-conj c*z) <= d*b+r+e
Proof
  rpt gen_tac >> strip_tac >>
  `modu ((u:complex)-conj(c:complex)*(z:complex)) = modu (c*u-z)` by metis_tac[unit_unpost] >>
  `modu ((c:complex)*(u:complex)-(h:complex)*u) = modu (c-h) * modu u` by
    REWRITE_TAC [GSYM COMPLEX_SUB_RDISTRIB,MODU_MUL] >>
  `modu ((c:complex)-(h:complex)) * modu (u:complex) <= d*b` by
    (match_mp_tac REAL_LE_MUL2 >> simp[MODU_POS]) >>
  mp_tac (Q.SPECL [`(c:complex)*(u:complex)`,`(h:complex)*(u:complex)`,`z:complex`] ss_modu_sub_triangle) >>
  mp_tac (Q.SPECL [`(h:complex)*(u:complex)`,`v:complex`,`z:complex`] ss_modu_sub_triangle) >>
  RealField.REAL_ASM_ARITH_TAC
QED
