Theory SharedChirp
Ancestors ChirpPackets TwoHead GenuineBatch list integer
Libs cv_transLib
Definition heads_def:
 (heads [] x y=T) /\
 (heads ((w,e,m,a,b,h,c)::rs) x y =
    (twosweep 64 w e m a b x y=(&h,&(2**(w*c))) /\ heads rs x y))
End
val _=cv_auto_trans heads_def;
Definition use_row_def:
 use_row mode g s p radix bound dx dy ax ay u v expectx expecty rs =
 if mode=1:num then heads rs expectx expecty else
 let (z,r,x,y,ok)=row 64 2 g s p radix bound (dx,dy) (ax,ay) (u,v)
 in ok /\ Num x=expectx /\ Num y=expecty /\ heads rs (Num x) (Num y)
End
val _=cv_auto_trans use_row_def;

Definition repeat_shared_def:
 (repeat_shared 0 mode g s p t b dx dy ax ay u v x y rs=T) /\
 (repeat_shared(SUC n) mode g s p t b dx dy ax ay u v x y rs=
  (use_row mode g s p t b dx dy ax ay u v x y rs /\ repeat_shared n mode g s p t b dx dy ax ay u v x y rs))
End
val _=cv_auto_trans repeat_shared_def;