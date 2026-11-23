Theory PrincipalUpper
Ancestors real pred_set arithmetic list
Libs realLib

(* One element for each multiplicity unit, with the right endpoint included. *)
Definition units_def:
  units (m:real->real->num) top =
    { (b,g,i) | 0<b /\ b<1 /\ 0<g /\ g<=top /\ i<m b g }
End

Theorem two_fresh:
  !s w (x:'a) y. FINITE s /\ w SUBSET s /\ x IN s /\ y IN s /\
    x NOTIN w /\ y NOTIN w /\ x<>y ==> CARD w + 2 <= CARD s
Proof
  rpt strip_tac >>
  `FINITE w` by metis_tac[SUBSET_FINITE] >>
  `x INSERT y INSERT w SUBSET s` by simp[INSERT_SUBSET] >>
  `CARD (x INSERT y INSERT w) <= CARD s` by metis_tac[CARD_SUBSET] >>
  `FINITE (y INSERT w) /\ x NOTIN (y INSERT w)` by simp[] >>
  `CARD (x INSERT y INSERT w) = SUC (SUC (CARD w))` by asm_simp_tac std_ss [CARD_INSERT] >> decide_tac
QED

Theorem line_from_principal_upper:
  !m top w (U:real).
    FINITE (units m top) /\ w SUBSET units m top /\
    (!b g i. (b,g,i) IN w ==> b=1/2) /\
    (!b g. 0<b /\ b<1 /\ 0<g /\ g<=top ==> m (1-b) g = m b g) /\
    &(CARD (units m top)) <= U /\ U < &(CARD w + 2) ==>
    !b g. 0<b /\ b<1 /\ 0<g /\ g<=top /\ 0<m b g ==> b=1/2
Proof
  rpt strip_tac >> CCONTR_TAC >>
  `0<1-b /\ 1-b<1 /\ 1-b<>1/2 /\ b<>1-b` by REAL_ASM_ARITH_TAC >>
  `m (1-b) g = m b g` by metis_tac[] >>
  `(b,g,0) IN units m top /\ (1-b,g,0) IN units m top` by simp[units_def] >>
  `(b,g,0) NOTIN w /\ (1-b,g,0) NOTIN w` by metis_tac[] >>
  `(b,g,0:num) <> (1-b,g,0)` by simp[] >>
  `CARD w + 2 <= CARD (units m top)` by metis_tac[two_fresh] >>
  `&(CARD w + 2) <= &(CARD (units m top)):real` by simp[] >>
  REAL_ASM_ARITH_TAC
QED



Definition weighted_def:
  (weighted (f:'a->real) []=0) /\ (weighted f (x::xs)=f x+weighted f xs)
End
Definition low_def:
  low main (g:'a->real) xs = LENGTH (FILTER (\x. g x<=main) xs)
End
Definition credit_def:
  (credit top (NONE:real option)=0) /\ (credit top (SOME r)=top-r)
End
Theorem weighted_lower:
  !main top (g:'a->real) e xs. main < top /\
    EVERY (\x. g x<=top /\ !r. e x=SOME r ==> main<g x /\ g x<=r /\ r<=top) xs ==>
    (top-main)* &(low main g xs) + weighted (\x. credit top (e x)) xs <=
      weighted (\x. if g x<=main then top-main else top-g x) xs
Proof
  rpt gen_tac >> qid_spec_tac `xs` >> Induct >> simp[low_def,weighted_def] >>
  rpt strip_tac >> qpat_x_assum `_ ==> _` mp_tac >> asm_rewrite_tac[] >> strip_tac >>
  Cases_on `e h` >> Cases_on `g h<=main` >> fs[credit_def] >>
  RULE_ASSUM_TAC (PURE_REWRITE_RULE[low_def]) >>
  PURE_REWRITE_TAC[GSYM REAL_OF_NUM_SUC] >> REAL_ASM_ARITH_TAC
QED
Theorem weighted_upper:
  !main top (g:'a->real) e xs A. main<top /\
    EVERY (\x. g x<=top /\ !r. e x=SOME r ==> main<g x /\ g x<=r /\ r<=top) xs /\
    weighted (\x. if g x<=main then top-main else top-g x) xs <= A ==>
    &(low main g xs) <= (A-weighted (\x. credit top (e x)) xs)/(top-main)
Proof
  rpt strip_tac >> `0<top-main` by REAL_ASM_ARITH_TAC >> asm_simp_tac std_ss [REAL_LE_RDIV_EQ] >>
  mp_tac (Q.SPECL [`main:real`,`top:real`,`g:'a->real`,`e:'a->real option`,`xs:'a list`] weighted_lower) >>
  asm_rewrite_tac[] >> REAL_ASM_ARITH_TAC
QED
