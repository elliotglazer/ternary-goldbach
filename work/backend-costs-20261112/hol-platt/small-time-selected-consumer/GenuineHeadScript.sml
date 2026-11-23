Theory GenuineHead
Ancestors SelectedHead SelectedBias TwoHead IntegratedHead integer
Libs cv_transLib
Definition genuinerow_def:
 genuinerow mode w e m (a:int) b c ah bh ch x y want count =
 let H= &(2**(544*64)); za=a+H*ah;zb=b+H*bh;zc=c+H*ch;
     B=repblk 6 544 1 (&(2**543));
     (al,ha)=central H za;(bl,hb)=central H zb;(cl,hc)=central H zc
 in if mode=1:num then ha=ah /\ hb=bh /\ hc=ch /\ al=a /\ bl=b /\ cl=c
 else
 let (pl,ph)=subfused H B (za-zb);(ql,qh)=subfused H B (zc-za-zb)
 in ph=ah-bh /\ qh=ch-ah-bh /\
    twosweep 64 w e m pl ql x y=(want,&(2**(w*count)))
End
val _=cv_auto_trans genuinerow_def;
