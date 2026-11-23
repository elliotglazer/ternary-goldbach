Theory RadiusBudget
Ancestors KernelWeights arithmetic real
Libs realLib

Definition budget_A_def:
 budget_A = 512*4*3**64*2**80:num
End
Definition budget_D_def:
 budget_D r = (7*524288)**r*FACT r
End
Definition budget_M_def:
 budget_M r = (2*68267+1)*(2*1250000**2+1)*(44*68267)**r*(FACT(r DIV 2))**2
End
Theorem radius_natural:
 !r e. KernelWeights$radius_ok r e ==>
  10*budget_A*budget_D r + 2**220*(5*524288*budget_D r+budget_A*budget_M r)
    <= e*budget_A*budget_D r
Proof
  simp [KernelWeightsTheory.radius_ok_def,budget_A_def,budget_D_def,budget_M_def]
QED
Theorem clear_budget:
 !n k e:num. 0<k /\ 10*k+n <= e*k ==> 10 + &n / &k <= (&e:real)
Proof
  rpt gen_tac >> strip_tac >>
  `(0:real) < &k` by simp [] >>
  `(&(10*k+n):real) <= &(e*k)` by simp [] >>
  `(10:real)* &k + &n <= &e * &k` by
    (pop_assum mp_tac >> PURE_REWRITE_TAC [GSYM REAL_OF_NUM_ADD,GSYM REAL_OF_NUM_MUL] >> simp []) >>
  `&n <= ((&e:real)-10)* &k` by
    (PURE_REWRITE_TAC [REAL_SUB_RDISTRIB] >> realLib.REAL_ASM_ARITH_TAC) >>
  `&n / &k <= (&e:real)-10` by metis_tac [REAL_LE_LDIV_EQ] >>
  realLib.REAL_ASM_ARITH_TAC
QED
fun progress s g=(print ("BUDGET "^s^"\n");ALL_TAC g);
Theorem radius_real:
 !r e. KernelWeights$radius_ok r e ==>
  10 + &(2**220*(5*524288*budget_D r+budget_A*budget_M r)) /
       &(budget_A*budget_D r) <= (&e:real)
Proof
  rpt strip_tac >> MATCH_MP_TAC clear_budget >>
  conj_tac >- (REWRITE_TAC [budget_A_def,budget_D_def] >> simp [FACT_LESS]) >> progress "positive" >>
  drule radius_natural >> PURE_REWRITE_TAC [MULT_ASSOC] >> DISCH_THEN ACCEPT_TAC
QED

Theorem radius_consumer:
 !r e H U I Z. KernelWeights$radius_ok r e /\
  abs(H-U) <= &(2**220*(5*524288*budget_D r)) / &(budget_A*budget_D r) /\
  abs(U-I) <= &(2**220*(budget_A*budget_M r)) / &(budget_A*budget_D r) /\
  abs(I-Z) <= 10 ==> abs(H-Z) <= (&e:real)
Proof
 rpt gen_tac >> strip_tac >>
 drule radius_real >>
 PURE_REWRITE_TAC [LEFT_ADD_DISTRIB,GSYM REAL_OF_NUM_ADD,real_div,REAL_RDISTRIB] >>
 RULE_ASSUM_TAC (PURE_REWRITE_RULE [ABS_BOUNDS,real_div]) >> PURE_REWRITE_TAC [ABS_BOUNDS] >> realLib.REAL_ASM_ARITH_TAC
QED


