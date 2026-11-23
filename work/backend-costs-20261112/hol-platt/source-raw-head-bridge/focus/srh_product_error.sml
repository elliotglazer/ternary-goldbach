val _ = set_goal ([],``  !U V C A:complex. !e f bound:real.
    modu (U-C) <= e /\ modu (V-A) <= f /\ modu C <= bound /\ modu A <= 1 ==>
    modu (conj U * V - conj C * A) <= e*(1+f) + bound*f``);
val _ = e (  rpt gen_tac >> strip_tac >>
  `modu V <= 1+f` by (mp_tac (Q.SPECL [`V-A:complex`,`A:complex`] ss_modu_triangle) >>
    REWRITE_TAC [COMPLEX_SUB_ADD] >> RealField.REAL_ASM_ARITH_TAC) >>
  `conj U * V - conj C * A = conj (U-C) * V + conj C * (V-A)` by
    (REWRITE_TAC [COMPLEX_RE_IM_EQ,complex_mul,conj,complex_sub,
       complex_add,complex_neg,RE,IM,pairTheory.FST,pairTheory.SND] >> conj_tac >> RealField.REAL_ARITH_TAC) >>
  `modu (U-C) * modu V <= e*(1+f)` by (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]) >>
  `modu C * modu (V-A) <= bound*f` by (match_mp_tac REAL_LE_MUL2 >> simp [MODU_POS]) >>
  mp_tac (Q.SPECL [`conj (U-C) * V:complex`,`conj C * (V-A):complex`] ss_modu_triangle) >>
  ASM_REWRITE_TAC [MODU_MUL,MODU_CONJ] >> RealField.REAL_ASM_ARITH_TAC);
val srh_product_error = top_thm ();
print "CHECKED srh_product_error\n";
