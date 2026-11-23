load "BatchPrimeTheory";
load "cv_transLib";
open HolKernel boolLib bossLib BatchPrimeTheory;
fun require b msg = if b then () else raise Fail msg;
val allowed=["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val axioms=List.concat(map(fn thy=>map(fn(name,_)=>thy^"."^name)(DB.axioms thy))
  ("BatchPrime"::Theory.ancestry "BatchPrime"));
val _=require (List.all(fn x=>List.exists(fn y=>x=y)allowed) axioms) "unexpected axiom";
val _=print("BATCH_PRIME_AXIOMS,"^String.concatWith ";" axioms^"\n");
val two=``CNode CEmpty 2 0 [] CEmpty``;
val good=``CNode ^two 3 2 [2] (CNode CEmpty 7 3 [2;3] CEmpty)``;
val accepted=EQT_ELIM(cv_transLib.cv_eval ``tree_valid ^good ^good``);
val result=MATCH_MP batch_prime_sound accepted;
val _=require (null(hyp result)) "hypothesis survived";
val _=require (aconv(concl result) ``tree_primes (prime_values ^good)``) "wrong result";
val (oracles,_)=Tag.dest_tag(tag result);
val _=require (List.all(fn x=>x="DISK_THM")oracles) "unexpected oracle";
val _=print "BATCH_PRIME_GOOD_ACCEPTED\n";
fun reject label tree =
  let val th=cv_transLib.cv_eval ``tree_valid ^tree ^tree``
  in require(aconv(rhs(concl th))boolSyntax.F)("bad certificate accepted: "^label);
     print("BATCH_PRIME_REJECTED,"^label^"\n") end;
val _=reject "bad_base" ``CNode ^two 3 2 [2] (CNode CEmpty 7 1 [2;3] CEmpty)``;
val _=reject "missing_factor" ``CNode CEmpty 2 0 [] (CNode CEmpty 7 3 [2;3] CEmpty)``;
val _=reject "wrong_product" ``CNode ^two 3 2 [2] (CNode CEmpty 7 3 [2;2] CEmpty)``;
val _=reject "composite" ``CNode ^two 3 2 [2] (CNode CEmpty 9 2 [2;2;2] CEmpty)``;
val _=reject "self_reference" ``CNode ^two 3 2 [3] CEmpty``;
val _=print "BATCH_PRIME_PROBE_DONE\n";
