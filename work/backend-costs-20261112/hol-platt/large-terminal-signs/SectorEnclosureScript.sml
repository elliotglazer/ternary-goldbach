Theory SectorEnclosure
Ancestors SectorSound HardyCoordinate Sector intreal integer real
Libs realLib intLib

Theorem integer_margin_sign:
  !z e x. (0:int) <= e /\ e < ABS z /\
    abs (x-real_of_int z) <= real_of_int e ==>
    0 < oriented ((0:int)<z) x
Proof
  rpt gen_tac >> PURE_REWRITE_TAC [ABS_BOUNDS] >> strip_tac >> Cases_on `(0:int)<z` >| [
    `~(z < (0:int))` by intLib.ARITH_TAC >>
    `e < z` by fs[INT_ABS] >>
    `real_of_int e < real_of_int z` by (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
    asm_simp_tac bool_ss [oriented_def] >> REAL_ASM_ARITH_TAC,
    `z < (0:int)` by (Cases_on `z < (0:int)` >> fs[INT_ABS] >> intLib.ARITH_TAC) >>
    `e < -z` by fs[INT_ABS] >>
    `real_of_int e < real_of_int (-z)` by (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
    pop_assum (mp_tac o REWRITE_RULE [real_of_int_neg]) >>
    asm_simp_tac bool_ss [oriented_def] >> REAL_ASM_ARITH_TAC
  ]
QED

Theorem unit_margin_sign:
  !z x. (1:int)<ABS z /\ abs(x-real_of_int z)<=1 ==>
    0 < oriented ((0:int)<z) x
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`z:int`,`1:int`,`x:real`] integer_margin_sign) >>
  simp[real_of_int_num] >> metis_tac[]
QED

(* Inputs are in their respective integer grid units. Positive grid scales
   preserve the sign. Only the selected output component needs an enclosure. *)
Theorem enclosed_one_hardy_sign:
  !p q f g e r i pp qq ff gg xx yy.
    let b = use_real (0<p) (0<q) (0<f) (0<g);
        c = if b then r else i;
        k = one (p,q) (f,g,e) (r,i)
    in k <> 0 /\ (0:int) <= e /\
    abs(pp-real_of_int p)<=1 /\ abs(qq-real_of_int q)<=1 /\
    abs(ff-real_of_int f)<=1 /\ abs(gg-real_of_int g)<=1 /\
    abs((if b then xx else yy)-real_of_int c)<=real_of_int e /\
    0 < (pp*ff-qq*gg)*(pp*ff-qq*gg)+(pp*gg+qq*ff)*(pp*gg+qq*ff) /\
    (pp*ff-qq*gg)*yy+(pp*gg+qq*ff)*xx=0 ==>
    0 < oriented (k=2) ((pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy)
Proof
  rpt gen_tac >> simp_tac bool_ss [LET_THM] >> strip_tac >>
  mp_tac (Q.SPECL [`p:int`,`q:int`,`f:int`,`g:int`,`e:int`,`r:int`,`i:int`] one_code) >>
  simp_tac bool_ss [LET_THM] >> strip_tac >>
  mp_tac (Q.SPECL [`p:int`,`q:int`,`f:int`,`g:int`,`e:int`,`r:int`,`i:int`,
    `pp:real`,`qq:real`,`ff:real`,`gg:real`,`xx:real`,`yy:real`] one_hardy_sign) >>
  simp_tac bool_ss [LET_THM] >> disch_then match_mp_tac >>
  rpt conj_tac >> metis_tac[unit_margin_sign,integer_margin_sign]
QED
