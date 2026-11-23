open HolKernel Parse boolLib bossLib;
open arithmeticTheory realTheory FourierJetTheory MomentTransferTheory;
val _ = new_theory "FourierStencil";

Definition coefficient_def:
 coefficient n w a b m = finitejet n m w a b 0 / &(FACT m)
End
Definition budget_def:
 budget n cap omega m = (&n*(cap*omega pow m)) / &(FACT m)
End

Theorem divide_bound:
 !z bound m. abs z <= bound ==> abs(z / &(FACT m)) <= bound / &(FACT m)
Proof
 rpt gen_tac >> strip_tac >>
 `abs(&(FACT m):real) = &(FACT m)` by simp [abs] >>
 ASM_REWRITE_TAC [REAL_ABS_DIV,real_div] >>
 irule REAL_LE_RMUL_IMP >> simp [REAL_LE_INV_EQ]
QED

Theorem coefficient_cap:
 !n w a b cap omega.
 0<=cap /\ 0<=omega /\ (!j. j<n ==> abs(a j)+abs(b j)<=cap /\ abs(w j)<=omega) ==>
 !m. abs(coefficient n w a b m) <= budget n cap omega m
Proof
 rpt strip_tac >> PURE_REWRITE_TAC [coefficient_def,budget_def] >>
 irule divide_bound >> metis_tac [finitejet_bound]
QED

Theorem taylor_tail:
 !n w a b cap omega.
 0<=cap /\ 0<=omega /\ (!j. j<n ==> abs(a j)+abs(b j)<=cap /\ abs(w j)<=omega) ==>
 !k x. abs(finitejet n 0 w a b x - polynomial k (coefficient n w a b) x) <=
 budget n cap omega k * abs(x pow k)
Proof
 map_every qx_gen_tac [`n`,`w`,`a`,`b`,`cap`,`freq`] >> strip_tac >>
 map_every qx_gen_tac [`k`,`x`] >>
 mp_tac (Q.SPECL [`n`,`w`,`a`,`b`,`x`,`k`] finitejet_taylor) >>
 disch_then (qx_choose_then `t` strip_assume_tac) >>
 `abs(finitejet n k w a b t / &(FACT k)) <= budget n cap freq k` by
    (PURE_REWRITE_TAC [budget_def] >> irule divide_bound >> metis_tac [finitejet_bound]) >>
 `finitejet n 0 w a b x - polynomial k (coefficient n w a b) x =
       finitejet n k w a b t / &(FACT k) * x pow k` by
   (PURE_REWRITE_TAC [polynomial_def,series_sum,coefficient_def] >>
    BETA_TAC >> realLib.REAL_ASM_ARITH_TAC) >>
 ASM_REWRITE_TAC [ABS_MUL] >> irule REAL_LE_RMUL_IMP >> simp [ABS_POS]
QED

Theorem finite_fourier_stencil:
 !n w a b cap omega.
 0<=cap /\ 0<=omega /\ (!j. j<n ==> abs(a j)+abs(b j)<=cap /\ abs(w j)<=omega) ==>
 !k zs. abs(row zs (finitejet n 0 w a b)) <=
   series k (budget n cap omega) (\m. abs(row zs (\x. x pow m))) +
   absolute_row zs (\x. budget n cap omega k * abs(x pow k))
Proof
 rpt gen_tac >> strip_tac >> rpt gen_tac >>
 match_mp_tac stencil_taylor_error >> qexists_tac `coefficient n w a b` >>
 BETA_TAC >> metis_tac [coefficient_cap,taylor_tail]
QED
val _ = export_theory();

