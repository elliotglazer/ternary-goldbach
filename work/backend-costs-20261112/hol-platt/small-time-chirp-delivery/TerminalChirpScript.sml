Theory TerminalChirp
Ancestors ChirpError PacketMeaning complex real transc
Libs realLib RealField
val _=realLib.prefer_real();
Theorem component_norm:
 !u v. abs u <= modu(u,v) /\ abs v <= modu(u,v)
Proof
 rpt gen_tac >> mp_tac(SPEC ``(u:real,v:real)`` RE_IM_LE_MODU) >> simp[RE,IM]
QED
Theorem coordinate_difference:
 !x y j t. (x,y)-cq t j=(x-cos((&j* &j)*t),y-sin((&j* &j)*t))
Proof
 simp[cq_def,cir_def,complex_sub,complex_add,complex_neg,RE,IM,real_sub]
QED
Theorem source_coordinates:
 !x y j t B. modu((x,y)-cq t j)<=B ==>
 abs(cos((&j* &j)*t)-x)<=B /\ abs(sin((&j* &j)*t)-y)<=B
Proof
 rpt gen_tac >> rewrite_tac[coordinate_difference] >> strip_tac >>
 mp_tac(SPECL [``(x:real)-cos((&(j:num)* &j)*(t:real))``,
               ``(y:real)-sin((&(j:num)* &j)*(t:real))``] component_norm) >>
 metis_tac[ABS_SUB,REAL_LE_TRANS]
QED
Theorem actual_cells:
 !x y j t a b S B.
   modu((x,y)-cq t j)<=B /\ 0<S /\
   2*abs(x-S*a)+2*B<S /\ 2*abs(y-S*b)+2*B<S ==>
   S*a-S/2<cos((&j* &j)*t) /\ cos((&j* &j)*t)<S*a+S/2 /\
   S*b-S/2<sin((&j* &j)*t) /\ sin((&j* &j)*t)<S*b+S/2
Proof
 rpt gen_tac >> strip_tac >> metis_tac[source_coordinates,strict_cell]
QED