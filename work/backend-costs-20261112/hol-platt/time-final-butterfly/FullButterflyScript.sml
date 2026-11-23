Theory FullButterfly
Ancestors MaskedButterfly FinalButterfly list arithmetic integer
Libs cv_transLib

Definition fr_advance_def:
  fr_advance m base y = if m MOD 2 = 0 then y else y DIV base
End
Definition fr_lane_def:
  fr_lane S B wr wi m target y <=>
    if m MOD 2 = 0 then T else
    let a=mb_signed (y MOD B) B;
        b=mb_signed ((y DIV B) MOD B) B;
        c=mb_signed ((y DIV (B*B)) MOD B) B;
        q=mb_signed (target MOD 115792089237316195423570985008687907853269984665640564039457584007913129639936) 115792089237316195423570985008687907853269984665640564039457584007913129639936;
        den= &(S*S);
        z=a* &S+wr*b-wi*c;
        err= &S+fb_abs wr+fb_abs wi+fb_abs b+fb_abs c+2
    in q*den <= (z-err)*1684996666696914987166688442938726917102321526408785780068975640576 /\ (z+err)*1684996666696914987166688442938726917102321526408785780068975640576 < (q+1)*den
End
Definition fr_row_def:
  fr_row S B pos a b c d ta tb tc td r <=>
    let k=r MOD 131072; raw=r DIV 131072; R=4*S;
        wr=mb_signed (raw MOD R) R; wi=mb_signed ((raw DIV R) MOD R) R;
        W=B*B*B; p0=raw DIV (R*R); p1=fr_advance a W p0;
        p2=fr_advance b W p1; p3=fr_advance c W p2
    in k=pos /\ fr_lane S B wr wi a ta p0 /\ fr_lane S B wr wi b tb p1 /\
       fr_lane S B wr wi c tc p2 /\ fr_lane S B wr wi d td p3 /\ fr_advance d W p3=0
End
Definition fr_tick_def:
  fr_tick S B pos a b c d ta tb tc td rs =
    if (a MOD 2)+(b MOD 2)+(c MOD 2)+(d MOD 2)=0 then SOME rs
    else case rs of [] => NONE | r::rest =>
       if fr_row S B pos a b c d ta tb tc td r then SOME rest else NONE
End
Definition fr_loop_def:
  (fr_loop 0 S B pos a b c d ta tb tc td rs <=>
     NULL rs /\ a=0 /\ b=0 /\ c=0 /\ d=0 /\ ta=0 /\ tb=0 /\ tc=0 /\ td=0) /\
  (fr_loop (SUC n) S B pos a b c d ta tb tc td rs <=>
     case fr_tick S B pos a b c d ta tb tc td rs of NONE => F
     | SOME rest => fr_loop n S B (SUC pos) (a DIV 2) (b DIV 2) (c DIV 2) (d DIV 2)
       (fr_advance a 115792089237316195423570985008687907853269984665640564039457584007913129639936 ta) (fr_advance b 115792089237316195423570985008687907853269984665640564039457584007913129639936 tb)
       (fr_advance c 115792089237316195423570985008687907853269984665640564039457584007913129639936 tc) (fr_advance d 115792089237316195423570985008687907853269984665640564039457584007913129639936 td) rest)
End
Definition fr_tile_def:
  fr_tile tile p w a b c d ta tb tc td rs <=>
   tile<1331 /\ p<=304 /\ w<=384 /\
   fr_loop (MIN 64 (85121-64*tile)) (2**p) (2**w) (64*tile) a b c d ta tb tc td rs
End
val _=cv_auto_trans fr_advance_def;
val _=cv_auto_trans fr_lane_def;
val _=cv_auto_trans fr_row_def;
val _=cv_auto_trans fr_tick_def;
val _=cv_auto_trans fr_loop_def;
val _=cv_auto_trans fr_tile_def;
