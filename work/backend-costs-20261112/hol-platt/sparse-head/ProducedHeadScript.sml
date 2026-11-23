Theory ProducedHead
Ancestors TwoHead Enclosure WindowPerturbation integer arithmetic
Libs intLib
Definition intermediate_def:
 intermediate (a:int) b x y=SelectedHead$hddiv (a*x-b*y + &(2**498)) (&(2**499))
End
Definition produced_raw_def:
 produced_raw (a:int) b x y=intermediate a b x y / 2
End
Theorem div_bounds:
 !v u:int. 0<u ==> (v/u)*u <= v /\ v < (v/u)*u+u
Proof
 rpt strip_tac >> mp_tac (Q.SPEC `u:int` INT_DIVISION) >>
 `u<>0 /\ ~(u<0)` by intLib.ARITH_TAC >>
 asm_rewrite_tac[] >> disch_then(qspec_then `v:int` mp_tac) >> intLib.ARITH_TAC
QED
Theorem halved_bin:
 !v u:int. 0<u ==>
   v/(2*u)*u <= v/2 /\ v/2 < v/(2*u)*u + u
Proof
 rpt gen_tac >> strip_tac >>
 `0<2*u` by intLib.ARITH_TAC >>
 mp_tac (Q.SPECL [`v:int`,`2*u:int`] div_bounds) >>
 mp_tac (Q.SPECL [`v:int`,`2:int`] div_bounds) >>
 `v/(2*u)*(2*u)=2*(v/(2*u)*u)` by
  (CONV_TAC (AC_CONV (INT_MUL_ASSOC,INT_MUL_COMM))) >>
 asm_rewrite_tac[] >> intLib.ARITH_TAC
QED
Theorem raw_code_center:
 !s:int. -&(2**255)<=s ==> &(Num(s+ &(2**255))) - &(2**255) = s
Proof
 rpt strip_tac >> `&(Num(s+ &(2**255)))=s+ &(2**255)` by (PURE_REWRITE_TAC [INT_OF_NUM] >> intLib.ARITH_TAC) >> asm_rewrite_tac[] >> intLib.ARITH_TAC
QED
Theorem twoval_unbias:
 !w e a b x y. TwoHead$twoval w e a b x y - &(2**(w-1)) =
 intermediate a b x y / (2 * &(2**e))
Proof
 rpt gen_tac >>
 `(&(2**(e+1)):int) = 2 * &(2**e)` by simp[EXP_ADD,INT_MUL,MULT_COMM] >>
 simp[TwoHeadTheory.twoval_def,intermediate_def,LET_THM,SelectedHeadTheory.hddiv_def,EXP_ADD,INT_MUL,MULT_COMM] >> intLib.ARITH_TAC
QED
Theorem twoval_encloses:
 !w e a b x y. -&(2**255)<=produced_raw a b x y ==>
 Enclosure$encloses (Num(produced_raw a b x y + &(2**255)))
 (TwoHead$twoval w e a b x y - &(2**(w-1)), 2**e)
Proof
 rpt strip_tac >>
 PURE_REWRITE_TAC [EnclosureTheory.encloses_def,twoval_unbias] >> drule raw_code_center >> strip_tac >> asm_rewrite_tac[] >> PURE_REWRITE_TAC[produced_raw_def] >>
 MATCH_MP_TAC (Q.SPECL [`intermediate a b x y`,`&(2**e):int`] halved_bin) >> simp[]
QED


