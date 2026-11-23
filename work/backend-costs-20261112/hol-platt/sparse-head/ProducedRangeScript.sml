Theory ProducedRange
Ancestors ProducedHead integer arithmetic
Libs intLib
Theorem signed_bin_range:
 !u h q s:int. 0<u /\ u*q<=s /\ s<u*q+u ==>
 (0<=q+h /\ q+h<2*h <=> -(u*h)<=s /\ s<u*h)
Proof
 rpt gen_tac >> strip_tac >>
 `u*(-h)= -(u*h) /\ u*(q+1)=u*q+u /\ u*(h+1)=u*h+u`
 by simp[INT_LDISTRIB,INT_NEG_RMUL] >>
 eq_tac >> strip_tac
 >- (`-h<=q /\ q+1<=h` by intLib.ARITH_TAC >>
     `u*(-h)<=u*q /\ u*(q+1)<=u*h` by metis_tac[INT_LE_MONO] >>
     intLib.ARITH_TAC)
 >> `u*(-h)<u*(q+1) /\ u*q<u*h` by intLib.ARITH_TAC >>
 `-h<q+1 /\ q<h` by metis_tac[INT_LT_MONO] >> intLib.ARITH_TAC
QED
Theorem twoval_fits:
 !w e a b x y. 0<w ==>
 (0<=TwoHead$twoval w e a b x y /\ TwoHead$twoval w e a b x y < &(2**w) <=>
  -( (&(2**e):int)* &(2**(w-1)) ) <= ProducedHead$produced_raw a b x y /\
  ProducedHead$produced_raw a b x y < (&(2**e):int)* &(2**(w-1)))
Proof
 rpt gen_tac >> strip_tac >>
 `(&(2**w):int)=2* &(2**(w-1))` by
  (Cases_on `w` >> fs[EXP,INT_MUL]) >>
 `0<(&(2**e):int)` by simp[] >>
 qabbrev_tac `q=TwoHead$twoval w e a b x y - &(2**(w-1))` >>
 `q=ProducedHead$intermediate a b x y /(2* &(2**e))`
 by simp[Abbr `q`,ProducedHeadTheory.twoval_unbias] >>
 mp_tac (Q.SPECL [`ProducedHead$intermediate a b x y`,`&(2**e):int`] ProducedHeadTheory.halved_bin) >>
 PURE_ASM_REWRITE_TAC[GSYM ProducedHeadTheory.produced_raw_def] >>
 strip_tac >>
 `(&(2**e):int)*q<=ProducedHead$produced_raw a b x y /\
 ProducedHead$produced_raw a b x y< (&(2**e):int)*q+ &(2**e)`
 by metis_tac[INT_MUL_COMM] >>
 drule_all signed_bin_range >> strip_tac >>
 `q+ &(2**(w-1))=TwoHead$twoval w e a b x y` by
  (simp[Abbr `q`] >> intLib.ARITH_TAC) >>
 metis_tac[signed_bin_range]
QED
