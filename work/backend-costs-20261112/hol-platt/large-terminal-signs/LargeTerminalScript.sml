Theory LargeTerminal
Ancestors arithmetic integer list
Libs cv_transLib intLib
Definition score_def:
 score (p:int,q:int) (f:int,g:int,e:int) (r:int,i:int) =
  let a=p*f-q*g; b=p*g+q*f; v=a*r-b*i;
      err=(ABS a+ABS b)*e+(ABS p+ABS q+ABS f+ABS g+2)*(ABS r+ABS i+2*e)
  in if err<v then (2:num) else if v < -err then 1 else 0
End
Definition packet_def:
 (packet [] f g a b=SOME (0:num,0:num,0:num)) /\
 (packet ((p,q,r,i,s,j)::xs) f g a b =
  let l=score (p,q) f (r,i); h=score (p,q) a (s,j) in
  if l=0 \/ h=0 then NONE else case packet xs g f b a of NONE=>NONE | SOME(m,n,c)=>
    SOME(2*m+(l-1),2*n+(h-1),c+(if l=h then 0 else 1)))
End
Definition verified_def:
 (verified [] [] f g a b <=> T) /\
 (verified (x::xs) (y::ys) f g a b <=> packet x f g a b=SOME y /\ verified xs ys f g a b) /\
 (verified _ _ f g a b <=> F)
End
Definition checked_def:
 checked rows masks (f,g,e,h,i,j,k,t,l,v) <=> 0<=e /\ 0<=v /\ verified rows masks (f,g,e) (h,i,e) (j,k,v) (t,l,v)
End
Definition skim_def:
 (skim [] acc=acc:int) /\ (skim (((p:int),(q:int),r,i,s,j)::xs) acc=skim xs (acc+r+3*i+s+3*j))
End
Definition sink_def:
 (sink [] acc=acc:int) /\ (sink (x::xs) acc=sink xs (skim x acc))
End
Definition times_def:
 (times 0 mode rows masks cfg checksum acc=acc:num) /\
 (times (SUC n) mode rows masks cfg checksum acc=
   let ok=if 0<(mode:num) then checked rows masks cfg else sink rows 0=checksum
   in times n mode rows masks cfg checksum (if ok then acc+1 else acc))
End
Definition trial_def:
 trial rows masks cfg checksum mode n <=> times n mode rows masks cfg checksum 0=n
End
val _=cv_auto_trans trial_def;

