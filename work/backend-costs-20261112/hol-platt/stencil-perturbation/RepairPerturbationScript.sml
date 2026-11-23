Theory RepairPerturbation
Ancestors WindowPerturbation GridSigns KernelWeights StencilReceipt Enclosure sptree arithmetic integer list

Theorem repair_raw_margin:
  !tab ks t k r off den err ws ps raw.
  lookup k ks = SOME(r,off,den,err,ws) /\ KernelWeights$kernel_ok r off (&den) ws /\
  LENGTH ws = LENGTH ps /\ reads tab (129+t DIV 4096-r DIV 2) ps /\
  LIST_REL Enclosure$encloses raw ps ==>
  (GridSigns$at_repair tab ks t k = 2 ==>
     &(den*err) < StencilReceipt$dot ws (MAP raw_center raw)) /\
  (GridSigns$at_repair tab ks t k = 1 ==>
     StencilReceipt$dot ws (MAP raw_center raw) < -&(den*err))
Proof
  rpt gen_tac >> strip_tac >>
  `!z cap. GridSigns$dot_window tab (129+t DIV 4096-r DIV 2) ws 0 0 = SOME(z,cap) ==>
    (GridSigns$strict_code z (den*(err+5*cap)) = 2 ==> &(den*err)<StencilReceipt$dot ws (MAP raw_center raw)) /\
    (GridSigns$strict_code z (den*(err+5*cap)) = 1 ==> StencilReceipt$dot ws (MAP raw_center raw) < -&(den*err))` by
    (rpt gen_tac >> strip_tac >>
     mp_tac (Q.SPECL [`ws`,`ps`,`raw`,`tab`,`129+t DIV 4096-r DIV 2`,`z`,`cap`,`r`,`off`,`den`,`err`] window_sign_margin) >>
     ASM_REWRITE_TAC [LET_THM] >> CONV_TAC (DEPTH_CONV BETA_CONV) >> simp []) >>
  Cases_on `0<off /\ off=t MOD 4096 /\ r DIV 2 <= 129+t DIV 4096 /\ LENGTH ws=r` >>
  simp [GridSignsTheory.at_repair_def] >>
  Cases_on `GridSigns$dot_window tab (129+t DIV 4096-r DIV 2) ws 0 0` >> simp [] >>
  rename1 `SOME p` >> PairCases_on `p` >> fs [] >> metis_tac []
QED
