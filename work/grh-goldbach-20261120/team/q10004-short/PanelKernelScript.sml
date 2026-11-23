Theory PanelKernel
Ancestors ShortKernel integer list arithmetic
Libs cv_transLib intLib
Definition partition12_def:
  (partition12 0 (xs:int list)=([],xs)) /\
  (partition12 (SUC n) xs=case xs of []=>([],[]) | h::tail =>
      let (a,b)=partition12 n tail in (h::a,b))
End
Definition checkdot_def:
  (checkdot ([]:int list) ws=if ws=[] then SOME(0:int,0:int,0:int) else NONE) /\
  (checkdot (x::xs) ws=case ws of []=>NONE | w::rest =>
    if ABS x>65535 then NONE else
    case checkdot xs rest of SOME(d,a,b)=>SOME(d+x*w,a+ABS x,b+ABS w) | _=>NONE)
End
Definition panel_def:
  panel (row:int list) <=>
    case row of q::label::tick::sub::ex::bits::r::sg::v =>
      let (xs,ws)=partition12 12 v in
      0<q /\ 0<label /\ label<q /\ 0<tick /\ 0<sub /\ bits=24 /\
      0<=r /\ ABS sg=1 /\ LENGTH xs=12 /\ LENGTH ws=12 /\
      (case checkdot xs ws of SOME(d,a,b)=>2*(sg*d-r-b)>=(a+12)+2 | _=>F)
    | _=>F
End
Definition panels_def:
  (panels [] <=> T) /\ (panels (r::rs) <=> panel r /\ panels rs)
End
val _=cv_auto_trans panels_def;
