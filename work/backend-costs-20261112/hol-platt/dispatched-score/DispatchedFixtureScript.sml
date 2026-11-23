Theory DispatchedFixture
Ancestors DispatchedScore Sector LargeTerminal integer intreal real
Libs realLib intLib

Theorem fixture_3_code:
  let c=Sector$one (1613086167367824050620613,1801099543603905310752363) (547717860172185411035664,(-349818618999149958642857),13308) (262925930125536987524716363,(-73342367083943906221400553)) in (if c=0 then LargeTerminal$score (1613086167367824050620613,1801099543603905310752363) (547717860172185411035664,(-349818618999149958642857),13308) (262925930125536987524716363,(-73342367083943906221400553)) else c)=2 /\ (c=0 <=> F)
Proof
  EVAL_TAC
QED

Theorem fixture_3_sign:
  !pp qq ff gg xx yy. abs(pp-real_of_int 1613086167367824050620613)<=1 /\ abs(qq-real_of_int 1801099543603905310752363)<=1 /\
  abs(ff-real_of_int 547717860172185411035664)<=1 /\ abs(gg-real_of_int (-349818618999149958642857))<=1 /\
  abs(xx-real_of_int 262925930125536987524716363)<=real_of_int 13308 /\ abs(yy-real_of_int (-73342367083943906221400553))<=real_of_int 13308 /\
  0 < (pp*ff-qq*gg)*(pp*ff-qq*gg)+(pp*gg+qq*ff)*(pp*gg+qq*ff) /\
  (pp*ff-qq*gg)*yy+(pp*gg+qq*ff)*xx=0 ==>
  0 < (pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`1613086167367824050620613:int`,`1801099543603905310752363:int`,`547717860172185411035664:int`,`(-349818618999149958642857):int`,`13308:int`,`262925930125536987524716363:int`,`(-73342367083943906221400553):int`,`pp:real`,`qq:real`,`ff:real`,`gg:real`,`xx:real`,`yy:real`] dispatched_sign) >>
  impl_tac >- (rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >> EVAL_TAC) >>
  simp_tac bool_ss [LET_THM,CONJUNCT1 (SIMP_RULE bool_ss [LET_THM] fixture_3_code)]
QED

Theorem fixture_10003_code:
  let c=Sector$one (2417851639229258349412352,0) (11302235967085741560522130,(-5416098435190739482364960),13308) (1066120088293576659453813172,510891062507264405502050296) in (if c=0 then LargeTerminal$score (2417851639229258349412352,0) (11302235967085741560522130,(-5416098435190739482364960),13308) (1066120088293576659453813172,510891062507264405502050296) else c)=2 /\ (c=0 <=> T)
Proof
  EVAL_TAC
QED

Theorem fixture_10003_sign:
  !pp qq ff gg xx yy. abs(pp-real_of_int 2417851639229258349412352)<=1 /\ abs(qq-real_of_int 0)<=1 /\
  abs(ff-real_of_int 11302235967085741560522130)<=1 /\ abs(gg-real_of_int (-5416098435190739482364960))<=1 /\
  abs(xx-real_of_int 1066120088293576659453813172)<=real_of_int 13308 /\ abs(yy-real_of_int 510891062507264405502050296)<=real_of_int 13308 /\
  0 < (pp*ff-qq*gg)*(pp*ff-qq*gg)+(pp*gg+qq*ff)*(pp*gg+qq*ff) /\
  (pp*ff-qq*gg)*yy+(pp*gg+qq*ff)*xx=0 ==>
  0 < (pp*ff-qq*gg)*xx-(pp*gg+qq*ff)*yy
Proof
  rpt gen_tac >> strip_tac >>
  mp_tac (Q.SPECL [`2417851639229258349412352:int`,`0:int`,`11302235967085741560522130:int`,`(-5416098435190739482364960):int`,`13308:int`,`1066120088293576659453813172:int`,`510891062507264405502050296:int`,`pp:real`,`qq:real`,`ff:real`,`gg:real`,`xx:real`,`yy:real`] dispatched_sign) >>
  impl_tac >- (rpt conj_tac >> TRY (first_assum ACCEPT_TAC) >> EVAL_TAC) >>
  simp_tac bool_ss [LET_THM,CONJUNCT1 (SIMP_RULE bool_ss [LET_THM] fixture_10003_code)]
QED

