Theory InterpolationConsumer
Ancestors RadiusBudget WeightedSample StencilReceipt KernelWeights intreal real integer arithmetic list
Libs realLib

fun mark s g=(print (s^" "^Parse.term_to_string (#2 g)^"\n");ALL_TAC g);
Theorem divide_sample:
  !w z:real. !den:num. 0 < den /\ abs(w-z) <= 10* &den ==>
  abs(w / &den - z / &den) <= 10
Proof
  rpt gen_tac >> strip_tac >>
  `0<(&den:real)` by simp [] >> mark "positive" >>
  `(&den:real) <> 0` by realLib.REAL_ASM_ARITH_TAC >> mark "nonzero" >>
  `abs(&den:real)= &den` by simp [abs] >> mark "abs" >>
  `(w:real) / (&den:real) - (z:real) / (&den:real) = (w-z) / (&den:real)` by (PURE_REWRITE_TAC [real_div,REAL_SUB_RDISTRIB] >> mark "ring" >> realLib.REAL_ARITH_TAC) >> mark "sub" >>
  ASM_SIMP_TAC bool_ss [ABS_DIV,REAL_LE_LDIV_EQ]
QED

Theorem interpolation_consumer:
  !r off den err ws nodes centers H U.
  KernelWeights$kernel_ok r off (&den) ws /\ KernelWeights$radius_ok r err /\
  LENGTH ws = LENGTH nodes /\
  LIST_REL (\v z. abs(v-real_of_int z)<=2) nodes centers /\
  abs(H-U) <= &(2**220*(5*524288*budget_D r)) / &(budget_A*budget_D r) /\
  abs(U - weighted ws nodes / &den) <=
    &(2**220*(budget_A*budget_M r)) / &(budget_A*budget_D r) ==>
  abs(H-real_of_int (StencilReceipt$dot ws centers) / &den) <= &err
Proof
  rpt gen_tac >> strip_tac >>
  `0<den` by fs [KernelWeightsTheory.kernel_ok_def] >>
  `abs(weighted ws nodes - real_of_int(StencilReceipt$dot ws centers)) <= 10* &den`
    by metis_tac [certified_coarse_samples] >>
  `abs(weighted ws nodes / &den - real_of_int(StencilReceipt$dot ws centers) / &den) <= 10`
    by metis_tac [divide_sample] >>
  MATCH_MP_TAC (Q.SPECL [`r`,`err`,`H:real`,`U:real`,`weighted ws nodes / &den`,`real_of_int(StencilReceipt$dot ws centers) / &den`] radius_consumer) >>
  ASM_REWRITE_TAC []
QED



