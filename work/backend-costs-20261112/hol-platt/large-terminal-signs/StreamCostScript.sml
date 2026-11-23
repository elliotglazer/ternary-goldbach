Theory StreamCost
Ancestors FullCount
Libs cv_transLib
Definition counts_def:
 (counts base upper len [] <=> T) /\
 (counts base upper len ((bits,k,w)::xs) <=>
  FullCount$scan_between 0 upper [(base,len,bits)]=SOME(k,w) /\ counts base upper len xs)
End
Definition streamrun_def:
 (streamrun 0 base upper len xs <=> T) /\
 (streamrun (SUC n) base upper len xs <=> counts base upper len xs /\ streamrun n base upper len xs)
End
val _=cv_auto_trans streamrun_def;
