Theory MomentRates
Ancestors StencilReceipt arithmetic integer list
Libs meter intLib cv_transLib
open meter;

Definition points_def:
 (points (x:int) ([]:int list) = []:(int # int) list) /\
 (points x (w::ws) = (-w,4096*x)::points (x+1) ws)
End
Definition step_def:
 (step ([]:(int # int) list) = []) /\
 (step ((z,x)::zs) = (z*x,x)::step zs)
End
Definition mass_def:
 (mass flag ([]:(int # int) list) = 0:int) /\
 (mass flag ((z,x)::zs) = (if flag then ABS z else z) + mass flag zs)
End
Definition numer_def:
 (numer 0 (k:num) acc power zs =
    &(k * (4096*7*524288)) * acc + power * mass T zs) /\
 (numer (SUC n) k acc power zs =
    numer n (SUC k) (&(k*(4096*7*524288))*acc + power*ABS(mass F zs))
      (power * &(44*68267)) (step zs))
End
Definition rate_ok_def:
 rate_ok r f den ws <=>
 let k = 2*r+64;
     z = numer k 0 0 1 ((den,&f)::points (1 - &(r DIV 2)) ws)
 in 2*z * &((7*524288)**r * FACT r) <=
    den * &((4096*7*524288)**k * FACT k * (44*68267)**r * (FACT(r DIV 2))**2)
End
val _ = cv_auto_trans rate_ok_def;
val ins=TextIO.openIn "../full-height-count/stencils.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
fun verify k =
 let val [idx,r,f,d,e]=line()
     val _=if idx=Int.toString k then () else raise Fail "kernel sequence"
     val _=line()
     val kd=DB.fetch "StencilReceipt" ("kernel_"^idx^"_def")
     val prefix=list_mk_comb(``rate_ok``,[nat r,nat f,integer d])
     val th=TRANS (AP_TERM prefix kd) (cv_eval(mk_comb(prefix,rhs(concl kd))))
 in if closed th andalso aconv(rhs(concl th)) boolSyntax.T
    then save_thm("kernel_"^idx^"_rate",EQT_ELIM th) else raise Fail idx end;
val rates=List.tabulate(valOf(Int.fromString(hd(line()))),verify);
val _=TextIO.closeIn ins;
val _=print ("EXACT_TAYLOR_RATES "^Int.toString(length rates)^"\n");
