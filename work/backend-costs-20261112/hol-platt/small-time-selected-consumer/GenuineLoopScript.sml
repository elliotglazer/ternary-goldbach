Theory GenuineLoop
Ancestors GenuineBatch integer
Libs cv_transLib
Definition repeated_def:
 (repeated 0 mode k rs a b c ah bh ch=T) /\
 (repeated (SUC n) mode k rs a b c ah bh ch=
  (batchhead mode k rs a b c ah bh ch /\ repeated n mode k rs a b c ah bh ch))
End
val _=cv_auto_trans repeated_def;
