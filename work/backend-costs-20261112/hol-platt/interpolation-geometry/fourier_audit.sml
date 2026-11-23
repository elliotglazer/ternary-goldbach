open HolKernel Parse boolLib bossLib FourierJetTheory MomentRatesTheory MomentTransferTheory FourierStencilTheory;
val roots=["FourierStencil","MomentRates"];
val allowed=["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val _=List.app(fn thy=>List.app(fn (n,_)=>if List.exists(fn x=>x=thy^"."^n)allowed then ()
 else raise Fail ("unexpected axiom "^n)) (DB.axioms thy))
 (List.concat(map(fn root=>root::Theory.ancestry root)roots));
fun check (n,th)=let val (os,_)=Tag.dest_tag(tag th) in
 if null(hyp th) andalso List.all(fn a=>a="DISK_THM")os
 then print(n^" "^Parse.thm_to_string th^"\n") else raise Fail n end;
val _=List.app check [("finitejet_diffl",finitejet_diffl),("finitejet_bound",finitejet_bound),
 ("finitejet_taylor",finitejet_taylor),("stencil_taylor_error",stencil_taylor_error),
 ("finite_fourier_stencil",finite_fourier_stencil)];
val _=List.app (fn i=>let val n="kernel_"^Int.toString i^"_rate" in check(n,DB.fetch "MomentRates" n)end)
 (List.tabulate(55,fn x=>x));
val _=print "FOURIER_RATE_AUDIT_PASS\n";
