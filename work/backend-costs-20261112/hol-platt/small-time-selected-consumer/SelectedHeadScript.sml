Theory SelectedHead
Ancestors integer arithmetic
Libs cv_transLib intLib
Definition hddiv_def:
 hddiv (x:int) b = if b=0 then 0 else x/b
End
val _=cv_auto_trans hddiv_def;
Definition halves_def:
 halves w k (x:int) = let B= &(2**(w*2**k)); y=hddiv (x+B/2) B in (x-B*y,y)
End
val hp=cv_trans_pre "halves_pre" halves_def;
Theorem halves_ok[cv_pre]:
 !w k x. halves_pre w k x
Proof
 simp[hp]
QED
Definition repeat_def:
 (repblk 0 w n (x:int)=x) /\
 (repblk (SUC k) w n x = let y=repblk k w n x in y+ &(2**(w*n*2**k))*y)
End
val _=cv_auto_trans repeat_def;
Definition hval_def:
 hval w e (a:int) b c x y =
 let t=(a-b)*x-(c-a-b)*y;
     z=hddiv (t+ &(2**498)) (&(2**499));
     head=hddiv z (&(2**(e+1)))
 in head+ &(2**(w-1))
End
val _=cv_auto_trans hval_def;
Definition leaves_def:
 (leaves 0 sel w e m a b c x y =
   if m=0 then (0:int,1:int) else (hval w e a b c x y, &(2**w))) /\
 (leaves (SUC k) sel w e m a b c x y =
  if sel /\ (m=0) then (0,1) else
  let (al,ah)=halves 544 k a; (bl,bh)=halves 544 k b;
      (cl,ch)=halves 544 k c; (xl,xh)=halves 243 k x; (yl,yh)=halves 243 k y;
      cut=2**(2**k);
      (u,us)=leaves k sel w e (m MOD cut) al bl cl xl yl;
      (v,vs)=leaves k sel w e (m DIV cut) ah bh ch xh yh
  in (u+us*v,us*vs))
End
val _=cv_auto_trans leaves_def;
Definition same_heads_def:
 same_heads k sel w e m a b c x y want count <=>
 leaves k sel w e m a b c x y = (want, &(2**(w*count)))
End
val _=cv_auto_trans same_heads_def;
Definition repeat_test_def:
 repeat_test mode k w e m a b c x y want count =
 let aa=repblk k 544 64 a;bb=repblk k 544 64 b;cc=repblk k 544 64 c;
     xx=repblk k 243 64 x;yy=repblk k 243 64 y;
     wanti=repblk k w count want; mask=Num(repblk k 1 64 (&m))
 in if mode=0:num then aa+bb+cc+xx+yy+wanti+ &mask<>0
 else same_heads (6+k) (mode=2) w e mask aa bb cc xx yy wanti (count*2**k)
End
val _=cv_auto_trans repeat_test_def;




