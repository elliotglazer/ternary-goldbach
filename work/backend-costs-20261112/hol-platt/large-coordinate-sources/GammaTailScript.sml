Theory GammaTail
Ancestors arithmetic real
Libs cv_transLib realLib RealField

Theorem stirling_integer_tail:
  (2:num)**190 * 261082718496449122051 <
    13530*40*39*64**39
Proof
  CONV_TAC cv_transLib.cv_eval
QED

Theorem enclosed_bin_real:
  !lo hi mid x:real.
    lo <= x /\ x <= hi /\
    (2*mid-1)*35184372088832 < 2*lo /\
    2*hi < (2*mid+1)*35184372088832 ==>
    abs(x-mid*35184372088832) < 17592186044416
Proof
  rw[abs] >> RealField.REAL_ASM_ARITH_TAC
QED
