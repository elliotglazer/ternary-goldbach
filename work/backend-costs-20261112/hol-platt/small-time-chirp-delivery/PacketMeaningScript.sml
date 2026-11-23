Theory PacketMeaning
Ancestors ChirpPackets SourceArithmetic BlockRound real intreal integer
Libs realLib RealField intLib
Theorem cmul_source:
 !g a b. 0<g ==> cmul (&g) a b=source_mul g a b
Proof
 rpt gen_tac >> strip_tac >> Cases_on `a` >> Cases_on `b` >>
 simp[cmul_def,cr_def,sdiv_def,source_mul_def,round_scaled_def]
QED
val _=realLib.prefer_real();
Theorem strict_cell:
 !x y h S B:real. 0<S /\ abs(y-x)<=B /\ 2*abs(x-S*h)+2*B<S ==>
   S*h-S/2<y /\ y<S*h+S/2
Proof
 rpt gen_tac >> rw[abs] >> RealField.REAL_ASM_FIELD_TAC
QED
Theorem bound_increments:
 !(e:real) (d:real) (h:real) (j:num).
   e+ &(SUC j)*(2*d+h)=(e+ &j*(2*d+h))+2*d+h /\
   &(SUC j)*(h+2*e)+(2*d+h)* &(SUC j)*(&(SUC j)-1)=
   (&j*(h+2*e)+(2*d+h)* &j*(&j-1))+2*(e+ &j*(2*d+h))+h
Proof
 rpt gen_tac >> conj_tac >> rewrite_tac[REAL] >> RealField.REAL_FIELD_TAC
QED
Theorem truncated_cell:
 !x v rounded E H S q:real.
   abs(v-x)<=E /\ abs(rounded-v)<=H /\
   q*S<=x-(E+H) /\ x+(E+H)<q*S+S ==>
   q*S<=rounded /\ rounded<q*S+S
Proof
 rpt gen_tac >> rw[abs] >> RealField.REAL_ASM_FIELD_TAC
QED
