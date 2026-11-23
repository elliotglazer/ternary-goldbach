Theory StripShift
Ancestors StripParameter integer list arithmetic
Libs intLib

Definition pos_def:
  pos (k:int) = if k<=0 then 0 else Num k
End

Definition upper_pow_def:
  upper_pow (n:num) d k <=>
    0<d /\ n*2**(pos (-k)) <= d*2**(pos k)
End

Definition geom_shift_def:
  geom_shift (x:int,sub:int,bits:num,ws:int list,delta:num) (b:num) (k:int) <=>
    0<sub /\ 2<=b /\ b<=5 /\
    upper_pow (delta*10**12) ((64*Num sub*(2*b-1))**12) k
End

Definition mass_shift_def:
  mass_shift (q:num,a:num,b:num,last:num,m:num,r:num,h:num) (k:int) <=>
    upper_pow m 1 k
End

Definition shift_row_def:
  shift_row (q:num,label:num,tick:num,sub:num,ex:int,bits:num,c:num,sg:int,
             vs:int list,ws:int list)
      (cq:num,cl:num,ca:num,last:num)
      (x:int,gs:int,gb:num,gw:int list,delta:num)
      (mq:num,ma:num,b:num,ml:num,m:num,r:num,h:num) (b0:num) (km:int) (kg:int) (u:num) <=>
  let start=MIN ((tick DIV sub)-5) (last-11)
  in 0<sub /\ last>=11 /\ tick<=last*sub /\ q=cq /\ label=cl /\ q=mq /\ ma=ca /\
    last=ml /\ b=b0 /\ gs= &sub /\ gb=bits /\ gw=ws /\ x= &tick- &(start*sub) /\
    LENGTH vs=12 /\ (sg=1 \/ sg= -1) /\ u=2**pos (km+kg+ &bits-ex)
End

Definition dot_def:
  (dot ([]:int list) (ys:int list)=0:int) /\
  (dot (x::xs) ys=case ys of []=>0 | y::zs=>x*y+dot xs zs)
End

Definition absolute_sum_def:
  (absolute_sum ([]:int list)=0:int) /\ (absolute_sum (x::xs)=ABS x+absolute_sum xs)
End

Definition shift_sign_def:
  shift_sign (q:num,label:num,tick:num,sub:num,ex:int,bits:num,c:num,sg:int,
              vs:int list,ws:int list) (u:num) <=>
  let v=dot vs ws
  in LENGTH vs=12 /\ LENGTH ws=12 /\ EVERY (\x. ABS x<=65536) vs /\
     0<v*sg /\ 2*ABS v>2*(&u+absolute_sum ws)+12*(65536+1)
End
