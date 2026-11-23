Theory UnitBounds
Ancestors Gauss integer
Libs intLib

open integerTheory intLib;

Theorem gcut_quot:
  !s z. 0 < s ==> gcut z s = z quot (&s)
Proof
  rpt strip_tac >>
  `~(s = 0) /\ 0 < (&s:int) /\ ~((&s:int) = 0)` by simp[] >>
  Cases_on `z < 0`
  >- (`~(0 <= z)` by intLib.ARITH_TAC >> simp[gcut_def,int_quot,NUM_OF_INT])
  >> `0 <= z` by intLib.ARITH_TAC >> simp[gcut_def,int_quot,NUM_OF_INT]
QED

Theorem gcut_contraction:
  !s z. 0 < s ==> ABS (gcut z s * &s) <= ABS z
Proof
  rpt strip_tac >> simp[gcut_quot,INT_ABS_QUOT]
QED

Theorem gcut_error:
  !s z. 0 < s ==> ABS (z - gcut z s * &s) < &s
Proof
  rpt strip_tac >>
  `~((&s:int) = 0)` by simp[] >>
  mp_tac (Q.SPEC `z` (UNDISCH (Q.SPEC `&s` INT_REMQUOT))) >>
  strip_tac >>
  `z - (z quot &s) * &s = z rem &s` by intLib.ARITH_TAC >>
  simp[gcut_quot] >> fs[INT_ABS_NUM]
QED

Theorem nonnegative_product_mono:
  !a b c d:int. 0 <= a /\ a <= b /\ 0 <= c /\ c <= d ==> a*c <= b*d
Proof
  rpt strip_tac >>
  `0 <= (b-a)*c` by (match_mp_tac INT_LE_MUL >> intLib.ARITH_TAC) >>
  `0 <= b*(d-c)` by (match_mp_tac INT_LE_MUL >> intLib.ARITH_TAC) >>
  `(b-a)*c+b*(d-c) = b*d-a*c` by intLib.INT_RING_TAC >>
  intLib.ARITH_TAC
QED

Theorem square_abs:
  !x:int. ABS x * ABS x = x*x
Proof
  rw[INT_ABS] >> intLib.INT_RING_TAC
QED

Theorem square_abs_mono:
  !x y:int. ABS x <= ABS y ==> x*x <= y*y
Proof
  rpt strip_tac >>
  mp_tac (Q.SPECL [`ABS x`,`ABS y`,`ABS x`,`ABS y`] nonnegative_product_mono) >>
  simp[square_abs]
QED

Definition norm2_def:
  norm2 (z:int#int) = FST z * FST z + SND z * SND z
End

Theorem gmul_pair:
  !s a b c d. gmul s (a,b) (c,d) =
               (gcut (a*c-b*d) s,gcut (a*d+b*c) s)
Proof
  simp[gmul_def] >>
  `!a b c d:int. (a+b)*(c+d)-a*c-b*d = a*d+b*c` by
    (rpt gen_tac >> intLib.INT_RING_TAC) >> simp[]
QED

Theorem rounded_pair_scaled:
  !s re im. 0 < s ==> (&s * &s) * (gcut re s * gcut re s + gcut im s * gcut im s)
                      <= re*re + im*im
Proof
  rpt strip_tac >>
  `(gcut re s * &s) * (gcut re s * &s) <= re*re` by
    (match_mp_tac square_abs_mono >> simp[gcut_contraction]) >>
  `(gcut im s * &s) * (gcut im s * &s) <= im*im` by
    (match_mp_tac square_abs_mono >> simp[gcut_contraction]) >>
  `(&s * &s) * (gcut re s * gcut re s + gcut im s * gcut im s) =
    (gcut re s * &s) * (gcut re s * &s) + (gcut im s * &s) * (gcut im s * &s)` by
    intLib.INT_RING_TAC >>
  intLib.ARITH_TAC
QED

Theorem gmul_norm_coordinates:
  !s a b c d. 0 < s ==> (&s * &s) * norm2 (gmul s (a,b) (c,d))
                     <= norm2 (a,b) * norm2 (c,d)
Proof
  rpt strip_tac >>
  `(a*c-b*d)*(a*c-b*d)+(a*d+b*c)*(a*d+b*c) = (a*a+b*b)*(c*c+d*d)`
     by intLib.INT_RING_TAC >>
  mp_tac (Q.SPECL [`s`,`a*c-b*d`,`a*d+b*c`] rounded_pair_scaled) >>
  ASM_REWRITE_TAC[gmul_pair,norm2_def,pairTheory.FST,pairTheory.SND]
QED

Theorem gmul_norm_scaled:
  !s u v. 0 < s ==> (&s * &s) * norm2 (gmul s u v) <= norm2 u * norm2 v
Proof
  rpt gen_tac >> PairCases_on `u` >> PairCases_on `v` >>
  metis_tac[gmul_norm_coordinates]
QED

Theorem norm2_nonnegative:
  !w. 0 <= norm2 w
Proof
  gen_tac >> REWRITE_TAC[norm2_def] >> match_mp_tac INT_LE_ADD >>
  REWRITE_TAC[INT_LE_SQUARE]
QED

Theorem square_scale_positive:
  !s:num. 0 < s ==> 0 < (&s:int) * &s
Proof
  simp[INT_POSSQ]
QED

Theorem norm_product_cap:
  !u v bound. norm2 u <= bound /\ norm2 v <= bound ==>
      norm2 u * norm2 v <= bound * bound
Proof
  rpt strip_tac >> match_mp_tac nonnegative_product_mono >>
  ASM_REWRITE_TAC[norm2_nonnegative]
QED

Theorem gmul_unit_disk:
  !s u v. 0 < s /\ norm2 u <= (&s * &s) /\ norm2 v <= (&s * &s) ==>
          norm2 (gmul s u v) <= (&s * &s)
Proof
  rpt strip_tac >>
  mp_tac (Q.SPECL [`s`,`u`,`v`] gmul_norm_scaled) >>
  mp_tac (Q.SPECL [`u`,`v`,`(&s:int) * &s`] norm_product_cap) >>
  mp_tac (Q.SPECL [`(&s:int) * &s`,`norm2 (gmul s u v)`,`(&s:int) * &s`] INT_LE_MONO) >>
  mp_tac (Q.SPEC `s` square_scale_positive) >>
  ASM_REWRITE_TAC[] >> metis_tac[INT_LE_TRANS]
QED
