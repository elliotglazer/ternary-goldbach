Theory RateLimit
Ancestors RateMeaning MomentRates RadiusBudget real intreal integer arithmetic
Libs realLib intLib
Definition rate_ratio_def:
 rate_ratio r = &((44*68267)**r * (FACT(r DIV 2))**2) / &((7*524288)**r * FACT r):real
End

Theorem clear_rate:
 !z d s m h:real. 0<d /\ 0<s /\ 2*z*d <= h*(s*m) ==>
 2 * (z / s) <= h*(m / d)
Proof
 rpt gen_tac >> strip_tac >>
 `(2*z*d) / s <= h*m` by
   (ASM_SIMP_TAC bool_ss [REAL_LE_LDIV_EQ] >> realLib.REAL_ASM_ARITH_TAC) >>
 `(2*(z/s))*d <= h*m` by
   (pop_assum mp_tac >> PURE_REWRITE_TAC [real_div] >> realLib.REAL_ARITH_TAC) >>
 `2*(z/s) <= (h*m)/d` by metis_tac [REAL_LE_RDIV_EQ] >>
 pop_assum mp_tac >> PURE_REWRITE_TAC [real_div] >> realLib.REAL_ARITH_TAC
QED

Theorem checked_rate:
 !r f den ws. rate_ok r f den ws ==>
 2*(real_of_int(numer (2*r+64) 0 0 1 ((den,&f)::points (1 - &(r DIV 2)) ws)) /
    factorial_scale (2*r+64)) <= real_of_int den * rate_ratio r
Proof
 rpt gen_tac >> rewrite_tac [rate_ok_def] >> simp_tac bool_ss [LET_THM] >> strip_tac >>
 PURE_REWRITE_TAC [rate_ratio_def] >> irule clear_rate >>
 conj_tac >- simp [FACT_LESS] >>
 conj_tac >- metis_tac [scale_positive] >>
 qpat_x_assum `_ <= _` mp_tac >>
 ONCE_REWRITE_TAC [GSYM real_of_int_le] >>
 PURE_REWRITE_TAC [real_of_int_mul,real_of_int_num,factorial_scale_def,GSYM REAL_OF_NUM_MUL] >>
 realLib.REAL_ARITH_TAC
QED
