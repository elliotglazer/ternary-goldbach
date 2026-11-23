Theory Gauss
Ancestors integer list cv_std
Libs intLib cv_transLib
val _=intLib.ARITH_TAC;
Definition gcut_def:
  gcut (z:int) (s:num) = if s=0 then 0:int else
    if z<0 then -(&(Num (-z) DIV s)) else &(Num z DIV s)
End
Definition gmul_def:
  gmul s (a:int # int) (b:int # int) =
    let x=FST a; y=SND a; u=FST b; v=SND b; p=x*u; q=y*v in
      (gcut (p-q) s,gcut ((x+y)*(u+v)-p-q) s)
End
Definition entry_def:
  entry (index:int) (g:int # int) = (g,(index*FST g,index*SND g))
End
Definition terms_def:
  (terms 0 s i g h d=[]) /\
  (terms (SUC n) s i g h d =
     if n=0 then [entry i g] else if n=1 then [entry i g;entry (i+1) (gmul s g h)]
     else entry i g :: terms n s (i+1) (gmul s g h) (gmul s h d) d)
End
Definition plus_def:
  plus (x:(int#int)#(int#int)) (y:(int#int)#(int#int)) =
    ((FST(FST x)+FST(FST y),SND(FST x)+SND(FST y)),(FST(SND x)+FST(SND y),SND(SND x)+SND(SND y)))
End
Definition zipplus_def:
  (zipplus [] ys=ys) /\
  (zipplus (x::xs) ys= case ys of []=>x::xs | y::tail=>plus x y::zipplus xs tail)
End
Definition buckets_def:
  (buckets 0 c xs acc=acc) /\
  (buckets (SUC r) c xs acc=
     buckets r c (DROP c xs) (zipplus (TAKE c xs) acc))
End
Definition produce_def:
  produce c m p q =
    if c=0 \/ m=0 then [] else if m=1 then [entry 1 q] else
    let s=2**p; d=gmul s q q; h=gmul s q d; xs=terms m s 1 q h d in
      if m<=c then xs else buckets ((m+c-1) DIV c) c xs []
End
Definition eqvec_def:
  (eqvec ([]:((int#int)#(int#int)) list) ys <=> ys=[]) /\
  (eqvec (x::xs) ys <=> case ys of []=>F | y::tail=>x=y /\ eqvec xs tail)
End
Definition gloop_def:
  (gloop 0 flag c m p q ex = T) /\
  (gloop (SUC n) flag c m p q ex =
    (eqvec (if flag then produce c m p q else ex) ex /\ gloop n flag c m p q ex))
End
Definition signature_def:
  (signature ([]:((int#int)#(int#int)) list) (a:int) b=(a,b)) /\
  (signature (x::xs) a b=signature xs
    ((1000003*(1000003*a+FST(FST x))+FST(SND x)) % 2305843009213693951)
    ((1000033*(1000033*b+SND(FST x))+SND(SND x)) % 2305843009213693951))
End
Definition test_def:
  test c m p q checksum flag reps =
    let xs=produce c m p q in
      (signature xs 0 0=checksum /\ gloop reps flag c m p q xs)
End
val _=cv_auto_trans test_def;
