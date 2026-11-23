Theory C10004Fused
Ancestors C10004TraversalCV C10004TraversalBase integer list
Libs cv_transLib

Definition fused_abs_def:
  fused_abs (x:int) = if x < 0 then -x else x
End

Definition fused_margin_def:
  fused_margin ((a:int,b:int),(e:int,s:int)) (r:int,i:int) <=>
    0 <= e /\ (s = 1 \/ s = -1) /\
    ((fused_abs a + fused_abs b) * e + fused_abs r + fused_abs i + 2 * e <
     s * (a * r - b * i))
End

Definition fused_all_def:
  (fused_all [] ys <=> NULL ys) /\
  (fused_all (g::gs) [] <=> F) /\
  (fused_all (g::gs) (y::ys) <=> fused_margin g y /\ fused_all gs ys)
End

Definition fused_checked_def:
  fused_checked roots xs guards <=>
    case ft_checked roots xs of NONE => F | SOME ys => fused_all guards ys
End

val _ = cv_trans fused_abs_def;
val _ = cv_trans fused_margin_def;
val _ = cv_auto_trans fused_all_def;
val _ = cv_trans fused_checked_def;

