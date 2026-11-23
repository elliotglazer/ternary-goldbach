open HolKernel boolLib bossLib FiniteCoverTheory PrimeData CoverData;
val _ = new_theory "FiniteCoverResults";
fun require b message = if b then () else raise Fail message;
val context_axioms = List.concat (map (fn theory =>
  map (fn (name,_) => theory ^ "." ^ name) (DB.axioms theory))
  ("FiniteCover" :: Theory.ancestry "FiniteCover"));
val allowed_axioms = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val _ = require (List.all (fn x => List.exists (fn y => x=y) allowed_axioms) context_axioms) "unexpected axiom";
val _ = print ("HOL4_COVER_AXIOMS," ^ String.concatWith ";" context_axioms ^ "\n");
fun timed label work =
  let val cpu=Timer.startCPUTimer () val wall=Time.now () val result=work ()
      val {usr,sys}=Timer.checkCPUTimer cpu
  in print ("HOL4_COVER_TIME," ^ label ^ "," ^
      Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.+(usr,sys))) ^ "," ^
      Real.fmt (StringCvt.FIX (SOME 9)) (Time.toReal (Time.-(Time.now(),wall))) ^ "\n");result end;
fun numeral s = numSyntax.mk_numeral (Arbnum.fromString s);
val prime_tm=prim_mk_const {Thy="divides",Name="prime"};
fun prime_term p=mk_comb(prime_tm,numeral p);
fun audit tm th =
  let val (oracles,_) = Tag.dest_tag (tag th)
  in require (null(hyp th)) "hypothesis survived";
     require (aconv (concl th) tm) "wrong conclusion";
     require (List.all (fn x=>x="DISK_THM") oracles) "unexpected oracle" end;
val prime_results = timed "all_primes" (fn () =>
  let val conv=primeCertificateLib.PRIME_CERT_CONV certificates
  in map (fn p=>let val tm=prime_term p val th=EQT_ELIM(conv tm)
               in audit tm th; (p,th) end) all_roots end);
val _ = require (length prime_results = 393) "wrong prime cohort";
fun prime_proof p = case List.find (fn(q,_)=>p=q) prime_results of
    SOME (_,th) => th | NONE => raise Fail "unknown prime";
fun build_tree [] = tree_primes_empty
  | build_tree ps =
    let val middle=length ps div 2 val p=List.nth(ps,middle)
        val left=build_tree(List.take(ps,middle))
        val right=build_tree(List.drop(ps,middle+1))
    in MATCH_MP tree_primes_node (CONJ left (CONJ (prime_proof p) right)) end;
val tree_proof = timed "prime_tree" (fn()=>build_tree all_roots);
val raw_tree = rand(concl tree_proof);
val tree_def = new_definition("cert_tree_def",mk_eq(mk_var("cert_tree",type_of raw_tree),raw_tree));
val tree = lhs(concl tree_def);
val named_tree_proof = REWRITE_RULE [GSYM tree_def] tree_proof;
val _ = audit ``tree_primes ^tree`` named_tree_proof;
val _ = save_thm("cert_tree_primes",named_tree_proof);
val raw_ws = listSyntax.mk_list
  (map(fn(p,q)=>pairSyntax.mk_pair(numeral p,numeral q)) witnesses,
   pairSyntax.mk_prod(numSyntax.num,numSyntax.num));
val ws_def = new_definition("cert_witnesses_def",mk_eq(mk_var("cert_witnesses",type_of raw_ws),raw_ws));
val ws = lhs(concl ws_def);
val _ = timed "input_translation" (fn()=> (cv_transLib.cv_trans tree_def;cv_transLib.cv_trans ws_def));
val target_tm=numeral target;
val end_tm=numeral end_exclusive;
val width_tm=numSyntax.mk_numeral(Arbnum.fromInt width);
val checked_tm=``checked_cover ^target_tm ^tree ^ws``;
val cover_proof = timed "coverage" (fn()=>EQT_ELIM(cv_transLib.cv_eval checked_tm));
val _ = audit checked_tm cover_proof;
val expected=``!n:num. ^target_tm <= n /\ n < ^end_tm /\ n MOD 2 = 0 ==>
  ?p q:num. prime p /\ prime q /\ p + q = n``;
val interval = timed "interval_assembly" (fn()=>
  let val even_th=EQT_ELIM(cv_transLib.cv_eval ``^target_tm MOD 2 = 0``)
      val len_th=cv_transLib.cv_eval ``LENGTH ^ws``
      val _=require (aconv (rhs(concl len_th)) width_tm) "wrong witness length"
      val end_th=cv_transLib.cv_eval ``^target_tm + 2 * ^width_tm``
      val _=require (aconv (rhs(concl end_th)) end_tm) "wrong interval endpoint"
      val th=MATCH_MP checked_cover_interval (CONJ even_th (CONJ named_tree_proof cover_proof))
  in REWRITE_RULE [len_th,end_th,binary_goldbach_def] th end);
val _=audit expected interval;
val _=save_thm("binary_interval",interval);
val _=print("HOL4_COVER_INTERVAL,"^target^","^end_exclusive^","^Int.toString width^"\n");
fun reject label tm =
  let val th=cv_transLib.cv_eval tm
  in require (aconv(rhs(concl th)) boolSyntax.F) ("corruption accepted: "^label);
     audit (concl th) th;
     print("HOL4_COVER_REJECTED,"^label^"\n") end;
val _=reject "empty_tree" ``checked_cover ^target_tm PEmpty ^ws``;
val _=reject "wrong_origin" ``checked_cover (^target_tm + 2) ^tree ^ws``;
val _=reject "missing_witness" ``LENGTH (TL ^ws) = ^width_tm``;
val _=reject "wrong_endpoint" ``^target_tm + 2 * LENGTH ^ws = ^end_tm + 2``;
val _=timed "export" export_theory;
val _=print "HOL4_FINITE_COVER_BENCHMARK_DONE\n";
