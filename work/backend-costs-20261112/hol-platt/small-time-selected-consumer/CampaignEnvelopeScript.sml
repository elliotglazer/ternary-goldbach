Theory CampaignEnvelope
Ancestors integer list
Libs intLib
Theorem bounded_product:
 !a u X Y:int. ABS a<=X /\ ABS u<=Y ==> ABS(a*u)<=X*Y
Proof
 rpt strip_tac >>
 `0<=X /\ 0<=X-ABS a /\ 0<=Y-ABS u` by
   (mp_tac (Q.SPEC `a:int` INT_ABS_POS) >> intLib.ARITH_TAC) >>
 `0<=(X-ABS a)*ABS u` by metis_tac[INT_LE_MUL,INT_ABS_POS] >>
 `0<=X*(Y-ABS u)` by metis_tac[INT_LE_MUL] >>
 fs[INT_SUB_LDISTRIB,INT_SUB_RDISTRIB,GSYM INT_ABS_MUL] >>
 intLib.ARITH_TAC
QED
Theorem one_complex_product:
 !a b u v X Y:int. ABS a<=X /\ ABS b<=X /\ ABS u<=Y /\ ABS v<=Y ==>
 ABS(a*u-b*v)<=2*(X*Y) /\ ABS(a*v+b*u)<=2*(X*Y)
Proof
 rpt strip_tac >>
 `ABS(a*u)<=X*Y /\ ABS(b*v)<=X*Y /\ ABS(a*v)<=X*Y /\ ABS(b*u)<=X*Y` by metis_tac[bounded_product] >>
 fs[INT_ABS_LE] >> intLib.ARITH_TAC
QED
Definition isum_def:
 (isum []=0:int) /\ (isum (h::t)=h+isum t)
End
Theorem partial_coordinate:
 !xs (B:int). EVERY (\v. ABS v<=B) xs ==> ABS(isum xs)<= &(LENGTH xs)*B
Proof
 Induct >> simp[isum_def] >> rpt strip_tac >>
 `ABS(isum xs)<= &(LENGTH xs)*B` by metis_tac[] >>
 mp_tac (Q.INST [`i`|->`h`,`j`|->`isum xs`] INT_ABS_TRIANGLE) >>
 simp[integerTheory.INT,INT_RDISTRIB] >> intLib.ARITH_TAC
QED

Definition ipack_def:
 (ipack (R:int) []=0) /\ (ipack R (h::t)=h+R*ipack R t)
End
Theorem bias_fieldwise:
 !xs (R:int) bias.
 ipack R (MAP (\x. x+bias) xs) = ipack R xs + ipack R (MAP (K bias) xs)
Proof
 Induct >> simp[ipack_def,INT_LDISTRIB] >> intLib.ARITH_TAC
QED
Theorem valid_packed_range:
 !xs (R:int). 0<R /\ EVERY (\v. 0<=v /\ v<R) xs ==>
  0<=ipack R xs /\ ipack R xs < R ** LENGTH xs
Proof
 Induct >> simp[ipack_def,INT_POW] >> rpt gen_tac >> strip_tac >>
 `0<=ipack R xs /\ ipack R xs<R ** LENGTH xs` by metis_tac[] >>
 `0<=R*ipack R xs` by metis_tac[INT_LE_MUL,INT_LT_IMP_LE] >>
 `ipack R xs + 1 <= R ** LENGTH xs` by intLib.ARITH_TAC >>
 `R*(ipack R xs+1)<=R*(R ** LENGTH xs)` by metis_tac[INT_LE_MONO] >>
 fs[INT_LDISTRIB,INT_POW] >> intLib.ARITH_TAC
QED

Theorem three_to_two:
 !a b u v:int. (a+b)*(u+v)-a*u-b*v=a*v+b*u
Proof
 rpt gen_tac >> simp[INT_LDISTRIB,INT_RDISTRIB] >> intLib.ARITH_TAC
QED
