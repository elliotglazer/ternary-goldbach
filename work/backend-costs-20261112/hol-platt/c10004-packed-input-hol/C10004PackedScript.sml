Theory C10004Packed
Ancestors C10004Shared integer list arithmetic
Libs cv_transLib

Definition packed_coord_def:
  packed_coord (x:num) : int =
    if x < 39614081257132168796771975168 then &x
    else &x - 79228162514264337593543950336
End
Definition packed_block_def:
  (packed_block 0 (z:num) = []) /\
  (packed_block (SUC n) z =
    (packed_coord (z MOD 79228162514264337593543950336),
     packed_coord ((z DIV 79228162514264337593543950336) MOD 79228162514264337593543950336)) ::
    packed_block n (z DIV 6277101735386680763835789423207666416102355444464034512896))
End
Definition packed_input_def:
  (packed_input n [] = []) /\
  (packed_input n (z::zs) = packed_block n z ++ packed_input n zs)
End
Definition packed_probe_def:
  packed_probe n zs xs <=> packed_input n zs = xs
End
Definition packed_checked_def:
  packed_checked roots n zs phases params <=>
    shared_checked roots (packed_input n zs) phases params
End
val _ = cv_trans packed_coord_def;
val _ = cv_trans packed_block_def;
val _ = cv_trans packed_input_def;
val _ = cv_trans packed_probe_def;
val _ = cv_trans packed_checked_def;
