open HolKernel Parse boolLib bossLib cv_transLib;
open C10004TraversalBaseTheory C10004TraversalRefinementTheory;
open C10004TransformTheory C10004TransformTestsTheory C10004TraversalCVTheory;

fun require b s = if b then () else raise Fail s;
val mode = case OS.Process.getEnv "C10004_TRAVERSAL_CV_MODE" of
    SOME s => s | NONE => raise Fail "missing diagnostic mode";
val suffix = case mode of "controls" => "Controls"
  | "reference_first" => "ReferenceFirst"
  | "sequential_first" => "SequentialFirst"
  | _ => raise Fail "invalid diagnostic mode";
val _ = new_theory ("C10004TraversalCV" ^ suffix ^ "Diagnostics");
val allowed = ["bool.ETA_AX","bool.SELECT_AX",
  "bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "C10004TraversalCV" :: Theory.ancestry "C10004TraversalCV";
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
      let val rep = cv_repLib.cv_rep_for [] tm
          val ft = cv_typeLib.from_to_thm_for (type_of tm)
          val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
          val eqs = cv_eqs_for cvtm
          val conv = cv_computeLib.cv_compute eqs
          val ctx = UNDISCH_ALL
            (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
      in (conv,ctx) end)
    val (raw,execute) = timed (fn () =>
      CONV_RULE (RAND_CONV (RAND_CONV conv)) ctx)
    val (decoded,decode) = timed (fn () =>
      CONV_RULE (RAND_CONV EVAL) raw)
    val (closed,discharge) = timed (fn () =>
      List.foldl discharge_one decoded (hyp decoded))
  in (closed,[prepare,execute,decode,discharge]) end;

fun check group name expected tm =
  let val clock = Timer.startCPUTimer ()
      val (th0,parts) = evaluate tm
      val (_,finish) = timed (fn () =>
        let val th = if aconv (concl th0) tm then EQT_INTRO th0
          else if aconv (concl th0) (mk_neg tm) then EQF_INTRO th0 else th0
            val _ = audit name th
            val _ = require (is_eq (concl th)) (name ^ ": not equality")
            val _ = require (aconv (lhs (concl th)) tm) (name ^ ": changed claim")
            val target = if expected then boolSyntax.T else boolSyntax.F
            val _ = require (aconv (rhs (concl th)) target)
              (name ^ ": wrong logical result")
            val _ = save_thm ("checked_" ^ name,th)
        in () end)
      val total = cpu clock
  in print ("TRAVERSAL_CV_TIME," ^ group ^ "," ^ name ^ "," ^
      (if expected then "T" else "F") ^ "," ^
      String.concatWith "," (map seconds (parts @ [finish,total])) ^ "\n") end;

fun controls () =
 (check "control" "outputs_fixture1" true ``cvfast_output_matches 1``;
  check "control" "outputs_fixture2" true ``cvfast_output_matches 2``;
  check "control" "impulse_all_channels" true
    ``ft_checked test_roots test_impulse = SOME test_impulse_expected``;
  check "control" "short_input_rejected" true
    ``ft_checked test_roots (test_input 1 4799) = NONE``;
  check "control" "invalid_root_rejected" true
    ``ft_checked test_bad_special (test_input 1 4800) = NONE``;
  check "control" "input_range_rejected" true
    ``ft_checked test_roots
      ((2 ** 95,0) :: GENLIST (\i. (0:int,0:int)) 4799) = NONE``;
  check "control" "changed_output" false ``cvfast_wrong_output``);

fun fixture_tm entry fixture =
  case (entry,fixture) of
    ("reference",1) => ``test_public_success 1``
  | ("reference",2) => ``test_public_success 2``
  | ("sequential",1) => ``cvfast_public_success 1``
  | ("sequential",2) => ``cvfast_public_success 2``
  | _ => raise Fail "invalid fixture selection";
fun benchmark () =
  let val entries = if mode="reference_first" then ["reference","sequential"]
        else ["sequential","reference"]
      fun run group repetition fixture entry =
        check group (entry ^ "_fixture" ^ Int.toString fixture ^ "_run" ^
          Int.toString repetition) true (fixture_tm entry fixture)
      val _ = List.app (fn fixture => List.app (run "first" 0 fixture) entries) [1,2]
      val _ = List.app (fn repetition => List.app (fn fixture =>
        List.app (run "warm" repetition fixture) entries) [1,2]) [1,2,3]
  in () end;

val _ = print "TRAVERSAL_CV_COLUMNS,group,name,result,prepare_cpu,execute_cpu,decode_cpu,discharge_cpu,audit_store_cpu,total_cpu\n";
val _ = if mode="controls" then controls () else benchmark ();
val _ = export_theory ();
val _ = print ("C10004_TRAVERSAL_CV_DONE," ^ mode ^ ",INTEGER_ONLY\n");
