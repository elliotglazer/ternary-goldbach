Theory ChirpPackets
Ancestors integer arithmetic
Libs cv_transLib
Definition sdiv_def:
 sdiv (x:int) y=if y=0 then 0 else x/y
End
val _=cv_auto_trans sdiv_def;
Definition cr_def:
 cr g x=sdiv (2*x+g) (2*g)
End
val _=cv_auto_trans cr_def;
Definition cmul_def:
 cmul g (a:int,b:int) (x:int,y:int)=(cr g (a*x-b*y),cr g(a*y+b*x))
End
val _=cv_auto_trans cmul_def;
Definition emit_def:
 emit S B x=let h=cr S x in (h,2*ABS(x-S*h)+2*B<S)
End
val _=cv_auto_trans emit_def;
Definition row_def:
 (row 0 mode G S P R B delta z r=(z,r,0:int,0:int,T)) /\
 (row (SUC n) mode G S P R B delta (ax,ay) r=
 let (zz,rr,u,v,ok)=row n mode G S P R B delta (cmul G (ax,ay) r) (cmul G r delta)
 in if mode=1:num then (zz,rr,0,0,T) else
 let (a,ca)=emit S B ax; (b,cb)=emit S B ay
 in (zz,rr,a+P+R*u,b+P+R*v,ok /\ ca /\ cb))
End
val _=cv_auto_trans row_def;
Definition smod_def:
 smod (a:int) b=if b=0 then 0 else a%b
End
val _=cv_auto_trans smod_def;
Definition pump_def:
 (pump 0 mode G S P R B d z r=(z,r,0:int,T)) /\
 (pump (SUC n) mode G S P R B d z r=
 let (zz,rr,u,v,ok)=row 64 mode G S P R B d z r;
     (ze,re,h,ok2)=pump n mode G S P R B d zz rr
 in (ze,re,smod (h+u+3*v) 65537,ok /\ ok2))
End
val _=cv_auto_trans pump_def;
Definition accept_def:
 accept n mode G S P R B dx dy a b u v x y s t h =
 (pump n mode G S P R B (dx,dy) (a,b) (u,v)=((x,y),(s,t),h,T))
End
val _=cv_auto_trans accept_def;
