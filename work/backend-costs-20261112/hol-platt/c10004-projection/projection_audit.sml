open HolKernel Parse boolLib bossLib C10004ProjectionTheory;
fun require b message = if b then () else raise Fail message;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val ancestry = "C10004Projection" :: Theory.ancestry "C10004Projection";
val axs = List.concat (map (fn thy => map (fn (name,_) => thy ^ "." ^ name)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected ancestry axiom";
val _ = print ("PROJECTION_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [("txp_stage2",txp_stage2),("txp_stage40",txp_stage40),
  ("txp_stage60",txp_stage60),
  ("tx_tensor_selected_project_all",tx_tensor_selected_project_all),
  ("tx_tensor_selected_project",tx_tensor_selected_project)];
val expected = ``!cache xs.
  tx_tensor_selected cache xs = tx_project (tx_tensor_full cache xs)``;
val _ = require (aconv (concl tx_tensor_selected_project_all) expected)
  "changed universal projection conclusion";
val _ = List.app (fn (name,th) =>
  let val (oracles,axioms) = Tag.dest_tag (tag th)
      val _ = require (null (hyp th)) (name ^ ": open theorem")
      val _ = require (List.all (fn x => x="DISK_THM") oracles)
        (name ^ ": unexpected oracle")
  in print ("PROJECTION_THEOREM," ^ name ^ ",oracles=" ^
      String.concatWith ";" oracles ^ ",axioms=" ^ String.concatWith ";" axioms ^
      "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "C10004_PROJECTION_AUDIT_DONE_GENERIC_ONLY\n";
