Theory TwoHead
Ancestors SelectedBias IntegratedHead SelectedHead integer
Libs cv_transLib
Definition twoval_def:
 twoval w e (a:int) b x y =
 let t=a*x-b*y; z=hddiv (t+ &(2**498)) (&(2**499))
 in hddiv z (&(2**(e+1)))+ &(2**(w-1))
End
val _=cv_auto_trans twoval_def;
Definition twosweep_def:
 (twosweep 0 w e m a b x y = (0:int,1:int)) /\
 (twosweep (SUC n) w e m a b x y =
 if m=0 then (0,1) else
 let j=tz 64 m; sa=2**(544*j); sr=2**(243*j);d=nd m (2**j);
     (a0,an)=dq (nd a sa) (2**544);(b0,bn)=dq (nd b sa) (2**544);
     (x0,xn)=dq (nd x sr) (2**243);(y0,yn)=dq (nd y sr) (2**243);
     (v,mul)=twosweep n w e (d DIV 2) an bn xn yn
 in (twoval w e (&a0- &(2**543)) (&b0- &(2**543))
     (&x0- &(2**242)) (&y0- &(2**242))+ &(2**w)*v, &(2**w)*mul))
End
val _=cv_auto_trans twosweep_def;
Definition twogroups_def:
 (twogroups 0 w e m a b x y=twosweep 64 w e m a b x y) /\
 (twogroups (SUC k) w e m a b x y =
 if m=0 then (0,1) else
 let B=2**(544*64*2**k);M=2**(64*2**k);
     (al,ah)=dq a B;(bl,bh)=dq b B;(ml,mh)=dq m M;
     (u,us)=twogroups k w e ml al bl x y;
     (v,vs)=twogroups k w e mh ah bh x y
 in (u+us*v,us*vs))
End
val _=cv_auto_trans twogroups_def;
Definition subfused_def:
 subfused H B (z:int) =
 let n=z+B; q=hddiv n H in (Num(n-H*q),q)
End
val _=cv_auto_trans subfused_def;
Definition choose_split_def:
 choose_split mode H B z=if mode=4:num then subfused H B z else fused H B z
End
val _=cv_auto_trans choose_split_def;
Definition two_integrated_def:
 two_integrated mode k w e m a b c x y want count =
 let la=repblk k 544 64 a;lb=repblk k 544 64 b;lc=repblk k 544 64 c;
     H= &(2**(544*64*2**k));za=la+H*lb;zb=lb+H*lc;zc=lc+H*la
 in if mode=1:num then
 let (al,ah)=central H za;(bl,bh)=central H zb;(cl,ch)=central H zc
 in ah=lb /\ bh=lc /\ ch=la /\ al=la /\ bl=lb /\ cl=lc
 else
 let B=repblk (6+k) 544 1 (&(2**543));
     (al,ah)=choose_split mode H B (za-zb);(bl,bh)=choose_split mode H B (zc-za-zb)
 in ah=lb-lc /\ bh=la-lb-lc /\
 if mode=2 then al=Num(la-lb+B) /\ bl=Num(lc-la-lb+B) else
 let rb=repblk 6 243 1 (&(2**242))
 in twogroups k w e m al bl (Num(x+rb)) (Num(y+rb)) = (want, &(2**(w*count)))
End
val _=cv_auto_trans two_integrated_def;

