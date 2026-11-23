Theory SelectedBias
Ancestors SelectedHead integer
Libs cv_transLib
Definition tz_def:
 (tz 0 m=0) /\
 (tz (SUC k) m=if ODD m then 0 else SUC(tz k (m DIV 2)))
End
val _=cv_auto_trans tz_def;
Definition dq_def:
 dq x d = if d=0:num then (0,0) else (x MOD d,x DIV d)
End
val _=cv_auto_trans dq_def;
Definition nd_def:
 nd (a:num) b = if b=0 then 0 else a DIV b
End
val _=cv_auto_trans nd_def;
Definition sweep_def:
 (sweep 0 sel w e m a b c x y = (0:int,1:int)) /\
 (sweep (SUC n) sel w e m a b c x y =
 if sel /\ (m=0) then (0,1) else
 let j=if sel then tz 64 m else 0;
     sa=2**(544*j);sr=2**(243*j); sm=2**j;
     d=if sm=0 then 0 else m DIV sm;
     a1=nd a sa; b1=nd b sa; c1=nd c sa;
     x1=nd x sr; y1=nd y sr;
     (a0,an)=dq a1 (2**544);(b0,bn)=dq b1 (2**544);(c0,cn)=dq c1 (2**544);
     (x0,xn)=dq x1 (2**243);(y0,yn)=dq y1 (2**243);
     (v,mul)=sweep n sel w e (d DIV 2) an bn cn xn yn
 in if EVEN d then (v,mul) else
 (hval w e (&a0- &(2**543)) (&b0- &(2**543)) (&c0- &(2**543))
       (&x0- &(2**242)) (&y0- &(2**242)) + &(2**w)*v,mul* &(2**w)))
End
val _=cv_auto_trans sweep_def;
Definition groups_def:
 (groups 0 sel w e m a b c x y = sweep 64 sel w e m a b c x y) /\
 (groups (SUC k) sel w e m a b c x y =
 if sel /\ (m=0) then (0,1) else
 let B=2**(544*64*2**k);M=2**(64*2**k);
     (al,ah)=dq a B; (bl,bh)=dq b B; (cl,ch)=dq c B;
     (ml,mh)=dq m M;
     (u,us)=groups k sel w e ml al bl cl x y;
     (v,vs)=groups k sel w e mh ah bh ch x y
 in (u+us*v,us*vs))
End
val _=cv_auto_trans groups_def;
Definition bias_test_def:
 bias_test mode k w e m a b c x y want count =
 let bias=repblk (6+k) 544 1 (&(2**543)); rb=repblk 6 243 1 (&(2**242));
     aa=Num(repblk k 544 64 a+bias);bb=Num(repblk k 544 64 b+bias);
     cc=Num(repblk k 544 64 c+bias); xx=Num(x+rb); yy=Num(y+rb)
 in if mode=0:num then aa+bb+cc+xx+yy+Num want+m+count<>0
 else groups k (mode=2) w e m aa bb cc xx yy = (want, &(2**(w*count)))
End
val _=cv_auto_trans bias_test_def;


