Theory TransposeScan
Ancestors FullCount
Libs cv_transLib
Definition lowhi_def:
 (lowhi k [] = ([],[])) /\
 (lowhi k ((x:num)::xs) =
   let (a,b)=lowhi k xs in (x MOD (2**k)::a, x DIV (2**k)::b))
End
Definition rebit_def:
 (rebit [] = 0:num) /\
 (rebit (x::xs)=x+2*rebit xs)
End
Definition transpose_def:
 (transpose 0 ws = [rebit ws]) /\
 (transpose (SUC d) ws = let (a,b)=lowhi (2**d) ws
                         in transpose d a ++ transpose d b)
End
Definition matchrow_def:
 (matchrow base up len [] ys <=> T) /\
 (matchrow base up len (b::bs) ys <=> case ys of []=>F | (v,k,w)::rest =>
    b=v /\ FullCount$scan_between 0 up [(base,len,b)]=SOME(k,w) /\ matchrow base up len bs rest)
End
Definition allblocks_def:
 (allblocks base up len [] ys <=> ys=[]) /\
 (allblocks base up len (block::blocks) ys <=>
   let bits=TAKE (MIN 64 (LENGTH ys)) (transpose 6 block)
   in matchrow base up len bits ys /\ allblocks base up len blocks (DROP 64 ys))
End
Definition tiled_def:
 (tiled 0 base up len blocks ys <=> T) /\
 (tiled (SUC n) base up len blocks ys <=>
     allblocks base up len blocks ys /\ tiled n base up len blocks ys)
End
val _=cv_auto_trans tiled_def;
