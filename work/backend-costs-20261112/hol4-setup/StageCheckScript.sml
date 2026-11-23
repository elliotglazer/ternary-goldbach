Theory StageCheck
Ancestors integer list cv_std
Libs intLib cv_transLib

val _ = intLib.prefer_int ();

Definition within_def:
  within (b:int) (x:int) <=> -b <= x /\ x <= b
End

Definition stage_one_def:
  stage_one (s:int) (b:int) (ur,ui,vr,vi,wr,wi) (pr,pi,mr,mi) =
  let t = wr * (vr+vi);
      u = vi * (wr+wi);
      v = vr * (wi-wr);
      rr = t-u;
      ii = t+v
  in
    within b ur /\ within b ui /\ within b vr /\ within b vi /\
    within s wr /\ within s wi /\
    within (4*b) pr /\ within (4*b) pi /\
    within (4*b) mr /\ within (4*b) mi /\
    within (4*b*s) t /\ within (4*b*s) u /\ within (4*b*s) v /\
    pr+mr = 2*ur /\ pi+mi = 2*ui /\
    -s <= 2*(rr-(pr-ur)*s) /\ 2*(rr-(pr-ur)*s) < s /\
    -s <= 2*(ii-(pi-ui)*s) /\ 2*(ii-(pi-ui)*s) < s
End

Definition stage_check_def:
  (stage_check s b [] [] = T) /\
  (stage_check s b (x::xs) (y::ys) =
     (stage_one s b x y /\ stage_check s b xs ys)) /\
  (stage_check s b [] (y::ys) = F) /\
  (stage_check s b (x::xs) [] = F)
End

Definition butterfly_spec_def:
  butterfly_spec (s:int) (b:int) (ur,ui,vr,vi,wr,wi) (pr,pi,mr,mi) =
    (within b ur /\ within b ui /\ within b vr /\ within b vi /\
     within s wr /\ within s wi /\
     within (4*b) pr /\ within (4*b) pi /\
     within (4*b) mr /\ within (4*b) mi /\
     within s (2*(ur*s+(vr*wr-vi*wi)-pr*s)) /\
     within s (2*(ui*s+(vr*wi+vi*wr)-pi*s)) /\
     within s (2*(ur*s-(vr*wr-vi*wi)-mr*s)) /\
     within s (2*(ui*s-(vr*wi+vi*wr)-mi*s)))
End

val int_normalize = DEPTH_CONV (CHANGED_CONV (fn tm =>
  if type_of tm = ``:int`` then intLib.INT_POLY_CONV tm
  else raise mk_HOL_ERR "StageCheck" "int_normalize" "not an integer"));

Theorem residual_pair:
  !s a r p m:int.
    p+m = 2*a /\ -s <= 2*(r-(p-a)*s) /\ 2*(r-(p-a)*s) < s ==>
    within s (2*(a*s+r-p*s)) /\ within s (2*(a*s-r-m*s))
Proof
  rpt gen_tac >> strip_tac >>
  `p*s + m*s = 2*(a*s)` by
    (fs [GSYM INT_RDISTRIB] >> intLib.INT_RING_TAC) >>
  REWRITE_TAC [within_def] >>
  RULE_ASSUM_TAC (CONV_RULE int_normalize) >>
  CONV_TAC int_normalize >> intLib.ARITH_TAC
QED

Theorem three_real:
  (wr:int)*(vr+vi)-vi*(wr+wi) = vr*wr-vi*wi
Proof intLib.INT_RING_TAC
QED

Theorem three_imag:
  (wr:int)*(vr+vi)+vr*(wi-wr) = vr*wi+vi*wr
Proof intLib.INT_RING_TAC
QED

Theorem stage_one_sound_coordinates:
  stage_one s b (ur,ui,vr,vi,wr,wi) (pr,pi,mr,mi) ==>
  butterfly_spec s b (ur,ui,vr,vi,wr,wi) (pr,pi,mr,mi)
Proof
  SIMP_TAC bool_ss [stage_one_def,butterfly_spec_def,LET_THM,
                   three_real,three_imag] >>
  strip_tac >>
  mp_tac (Q.SPECL [`s`,`ur`,`vr*wr-vi*wi`,`pr`,`mr`] residual_pair) >>
  mp_tac (Q.SPECL [`s`,`ui`,`vr*wi+vi*wr`,`pi`,`mi`] residual_pair) >>
  metis_tac []
QED

Theorem stage_one_sound:
  !x y. stage_one s b x y ==> butterfly_spec s b x y
Proof
  rpt gen_tac >> PairCases_on `x` >> PairCases_on `y` >>
  metis_tac [stage_one_sound_coordinates]
QED

Theorem stage_check_sound:
  !xs ys. stage_check s b xs ys ==>
    LIST_REL (butterfly_spec s b) xs ys
Proof
  Induct_on `xs` >> Cases_on `ys` >>
  simp [stage_check_def,LIST_REL_def] >>
  metis_tac [stage_one_sound]
QED

val _ = cv_trans within_def;
val _ = cv_trans stage_one_def;
val _ = cv_trans stage_check_def;

val _ = print "HOL4_STAGE_THEORY_DONE\n";
