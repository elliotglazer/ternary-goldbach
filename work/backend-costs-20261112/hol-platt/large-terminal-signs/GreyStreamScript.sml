Theory GreyStream
Ancestors arithmetic list
Definition flip_def:
 flip (l:bool) r = if l=r then (0:num) else 1
End
Definition bridge_def:
 bridge up m r l x h = (flip l x + flip x h, flip l x*(up-m)+flip x h*(up-r))
End
Theorem bridge_count_lower:
 !up m r l x h. flip l h <= FST (bridge up m r l x h)
Proof rpt gen_tac >> Cases_on `l` >> Cases_on `x` >> Cases_on `h` >> simp[bridge_def,flip_def]
QED
Theorem bridge_weight_lower:
 !up m r l x h. m<=r ==> flip l h*(up-r) <= SND (bridge up m r l x h)
Proof rpt gen_tac >> Cases_on `l` >> Cases_on `x` >> Cases_on `h` >>
 simp[bridge_def,flip_def] >> decide_tac
QED
Theorem opposite_bridge:
 !l x h. l<>h ==> flip l x+flip x h=1
Proof rpt gen_tac >> Cases_on `l` >> Cases_on `x` >> Cases_on `h` >> simp[flip_def]
QED
Definition stream_def:
 (stream up old [] = (0:num,0:num)) /\
 (stream up old ((pos,sg)::more) =
  case sg of NONE=>stream up old more | SOME cur =>
   let (n,w)=stream up (SOME cur) more;
       change=case old of NONE=>0 | SOME prev=>flip prev cur
   in (change+n,change*(up-pos)+w))
End
Theorem stream_skips_grey:
 !xs old up. stream up old xs = stream up old (FILTER (IS_SOME o SND) xs)
Proof
 Induct >> simp[stream_def] >> Cases_on `h` >> Cases_on `r` >>
 simp[stream_def]
QED
