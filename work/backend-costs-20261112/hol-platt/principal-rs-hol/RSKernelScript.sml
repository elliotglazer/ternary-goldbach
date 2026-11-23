Theory RSKernel
Ancestors integer real cv_std
Libs cv_transLib realLib

Theorem rs_negative_sign:
  !z a b e:real. abs(z-a) <= e /\ 
               abs(a-b) < -b-e ==> z < 0
Proof
  PURE_REWRITE_TAC [ABS_BOUNDS,ABS_BOUNDS_LT] >> rpt strip_tac >> REAL_ASM_ARITH_TAC
QED

Definition rr_def:
 rr (d:int) (x:int) = if 2*d=0 then 0 else (2*x+d)/(2*d)
End
val _ = cv_auto_trans rr_def;

Definition lh_def:
 (lh (a:int) (b:int) 0 k = 0:int) /\
 (lh a b (SUC m) k = let j = &(2*k+1) in
   rr (j*b*b) (&(2**137)*b*b+j*a*a*lh a b m (SUC k)))
End
val _ = cv_auto_trans lh_def;

Definition logc_def:
 logc a b = rr b (2*a*lh a b 45 0)
End
val _ = cv_auto_trans logc_def;

Definition nr_def:
 (nr (v:num) 0 a = a) /\
 (nr v (SUC m) a = if a=0 then 0 else nr v m ((a + v DIV a) DIV 2))
End
val _ = cv_auto_trans nr_def;

Definition cache_def:
 (cache 0 k l = []) /\
 (cache (SUC n) k l =
 let h = if SUC n < 2**k then k-1 else k;
     b = 2**h; w=nr (2**128 DIV SUC n) 16 (2**64);
     x = &(SUC n); logn=rr 256 (&h*l + logc (x- &b) (x+ &b))
 in (w,logn,w*w*SUC n <= 2**128 /\ 2**128 < (w+1)*(w+1)*SUC n /\ b <= SUC n /\ SUC n <= 2*b)::cache n h l)
End
val _ = cv_auto_trans cache_def;

Definition eh_def:
 (eh (p:int) 0 k = (&(2**64):int,0:int)) /\
 (eh p (SUC m) k = let (x,y)=eh p m (SUC k); d= &(2**139 * (k+1)) in
  (rr d (&(2**64)*d-p*y),rr d (p*x)))
End
val _ = cv_auto_trans eh_def;

Definition valrs_def:
 (valrs t h pi [] = (0:int,T)) /\
 (valrs t h pi ((w,l,g)::xs) =
 let f=h-t*l; q=rr pi f; r=f-q*pi; x=FST(eh r 72 0);
     (z,ok)=valrs t h pi xs in
 (z + 2* &w*(if q % 2 = 0 then x else -x),
  ok /\ g /\ - &(2**140) <= r /\ r <= &(2**140) /\ -10000000000 <= q /\ q <= 10000000000))
End
val _ = cv_auto_trans valrs_def;

Definition rscheck_def:
 rscheck t h pi j want = let (z,ok)=valrs t h pi (cache 3989 11 (logc 1 3)) in ok /\ z+j=want
End
val _ = cv_auto_trans rscheck_def;

Definition rsitem_def:
 rsitem c p (t,h,j,want) = let (z,ok)=valrs t h p c in ok /\ (z+j=want)
End
val _ = cv_auto_trans rsitem_def;
Definition rscommon_def:
 rscommon p a b d = let c=cache 3989 11 (logc 1 3) in
 rsitem c p a /\ rsitem c p b /\ rsitem c p d
End
val _ = cv_auto_trans rscommon_def;
