Theory ShortSink
Ancestors integer list
Libs intLib cv_transLib
Definition ss_choose_def:
 ss_choose (p:int) q f g =
 if ABS p<=1 \/ ABS q<=1 \/ ABS f<=1 \/ ABS g<=1 then (0:num)
 else if ((0<p)=(0<f)) <> ((0<q)=(0<g)) then (if (0<p)=(0<f) then 1 else 2)
 else if (0<p)<>(0<g) then 3 else 4
End
Definition ss_score_def:
 ss_score (p:int) q f g e r i =
 let a=p*f-q*g; b=p*g+q*f; v=a*r-b*i;
     err=(ABS a+ABS b)*e+(ABS p+ABS q+ABS f+ABS g+2)*(ABS r+ABS i+2*e)
 in if err<v then (2:num) else if v < -err then 1 else 0
End
Definition ss_lanes_def:
 (ss_lanes full p q e (x:int) (y:int) [] = (0:num,0:num)) /\
 (ss_lanes full p q e x y ((f,g)::fs) =
 let b=(5192296858534827628530496329220096:int); h=2596148429267413814265248164610048;
     xx=(x+h)/b; yy=(y+h)/b; r=x-xx*b; i=y-yy*b;
     ch=ss_choose p q f g; z=if ch<=2 then r else i;
     sign=if full \/ ch=0 \/ ABS z<=e then ss_score p q f g e r i
          else if (ch=1 \/ ch=3)=(0<z) then 2 else 1;
     (m,d)=ss_lanes full p q e xx yy fs
 in (4294967296*m+(if sign=2 then 1 else 0),4294967296*d+(if sign=0 then 1 else 0)))
End
Definition ss_rows_def:
 (ss_rows full fs gs [] = (0:num,0:num)) /\
 (ss_rows full fs gs ((x,y,p,q,a,e)::rest) =
 let (m,d)=ss_lanes full p q e x y (if (a:num)=0 then fs else gs);
     (m1,d1)=ss_rows full fs gs rest in (m+2*m1,d+2*d1))
End
Definition ss_loop_def:
 (ss_loop 0 mode fs gs rows expected = T) /\
 (ss_loop (SUC n) mode fs gs rows expected =
    ((if (mode:num)=0 then expected else ss_rows (mode=2) fs gs rows)=expected /\
      ss_loop n mode fs gs rows expected))
End
val _=cv_auto_trans ss_loop_def;
