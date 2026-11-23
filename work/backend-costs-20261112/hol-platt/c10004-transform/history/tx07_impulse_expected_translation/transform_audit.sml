open HolKernel Parse boolLib bossLib cv_transLib;
open C10004TransformTheory C10004TransformTestsTheory;

fun require b s = if b then () else raise Fail s;
val full_mode = case OS.Process.getEnv "C10004_TRANSFORM_MODE" of
    SOME "full" => true
  | SOME "small" => false
  | _ => raise Fail "C10004_TRANSFORM_MODE must be small or full";
val mode_name = if full_mode then "Full" else "Small";
val _ = new_theory ("C10004Transform" ^ mode_name ^ "Diagnostics");
val allowed = ["bool.ETA_AX","bool.SELECT_AX",
  "bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "C10004TransformTests" :: Theory.ancestry "C10004TransformTests";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected context axiom";
val _ = print ("TRANSFORM_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
fun audit name th =
  let val (oracles,axioms) = Tag.dest_tag (tag th)
  in require (null (hyp th)) (name ^ ": open hypotheses");
     require (List.all (fn s => s="DISK_THM") oracles)
       (name ^ ": unexpected oracle");
     print ("TRANSFORM_TAG," ^ name ^ "," ^
       String.concatWith ";" oracles ^ "," ^
       String.concatWith ";" axioms ^ "\n")
  end;
val generic = [("tx_mul_cached_identity",tx_mul_cached_identity),
  ("tx_omit_projection",tx_omit_projection),
  ("tx_full_length",tx_full_length),("tx_omit_length",tx_omit_length),
  ("tx_tensor_full_length",tx_tensor_full_length),
  ("tx_tensor_selected_length",tx_tensor_selected_length),
  ("tx_checked_contract",tx_checked_contract)];
val _ = List.app (fn (n,th) =>
  (audit n th; print ("TRANSFORM_GENERIC," ^ n ^ "," ^
    thm_to_string th ^ "\n"))) generic;
val scale_two_pre = MATCH_MP BlockRoundTheory.round_scaled_pre_ok
  (prove (``(0:int) < 2``,intLib.ARITH_TAC));
fun discharge_one (h,th) =
  let val heq = QCONV (SIMP_CONV bool_ss
        [scale_two_pre,tx_mul_pre_ok]) h
      val _ = require (aconv (rhs (concl heq)) boolSyntax.T)
        "unproved evaluation hypothesis"
  in PROVE_HYP (EQT_ELIM heq) th end;
fun evaluate tm =
  let val rep = cv_repLib.cv_rep_for [] tm
      val ft = cv_typeLib.from_to_thm_for (type_of tm)
      val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
      val eqs = cv_eqs_for cvtm
      val conv = cv_computeLib.cv_compute eqs
      val ctx = UNDISCH_ALL
        (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft)
      val raw = CONV_RULE (RAND_CONV (RAND_CONV conv)) ctx
      val decoded = CONV_RULE (RAND_CONV EVAL) raw
  in List.foldl discharge_one decoded (hyp decoded) end;
fun check name expected tm =
  let val clock = Timer.startCPUTimer ()
      val th0 = evaluate tm
      val th = if aconv (concl th0) tm then EQT_INTRO th0
        else if aconv (concl th0) (mk_neg tm) then EQF_INTRO th0 else th0
      val _ = audit name th
      val _ = require (is_eq (concl th)) (name ^ ": not equality")
      val _ = require (aconv (lhs (concl th)) tm) (name ^ ": changed claim")
      val target = if expected then boolSyntax.T else boolSyntax.F
      val _ = require (aconv (rhs (concl th)) target)
        (name ^ ": wrong logical result")
      val _ = save_thm ("checked_" ^ name,th)
      val {usr,sys} = Timer.checkCPUTimer clock
  in print ("TRANSFORM_CONTROL," ^ name ^ "," ^
       (if expected then "T" else "F") ^ "," ^
       Time.toString (Time.+ (usr,sys)) ^ "\n") end;
val _ = check "root_packet" true ``tx_roots_ok test_roots``;
val _ = check "short_root_packet" false ``tx_roots_ok (TL test_roots)``;
val _ = check "wrong_exact_root" false ``tx_roots_ok test_bad_special``;
val _ = check "root_out_of_range" false ``tx_roots_ok test_bad_bound``;
val _ = check "all_local_projections" true ``test_local_projection``;
val _ = check "negative_half_tie" true
  ``round_scaled (2:int) (-5) = -2``;
val _ = check "positive_half_tie" true
  ``round_scaled (2:int) 5 = 3``;
val _ = check "short_input_rejected" true
  ``tx_checked test_roots (test_input 1 4799) = NONE``;
val _ = check "invalid_root_rejected" true
  ``tx_checked test_bad_special (test_input 1 4800) = NONE``;
val _ = check "input_range_rejected" true
  ``tx_checked test_roots
      ((2 ** 95,0) :: GENLIST (\i. (0:int,0:int)) 4799) = NONE``;
val _ = if full_mode then
  (check "tensor_projection_h1" true ``test_tensor_projection 1``;
   check "tensor_projection_h2" true ``test_tensor_projection 2``;
   check "checked_h1" true ``test_public_success 1``;
   check "checked_h2" true ``test_public_success 2``;
   check "impulse_all_channels" true
     ``tx_checked test_roots test_impulse =
       SOME (GENLIST (\i. (tx_scale,0)) 2301)``;
   check "changed_output" false ``test_wrong_output``)
  else ();
val _ = export_theory ();
val _ = print ("C10004_TRANSFORM_" ^ mode_name ^
  "_DIAGNOSTICS_DONE_INTEGER_ONLY\n");
