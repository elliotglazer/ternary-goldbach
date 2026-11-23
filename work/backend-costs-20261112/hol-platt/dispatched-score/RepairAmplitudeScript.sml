Theory RepairAmplitude
Ancestors FallbackScore LargeTerminal real integer intreal
Libs realLib intLib

Definition ball_def:
  ball (p:int,q:int) (f:int,g:int,e:int) (r:int,i:int) =
  let a=p*f-q*g; b=p*g+q*f in
  (a*r-b*i,(ABS a+ABS b)*e+(ABS p+ABS q+ABS f+ABS g+2)*(ABS r+ABS i+2*e))
End

Theorem matches_score:
  !p q f g e r i.
  let (v,d)=ball (p,q) (f,g,e) (r,i)
  in LargeTerminal$score (p,q) (f,g,e) (r,i)=
     if d<v then 2 else if v < -d then 1 else 0
Proof
  simp[ball_def,LargeTerminalTheory.score_def,LET_THM]
QED

Theorem enclosed_amplitude:
  !p q f g e r i pp qq ff gg xx yy.
  abs(pp-real_of_int p)<=1 /\ abs(qq-real_of_int q)<=1 /\
  abs(ff-real_of_int f)<=1 /\ abs(gg-real_of_int g)<=1 /\
  abs(xx-real_of_int r)<=real_of_int e /\ abs(yy-real_of_int i)<=real_of_int e ==>
  abs(((pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy)-
    real_of_int (FST (ball (p,q) (f,g,e) (r,i))))<=
    real_of_int (SND (ball (p,q) (f,g,e) (r,i)))
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
  simp_tac bool_ss [ball_def,LET_THM,pairTheory.FST,pairTheory.SND] >>
  PURE_REWRITE_TAC [real_of_int_add,real_of_int_sub,real_of_int_mul,real_of_int_num,GSYM cast_abs] >>
  first_assum ACCEPT_TAC
QED
