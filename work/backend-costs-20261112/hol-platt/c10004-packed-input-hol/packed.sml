open HolKernel Parse boolLib bossLib cv_transLib;
open C10004TraversalBaseTheory C10004TraversalRefinementTheory;
open C10004PackedTheory C10004SharedTheory C10004PhaseDataTheory C10004TransformTheory C10004TransformTestsTheory C10004TraversalCVTheory;

fun require b s = if b then () else raise Fail s;
val mode = valOf(OS.Process.getEnv "PACKED_MODE");
val _ = new_theory ("C10004Packed" ^ (case mode of "cal" => "Cal" | "admit" => "Admission" | _ => "Identity"));
val allowed = ["bool.ETA_AX","bool.SELECT_AX",
  "bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "C10004Packed" :: "C10004PhaseData" :: (Theory.ancestry "C10004Packed" @ Theory.ancestry "C10004PhaseData");
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
val label = valOf(OS.Process.getEnv "REPLAY_LABEL");
val choiceFile = label ^ "_width.txt";
fun blocks h n count =
 let val stream = TextIO.openIn ("h" ^ h ^ "-n" ^ Int.toString n ^ ".txt")
     fun loop 0 acc = rev acc
       | loop k acc = let val line = valOf(TextIO.inputLine stream)
                          val field = hd(String.tokens Char.isSpace line)
                      in loop (k-1) (numSyntax.mk_numeral(Arbnum.fromString field)::acc) end
     val zs = loop (count div n) []
     val _ = if count=4800 then require (not(isSome(TextIO.inputLine stream))) "extra blocks" else ()
     val _ = TextIO.closeIn stream
 in listSyntax.mk_list(zs,numSyntax.num) end;
fun check group h n count store =
 let val clock = Timer.startCPUTimer ()
     val ((tm,encoders),readTime) = timed (fn () =>
       let val ntm = numSyntax.term_of_int n
           val zs = blocks h n count
       in if group="admit" then
         (list_mk_comb(``packed_checked``,[mkRoots(),ntm,zs,``actual_phase``,
           params ("../c10004-hol-shared-phase/h" ^ h ^ "-params.tsv")]),
          [EVAL,EVAL,EVAL,REWR_CONV actual_phase_encoding,EVAL])
       else let val xs = List.take(readPairs("../c10004-hol-replay/input" ^ h ^ ".tsv"),count)
            in (list_mk_comb(``packed_probe``,[ntm,zs,pairList xs]),[EVAL,EVAL,EVAL]) end
       end)
     val (result,parts) = evaluate encoders tm
     val th = if aconv (concl result) tm then EQT_INTRO result else result
     val _ = require (aconv (lhs (concl th)) tm andalso aconv (rhs (concl th)) boolSyntax.T) "wrong result"
     val _ = if store then let val name = group ^ "_h" ^ h
                           in audit name th; ignore(save_thm(name,th)) end else ()
     val total = cpu clock
     val _ = print ("PACKED_CPU," ^ group ^ "," ^ h ^ "," ^ Int.toString n ^ "," ^
       Int.toString count ^ "," ^ String.concatWith "," (map seconds (readTime :: parts @ [total])) ^ "\n")
 in Time.toReal(List.foldl Time.+ Time.zeroTime parts) end;
fun calibration () =
 let val _ = List.app (fn n => ignore(check "warmup" "1" n 256 false)) [4,16]
     val runs = map (fn n => (n,check "cal" "1" n 256 false)) [4,16,16,4,4,16]
     fun median n = case map #2 (List.filter (fn (k,_) => k=n) runs) of
         [a,b,c] => Real.max(Real.min(a,b),Real.min(Real.max(a,b),c))
       | _ => raise Fail "calibration sample count"
     val n = if median 4 <= median 16 then 4 else 16
     val f = TextIO.openOut choiceFile
 in TextIO.output(f,Int.toString n ^ "\n"); TextIO.closeOut f;
    print ("PACKED_CHOICE," ^ Int.toString n ^ "\n") end;
fun run () =
 let val f = TextIO.openIn choiceFile
     val n = valOf(Int.fromString(valOf(TextIO.inputLine f)))
     val _ = TextIO.closeIn f
     val _ = require (n=4 orelse n=16) "invalid width"
 in List.app (fn h => ignore(check mode h n 4800 true)) ["1","2"] end;
val _ = if mode="cal" then calibration () else run ();
val _ = export_theory ();
val _ = print ("PACKED_REPLAY_DONE," ^ mode ^ "\n");
