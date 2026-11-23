Theorem increasing_index_gap:
  !f:num->num. !N. (!i j. 0 < i /\ i < j /\ j <= N ==> f i < f j) ==>
    !d i. 0 < i /\ i+d <= N ==> f i+d <= f (i+d)
Proof
  rpt gen_tac >> strip_tac >> Induct_on `d` >- simp[] >>
  rpt strip_tac >>
  `f i + d <= f (i+d)` by (first_x_assum match_mp_tac >> decide_tac) >>
  `f (i+d) < f (i+SUC d)` by (first_x_assum match_mp_tac >> decide_tac) >>
  decide_tac
QED

Theorem increasing_index_identity:
  !f:num->num. !N.
    (!i. 0 < i /\ i <= N ==> 0 < f i /\ f i <= N) /\
    (!i j. 0 < i /\ i < j /\ j <= N ==> f i < f j) ==>
    !i. 0 < i /\ i <= N ==> f i = i
Proof
  rpt strip_tac >>
  `0 < f 1 /\ f N <= N` by (conj_tac >> first_x_assum (irule_at Any) >> decide_tac) >>
  mp_tac (Q.SPECL [`f`, `N`] increasing_index_gap) >> impl_tac >- metis_tac[] >>
  disch_then (fn th => mp_tac (Q.SPECL [`i-1`,`1`] th) >>
                        mp_tac (Q.SPECL [`N-i`,`i`] th)) >>
  `i+(N-i)=N /\ 1+(i-1)=i` by decide_tac >> asm_rewrite_tac[] >> decide_tac
QED
