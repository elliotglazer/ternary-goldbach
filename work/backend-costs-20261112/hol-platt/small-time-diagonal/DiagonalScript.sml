Theory Diagonal
Ancestors list arithmetic integer cv_std
Libs cv_transLib intLib

Definition lows_def:
  (lows ([]:(int # int) list) = 0:int) /\
  (lows (x::xs) = FST x + lows xs)
End
Definition highs_def:
  (highs ([]:(int # int) list) = 0:int) /\
  (highs (x::xs) = SND x + highs xs)
End
Definition joined_def:
  (joined (b:int) ([]:(int # int) list) = 0:int) /\
  (joined b (x::xs) = FST x + b*SND x + joined b xs)
End
Theorem joined_value:
  !b xs. joined b xs = lows xs + b*highs xs
Proof
  gen_tac >> Induct >> rpt gen_tac >>
  ASM_REWRITE_TAC[joined_def,lows_def,highs_def] >> intLib.INT_RING_TAC
QED
Definition split2_def:
  split2 (b:int) offset z =
    if b=0 then (z,0) else let hi=(z+offset)/b in (z-hi*b,hi)
End
Theorem split_exact:
  !b off lo hi. 0 < b /\ 0 <= lo+off /\ lo+off < b ==>
    split2 b off (lo+b*hi) = (lo,hi)
Proof
  rpt strip_tac >>
  `((lo+b*hi+off)/b = hi)` by
    (irule INT_DIV_UNIQUE >> qexists_tac `lo+off` >> conj_tac
     >- intLib.INT_RING_TAC >> `~(b<0)` by intLib.ARITH_TAC >> simp[]) >>
  `b <> 0` by intLib.ARITH_TAC >>
  simp[split2_def] >> intLib.INT_RING_TAC
QED
Theorem split_diagonal:
  !xs b off carry.
    0 < b /\ 0 <= carry+lows xs+off /\ carry+lows xs+off < b ==>
    split2 b off (carry+joined b xs) = (carry+lows xs,highs xs)
Proof
  rpt strip_tac >>
  `carry+joined b xs = (carry+lows xs)+b*highs xs` by
    (REWRITE_TAC[joined_value] >> intLib.INT_RING_TAC) >>
  ASM_REWRITE_TAC[] >> irule split_exact >> simp[]
QED
val _=cv_trans split2_def;

Definition mkprod_def:
  (mkprod 0 (b:int) x y = []:int list) /\
  (mkprod (SUC j) b x y =
   let a= (&(2*j+1)*x+ &j):int; c= &j- &(j+2)*y in
      (a+b*c) :: mkprod j b x y)
End
Definition old_def:
  (old (b:int) off [] = (0:int,0:int)) /\
  (old b off (z::zs) =
   let (a,c)=split2 b off z; (d,e)=old b off zs in (a+d,c+e))
End
Definition total_def:
  (total ([]:int list)=0:int) /\ (total (x::xs)=x+total xs)
End
Definition trial_def:
  trial (mode:num) (w:num) (t:num) (n:num) =
    let b= &(2 ** (w*t)):int; off=b/2; x=b/8191; y=b/16381;
        zs=mkprod n b x y;
        s= &n; tri= &(n*(n-1) DIV 2);
        expected=(s*s*x+tri,tri-(tri+2*s)*y)
    in if mode=0 then old b off zs = expected
       else if mode=1 then split2 b off (total zs) = expected
       else total zs=FST expected+b*SND expected
End
val _=cv_auto_trans mkprod_def;
val _=cv_auto_trans old_def;
val _=cv_auto_trans total_def;
val trial_p_def=cv_trans_pre "trial_p" trial_def;
Theorem trial_ok[cv_pre]:
  !mode w t n. trial_p mode w t n
Proof
  simp[trial_p_def]
QED
