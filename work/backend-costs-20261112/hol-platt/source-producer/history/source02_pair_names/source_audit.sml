open HolKernel Parse boolLib bossLib SourceArithmeticTheory;
fun require b msg = if b then () else raise Fail msg;
val allowed = ["bool.BOOL_CASES_AX", "bool.ETA_AX", "bool.SELECT_AX", "bool.INFINITY_AX"];
val ancestry = "SourceArithmetic" :: Theory.ancestry "SourceArithmetic";
val axs = List.concat (map (fn thy => map (fn (name,_) => thy ^ "." ^ name)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected ancestry axiom";
val _ = print ("SOURCE_ANCESTRY," ^ String.concatWith ";" ancestry ^ "\n");
val _ = print ("SOURCE_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
  ("source_log_checked_domain", source_log_checked_domain,
   ``!S n out_div l2 k A D q.
       source_log_checked S n out_div l2 k A D = SOME q ==>
       0 < S /\ 0 < out_div /\ source_log_domain A D k``),
  ("source_pool_tick_length", source_pool_tick_length,
   ``!step_scale entries. LENGTH (source_pool_tick step_scale entries) = LENGTH entries``),
  ("source_mul_residuals", source_mul_residuals,
   ``!step_scale ur ui vr vi. 0 < (&step_scale:int) ==>
       -(&step_scale) <= 2*((ur*vr-ui*vi) - FST (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) /\
       2*((ur*vr-ui*vi) - FST (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) < &step_scale /\
       -(&step_scale) <= 2*((ur*vi+ui*vr) - SND (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) /\
       2*((ur*vi+ui*vr) - SND (source_mul step_scale (ur,ui) (vr,vi))*(&step_scale)) < &step_scale``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,axioms) = Tag.dest_tag (tag th)
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (List.all (fn x => x="DISK_THM") oracles) (name ^ ": unexpected oracle")
  in print ("SOURCE_THEOREM," ^ name ^ ",oracles=" ^ String.concatWith ";" oracles ^
       ",axiom_tags=" ^ String.concatWith ";" axioms ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_AUDIT_DONE_GENERIC_ONLY_NO_ANALYTIC_PRODUCER\n";
