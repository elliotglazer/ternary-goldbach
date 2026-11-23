Theory DirectTranslate
Ancestors integer list arithmetic
Libs cv_transLib
Definition choice_def:
 (choice n 0=1) /\
 (choice n (SUC k)=(choice n k*(n-k)) DIV (SUC k))
End
Definition nquot_def:
 nquot a b=if b=0 then 0 else (a:int)/b
End
Definition ndiv_def:
 ndiv a m=if m=0 then 0 else a DIV m
End
val _=cv_auto_trans ndiv_def;
val _=cv_auto_trans nquot_def;
Definition weight_def:
 (weight 0 m k w scale cap xs=[]:int list) /\
 (weight (SUC t) m k w scale cap []=[]) /\
 (weight (SUC t) m k w scale cap (x::xs)=
   ((&x- &cap)* &w* &scale)::weight t (m-1) k (ndiv (w*(m-k)) m) (64*scale) cap xs)
End
Definition eval_def:
 (eval (d:int) a []=a) /\
 (eval d a (v::vs)=eval d (d*a+v) vs)
End
Definition fits_def:
 fits d multiplier den field coeff packed =
 (nquot (multiplier*eval d 0 coeff+nquot den 2) den =
   ((&((ndiv packed field) MOD (2**128))- &(2**127)):int))
End
Definition offsets_def:
 (offsets 0 pos mult den field x y es fs=T) /\
 (offsets (SUC t) pos mult den field x y [] fs=F) /\
 (offsets (SUC t) pos mult den field x y (e::es) []=F) /\
 (offsets (SUC t) pos mult den field x y (e::es) (f::fs)=
   (fits (&pos-64) mult den field x e /\ fits (&pos-64) mult den field y f /\
     offsets t (SUC pos) mult den field x y es fs))
End
Definition orders_def:
 (orders 0 n D k mult field cap den xs ys es fs=T) /\
 (orders (SUC t) n D k mult field cap den xs ys es fs=
  let w=choice D k; L=D-k+1 in
   offsets n 0 mult den field (weight L D k w 1 cap xs) (weight L D k w 1 cap ys) es fs /\
   orders t n D (SUC k) (2*mult) ((2**128)*field) cap den xs ys es fs)
End
Definition direct_def:
 direct n D (width:num) prec xs ys es fs=
   orders 20 n D 0 1 1 (2**(prec+64)) (&(2**(prec-94+6*D))) xs ys es fs
End
val _=cv_auto_trans direct_def;
