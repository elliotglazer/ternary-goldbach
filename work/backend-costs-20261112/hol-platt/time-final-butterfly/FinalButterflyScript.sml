Theory FinalButterfly
Ancestors GridSigns integer arithmetic
Libs cv_transLib intLib

Definition fb_abs_def:
  fb_abs (x:int) = if x < 0 then -x else x
End
Definition fb_value_def:
  fb_value (n:num):int = &n - 971334446112864535459730953411759453321203419526069760625906204869452142602604249088
End
Definition fb_project_def:
  fb_project ner nor noi nwr nwi (e:num) nq code <=>
    let er = fb_value ner; orr=fb_value nor; oi=fb_value noi;
        wr=fb_value nwr; wi=fb_value nwi;
        q = (&nq:int)-2147483648;
        unit = 2 ** e;
        d = 7957171782556586274486115970349133441607298412757563479047423630290551952200534008528896 * &unit;
        z = er*115792089237316195423570985008687907853269984665640564039457584007913129639936 + wr*orr - wi*oi;
        err = 115792089237316195423570985008687907853269984665640564039457584007913129639936 + fb_abs wr + fb_abs wi + fb_abs orr + fb_abs oi + 2
    in e<=255 /\ q*d <= z-err /\ z+err < (q+1)*d /\
       (code=1 \/ code=2) /\ strict_code (q * &unit) (519575974158994+unit) = code
End
val _=cv_trans fb_abs_def;
val _=cv_trans fb_value_def;
val _=cv_auto_trans fb_project_def;

Theorem fb_interval_projection:
  !q d z e x:int.
   q*d <= z-e /\ z+e < (q+1)*d /\ z-e <= x /\ x <= z+e ==>
   q*d <= x /\ x < (q+1)*d
Proof
  intLib.ARITH_TAC
QED
