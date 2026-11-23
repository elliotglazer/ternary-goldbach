val _ = set_goal ([],``  !c:num. !U V:int#int. !C A:complex. !e f bound:real.
    modu (source_pair_value (2**120) U-C) <= e /\ modu (source_pair_value (2**120) V-A) <= f /\
    modu C <= bound /\ modu A <= 1 ==>
    modu (source_pair_value (2**100) (raw_head (&c) U V) - (&c:real)*(conj C*A)) <=
      1/(2:real) pow 100 + &c*(e*(1+f)+bound*f)``);
val _ = e (  rpt gen_tac >> strip_tac >>
  `modu (conj (source_pair_value (2**120) U) * source_pair_value (2**120) V - conj C*A) <= e*(1+f)+bound*f`
    by metis_tac [srh_product_error] >>
  `(&c:real)*modu (conj (source_pair_value (2**120) U) * source_pair_value (2**120) V - conj C*A)
    <= &c*(e*(1+f)+bound*f)` by (match_mp_tac REAL_LE_LMUL_IMP >> simp []) >>
  `abs (&c:real) = &c` by simp [abs] >>
  mp_tac (Q.SPECL [`source_pair_value (2**100) (raw_head (&c) U V)`,
    `(&c:real)*(conj (source_pair_value (2**120) U)*source_pair_value (2**120) V)`,
    `(&c:real)*(conj C*A)`] ss_modu_sub_triangle) >>
  ASM_REWRITE_TAC [GSYM COMPLEX_SUB_SCALAR_LMUL,MODU_SCALAR_LMUL] >>
  mp_tac (Q.SPECL [`c:num`,`U:int#int`,`V:int#int`] srh_rounding) >> RealField.REAL_ASM_ARITH_TAC);
val srh_head_error = top_thm ();
print "CHECKED srh_head_error\n";
