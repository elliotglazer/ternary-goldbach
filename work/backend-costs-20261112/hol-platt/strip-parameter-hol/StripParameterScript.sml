Theory StripParameter
Ancestors integer arithmetic list
Libs intLib

Definition prod_def:
  (prod ([]:int list) = 1) /\ (prod (x::xs) = x*prod xs)
End

Definition numerator_def:
  numerator (x:int) sub i =
    prod (MAP (\j. x - &j * sub) (FILTER (\j. j<>i) (COUNT_LIST 12)))
End

Definition denominator_def:
  denominator (sub:int) (i:num) =
    sub ** 11 * prod (MAP (\j. &i - &j) (FILTER (\j. j<>i) (COUNT_LIST 12)))
End

Definition geometry_def:
  geometry (x:int,sub:int,bits:num,ws:int list,delta:num) <=>
   0<sub /\ LENGTH ws=12 /\
   EVERY (\i. let den=denominator sub i in den<>0 /\
       2*ABS (numerator x sub i * 2**bits - EL i ws*den)<=ABS den)
     (COUNT_LIST 12) /\
   &delta=ABS(prod(MAP (\j. x - &j * sub) (COUNT_LIST 12)))
End

Definition mass_def:
  mass (q:num,a:num,b:num,last:num,m:num,r:num,h:num) <=>
  let n=b+a; v=64*(b+2)+5*last;
      num=q**n * v**(n-1); den=3**n * 64**(n-1);
      en=9*(n-1)*(2*b-1); ed=16*(b+2)
  in 0<q /\ a<=1 /\ 2<=b /\ b<=5 /\ 0<r /\
    (r-1)**2*den<num /\ num<=r**2*den /\
    h=(en+ed-1) DIV ed /\ m=6*2**h*r
End

Definition row_def:
  row (q:num,label:num,tick:num,sub:num,ex:int,bits:num,c:num,sg:int,
       vs:int list,ws:int list)
      (cq:num,cl:num,ca:num,last:num)
      (x:int,gs:int,gb:num,gw:int list,delta:num)
      (mq:num,ma:num,b:num,ml:num,m:num,r:num,h:num) <=>
  let start=MIN ((tick DIV sub)-5) (last-11);
      ne=if ex <= &bits then Num (&bits-ex) else 0;
      de=if &bits <= ex then Num (ex- &bits) else 0;
      n=m*delta*10**12*2**ne; d=(64*sub*(2*b-1))**12*2**de
  in 0<sub /\ last>=11 /\ tick<=last*sub /\ q=cq /\ label=cl /\ q=mq /\
    ma=ca /\ last=ml /\ gs= &sub /\ gb=bits /\ gw=ws /\
    x= &tick- &(start*sub) /\ LENGTH vs=12 /\ (sg=1 \/ sg= -1) /\
    0<d /\ n<=c*d /\ (c=0 \/ (c-1)*d<n)
End
