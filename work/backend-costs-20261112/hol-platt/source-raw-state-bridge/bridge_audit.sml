open HolKernel Parse boolLib bossLib SourceRawStateBridgeTheory;
fun require ok msg = if ok then () else raise Fail msg;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy))
  ("SourceRawStateBridge" :: Theory.ancestry "SourceRawStateBridge"));
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val roots = [
 ("srb_target_step", srb_target_step,
  ``!x n. 0<x ==> srb_target x (5 * (&(SUC n):real)/64) =
    srb_target x (5 * (&n:real)/64) * (cos (~(5/64)*ln (&x)),sin (~(5/64)*ln (&x)))``),
 ("srb_log2_gate", srb_log2_gate,
  ``!x:num. 0<x /\ x<2**19 ==> source_log_domain x 1 (logroot$LOG 2 x) /\ logroot$LOG 2 x <= 18``),
 ("source_raw_state_from_domain", source_raw_state_from_domain,
  ``!k x initial. source_log_domain x 1 k /\ k <= 18 /\ source_raw_initial x = SOME initial ==>
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 k x)) j) -
      srb_target x (5 * (&j:real)/64)) < 1 / (2:real) pow 96``),
 ("c10004_raw_state_error", c10004_raw_state_error,
  ``!x:num. 1<=x /\ x<=10004 ==> ?initial. source_raw_initial x = SOME initial /\
    !j. j <= 90000 ==> modu (source_pair_value (2**120)
      (source_state (2**122) initial (source_raw_step (source_raw_log129 (logroot$LOG 2 x) x)) j) -
      complex_exp ((~(1/2),~(5*(&j:real)/64)) * complex_of_real (ln (&x)))) < 1 / (2:real) pow 96``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": different conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_RAW_STATE_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print ("SOURCE_RAW_STATE_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val _ = print "SOURCE_RAW_STATE_AUDIT_DONE\n";
