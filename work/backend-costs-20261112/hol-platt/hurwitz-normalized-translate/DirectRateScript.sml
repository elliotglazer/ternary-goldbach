Theory DirectRate
Ancestors DirectTranslate
Libs cv_transLib
Definition dtest_def:
 dtest n D width prec xs ys es fs=
  if n=0 then T else direct n D width prec xs ys es fs
End
val _=cv_auto_trans dtest_def;
Definition dreject_def:
 dreject D width prec xs ys es fs= ~dtest 129 D width prec xs ys es fs
End
val _=cv_auto_trans dreject_def;
