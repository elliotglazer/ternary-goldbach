Theory FusedCorrect
Ancestors SelectedHead IntegratedHead TwoHead integer
Libs intLib
Theorem fused_exact:
 !H bias lo hi:int. 0 < H /\ 0 <= lo+bias /\ lo+bias < H ==>
   fused H bias (lo+H*hi) = (Num(lo+bias),hi)
Proof
 rpt strip_tac >>
 `~(H=0) /\ ~(H<0)` by intLib.ARITH_TAC >>
 `lo+H*hi+bias = hi*H+(lo+bias)` by
   simp[AC INT_ADD_ASSOC INT_ADD_COMM, AC INT_MUL_ASSOC INT_MUL_COMM] >>
 `(lo+H*hi+bias) / H = hi` by
   (irule INT_DIV_UNIQUE >> qexists_tac `lo+bias` >> asm_rewrite_tac[]) >>
 `(lo+H*hi+bias) % H = lo+bias` by
   (irule INT_MOD_UNIQUE >> qexists_tac `hi` >> asm_rewrite_tac[]) >>
 simp [fused_def,hddiv_def,LET_THM] >> metis_tac[]
QED

Theorem recombine_carry:
 !H a b c ah bh ch:int.
 (a+H*ah)-(b+H*bh)=(a-b)+H*(ah-bh) /\
 (c+H*ch)-(a+H*ah)-(b+H*bh)=(c-a-b)+H*(ch-ah-bh)
Proof
 rpt gen_tac >> REWRITE_TAC[INT_SUB_LDISTRIB,INT_SUB_RDISTRIB] >> intLib.ARITH_TAC
QED

Theorem fused_real_imag:
 !H B a b c ah bh ch:int. 0<H /\
  0<=a-b+B /\ a-b+B<H /\ 0<=c-a-b+B /\ c-a-b+B<H ==>
 fused H B ((a+H*ah)-(b+H*bh)) = (Num(a-b+B),ah-bh) /\
 fused H B ((c+H*ch)-(a+H*ah)-(b+H*bh)) = (Num(c-a-b+B),ch-ah-bh)
Proof
 rpt strip_tac >> metis_tac[fused_exact,recombine_carry]
QED

Theorem subfused_exact:
 !H bias lo hi:int. 0 < H /\ 0 <= lo+bias /\ lo+bias < H ==>
   subfused H bias (lo+H*hi) = (Num(lo+bias),hi)
Proof
 rpt strip_tac >>
 `hddiv (lo+H*hi+bias) H = hi` by
   (mp_tac (Q.SPECL [`H`,`bias`,`lo`,`hi`] fused_exact) >>
    simp[fused_def,LET_THM]) >>
 simp[subfused_def,LET_THM] >>
 AP_TERM_TAC >> intLib.ARITH_TAC
QED