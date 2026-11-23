structure encoding = struct
open HolKernel Parse boolLib bossLib cv_transLib meter;

(* Prove encoder (f args) = data. An earlier certified encoder equality can
   supply any argument directly, with no visit to its decoded HOL value. *)
fun produce label f args converters = let
  val vs=vars args
  val tm=list_mk_comb(f,args)
  val t=cpu()
  val rep=cv_repLib.cv_rep_for [] (list_mk_comb(f,vs))
  val schema=UNDISCH_ALL(REWRITE_RULE[cv_repTheory.cv_rep_def] rep)
  val inst=INST(ListPair.map(fn(v,a)=>v |-> a)(vs,args)) schema
  fun descend (c,acc) = RATOR_CONV acc THENC RAND_CONV c
  val base=CONV_RULE(RAND_CONV (List.foldl descend ALL_CONV converters)) inst
  val (cf,aa)=strip_comb(rhs(concl base))
  val conv=cv_computeLib.cv_compute(cv_eqs_for(list_mk_comb(cf,vars aa)))
  val ready=cpu()
  val computed=CONV_RULE(RAND_CONV conv) base
  val th=List.foldl(fn(a,z)=>PROVE_HYP(prove(a,SIMP_TAC(srw_ss())[])) z) computed (hyp computed)
  val stop=cpu()
  val _=if closed th andalso aconv(rand(lhs(concl th))) tm then () else raise Fail label
  val _=print("ENCODED "^label^" "^Real.toString(ready-t)^" "^Real.toString(stop-ready)^"\n")
in th end;
end;
