open HolKernel boolLib bossLib FiniteCoverTheory BatchPrimeTheory BatchData CoverData;
val _ = new_theory "BatchCoverResults";
fun require b message = if b then () else raise Fail message;
val context_axioms = List.concat (map (fn theory =>
  map (fn (name,_) => theory ^ "." ^ name) (DB.axioms theory))
  ("BatchPrime" :: Theory.ancestry "BatchPrime"));
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
val cert_serial=ref 0;
val root_definition=ref TRUTH;
fun raw_certificate_tree [] = ``CEmpty``
  | raw_certificate_tree cs =
    let val middle=length cs div 2
        val (p,a,fs)=List.nth(cs,middle)
        val left=raw_certificate_tree(List.take(cs,middle))
        val right=raw_certificate_tree(List.drop(cs,middle+1))
        val pt=numeral p val at=numeral a
        val ft=listSyntax.mk_list(map numeral fs,numSyntax.num)
    in ``CNode ^left ^pt ^at ^ft ^right`` end;
fun define_certificates cs =
  let val rhs=if length cs <= 31 then raw_certificate_tree cs
      else let val middle=length cs div 2
               val (p,a,fs)=List.nth(cs,middle)
               val left=define_certificates(List.take(cs,middle))
               val right=define_certificates(List.drop(cs,middle+1))
               val pt=numeral p val at=numeral a
               val ft=listSyntax.mk_list(map numeral fs,numSyntax.num)
           in ``CNode ^left ^pt ^at ^ft ^right`` end
      val id= !cert_serial val _=cert_serial:=id+1
      val name="certificates_"^Int.toString id
      val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of rhs),rhs))
      val _=cv_transLib.cv_trans def
      val _=root_definition:=def
  in lhs(concl def) end;
val _=require(length certificates=1537 andalso length all_roots=393) "wrong fixture sizes";
val certs=timed "certificate_translation" (fn()=>define_certificates certificates);
val valid=timed "batch_primality" (fn()=>EQT_ELIM(cv_transLib.cv_eval ``tree_valid ^certs ^certs``));
val _=audit ``tree_valid ^certs ^certs`` valid;
val (tree,named_tree_proof) = timed "prime_tree" (fn()=>
  let val raw=``prime_values ^certs``
      val def=new_definition("cert_tree_def",mk_eq(mk_var("cert_tree",type_of raw),raw))
      val _=cv_transLib.cv_trans def
      val th=REWRITE_RULE[GSYM def](MATCH_MP batch_prime_sound valid)
  in (lhs(concl def),th) end);
val _=audit ``tree_primes ^tree`` named_tree_proof;
val _=save_thm("cert_tree_primes",named_tree_proof);
val _=timed "root_claims" (fn()=>List.app(fn p=>
  let val pt=numeral p
      val member=EQT_ELIM(cv_transLib.cv_eval ``tree_contains ^pt ^tree``)
      val th=MATCH_MP tree_contains_prime (CONJ named_tree_proof member)
  in audit (prime_term p) th; ignore(save_thm("prime_"^p,th));
     print("HOL4_BATCH_ROOT,"^p^"\n") end) all_roots);
val serial = ref 0;
fun define_witnesses ps =
  let val rhs = if length ps <= 32 then
        listSyntax.mk_list
          (map(fn(p,q)=>pairSyntax.mk_pair(numeral p,numeral q)) ps,
           pairSyntax.mk_prod(numSyntax.num,numSyntax.num))
      else let val middle=length ps div 2
               val left=define_witnesses(List.take(ps,middle))
               val right=define_witnesses(List.drop(ps,middle))
           in ``^left ++ ^right`` end
      val id = !serial
      val _ = serial := id+1
      val name="cert_witnesses_" ^ Int.toString id
      val def=new_definition(name^"_def",mk_eq(mk_var(name,type_of rhs),rhs))
      val _=cv_transLib.cv_trans def
  in lhs(concl def) end;
val ws = timed "input_translation" (fn()=>
  define_witnesses witnesses);
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
val (_,root_args)=strip_comb(rhs(concl(!root_definition)));
val _=require(length root_args=5) "unexpected certificate root definition";
val [left,p,a,fs,right]=root_args;
fun reject_tree label t = reject label ``tree_valid ^t ^t``;
val _=reject_tree "certificate_bad_base" ``CNode ^left ^p 1 ^fs ^right``;
val _=reject_tree "certificate_wrong_product" ``CNode ^left ^p ^a (0::^fs) ^right``;
val _=reject_tree "certificate_missing_factor" ``CNode CEmpty ^p ^a ^fs ^right``;
val _=reject_tree "certificate_self_reference" ``CNode ^left ^p ^a (^p::^fs) ^right``;
val _=reject_tree "certificate_composite" ``CNode (CNode CEmpty 2 0 [] CEmpty) 9 2 [2;2;2] CEmpty``;
val _=timed "export" export_theory;
val _=print "HOL4_BATCH_COVER_BENCHMARK_DONE\n";
