open HolKernel Parse boolLib bossLib cv_transLib;
open C10004TraversalBaseTheory C10004TraversalRefinementTheory;
open C10004LinkedTheory C10004FullIntegerTheory PackedPriceTheory C10004PackedTheory C10004SharedTheory C10004PhaseDataTheory C10004TransformTheory C10004TransformTestsTheory C10004TraversalCVTheory;

fun require b s = if b then () else raise Fail s;
val mode = valOf(OS.Process.getEnv "PACKED_MODE");
val _ = new_theory ("C10004Linked" ^ (if mode="admit" then "Admission" else if mode="id1" then "IdentityOne" else "IdentityTwo"));
val allowed = ["bool.ETA_AX","bool.SELECT_AX",
  "bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "C10004Linked" :: "C10004PhaseData" :: (Theory.ancestry "C10004Linked" @ Theory.ancestry "C10004PhaseData");
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected context axiom";
val _ = print ("TRAVERSAL_CV_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
fun audit name th =
  let val (oracles,axioms) = Tag.dest_tag (tag th)
  in require (null (hyp th)) (name ^ ": open hypotheses");
     require (List.all (fn s => s="DISK_THM") oracles)
       (name ^ ": unexpected oracle");
     require (null axioms) (name ^ ": unexpected explicit axiom tags");
     print ("TRAVERSAL_CV_TAG," ^ name ^ "," ^
       String.concatWith ";" oracles ^ "," ^
       String.concatWith ";" axioms ^ "\n")
  end;
val generic = [
 ("ft_checked_refines",ft_checked_refines,
   ``!roots xs. ft_checked roots xs = tx_checked roots xs``),
 ("cvfast_public_refines",cvfast_public_refines,
   ``!fixture. cvfast_public_success fixture = test_public_success fixture``)];
val _ = List.app (fn (name,th,expected) =>
  (require (aconv (concl th) expected) (name ^ ": changed conclusion");
   audit name th;
   print ("TRAVERSAL_CV_GENERIC," ^ name ^ "," ^ thm_to_string th ^ "\n"))) generic;

val scale_two_pre = MATCH_MP BlockRoundTheory.round_scaled_pre_ok
  (prove (``(0:int) < 2``,intLib.ARITH_TAC));
fun discharge_one (h,th) =
  let val heq = QCONV (SIMP_CONV bool_ss
        [scale_two_pre,tx_mul_pre_ok,actual_rpre_ok,linked_r122pre_ok,linked_r140pre_ok]) h
      val _ = require (aconv (rhs (concl heq)) boolSyntax.T)
        "unproved evaluation hypothesis"
  in PROVE_HYP (EQT_ELIM heq) th end;
fun cpu timer = let val {usr,sys} = Timer.checkCPUTimer timer
  in Time.+ (usr,sys) end;
fun seconds t = Real.toString (Time.toReal t);
fun timed f = let val clock = Timer.startCPUTimer ()
                 val value = f ()
             in (value,cpu clock) end;

val templates = ref ([] : (int * (term list * thm)) list);
fun blockCon tm =
 let val (encoder,blocks) = dest_comb tm
     val (zs,ty) = listSyntax.dest_list blocks
     val (vs,template) = case List.find (fn (n,_) => n=length zs) (!templates) of SOME (_,x) => x
       | NONE => let val vs = List.tabulate(length zs,fn j => mk_var("payload" ^ Int.toString j,ty))
                     val (template,dt) = timed (fn () =>
                         EVAL(mk_comb(encoder,listSyntax.mk_list(vs,ty))))
                     val _ = print ("BLOCK_TEMPLATE_CPU," ^ seconds dt ^ "\n")
                     val _ = templates := (length zs,(vs,template)) :: !templates
                 in (vs,template) end
     val (inst,dt) = timed (fn () => INST(ListPair.map (fn (v,z) => v |-> z) (vs,zs)) template)
     val _ = print ("BLOCK_INSTANTIATION_CPU," ^ seconds dt ^ "\n")
     val _ = require (aconv (lhs(concl inst)) tm) "wrong source encoding"
 in inst end;
(* Every call creates a conversion and executes it. No saved closed result
   is consulted. Stock library translation/compiled-equation caches persist
   within this process, as in the production evaluator. *)
fun evaluate encoders tm =
  let
    val ((conv,ctx),prepare) = timed (fn () =>
      let val (fnTm,args) = strip_comb tm
          val vs = ListPair.map (fn (a,j) => mk_var("arg" ^ Int.toString j,type_of a)) (args,List.tabulate(length args,fn j => j))
          val rep = cv_repLib.cv_rep_for [] (list_mk_comb(fnTm,vs))
          val ft = cv_typeLib.from_to_thm_for (type_of tm)
          val template = UNDISCH_ALL
            (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
          val concrete = INST (ListPair.map (fn (v,a) => v |-> a) (vs,args)) template
          val cvpath = RAND_CONV o RAND_CONV
          fun applyArgs [] = ALL_CONV
            | applyArgs (cv::rest) = RATOR_CONV (applyArgs rest) THENC RAND_CONV cv
          val ctx = CONV_RULE (cvpath (applyArgs (rev encoders))) concrete
          val cvtm = rand (rhs (concl ctx))
          val (cvfn,cvargs) = strip_comb cvtm
          val argVars = ListPair.map (fn (s,j) => mk_var("cvarg" ^ Int.toString j,type_of s))
                           (cvargs,List.tabulate(length cvargs,fn j => j))
          val conv = cv_computeLib.cv_compute (cv_eqs_for (list_mk_comb(cvfn,argVars)))
      in (conv,ctx) end)
    val (raw,execute) = timed (fn () =>
      CONV_RULE (RAND_CONV (RAND_CONV conv)) ctx)
    val (decoded,decode) = timed (fn () =>
      CONV_RULE (RAND_CONV EVAL) raw)
    val (closed,discharge) = timed (fn () =>
      List.foldl discharge_one decoded (hyp decoded))
  in (closed,[prepare,execute,decode,discharge]) end;


fun readPairs path =
  let val stream = TextIO.openIn path
      fun number s = intSyntax.term_of_int (Arbint.fromString
        (String.translate (fn #"-" => "~" | c => String.str c) s))
      fun loop acc = case TextIO.inputLine stream of NONE => rev acc
        | SOME line => (case String.tokens Char.isSpace line of
            [r,i] => loop (pairSyntax.mk_pair(number r,number i)::acc)
          | _ => raise Fail path)
      val pairs = loop []
  in TextIO.closeIn stream; pairs end;
val pairty = ``:int # int``;
fun pairList pairs = listSyntax.mk_list(pairs,pairty);
fun rootRows [] [] = []
  | rootRows (n::ns) pairs = pairList (List.take(pairs,n)) ::
      rootRows ns (List.drop(pairs,n))
  | rootRows _ _ = raise Fail "root count";
val _ = print "SHARED_BOOTSTRAP_DONE\n";
fun mkRoots () = listSyntax.mk_list (rootRows [2,3,5,10,15,20,30,40,60]
  (readPairs "../c10004-hol-replay/roots.tsv"), ``:(int # int) list``);
val _ = audit "actual_phase_encoding" actual_phase_encoding;
fun params path =
 let val ins = TextIO.openIn path
     val fields = String.tokens Char.isSpace (valOf(TextIO.inputLine ins))
     val _ = TextIO.closeIn ins
     fun ai s = Arbint.fromString (String.translate (fn #"-" => "~" | c => String.str c) s)
     fun it s = intSyntax.term_of_int (ai s)
     fun pair x y = pairSyntax.mk_pair(x,y)
 in case fields of [er,ei,odr,odi,e,m] =>
     pair (pair (pair (it odr) (it odi)) (pair (it er) (it ei)))
          (pair (it e) (numSyntax.mk_numeral (Arbnum.fromString m)))
  | _ => raise Fail "bad parameter line" end;
fun packed path count =
 let val ins = TextIO.openIn path
     fun loop acc = case TextIO.inputLine ins of NONE => rev acc | SOME s =>
       loop (numSyntax.mk_numeral(Arbnum.fromString(hd(String.tokens Char.isSpace s)))::acc)
     val xs = loop []
     val _ = TextIO.closeIn ins
     val _ = require (length xs = count) ("payload count in " ^ path)
 in listSyntax.mk_list(xs,numSyntax.num) end;
fun run () =
 let val clock = Timer.startCPUTimer ()
     val ((tm,encoders),readTime) = timed (fn () =>
       let val roots = mkRoots()
           val q = hd(#1(listSyntax.dest_list(packed "conductor.txt" 1)))
           val blocks = packed "states.txt" 1200
           val c1path = "../c10004-full-integer/coeffs.txt"
       in if mode="admit" then
         (list_mk_comb(``linked_both``,[roots,packed c1path 1025,packed "coeff2.txt" 1025,q,blocks,
             ``actual_phase``,params "../c10004-full-integer/params.tsv",params "params2.tsv"]),
          [EVAL,blockCon,blockCon,EVAL,blockCon,REWR_CONV actual_phase_encoding,EVAL,EVAL])
       else let val h = if mode="id1" then "1" else "2"
                val c = packed (if h="1" then c1path else "coeff2.txt") 1025
            in (list_mk_comb(``linked_identity``,[roots,c,q,blocks,
               if h="1" then boolSyntax.F else boolSyntax.T,
               packed ("h" ^ h ^ "-source.txt") 300, packed ("h" ^ h ^ "-spectrum.txt") 144]),
               [EVAL,blockCon,EVAL,blockCon,EVAL THENC SIMP_CONV bool_ss [cv_primTheory.cv_rep_T,cv_primTheory.cv_rep_F],blockCon,blockCon]) end
       end)
     val _ = print ("LINKED_READY," ^ mode ^ "," ^ seconds readTime ^ "\n")
     val (result,parts) = evaluate encoders tm
     val th = if aconv (concl result) tm then EQT_INTRO result else result
     val _ = require (aconv (lhs (concl th)) tm andalso aconv (rhs (concl th)) boolSyntax.T) "full block result mismatch"
     val _ = audit ("linked_" ^ mode) th
     val _ = save_thm("linked_" ^ mode,th)
 in print ("LINKED_CPU," ^ mode ^ "," ^ String.concatWith ","
       (map seconds (readTime :: parts @ [cpu clock])) ^ "\n") end;
val _ = run ();
val _ = export_theory ();
val _ = print ("LINKED_REPLAY_DONE," ^ mode ^ "\n");

