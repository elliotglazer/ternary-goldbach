open HolKernel Parse boolLib bossLib RawStateHandoffTheory
  RawCompactSignsTheory cv_transLib;
val _ = new_theory "CompactFusedResults";
(* Included verbatim by the generator after the fresh result theory opens. *)
fun require b msg = if b then () else raise Fail msg;
fun timed label f =
  let val ct = Timer.startCPUTimer ()
      val wt = Time.now ()
      val ans = f ()
      val {usr,sys} = Timer.checkCPUTimer ct
  in print ("HANDOFF_PHASE," ^ label ^ "," ^
       Real.fmt (StringCvt.FIX (SOME 9))
         (Time.toReal (Time.+ (usr,sys))) ^ "," ^
       Real.fmt (StringCvt.FIX (SOME 9))
         (Time.toReal (Time.- (Time.now (),wt))) ^ "\n"); ans end;
val allowed_axioms = ["bool.ETA_AX","bool.SELECT_AX",
  "bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val context_axioms = List.concat (map (fn t =>
  map (fn (n,_) => t ^ "." ^ n) (DB.axioms t))
  ("RawStateHandoff" :: Theory.ancestry "RawStateHandoff"));
val _ = require (List.all (fn a => List.exists (fn b => a=b)
  allowed_axioms) context_axioms) "unexpected context axioms";
val _ = print ("HANDOFF_AXIOMS," ^
  String.concatWith ";" context_axioms ^ "\n");
fun audit label th =
  let val (oracles,axs) = Tag.dest_tag (tag th)
  in require (null (hyp th)) "nonempty hypotheses";
     require (List.all (fn t => t="DISK_THM") oracles)
       "unexpected theorem oracle";
     print ("HANDOFF_TAG," ^ label ^ "," ^
       String.concatWith ";" oracles ^ "," ^
       String.concatWith ";" axs ^ "\n") end;
fun integer text =
  let val n = Arbint.fromString text
      val tm = intSyntax.term_of_int n
  in require (Arbint.toString (intSyntax.int_of_term tm) =
      Arbint.toString n) "integer round trip"; tm end;
fun pair [a,b] = pairSyntax.mk_pair(integer a,integer b)
  | pair _ = raise Fail "pair arity";
fun terms_list ty xs = listSyntax.mk_list(xs,ty);
fun state_row xs = terms_list ``:int # int`` (map pair xs);
fun traces xs = terms_list ``:(int # int) list`` (map state_row xs);
fun sources xs = terms_list ``:(int # int) # (int # int)``
  (map (fn (z,w) => pairSyntax.mk_pair(pair z,pair w)) xs);
fun define label name tm = timed label (fn () =>
  new_definition(name ^ "_def",mk_eq(mk_var(name,type_of tm),tm)));
fun translated label def = timed label (fn () => cv_trans def);
val pre_rules = [raw_mul_pre_ok,raw_trace_pre_ok,
  raw_produce_pre_ok,raw_head_pre_ok,raw_heads_pre_ok];
val scale_two_pre = timed "common_scale_two_pre_setup" (fn () =>
  MATCH_MP BlockRoundTheory.round_scaled_pre_ok
    (prove (``(0:int) < 2``, intLib.ARITH_TAC)));
(* Close actual assumptions only, preserving the decoded result equation. *)
fun discharge_one (h,th) =
  let val heq = QCONV (SIMP_CONV bool_ss (scale_two_pre::pre_rules)) h
      val _ = require (aconv (rhs (concl heq)) boolSyntax.T)
        "unproved decoded hypothesis"
      val hp = EQT_ELIM heq
  in PROVE_HYP hp th end;
(* Same proof-producing steps as cv_eval; expose the conversion boundaries. *)
fun evaluate label tm =
  let val rep = timed (label ^ "_representation")
        (fn () => cv_repLib.cv_rep_for [] tm)
      val ft = timed (label ^ "_from_to")
        (fn () => cv_typeLib.from_to_thm_for (type_of tm))
      val cvtm = cv_miscLib.cv_rep_cv_tm (concl rep)
      val eqs = timed (label ^ "_code_equations")
        (fn () => cv_eqs_for cvtm)
      val conv = timed (label ^ "_prepare_conversion")
        (fn () => cv_computeLib.cv_compute eqs)
      val ctx = timed (label ^ "_proof_context") (fn () =>
        UNDISCH_ALL (MATCH_MP (MATCH_MP cv_repTheory.cv_rep_eval rep) ft))
      val raw = timed (label ^ "_compute") (fn () =>
        CONV_RULE (RAND_CONV (RAND_CONV conv)) ctx)
      val decoded = timed (label ^ "_decode") (fn () =>
        CONV_RULE (RAND_CONV EVAL) raw)
      val closed = timed (label ^ "_close") (fn () =>
        List.foldl discharge_one decoded (hyp decoded))
      val normalized = timed (label ^ "_normalize_boolean") (fn () =>
        if type_of tm = ``:bool`` then
          if aconv (concl closed) tm then EQT_INTRO closed
          else if aconv (concl closed) (mk_neg tm) then EQF_INTRO closed
          else closed
        else closed)
      val _ = audit label normalized
      val _ = require (is_eq (concl normalized)) "evaluation not equality"
      val _ = require (aconv (lhs (concl normalized)) tm)
        "evaluation changed input term"
  in normalized end;
fun false_claim label tm =
  let val th = evaluate ("control_" ^ label) tm
  in require (aconv (rhs (concl th)) boolSyntax.F)
       ("corruption accepted: " ^ label);
     ignore (save_thm("reject_" ^ label,th));
     print ("HANDOFF_REJECTED," ^ label ^ "\n") end;
fun true_claim label tm =
  let val th = evaluate ("control_" ^ label) tm
  in require (aconv (rhs (concl th)) boolSyntax.T)
       ("control failed: " ^ label);
     ignore (save_thm("control_" ^ label,th)) end;

(* The reused runtime audits its old ancestor. Check the new ancestor too. *)
val compact_context = List.concat (map (fn t =>
  map (fn (n,_) => t ^ "." ^ n) (DB.axioms t))
  ("RawCompactSigns" :: Theory.ancestry "RawCompactSigns"));
val _ = require (List.all (fn a => List.exists (fn b => a=b)
  allowed_axioms) compact_context) "unexpected compact context axiom";
val _ = print "COMPACT_MODE,fused,integer_signs_only\n";
val source_literal = timed "construct_sources" (fn () => sources [(["1329227995784915872903807060280344576","0"],["5316911983139663491615228241121378304","0"]),
(["939906129562517623222788173737230336","0"],["5309118092161317707859746837123069152","~287781375247807318192539525964923486"]),
(["767430141180807920271061082510983168","0"],["5297340135894055109892069099877310185","~455785608702274642658363048504646236"]),
(["207590536509382518458908427623071744","0"],["5094711576120650345081147255727944941","~1521008544550749089529193262791321378"]),
(["170190205299757229007015392554516480","0"],["5045054256284328934536982452648729180","~1678386304639526643284448928968234290"]),
(["13289622299128633781560240511123456","0"],["3998725174552086266186697532737576300","~3504247424891332711812626554314990838"]),
(["2596148429267413814265248164610048","0"],["2984833080668728037436721529129024568","~4400036876777259435967534029736068700"]),
(["2578231982079492448054160729833472","0"],["2980070296623728307150253861563645337","~4403264023839033122567548857899872088"])]);
val source_def = define "define_sources" "compact_integer_sources" source_literal;
val _ = translated "translate_sources" source_def;
val source_name = lhs (concl source_def);
val bases = ``[1;2;3;41;61;10004;262144;265800]:num list``;
val c = ``61:int``;
val depth = ``128:num``;
val compact = list_mk_comb (``raw_compact``,[bases,c,depth,source_name]);
val result_th = evaluate "compact_pipeline" compact;
val masks_option = rhs (concl result_th);
val masks = optionSyntax.dest_some masks_option;
val (mask_terms,_) = listSyntax.dest_list masks;
val _ = require (length mask_terms = 4) "expected four row masks";
val _ = require (List.all numSyntax.is_numeral mask_terms) "mask not numeral";
val public_th = timed "public_literal_binding"
  (fn () => REWRITE_RULE [source_def] result_th);
val public_pipeline = list_mk_comb (``raw_pipeline``,
  [bases,c,depth,source_literal]);
val public_compact = list_mk_comb (``raw_compact``,
  [bases,c,depth,source_literal]);
val _ = require (aconv (concl public_th)
  (mk_eq(public_compact,masks_option))) "changed compact public input";
val semantic_th = timed "bind_sign_semantics" (fn () =>
  REWRITE_RULE [public_th]
    (SPECL [bases,c,depth,source_literal] raw_compact_correct));
val _ = require (aconv (concl semantic_th)
  (list_mk_comb (``raw_sign_summary_rel``,[public_pipeline,masks_option])))
  "unexpected sign semantics statement";
val _ = audit "compact_integer_pipeline" public_th;
val _ = audit "compact_sign_semantics" semantic_th;
val _ = timed "save_primary" (fn () =>
  (save_thm("compact_integer_pipeline",public_th);
   save_thm("compact_sign_semantics",semantic_th)));
val _ = print "COMPACT_PRIMARY_COMPLETE,4,129,1032\n";

(* All full-result readback and validation are AFTER primary acceptance. *)
val old_dir = OS.Path.mkCanonical (OS.Path.mkAbsolute
  {path="../raw-state-handoff",relativeTo=OS.FileSys.getDir()});
val _ = timed "validation_load_old_full_theory" (fn () =>
  (Meta.qquse (OS.Path.concat(old_dir,"HandoffFusedTheory.sig"));
   Meta.qquse (OS.Path.concat(old_dir,"HandoffFusedTheory.sml"))));
val old_full = DB.fetch "HandoffFused" "final_integer_pipeline";
val _ = audit "old_full_readback" old_full;
val _ = require (aconv (lhs (concl old_full)) public_pipeline)
  "old full theorem has different input";
val old_masks_th = evaluate "validation_old_full_mask"
  (mk_comb (``raw_compact_of``,rhs (concl old_full)));
val from_full = timed "validation_compose_old_full" (fn () =>
  TRANS (AP_TERM ``raw_compact_of`` old_full) old_masks_th);
val compact_expanded = timed "validation_expand_compact" (fn () =>
  REWRITE_RULE [raw_compact_def] public_th);
val _ = require (aconv (concl from_full) (concl compact_expanded))
  "compact mask differs from old full result";
val _ = audit "old_full_derived_mask" from_full;
val _ = save_thm("old_full_derived_mask",from_full);
val _ = print "COMPACT_MATCHED_OLD_FULL_SIGNS,1032\n";

(* Rejection is asserted only where the compact contract must differ. *)
val _ = false_claim "base_label" (mk_eq(list_mk_comb (``raw_compact``,
  [``[2;2;3;41;61;10004;262144;265800]:num list``,c,depth,source_name]),masks_option));
val _ = false_claim "denominator" (mk_eq(list_mk_comb (``raw_compact``,
  [bases,``62:int``,depth,source_name]),masks_option));
val _ = false_claim "depth" (mk_eq(list_mk_comb (``raw_compact``,
  [bases,c,``127:num``,source_name]),masks_option));
val wrong_masks = listSyntax.mk_list
  (mk_comb (``SUC``,hd mask_terms)::tl mask_terms,``:num``);
val _ = false_claim "final_mask" (mk_eq(compact,optionSyntax.mk_some wrong_masks));
val _ = true_claim "negative_ties"
  ``round_scaled 2 (~5) = ~2 /\ round_scaled 2 5 = 3``;
val _ = true_claim "sign_codes"
  ``raw_sign_code (~1) = 0 /\ raw_sign_code 0 = 1 /\ raw_sign_code 1 = 2``;
val _ = timed "theory_export" export_theory;
val _ = print "COMPACT_DONE\n";
