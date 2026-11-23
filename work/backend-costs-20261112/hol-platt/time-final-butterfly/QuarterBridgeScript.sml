Theory QuarterBridge
Ancestors FullButterfly MaskedButterfly FinalButterfly list integer arithmetic
Libs cv_transLib

Definition qb_close_def:
  qb_close (s:int) (den:int) z err target <=>
    (target-1)*den <= (z-err)*s /\ (z+err)*s <= (target+1)*den
End
Definition qb_lane_def:
  qb_lane s t b B vr vi old next <=>
   let a=mb_signed (old MOD b) b; d=mb_signed ((old DIV b) MOD b) b;
       e=mb_signed ((old DIV (b*b)) MOD b) b;
       c0=mb_signed (next MOD B) B; xs=next DIV B;
       c1r=mb_signed (xs MOD B) B; ys=xs DIV B;
       c1i=mb_signed (ys MOD B) B; zs=ys DIV B;
       c2r=mb_signed (zs MOD B) B; us=zs DIV B;
       c2i=mb_signed (us MOD B) B; vs=us DIV B;
       c3r=mb_signed (vs MOD B) B; c3i=mb_signed ((vs DIV B) MOD B) B;
       tt=t*t; den=tt*t;
       base=tt+fb_abs vr+fb_abs vi;
       r2=base+6*t*(fb_abs c2r+fb_abs c2i+2);
       r3=base+6*t*(fb_abs c3r+fb_abs c3i+2)
   in qb_close s den (c0*tt+vr*c2r-vi*c2i) r2 a /\
      qb_close s den (c1r*tt+vr*c3r-vi*c3i) r3 d /\
      qb_close s den (c1i*tt+vr*c3i+vi*c3r) r3 e
End
Definition qb_lanes_def:
  (qb_lanes 0 m s t b B vr vi old next <=> m=0 /\ old=0 /\ next=0) /\
  (qb_lanes (SUC n) m s t b B vr vi old next <=>
    if m MOD 2=0 then qb_lanes n (m DIV 2) s t b B vr vi old next else
    qb_lane s t b B vr vi old next /\
    qb_lanes n (m DIV 2) s t b B vr vi (old DIV (b*b*b)) (next DIV (B**7)))
End
Definition qb_row_def:
  qb_row tile s t b B m0 m1 m2 m3 old next <=>
   let idx=old MOD 131072; j=2**(idx MOD 64);
       mask=(m0 DIV j) MOD 2 + 2*((m1 DIV j) MOD 2) + 4*((m2 DIV j) MOD 2) + 8*((m3 DIV j) MOD 2);
       ro=old DIV 131072; rn=next DIV 131072; R=4*s; U=4*t;
       wr=mb_signed (ro MOD R) R; wi=mb_signed ((ro DIV R) MOD R) R;
       ur=mb_signed (rn MOD U) U; ui=mb_signed ((rn DIV U) MOD U) U;
       T= &t; S= &s; vr=ur*ur-ui*ui; vi=2*ur*ui
   in idx DIV 64=tile /\ next MOD 131072=idx /\ 0<mask /\
      fb_abs ur<=T /\ fb_abs ui<=T /\ qb_close S T ur 1 wr /\ qb_close S T ui 1 wi /\
      qb_lanes 4 mask S T b B vr vi (ro DIV (R*R)) (rn DIV (U*U))
End
Definition qb_rows_def:
  (qb_rows tile s t b B a c d e [] ys <=> NULL ys) /\
  (qb_rows tile s t b B a c d e (x::xs) [] <=> F) /\
  (qb_rows tile s t b B a c d e (x::xs) (y::ys) <=>
      qb_row tile s t b B a c d e x y /\ qb_rows tile s t b B a c d e xs ys)
End
Definition qb_tile_def:
  qb_tile tile p w t v m0 m1 m2 m3 xs ys <=>
    qb_rows tile (2**p) (2**t) (2**w) (2**v) m0 m1 m2 m3 xs ys
End
val _=cv_auto_trans qb_close_def;
val _=cv_auto_trans qb_lane_def;
val _=cv_auto_trans qb_lanes_def;
val _=cv_auto_trans qb_row_def;
val _=cv_auto_trans qb_rows_def;
val _=cv_auto_trans qb_tile_def;
