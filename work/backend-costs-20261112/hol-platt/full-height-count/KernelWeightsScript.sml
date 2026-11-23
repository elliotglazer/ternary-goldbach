Theory KernelWeights
Ancestors StencilReceipt arithmetic integer list
Libs meter intLib cv_transLib

open meter;

(* Index j corresponds to the actual node first+j. Evaluate the two
   products in the Lagrange basis formula at the subgrid target f/4096. *)
Definition basis_products_def:
  (basis_products 0 j idx (first:int) (f:int) p d = (p,d)) /\
  (basis_products (SUC len) j idx first f p d =
     if j = idx then basis_products len (SUC j) idx first f p d
     else basis_products len (SUC j) idx first f
       (p*(f-4096*(first + &j))) (d*(4096*(&idx - &j))))
End
Definition assess_def:
  (assess r j first f den norm ([]:int list) = (j = r /\ norm < 5*den)) /\
  (assess r j first f den norm (w::ws) =
     case basis_products r 0 j first f 1 1 of (p,d) =>
       d <> 0 /\ den*p = w*d /\ assess r (j+1) first f den (norm+ABS w) ws)
End
Definition kernel_ok_def:
  kernel_ok r (offset:num) den ws <=>
     0<r /\ EVEN r /\ 0<offset /\ offset<4096 /\ (0:int)<den /\
     assess r 0 (1 - &(r DIV 2)) (&offset) den 0 ws
End
val _=cv_auto_trans kernel_ok_def;

(* Multiply both sides of the radius bound by its positive denominators.
   C bounds the absolute row sum. The distance product at r=2h centered
   nodes is <= (h!)^2, so r!/(h!)^2 is the needed binomial factor. *)
Definition radius_ok_def:
  radius_ok (r:num) e <=>
    let n=524288; j=68267; c=(2*j+1)*(2*1250000**2+1);
        a=512*4*3**64*2**80; h=r DIV 2;
        d=(7*n)**r*FACT r; m=c*(44*j)**r*(FACT h)**2
    in EVEN r /\ 0<r /\ 10*a*d + 2**220*(5*n*d + a*m) <= e*a*d
End
val _=cv_auto_trans radius_ok_def;
val ins=TextIO.openIn "stencils.txt";
fun line()=String.tokens Char.isSpace(valOf(TextIO.inputLine ins));
val radiusSeen=ref ([]:(string*string) list);
fun store name th = if closed th andalso aconv(rhs(concl th)) boolSyntax.T then
                     save_thm(name,EQT_ELIM th) else raise Fail name;
fun verify k =
  let val [idx,r,f,d,e]=line()
      val _=if idx=Int.toString k then () else raise Fail "kernel sequence"
      val _=line()
      val kd=DB.fetch "StencilReceipt" ("kernel_"^idx^"_def")
      val named=lhs(concl kd)
      val prefix=list_mk_comb(``kernel_ok``,[nat r,nat f,integer d])
      val concrete=cv_transLib.cv_eval(mk_comb(prefix,rhs(concl kd)))
      val check=TRANS (AP_TERM prefix kd) concrete
      val result=store ("kernel_"^idx^"_lagrange") check
      val _=case List.find(fn (s,_)=>s=r) (!radiusSeen) of
           SOME(_,prior) => if prior=e then () else raise Fail "inconsistent radius"
         | NONE => (ignore(store ("radius_"^r) (cv_transLib.cv_eval(list_mk_comb(``radius_ok``,[nat r,nat e]))));
                    radiusSeen:=(r,e)::(!radiusSeen))
  in result end;
val kernels=List.tabulate(valOf(Int.fromString(hd(line()))),verify);
val _=TextIO.closeIn ins;
val _=print ("EXACT_LAGRANGE_KERNELS "^Int.toString(length kernels)^" "^Int.toString(length(!radiusSeen))^"\n");
