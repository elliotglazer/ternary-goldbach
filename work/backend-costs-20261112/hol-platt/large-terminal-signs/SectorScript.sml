Theory Sector
Ancestors LargeTerminal
Libs cv_transLib intLib
Definition one_def:
 one (p:int,q:int) (f:int,g:int,e:int) (r:int,i:int) =
  if ABS p<=1 \/ ABS q<=1 \/ ABS f<=1 \/ ABS g<=1 then (0:num) else
  let pf=(0<p <=> 0<f); qg=(0<q <=> 0<g);
      use_re=(pf<>qg); c=if use_re then r else i;
      orient=if use_re then pf else ((0<p) <> (0<g))
  in if ABS c<=e then 0 else if orient=(0<c) then 2 else 1
End
Definition sector_packet_def:
 (sector_packet [] f g a b=SOME (0:num,0:num,0:num,0:num,0:num)) /\
 (sector_packet ((p,q,r,i,s,j)::xs) f g a b =
  let x=one (p,q) f (r,i); y=one (p,q) a (s,j); l=if x=0 then LargeTerminal$score (p,q) f (r,i) else x; h=if y=0 then LargeTerminal$score (p,q) a (s,j) else y in
  if l=0 \/ h=0 then NONE else case sector_packet xs g f b a of NONE=>NONE | SOME(m,n,c,u,v)=>
    SOME(2*m+(l-1),2*n+(h-1),c+(if l=h then 0 else 1),2*u+(if x=0 then 1 else 0),2*v+(if y=0 then 1 else 0)))
End
Definition sector_verified_def:
 (sector_verified [] [] f g a b <=> T) /\
 (sector_verified (x::xs) (y::ys) f g a b <=> sector_packet x f g a b=SOME y /\ sector_verified xs ys f g a b) /\
 (sector_verified _ _ f g a b <=> F)
End
Definition sector_checked_def:
 sector_checked rows masks (f,g,e,h,i,j,k,t,l,v) <=> 0<=e /\ 0<=v /\ sector_verified rows masks (f,g,e) (h,i,e) (j,k,v) (t,l,v)
End
Definition sector_times_def:
 (sector_times 0 mode rows masks cfg checksum acc=acc:num) /\
 (sector_times (SUC n) mode rows masks cfg checksum acc=
   let ok=if 0<(mode:num) then sector_checked rows masks cfg else LargeTerminal$sink rows 0=checksum
   in sector_times n mode rows masks cfg checksum (if ok then acc+1 else acc))
End
Definition sector_trial_def:
 sector_trial rows masks cfg checksum mode n <=> sector_times n mode rows masks cfg checksum 0=n
End
val _=cv_auto_trans sector_trial_def;

