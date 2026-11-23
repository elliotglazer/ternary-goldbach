Theory MaskedButterfly
Ancestors FinalButterfly list arithmetic integer
Libs cv_transLib

Definition mb_signed_def:
  mb_signed (n:num) b:int = &n - &(b DIV 2)
End
Definition mb_test_def:
  mb_test S B (W:num) wr wi ex y <=>
   let a=mb_signed (y MOD B) B;
       b=mb_signed ((y DIV B) MOD B) B;
       c=mb_signed ((y DIV (B*B)) MOD B) B;
       q=mb_signed ((y DIV (B*B*B)) MOD 4294967296) 4294967296;
       code=1+y DIV (4294967296*B*B*B);
       u=2**ex; den= &(u*S*S);
       z=a* &S + wr*b - wi*c;
       err= &S + fb_abs wr + fb_abs wi + fb_abs b + fb_abs c + 2
   in q*den <= (z-err)*1684996666696914987166688442938726917102321526408785780068975640576 /\ (z+err)*1684996666696914987166688442938726917102321526408785780068975640576 < (q+1)*den /\
      strict_code (q* &u) (519575974158994+u) = code
End
Definition mb_lanes_def:
  (mb_lanes 0 S B W wr wi ex m y <=> m=0 /\ y=0) /\
  (mb_lanes (SUC n) S B W wr wi ex m y <=>
    if m MOD 2 = 0 then mb_lanes n S B W wr wi (ex DIV 256) (m DIV 2) y
    else mb_test S B W wr wi (ex MOD 256) (y MOD W) /\
         mb_lanes n S B W wr wi (ex DIV 256) (m DIV 2) (y DIV W))
End
Definition mb_row_def:
  mb_row S B W ex row <=>
    let root=row DIV 16; R=4*S; wr=mb_signed (root MOD R) R;
        wi=mb_signed ((root DIV R) MOD R) R
    in 0<row MOD 16 /\ mb_lanes 4 S B W wr wi ex (row MOD 16) (root DIV (R*R))
End
Definition mb_tile_def:
  (mb_tile 0 S B W ex rows = SOME rows) /\
  (mb_tile (SUC n) S B W ex [] = NONE) /\
  (mb_tile (SUC n) S B W ex (r::rs) =
      if mb_row S B W ex r then mb_tile n S B W ex rs else NONE)
End
Definition mb_all_def:
  (mb_all 0 rs <=> NULL rs) /\
  (mb_all (SUC n) [] <=> F) /\
  (mb_all (SUC n) (h::rs) <=>
    let k=h MOD 256; p=(h DIV 256) MOD 512; w=(h DIV 131072) MOD 512;
        B=2**w; S=2**p; W=8589934592*B*B*B
    in case mb_tile k S B W (h DIV 67108864) rs of NONE => F | SOME rest => mb_all n rest)
End
val _=cv_auto_trans mb_signed_def;
val _=cv_auto_trans mb_test_def;
val _=cv_auto_trans mb_lanes_def;
val _=cv_auto_trans mb_row_def;
val _=cv_auto_trans mb_tile_def;
val _=cv_auto_trans mb_all_def;
