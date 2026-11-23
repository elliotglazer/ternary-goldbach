open HolKernel Parse boolLib bossLib cv_transLib;
open C10004TraversalBaseTheory C10004TraversalRefinementTheory;
open C10004FusedTheory C10004TransformTheory C10004TransformTestsTheory C10004TraversalCVTheory;

fun require b s = if b then () else raise Fail s;
val _ = new_theory "C10004ActualFused";
val allowed = ["bool.ETA_AX","bool.SELECT_AX",
  "bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "C10004Fused" :: Theory.ancestry "C10004Fused";
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
        [scale_two_pre,tx_mul_pre_ok]) h
      val _ = require (aconv (rhs (concl heq)) boolSyntax.T)
        "unproved evaluation hypothesis"
  in PROVE_HYP (EQT_ELIM heq) th end;
fun cpu timer = let val {usr,sys} = Timer.checkCPUTimer timer
  in Time.+ (usr,sys) end;
fun seconds t = Real.toString (Time.toReal t);
fun timed f = let val clock = Timer.startCPUTimer ()
                 val value = f ()
             in (value,cpu clock) end;

(* Every call creates a conversion and executes it. No saved closed result
   is consulted. Stock library translation/compiled-equation caches persist
   within this process, as in the production evaluator. *)
fun evaluate tm =
  let
    val ((conv,ctx),prepare) = timed (fn () =>
      let val (fnTm,args) = strip_comb tm
          val vs = [mk_var("root_data",type_of (hd args)), mk_var("xs",type_of (List.nth(args,1))),
                    mk_var("input_data",type_of (List.last args))]
          val rep = cv_repLib.cv_rep_for [] (list_mk_comb(fnTm,vs))
          val ft = cv_typeLib.from_to_thm_for (type_of tm)
          val template = UNDISCH_ALL
            (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
          val concrete = INST (ListPair.map (fn (v,a) => v |-> a) (vs,args)) template
          val cvpath = RAND_CONV o RAND_CONV
          val ctx = CONV_RULE (cvpath
            ((RATOR_CONV (RATOR_CONV (RAND_CONV EVAL))) THENC (RATOR_CONV (RAND_CONV EVAL)) THENC (RAND_CONV EVAL))) concrete
          val cvtm = rand (rhs (concl ctx))
          val conv = cv_computeLib.cv_compute (cv_eqs_for cvtm)
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
val _ = print "FUSED_BOOTSTRAP_DONE\n";
fun mkRoots () = listSyntax.mk_list (rootRows [2,3,5,10,15,20,30,40,60]
  (readPairs "../c10004-hol-replay/roots.tsv"), ``:(int # int) list``);
fun guards path =
 let val ins = TextIO.openIn path
     fun num s = intSyntax.term_of_int (Arbint.fromString
         (String.translate (fn #"-" => "~" | c => String.str c) s))
     fun pair a b = pairSyntax.mk_pair(num a,num b)
     fun loop acc = case TextIO.inputLine ins of NONE => rev acc
       | SOME l => (case String.tokens Char.isSpace l of [a,b,e,s] =>
          loop (pairSyntax.mk_pair(pair a b,pair e s)::acc)
         | _ => raise Fail "bad guard")
     val gs = loop []
     val _ = TextIO.closeIn ins
     val _ = require (length gs = 2301) "guard count"
 in listSyntax.mk_list(gs,type_of (hd gs)) end;
fun run h =
 let val clock = Timer.startCPUTimer ()
     val (tm,readTime) = timed (fn () =>
        let val xs = readPairs ("../c10004-hol-replay/input" ^ h ^ ".tsv")
            val _ = require (length xs = 4800) "input count"
        in list_mk_comb (``fused_checked``,[mkRoots(),pairList xs,
             guards ("h" ^ h ^ "-guards.tsv")]) end)
     val _ = print ("FUSED_START," ^ h ^ "\n")
     val (result,parts) = evaluate tm
     val th = if aconv (concl result) tm then EQT_INTRO result else result
     val _ = audit ("fused_checked_h" ^ h) th
     val _ = require (aconv (lhs (concl th)) tm andalso
                      aconv (rhs (concl th)) boolSyntax.T) "fused sign check failed"
     val _ = save_thm("fused_checked_h" ^ h,th)
 in print ("FUSED_CPU," ^ h ^ "," ^ String.concatWith ","
       (map seconds (readTime :: parts @ [cpu clock])) ^ "\n") end;
val _ = List.app run ["1","2"];
val _ = export_theory ();
val _ = print "FUSED_REPLAY_DONE\n";
