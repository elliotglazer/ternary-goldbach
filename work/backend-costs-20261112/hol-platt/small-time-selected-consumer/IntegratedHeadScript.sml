Theory IntegratedHead
Ancestors SelectedHead SelectedBias integer
Libs cv_transLib
Definition central_def:
 central H (z:int) = let q=hddiv (z+H/2) H in (z-H*q,q)
End
val cp=cv_trans_pre "central_pre" central_def;
Theorem central_ok[cv_pre]:
 !H z. central_pre H z
Proof
 simp[cp]
QED
Definition fused_def:
 fused H bias (z:int) =
 let zl=z+bias; q=hddiv zl H in
 (if H=0 then 0 else Num(zl % H),q)
End
val _=cv_auto_trans fused_def;
Definition after_split_def:
 after_split k w e m a b c x y want count =
 let rb=repblk 6 243 1 (&(2**242)) in
 groups k T w e m a b c (Num(x+rb)) (Num(y+rb)) = (want, &(2**(w*count)))
End
val _=cv_auto_trans after_split_def;
Definition integrated_def:
 integrated mode k w e m a b c x y want count =
 let la=repblk k 544 64 a;lb=repblk k 544 64 b;lc=repblk k 544 64 c;
     H= &(2**(544*64*2**k));
     za=la+H*lb;zb=lb+H*lc;zc=lc+H*la
 in if mode=0:num then za+zb+zc+x+y+want+ &m+ &count<>0 else
 if mode=3 then
 let bias=repblk (6+k) 544 1 (&(2**543));
     (al,ah)=fused H bias za;(bl,bh)=fused H bias zb;(cl,ch)=fused H bias zc
 in ah=lb /\ bh=lc /\ ch=la /\ after_split k w e m al bl cl x y want count
 else
 let (al,ah)=central H za;(bl,bh)=central H zb;(cl,ch)=central H zc
 in ah=lb /\ bh=lc /\ ch=la /\
    if mode=1 then (al=la /\ bl=lb /\ cl=lc) else
    let bias=repblk (6+k) 544 1 (&(2**543))
    in after_split k w e m (Num(al+bias)) (Num(bl+bias)) (Num(cl+bias)) x y want count
End
val _=cv_auto_trans integrated_def;

