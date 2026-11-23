Theory SectorSound
Ancestors HardyCoordinate Sector real integer
Libs realLib intLib

Definition use_real_def:
  use_real (sp:bool) (sq:bool) (sf:bool) (sg:bool) <=> (sp=sf) <> (sq=sg)
End

Definition multiplier_positive_def:
  multiplier_positive sp sq sf sg <=>
    if use_real sp sq sf sg then sp=sf else sp<>sg
End

Theorem phase_coordinate:
  !sp sq sf sg p q f g.
    0<oriented sp p /\ 0<oriented sq q /\
    0<oriented sf f /\ 0<oriented sg g ==>
    0<oriented (multiplier_positive sp sq sf sg)
      (if use_real sp sq sf sg then p*f-q*g else -(p*g+q*f))
Proof
  rpt gen_tac >> strip_tac >>
  `0<oriented (sp=sf) (p*f)` by metis_tac[orient_product,REAL_LT_MUL] >>
  `0<oriented (sq=sg) (q*g)` by metis_tac[orient_product,REAL_LT_MUL] >>
  `0<oriented (sp=sg) (p*g)` by metis_tac[orient_product,REAL_LT_MUL] >>
  `0<oriented (sq=sf) (q*f)` by metis_tac[orient_product,REAL_LT_MUL] >>
  Cases_on `sp` >> Cases_on `sq` >> Cases_on `sf` >> Cases_on `sg` >>
  fs[use_real_def,multiplier_positive_def,oriented_def] >> REAL_ASM_ARITH_TAC
QED

Theorem one_code:
  !p q f g e r i.
    let b = use_real (0<p) (0<q) (0<f) (0<g);
        t = multiplier_positive (0<p) (0<q) (0<f) (0<g);
        c = if b then r else i
    in
    ((one (p,q) (f,g,e) (r,i) <> 0) <=>
     1 < ABS p /\ 1 < ABS q /\ 1 < ABS f /\ 1 < ABS g /\ e < ABS c) /\
    (one (p,q) (f,g,e) (r,i) <> 0 ==>
      ((one (p,q) (f,g,e) (r,i) = 2) <=> (t=(0<c))))
Proof
  rpt gen_tac >> simp[one_def,use_real_def,multiplier_positive_def,LET_THM] >>
  rpt IF_CASES_TAC >> fs[] >> intLib.ARITH_TAC
QED

Theorem read_coordinate:
  !sp sq sf sg sc p q f g x y.
    0 < oriented sp p /\ 0 < oriented sq q /\
    0 < oriented sf f /\ 0 < oriented sg g /\
    0 < oriented sc (if use_real sp sq sf sg then x else y) /\
    0 < (p*f-q*g)*(p*f-q*g)+(p*g+q*f)*(p*g+q*f) /\
    (p*f-q*g)*y+(p*g+q*f)*x=0 ==>
    0 < oriented (multiplier_positive sp sq sf sg=sc)
                 ((p*f-q*g)*x-(p*g+q*f)*y)
Proof
  rpt gen_tac >> strip_tac >>
  `0 < oriented (multiplier_positive sp sq sf sg)
      (if use_real sp sq sf sg then p*f-q*g else -(p*g+q*f))` by
    (match_mp_tac phase_coordinate >> asm_rewrite_tac[]) >>
  mp_tac (Q.SPECL [`use_real sp sq sf sg`,
    `multiplier_positive sp sq sf sg`,`sc:bool`,`(p:real)*f-q*g`,
    `(p:real)*g+q*f`,`x:real`,`y:real`] hardy_coordinate_sign) >>
  disch_then match_mp_tac >> rpt conj_tac >> first_assum ACCEPT_TAC
QED

Theorem one_hardy_sign:
  !p q f g e r i pp qq ff gg xx yy.
    let b = use_real (0<p) (0<q) (0<f) (0<g);
        c = if b then r else i;
        k = one (p,q) (f,g,e) (r,i)
    in
    k <> 0 /\
    0 < oriented (0<p) pp /\ 0 < oriented (0<q) qq /\
    0 < oriented (0<f) ff /\ 0 < oriented (0<g) gg /\
    0 < oriented (0<c) (if b then xx else yy) /\
    0 < (pp*ff-qq*gg)*(pp*ff-qq*gg)+(pp*gg+qq*ff)*(pp*gg+qq*ff) /\
    (pp*ff-qq*gg)*yy+(pp*gg+qq*ff)*xx=0 ==>
    0 < oriented (k=2) ((pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy)
Proof
  rpt gen_tac >> simp_tac bool_ss [LET_THM] >> strip_tac >>
  mp_tac (Q.SPECL [`p:int`,`q:int`,`f:int`,`g:int`,`e:int`,`r:int`,`i:int`] one_code) >>
  simp_tac bool_ss [LET_THM] >> strip_tac >>
  mp_tac (Q.SPECL [`(0:int)<p`,`(0:int)<q`,`(0:int)<f`,`(0:int)<g`,
    `(0:int)<(if use_real ((0:int)<p) ((0:int)<q) ((0:int)<f) ((0:int)<g) then r else i)`,
    `pp:real`,`qq:real`,`ff:real`,`gg:real`,`xx:real`,`yy:real`] read_coordinate) >>
  asm_simp_tac bool_ss [] >>
  Cases_on `one (p,q) (f,g,e) (r,i) = 2` >> fs[] >> metis_tac[]
QED
