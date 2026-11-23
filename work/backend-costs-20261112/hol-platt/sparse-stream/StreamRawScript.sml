Theory StreamRaw
Ancestors GridSigns arithmetic integer list
Libs cv_transLib intLib

Definition four_raw_def:
  four_raw w =
    let b=2**256; x=w DIV b; y=x DIV b; z=y DIV b
    in [w MOD b;x MOD b;y MOD b;z MOD b]
End

Definition mask_signs_def:
  (mask_signs 0 present want pos (xs:num list) <=> present=0 /\ want=0 /\ pos=0 /\ xs=[]) /\
  (mask_signs (SUC steps) present want pos xs <=>
    let p=present MOD 2; c=want MOD 2; s=pos MOD 2 in
    if c>p \/ s>c then F else
    if p=0 then mask_signs steps (present DIV 2) (want DIV 2) (pos DIV 2) xs
    else case xs of [] => F | x::rest =>
      (c=0 \/ GridSigns$strict_code ((&x-& (2**255)):int) 519575974158995 = 1+s) /\
      mask_signs steps (present DIV 2) (want DIV 2) (pos DIV 2) rest)
End

Definition raw_tile_def:
  raw_tile (label:num) (tile:num) present want pos n words <=>
    0<label /\ tile<1331 /\ n<=64 /\
    LENGTH words=(n+3) DIV 4 /\
    mask_signs (MIN 64 (85121-64*tile)) present want pos
      (TAKE n (FLAT (MAP four_raw words)))
End
val _=cv_auto_trans raw_tile_def;
