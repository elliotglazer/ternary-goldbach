Theory SelectedPrune
Ancestors SelectedHead integer
Libs intLib
Theorem empty_leaves:
 !k w e a b c x y. leaves k F w e 0 a b c x y = (0,1)
Proof
 Induct >> simp [leaves_def,LET_THM,pairTheory.UNCURRY]
QED
Theorem pruning_exact:
 !k w e m a b c x y. leaves k T w e m a b c x y = leaves k F w e m a b c x y
Proof
 Induct >> rpt gen_tac >> Cases_on `m=0` >>
 simp [leaves_def,LET_THM,pairTheory.UNCURRY,empty_leaves]
QED
Theorem quotient_bin:
 !d q low x high:int.
  0<d /\ low<=x /\ x<=high /\ q*d<=low /\ high<q*d+d ==> hddiv x d=q
Proof
 rpt strip_tac >> `~(d=0) /\ ~(d<0)` by intLib.ARITH_TAC >>
 asm_simp_tac bool_ss [hddiv_def] >> irule INT_DIV_UNIQUE >>
 qexists_tac `x-q*d` >> asm_simp_tac bool_ss [] >> intLib.ARITH_TAC
QED
