Theory HardyRepair
Ancestors RepairPerturbation WindowPerturbation GridSigns KernelWeights StencilReceipt Enclosure sptree integer intreal real arithmetic list
Libs realLib intLib

fun marker s g = (print ("REAL_STEP "^s^" "^Parse.term_to_string (#2 g)^"\n");ALL_TAC g);
Theorem scaled_radius_sign:
  !s y x e:real. 0<s /\ abs(s*y-x) <= e ==>
  (e<x ==> 0<y) /\ (x < -e ==> y<0)
Proof
  rpt gen_tac >> REWRITE_TAC [ABS_BOUNDS] >> strip_tac >> marker "input" >>
  conj_tac >> strip_tac
  >- (`0<s*y` by realLib.REAL_ASM_ARITH_TAC >> marker "positive" >>
      metis_tac [REAL_LT_LMUL_0])
  >> `s*y < s*0` by realLib.REAL_ASM_ARITH_TAC >> marker "negative" >>
  metis_tac [REAL_LT_LMUL]
QED

Theorem real_radius_sign:
  !x:int. !n:num. !s y:real. 0<s /\ abs(s*y-real_of_int x) <= &n ==>
  ((&n:int)<x ==> 0<y) /\ (x < -(&n:int) ==> y<0)
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`s:real`,`y:real`,`real_of_int x`,`real_of_int (&n:int)`] scaled_radius_sign) >>
  PURE_REWRITE_TAC [GSYM real_of_int_neg,real_of_int_lt] >>
  ASM_REWRITE_TAC [real_of_int_num] >> simp []
QED
Theorem repair_real_sign:
  !tab ks t k r off den err ws ps raw (hardy:num->real).
  lookup k ks = SOME(r,off,den,err,ws) /\ KernelWeights$kernel_ok r off (&den) ws /\
  LENGTH ws = LENGTH ps /\ reads tab (129+t DIV 4096-r DIV 2) ps /\
  LIST_REL Enclosure$encloses raw ps /\
  abs (&(den * 2**220) * hardy t -
       real_of_int (StencilReceipt$dot ws (MAP raw_center raw))) <= &(den*err) ==>
  (GridSigns$at_repair tab ks t k = 2 ==> 0 < hardy t) /\
  (GridSigns$at_repair tab ks t k = 1 ==> hardy t < 0)
Proof
  rpt gen_tac >> strip_tac >>
  `0 < den` by fs [KernelWeightsTheory.kernel_ok_def] >>
  `0 < (&(den*2**220):real)` by simp [] >>
  mp_tac (Q.SPECL [`tab`,`ks`,`t`,`k`,`r`,`off`,`den`,`err`,`ws`,`ps`,`raw`] repair_raw_margin) >>
  ASM_REWRITE_TAC [] >> strip_tac >>
  mp_tac (Q.SPECL [`StencilReceipt$dot ws (MAP raw_center raw)`,`den*err`,`&(den*2**220):real`,`(hardy:num->real) t`] real_radius_sign) >>
  ASM_REWRITE_TAC [] >> metis_tac []
QED


