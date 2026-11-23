open HolKernel Parse boolLib bossLib SourcePhaseRangeTheory;
fun require b message = if b then () else raise Fail message;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy))
  ("SourcePhaseRange" :: Theory.ancestry "SourcePhaseRange"));
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val roots = [
 ("spr_grid", spr_grid,
  ``!q:int. real_of_int (~5*q) / (&((2:num)**135):real) =
    ~(5/64) * (real_of_int q / (2:real) pow 129)``),
 ("spr_log_range", spr_log_range,
  ``!k x:num. source_log_domain x 1 k /\ k <= 18 ==> 0 <= ln (&x) /\ ln (&x) <= 19``),
 ("source_raw_phase_error", source_raw_phase_error,
  ``!k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    abs (real_of_int (~5 * source_raw_log129 k x) / (&((2:num)**135):real) -
      (~(5/64) * ln (&x))) <= (5/64) * (1 / (2:real) pow 128)``),
 ("source_raw_phase_range", source_raw_phase_range,
  ``!k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    abs (real_of_int (~5 * source_raw_log129 k x) / (&((2:num)**135):real)) <= 2``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_PHASE_RANGE_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print ("SOURCE_PHASE_RANGE_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val _ = print "SOURCE_PHASE_RANGE_AUDIT_DONE\n";
