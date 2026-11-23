Theory SelectedMasks
Ancestors SelectedHead integer
Libs cv_transLib
Definition test_mask_def:
 test_mask mode k w e m a b c x y want count =
 let aa=repblk k 544 64 a;bb=repblk k 544 64 b;cc=repblk k 544 64 c;
     xx=repblk k 243 64 x;yy=repblk k 243 64 y
 in if mode=0:num then aa+bb+cc+xx+yy+want+ &m+ &count<>0
 else same_heads (6+k) (mode=2) w e m aa bb cc xx yy want count
End
val _=cv_auto_trans test_mask_def;
