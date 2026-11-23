Theory MaskOrder
Ancestors SelectedBias arithmetic
Theorem first_one_factor:
 !n m. 0<m /\ m<2**n ==>
 tz n m<n /\ ?k. m=2**(tz n m)*(2*k+1)
Proof
 Induct >> simp[] >> rpt gen_tac >> strip_tac >>
 Cases_on `ODD m`
 >- (simp[tz_def] >> fs[ODD_EXISTS] >> metis_tac[ADD1]) >>
 `?h. m=2*h` by metis_tac[EVEN_ODD,EVEN_EXISTS] >>
 `0<h /\ h<2**n` by fs[EXP] >>
 first_x_assum(qspec_then `h` mp_tac) >> asm_rewrite_tac[] >> strip_tac >>
 `m DIV 2=h` by simp[MULT_COMM,MULT_DIV] >>
 simp[tz_def,EXP] >> qexists_tac `k` >>
 metis_tac[MULT_ASSOC]
QED
Theorem skip_remainder:
 !m j k. m=2**j*(2*k+1) ==>
   nd m (2**j)=2*k+1 /\ nd m (2**j) DIV 2=k
Proof
 rpt strip_tac >> simp[nd_def,MULT_COMM,MULT_DIV] >>
 irule DIV_UNIQUE >> qexists_tac `1` >> simp[MULT_COMM]
QED
