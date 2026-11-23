Theory DispatchedScore
Ancestors FallbackScore SectorEnclosure SectorSound HardyCoordinate Sector LargeTerminal intreal integer real
Libs realLib intLib

(* The expression defining k occurs twice in the timed Sector.packet. *)
Theorem dispatched_sign:
  !p q f g e r i pp qq ff gg xx yy.
  (0:int)<=e /\
  abs(pp-real_of_int p)<=1 /\ abs(qq-real_of_int q)<=1 /\
  abs(ff-real_of_int f)<=1 /\ abs(gg-real_of_int g)<=1 /\
  abs(xx-real_of_int r)<=real_of_int e /\ abs(yy-real_of_int i)<=real_of_int e /\
  0 < (pp*ff-qq*gg)*(pp*ff-qq*gg)+(pp*gg+qq*ff)*(pp*gg+qq*ff) /\
  (pp*ff-qq*gg)*yy+(pp*gg+qq*ff)*xx=0 ==>
  let c=Sector$one (p,q) (f,g,e) (r,i);
      k=if c=0 then LargeTerminal$score (p,q) (f,g,e) (r,i) else c;
      v=(pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy
  in (k=2 ==> 0<v) /\ (k=1 ==> v<0)
Proof
  rpt gen_tac >> strip_tac >> PURE_REWRITE_TAC [LET_THM] >> BETA_TAC >>
  Cases_on `Sector$one (p:int,q:int) (f:int,g:int,e:int) (r:int,i:int)=0` >>
  asm_rewrite_tac [] >| [
    irule (SIMP_RULE bool_ss [LET_THM] FallbackScoreTheory.score_sign) >>
    rpt conj_tac >> first_assum ACCEPT_TAC,
    mp_tac (Q.SPECL [`p:int`,`q:int`,`f:int`,`g:int`,`e:int`,`r:int`,`i:int`,
      `pp:real`,`qq:real`,`ff:real`,`gg:real`,`xx:real`,`yy:real`]
      SectorEnclosureTheory.enclosed_one_hardy_sign) >>
    PURE_REWRITE_TAC [LET_THM] >> BETA_TAC >>
    impl_tac >- (rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >>
      COND_CASES_TAC >> asm_rewrite_tac[]) >>
    Cases_on `Sector$one (p:int,q:int) (f:int,g:int,e:int) (r:int,i:int)=2` >>
    asm_simp_tac (srw_ss()) [oriented_def] >> REAL_ARITH_TAC
  ]
QED
