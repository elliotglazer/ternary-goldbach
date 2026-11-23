Theory GenuineBatch
Ancestors SelectedHead SelectedBias TwoHead IntegratedHead integer list
Libs cv_transLib
Definition treeword_def:
 treeword k (l:num) h=l+2**(16*2**k)*h
End
val _=cv_auto_trans treeword_def;
Definition rowsok_def:
 (rowsok 0 rs a b =
 case rs of [] => F | ((w,e,m,x,y,h,n)::t) =>
   twosweep 64 w e m a b x y=(&h,&(2**(w*n)))) /\
 (rowsok (SUC k) rs a b =
 let D=2**(544*64*2**k); (al,ah)=dq a D;(bl,bh)=dq b D
 in rowsok k (TAKE (2**k) rs) al bl /\ rowsok k (DROP (2**k) rs) ah bh)
End
val _=cv_auto_trans rowsok_def;
Definition batchhead_def:
 batchhead mode k rs (a:int) b c ah bh ch =
 let H= &(2**(544*64*2**k)); za=a+H*ah;zb=b+H*bh;zc=c+H*ch;
     B=repblk (6+k) 544 1 (&(2**543))
 in if mode=1:num then
 let (al,ha)=central H za;(bl,hb)=central H zb;(cl,hc)=central H zc
 in ha=ah /\ hb=bh /\ hc=ch /\ al=a /\ bl=b /\ cl=c
 else let (pl,ph)=subfused H B (za-zb);(ql,qh)=subfused H B (zc-za-zb)
 in ph=ah-bh /\ qh=ch-ah-bh /\ rowsok k rs pl ql
End
val _=cv_auto_trans batchhead_def;
