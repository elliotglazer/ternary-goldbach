open HolKernel boolLib bossLib primeCertificateTheory PrimeData;
val _ = new_theory "PrimeCertificateResults";
fun require b message = if b then () else raise Fail message;
val context_axioms = List.concat (map (fn theory =>
  map (fn (name,_) => theory ^ "." ^ name) (DB.axioms theory))
  ("primeCertificate" :: Theory.ancestry "primeCertificate"));
val allowed_axioms = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val _ = require (List.all (fn x => List.exists (fn y => x=y) allowed_axioms) context_axioms) "unexpected axiom";
val _ = print ("HOL4_PRIME_AXIOMS," ^ String.concatWith ";" context_axioms ^ "\n");
fun timed label work =
  let val cpu=Timer.startCPUTimer () val wall=Time.now () val result=work ()
      val {usr,sys}=Timer.checkCPUTimer cpu
  in print ("HOL4_PRIME_TIME," ^ label ^ "," ^
      Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.+(usr,sys))) ^ "," ^
      Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.-(Time.now(),wall))) ^ "\n");result end;
val prime_tm=prim_mk_const {Thy="divides",Name="prime"};
fun prime_term p=mk_comb(prime_tm,numSyntax.mk_numeral(Arbnum.fromString p));
fun audit tm th =
  let val (oracles,_) = Tag.dest_tag (tag th)
  in require (null(hyp th)) "primality hypothesis survived";
     require (aconv (concl th) tm) "wrong prime conclusion";
     require (List.all (fn x=>x="DISK_THM") oracles) "unexpected oracle" end;
fun cohort label roots = timed label (fn () =>
  let val conv=primeCertificateLib.PRIME_CERT_CONV certificates
  in map (fn p=>let val tm=prime_term p val th=EQT_ELIM(conv tm)
               in audit tm th; (p,th) end) roots end);
val full_results=cohort "all_roots" all_roots;
val source_results=cohort "source_roots" source_roots;
val anchor_results=cohort "anchor_roots" anchor_roots;
val _ = require (length full_results=393 andalso length source_results=283 andalso length anchor_results=110) "wrong cohort size";
val _ = List.app (fn (p,th)=>
  (ignore(save_thm("prime_"^p,th));print("HOL4_PRIME_ACCEPTED,"^p^"\n"))) full_results;
fun reject label data candidate =
  let val rejected=(ignore(primeCertificateLib.PRIME_CERT_CONV data (prime_term candidate));false)
                   handle HOL_ERR _=>true
  in require rejected ("corruption accepted: "^label);
     print("HOL4_PRIME_REJECTED,"^label^"\n") end;
val chosen=List.last all_roots;
val bad_base=map(fn(n,a,fs)=>if n=chosen then(n,"1",fs) else(n,a,fs)) certificates;
val bad_factors=map(fn(n,a,fs)=>if n=chosen then
  (n,a,case fs of (q,e)::rest=>(q,e+1)::rest | []=>raise Fail "empty factors") else(n,a,fs)) certificates;
val _=reject "bad_base" bad_base chosen;
val _=reject "bad_factors" bad_factors chosen;
val _=reject "composite" [("9","2",[("2",3)])] "9";
val _=timed "export" export_theory;
val _=print "HOL4_PRIME_BENCHMARK_DONE\n";
