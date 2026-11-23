Theory DynamicBudget
Ancestors real arithmetic
Libs realLib RealField
val _=realLib.prefer_real();
Theorem cap_step:
 !g x f k:real. 0 <= g /\ x <= f /\ f <= 1 /\ f <= 3*k*g ==>
 (1+g)*x+2*g <= 3*(k+1)*g
Proof
 rpt strip_tac >>
 `g*x<=g*f` by (irule REAL_LE_LMUL_IMP >> simp[]) >>
 `g*f<=g*1` by (irule REAL_LE_LMUL_IMP >> simp[]) >>
 RealField.REAL_ASM_ARITH_TAC
QED
Theorem all_state_errors:
 !g e. 0 <= g /\ 3*84880*g <= 1 /\ e 0 <= 0 /\
 (!j. j < 84880 ==> e (SUC j) <= (1+g)*e j+2*g) ==>
 !j. j <= 84880 ==> e j <= 3* &j*g
Proof
 rpt gen_tac >> strip_tac >> Induct_on `j`
 >- (simp[]) >>
 rpt strip_tac >>
 `j <= 84880 /\ j < 84880` by decide_tac >>
 `e j <= 3* &j*g` by metis_tac[] >>
 `(&j:real) <= &84880` by simp[] >>
 `(&j:real)*g <= &84880*g` by (irule REAL_LE_RMUL_IMP >> simp[]) >>
 `3* &j*g <= 1` by RealField.REAL_ASM_ARITH_TAC >>
 `(1+g)*e j+2*g <= 3*(&j+1)*g` by
   (match_mp_tac (Q.SPECL [`g:real`,`e(j:num):real`,`3* &j*g:real`,`&j:real`] cap_step) >> simp[]) >>
 `e (SUC j) <= (1+g)*e j+2*g` by metis_tac[] >>
 `(&(SUC j):real) = &j + 1` by simp[ADD1] >> metis_tac[REAL_LE_TRANS]
QED


