Theory PrimeSink
Ancestors Absorbed
Libs cv_transLib intLib
Definition primepairs_def:
 primepairs sc xs ws ker B M powers =
  let (x,y)=FastAxis$kt_pack 9 B (FastAxis$rotlist sc (FastAxis$kdiv sc 2) xs ws);
      (u,v)=ker; a=x*u; b=y*v; c=(x+y)*(u+v)
  in FastAxis$unpack_acc powers
    (FastAxis$foldcyc (a-b) M,FastAxis$foldcyc (c-a-b) M) []
End
Definition primeold_def:
 primeold sc zs ws chk taps =
 let ys=FastAxis$rotlist sc (FastAxis$kdiv sc 2) zs ws in
   FastAxis$kr_mod (FastAxis$lp_sum ys 0) 65537=chk /\
   [FastAxis$lp_pick 0 ys; FastAxis$lp_pick 1 ys; FastAxis$lp_pick 128 ys; FastAxis$lp_pick 256 ys]=taps
End
Definition primebatch_def:
 (primebatch 0 mode sc xs ws ker B M pw cs chk taps mask = T) /\
 (primebatch (SUC n) mode sc xs ws ker B M pw cs chk taps mask =
 let zs=primepairs sc xs ws ker B M pw in
 (if mode then Absorbed$collect (sc*sc) zs ws cs=(mask,0) else primeold (sc*sc) zs ws chk taps) /\
 primebatch n mode sc xs ws ker B M pw cs chk taps mask)
End
Definition primerun_def:
 primerun n mode sc xs ws phases chk taps mask =
 let B=(2:int)**160; M=B**257-1; pw=FastAxis$kt_powers 9 B [];
     ker=FastAxis$kt_pack 9 B (FastAxis$lp_conj ws); cs=Absorbed$cache sc phases ws
 in primebatch n mode sc xs ws ker B M pw cs chk taps mask
End
val _=cv_auto_trans primerun_def;
