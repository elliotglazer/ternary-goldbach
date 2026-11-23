Theory C10004Shared
Ancestors C10004TraversalCV C10004TraversalBase integer list arithmetic
Libs cv_transLib

Definition shared_abs_def:
  shared_abs (x:int) = if x < 0 then -x else x
End
Definition shared_one_def:
  shared_one (p:int,q:int) (f:int,g:int) (r:int,i:int) (e:int) pos <=>
    let a = p*f-q*g; b = p*g+q*f;
        d = shared_abs p + shared_abs q + shared_abs f + shared_abs g + 2;
        signed = if pos then a*r-b*i else b*i-a*r
    in (shared_abs a + shared_abs b)*e + d*(shared_abs r+shared_abs i+2*e) < signed
End
Definition shared_all_def:
  (shared_all [] ys f g e (m:num) <=> NULL ys /\ m = 0) /\
  (shared_all (p::ps) [] f g e m <=> F) /\
  (shared_all (p::ps) (y::ys) f g e m <=>
    shared_one p f y e (m MOD 2 = 1) /\ shared_all ps ys g f e (m DIV 2))
End
Definition shared_checked_def:
  shared_checked roots xs phases ((odd,even),(e,m)) <=>
    0 <= e /\
    case ft_checked roots xs of NONE => F
    | SOME ys => shared_all phases ys odd even e m
End
val _ = cv_trans shared_abs_def;
val _ = cv_trans shared_one_def;
val _ = cv_auto_trans shared_all_def;
val _ = cv_trans shared_checked_def;
