open HolKernel Parse boolLib bossLib;
open HandoffMaterializedTheory HandoffFusedTheory;
val left = DB.fetch "HandoffMaterialized" "final_integer_pipeline";
val right = DB.fetch "HandoffFused" "final_integer_pipeline";
val _ = if null (hyp left) andalso null (hyp right) andalso
  aconv (concl left) (concl right) then
  print "HANDOFF_MATCHED_EXACT_FINAL_THEOREM,516\n"
  else raise Fail "mismatched handoff final theorem";
