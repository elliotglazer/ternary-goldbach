Theory DynamicPhase
Ancestors integer cv_std
Libs intLib cv_transLib
Definition divd_def:
 divd (z:int) d = if d=0 then 0 else z / d
End
Definition times_def:
 times (den:int) (a:int,b:int) (x:int,y:int) =
 (divd (a*x-b*y+divd den 2) den, divd (a*y+b*x+divd den 2) den)
End
Definition tick_def:
 tick w z = times 85070591730234615865843651857942052864 z w
End
Definition advance_def:
 (advance 0 w z=z) /\
 (advance (SUC n) w z=advance n w (tick w z))
End
Definition digit_def:
 digit (x:num) = &(x MOD (2**128)) - (2:int)**126
End
Definition class_def:
 class (x:int) = if x < ~1 then 1:num else if 1 < x then 2 else 0
End
Definition quadrant_def:
 quadrant z x y =
 let (a,b)=times ((2:int)**147) z (digit x,digit y)
 in class a + 4*class b
End
Definition strip_def:
 (strip 0 w z x y a b m tgt = (m=0 /\ z=tgt)) /\
 (strip (SUC n) w z x y a b m tgt =
  ((m MOD 256 = quadrant z x y + 16*quadrant z a b) /\
   strip n w (tick w z) (x DIV (2**128)) (y DIV (2**128))
    (a DIV (2**128)) (b DIV (2**128)) (m DIV 256) tgt))
End
val _=cv_auto_trans advance_def;
val _=cv_auto_trans strip_def;
