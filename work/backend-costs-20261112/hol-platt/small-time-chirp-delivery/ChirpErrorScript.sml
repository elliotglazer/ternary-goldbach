Theory ChirpError
Ancestors SourceStateError SourceArithmetic complex real arithmetic transc
Libs realLib RealField
val _=realLib.prefer_real();
Theorem rounded_unit_step:
 !g u v z w err eps.
  0<g /\ 0<=err /\ err<=1 /\ 0<=eps /\ modu z=1 /\ modu w=1 /\
  modu(source_pair_value g u-z)<=err /\ modu(source_pair_value g v-w)<=eps ==>
  modu(source_pair_value g (source_mul g u v)-z*w)<=err+2*eps+1/(&g:real)
Proof
 rpt strip_tac >>
 `eps*err<=eps*1` by (irule REAL_LE_LMUL_IMP >> simp[]) >>
 mp_tac(Q.SPECL [`g`,`g`,`u`,`v`,`z`,`w`,`err`,`eps`] ss_source_update_error) >>
 simp[REAL_ADD_RDISTRIB] >> RealField.REAL_ASM_ARITH_TAC
QED
Theorem chirp_pair_envelope:
 !limit G Z R z r d D E A B.
   0<G /\ 0<=E /\ modu D=1 /\ modu(source_pair_value G d-D)<=E /\
   modu(source_pair_value G (Z 0)-z 0)<=A 0 /\
   modu(source_pair_value G (R 0)-r 0)<=B 0 /\
   (!j. j<limit ==> 0<=A j /\ A j<=1 /\ 0<=B j /\ B j<=1 /\ modu(z j)=1 /\ modu(r j)=1 /\
      z(SUC j)=z j*r j /\ r(SUC j)=r j*D /\
      Z(SUC j)=source_mul G (Z j) (R j) /\ R(SUC j)=source_mul G (R j) d /\
      A j+2*B j+1/(&G:real)<=A(SUC j) /\ B j+2*E+1/(&G:real)<=B(SUC j)) ==>
   !j. j<=limit ==> modu(source_pair_value G (Z j)-z j)<=A j /\
                 modu(source_pair_value G (R j)-r j)<=B j
Proof
 rpt gen_tac >> strip_tac >> Induct_on `j`
 >- metis_tac[] >>
 disch_tac >>
 qpat_x_assum `!i. i<_ ==> _` (qspec_then `j` mp_tac) >>
 impl_tac >- decide_tac >> strip_tac >>
 qpat_x_assum `j<=_ ==> _` mp_tac >>
 impl_tac >- decide_tac >> strip_tac >>
  mp_tac (Q.SPECL [`G`,`Z (j:num)`,`R (j:num)`,`z (j:num)`,`r (j:num)`,`A (j:num)`,`B (j:num)`] rounded_unit_step) >>
 mp_tac (Q.SPECL [`G`,`R (j:num)`,`d`,`r (j:num)`,`D`,`B (j:num)`,`E`] rounded_unit_step) >>
 asm_rewrite_tac[] >> RealField.REAL_ASM_ARITH_TAC
QED
Definition cir_def:
 cir t:complex=(cos t,sin t)
End
Theorem cir_unit:
 !t. modu(cir t)=1
Proof
 gen_tac >> simp[cir_def,modu,RE,IM] >>
 mp_tac(Q.SPEC `t` SIN_CIRCLE) >> simp[REAL_ADD_COMM,SQRT_1]
QED
Theorem cir_product:
 !s t. cir(s+t)=cir s*cir t
Proof
 simp[cir_def,complex_mul,COS_ADD,SIN_ADD,RE,IM,REAL_MUL_COMM,REAL_ADD_COMM]
QED
Definition cq_def:
 cq t (j:num)=cir ((&j* &j)*t)
End
Definition cd_def:
 cd t (j:num)=cir ((2* &j+1)*t)
End
Theorem phase_identities:
 !t j. cq t (SUC j)=cq t j*cd t j /\ cd t (SUC j)=cd t j*cir(2*t)
Proof
 rpt gen_tac >> rewrite_tac[cq_def,cd_def,GSYM cir_product] >>
 conj_tac >> AP_TERM_TAC >> rewrite_tac[REAL] >> RealField.REAL_FIELD_TAC
QED
Theorem chirp_units:
 !t j. modu(cq t j)=1 /\ modu(cd t j)=1
Proof
 simp[cq_def,cd_def,cir_unit]
QED
(* Specialization preserves every premise of the exported error induction. *)
val specialized_chirp = INST [
  (mk_var("z",type_of ``cq (t:real)``) |-> ``cq (t:real)``),
  (mk_var("r",type_of ``cd (t:real)``) |-> ``cd (t:real)``),
  (mk_var("D",type_of ``cir(2*(t:real))``) |-> ``cir(2*(t:real))``)]
  (SPEC_ALL chirp_pair_envelope);
val actual_chirp_envelope = save_thm ("actual_chirp_envelope",
  GEN_ALL (SIMP_RULE std_ss [cir_unit,phase_identities,chirp_units] specialized_chirp));
val _ = print (thm_to_string actual_chirp_envelope ^ "\n");