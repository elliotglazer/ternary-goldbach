Theory ShortKernel
Ancestors cv_std integer list arithmetic
Libs cv_transLib intLib
Definition product16_def:
  (product16 (h:int) v (i:num) 0 = (1:int,1:int)) /\
  (product16 h v i (SUC n) =
      let (a,b)=product16 h v (SUC i) n in
      if &i=v then (a,b) else ((2*h+1-2* &i)*a,2*(v- &i)*b))
End
Definition weight_ok_def:
  (weight_ok h den v ([]:int list) <=> v=16:num) /\
  (weight_ok h den v (w::ws) <=>
     let (a,b)=product16 h (&v) 0 16 in b<>0 /\ w*b=den*a /\ weight_ok h den (SUC v) ws)
End
Definition weights_def:
  (weights den ([]:int list list) <=> T) /\
  (weights den (row::rows) <=> (case row of h::ws => 0<=h /\ h<15 /\ weight_ok h den 0 ws | _=>F) /\ weights den rows)
End
Definition find_def:
  (find (h:int) ([]:int list list)=[]) /\
  (find h (row::rows)= case row of k::ws => if k=h then ws else find h rows | _=>[])
End
Definition sourcefold_def:
  (sourcefold (den:int) (scale:int) (h:int) (s:int) (i:num) ([]:int list) (vals:int list)=
    if vals=[] /\ i=16 then SOME (0:int,0:int) else NONE) /\
  (sourcefold den scale h s i (w::ws) vals =
     case vals of a::b::q::rest =>
       if a<=b /\ (q-1)*den<=a*scale /\ b*scale<=(q+1)*den /\
          ((&i=h \/ &i=h+1) ==> -s*q>1) then
         (case sourcefold den scale h s (SUC i) ws rest of SOME(z,r) => SOME(z+w*q,r+ABS w) | _=>NONE)
       else NONE | _=>NONE)
End
Definition short_def:
  short (den:int) wd kernels (row:int list) <=>
    case row of h::k::l::scale::rad::sign::vals =>
      0<den /\ 0<wd /\ 0<scale /\ 0<=rad /\ 0<k /\ k<40 /\ 0<l /\ l<60 /\
      (sign=0 \/ sign=1) /\
      (let s=2*sign-1 in case sourcefold den scale h s 0 (find h kernels) vals of
       SOME (z,r) => s*z*1099511627776 > r*1099511627776+rad*wd*scale | _=>F)
    | _=>F
End
Definition short_all_def:
  (short_all den wd kernels [] <=> T) /\
  (short_all den wd kernels (row::rows) <=> short den wd kernels row /\ short_all den wd kernels rows)
End
val _=cv_auto_trans weights_def;
val _=cv_auto_trans short_all_def;
