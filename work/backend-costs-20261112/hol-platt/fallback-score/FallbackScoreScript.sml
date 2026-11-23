Theory FallbackScore
Ancestors LargeTerminal real integer intreal
Libs realLib intLib

Theorem product_radius:
  !a b x y u v:real. abs(x-a)<=u /\ abs(y-b)<=v ==>
  abs(x*y-a*b)<=abs a*v + u*(abs b+v)
Proof
  rpt gen_tac >> strip_tac >>
  `abs y <= abs b+v` by
    (mp_tac (Q.SPECL [`y-b:real`,`b:real`] ABS_TRIANGLE) >>
     simp[] >> REAL_ASM_ARITH_TAC) >>
  `abs(a*(y-b))<=abs a*v` by
    (rewrite_tac[ABS_MUL] >> irule REAL_LE_MUL2 >> simp[ABS_POS]) >>
  `abs((x-a)*y)<=u*(abs b+v)` by
    (rewrite_tac[ABS_MUL] >> irule REAL_LE_MUL2 >> simp[ABS_POS]) >>
  `x*y-a*b = a*(y-b)+(x-a)*y` by REAL_ARITH_TAC >>
  mp_tac (Q.SPECL [`a*(y-b):real`,`(x-a)*y:real`] ABS_TRIANGLE) >>
  REAL_ASM_ARITH_TAC
QED

Theorem pair_radii:
  !a b x y u v:real. abs(x-a)<=u /\ abs(y-b)<=v ==>
   abs((x-y)-(a-b))<=u+v /\ abs((x+y)-(a+b))<=u+v
Proof
  simp[ABS_BOUNDS] >> REAL_ARITH_TAC
QED

Theorem phase_radii:
  !p q f g pp qq ff gg:real.
  abs(pp-p)<=1 /\ abs(qq-q)<=1 /\ abs(ff-f)<=1 /\ abs(gg-g)<=1 ==>
  let d=abs p+abs q+abs f+abs g+2 in
  abs((pp*ff-qq*gg)-(p*f-q*g))<=d /\
  abs((pp*gg+qq*ff)-(p*g+q*f))<=d
Proof
  rpt gen_tac >> simp[LET_THM] >> strip_tac >>
  map_every (fn ts => mp_tac (Q.SPECL ts product_radius))
    [[`p:real`,`f:real`,`pp:real`,`ff:real`,`1:real`,`1:real`],
     [`q:real`,`g:real`,`qq:real`,`gg:real`,`1:real`,`1:real`],
     [`p:real`,`g:real`,`pp:real`,`gg:real`,`1:real`,`1:real`],
     [`q:real`,`f:real`,`qq:real`,`ff:real`,`1:real`,`1:real`]] >>
  asm_simp_tac (srw_ss()) [ABS_BOUNDS] >> REAL_ARITH_TAC
QED

Theorem projected_radius:
  !a b aa bb r i xx yy d e:real.
  abs(aa-a)<=d /\ abs(bb-b)<=d /\ abs(xx-r)<=e /\ abs(yy-i)<=e ==>
  abs((aa*xx-bb*yy)-(a*r-b*i)) <=
  (abs a+abs b)*e+d*(abs r+abs i+2*e)
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`a:real`,`r:real`,`aa:real`,`xx:real`,`d:real`,`e:real`] product_radius) >>
  mp_tac (Q.SPECL [`b:real`,`i:real`,`bb:real`,`yy:real`,`d:real`,`e:real`] product_radius) >>
  asm_simp_tac (srw_ss()) [ABS_BOUNDS] >> REAL_ARITH_TAC
QED

Theorem cast_abs:
  !z:int. abs(real_of_int z)=real_of_int(ABS z)
Proof
  Cases >> simp[INT_ABS,abs,real_of_int_num,real_of_int_neg]
QED

Theorem margin_code:
  !z e:int. !x:real.
  abs(x-real_of_int z)<=real_of_int e ==>
  let k=if e<z then 2:num else if z < -e then 1 else 0
  in (k=2 ==> 0<x) /\ (k=1 ==> x<0)
Proof
  rpt gen_tac >> PURE_REWRITE_TAC [LET_THM,ABS_BOUNDS] >> BETA_TAC >> strip_tac >>
  Cases_on `(e:int)<z` >| [
    `real_of_int e<real_of_int z` by (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
    asm_simp_tac (srw_ss()) [] >> REAL_ASM_ARITH_TAC,
    Cases_on `(z:int) < -e` >| [
      `real_of_int z < real_of_int (-e)` by (rewrite_tac[real_of_int_lt] >> asm_rewrite_tac[]) >>
      pop_assum (mp_tac o REWRITE_RULE[real_of_int_neg]) >>
      asm_simp_tac (srw_ss()) [] >> REAL_ASM_ARITH_TAC,
      asm_simp_tac (srw_ss()) []
    ]
  ]
QED

Theorem score_sign:
  !p q f g e r i pp qq ff gg xx yy.
  abs(pp-real_of_int p)<=1 /\ abs(qq-real_of_int q)<=1 /\
  abs(ff-real_of_int f)<=1 /\ abs(gg-real_of_int g)<=1 /\
  abs(xx-real_of_int r)<=real_of_int e /\ abs(yy-real_of_int i)<=real_of_int e ==>
  let k=LargeTerminal$score (p,q) (f,g,e) (r,i);
      v=(pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy
  in (k=2 ==> 0<v) /\ (k=1 ==> v<0)
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`real_of_int p`,`real_of_int q`,`real_of_int f`,`real_of_int g`,
          `pp:real`,`qq:real`,`ff:real`,`gg:real`] phase_radii) >>
  PURE_REWRITE_TAC [LET_THM] >> BETA_TAC >>
  impl_tac >- (rpt conj_tac >> first_assum ACCEPT_TAC) >> strip_tac >>
  mp_tac (Q.SPECL [`real_of_int p*real_of_int f-real_of_int q*real_of_int g`,
       `real_of_int p*real_of_int g+real_of_int q*real_of_int f`,
       `pp*ff-qq*gg:real`,`pp*gg+qq*ff:real`,`real_of_int r`,`real_of_int i`,
       `xx:real`,`yy:real`,
       `abs(real_of_int p)+abs(real_of_int q)+abs(real_of_int f)+abs(real_of_int g)+2`,
       `real_of_int e`] projected_radius) >>
  impl_tac >- (rpt conj_tac >> first_assum ACCEPT_TAC) >> strip_tac >>
  PURE_REWRITE_TAC [LargeTerminalTheory.score_def,LET_THM] >> BETA_TAC >>
  irule (SIMP_RULE bool_ss [LET_THM] margin_code) >>
  PURE_REWRITE_TAC [real_of_int_add,real_of_int_sub,real_of_int_mul,real_of_int_num,GSYM cast_abs] >>
  first_assum ACCEPT_TAC
QED
