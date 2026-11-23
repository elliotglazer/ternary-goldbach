(* Readback only: no numerical wrapper, evaluator or theorem re-export. *)
open HolKernel Parse boolLib bossLib RawStateHandoffTheory;
(* HFS maps logical Theory paths to .hol/objs exactly once. *)
val export_dir = OS.Path.mkCanonical
  (OS.Path.mkAbsolute {path="..", relativeTo=OS.FileSys.getDir()});
fun load_export name = Meta.qquse (OS.Path.concat(export_dir,name));
val _ = print ("HANDOFF_LOGICAL_EXPORT_DIR," ^ export_dir ^ "\n");
val _ = load_export "HandoffMaterializedTheory.sig";
val _ = load_export "HandoffMaterializedTheory.sml";
val _ = load_export "HandoffFusedTheory.sig";
val _ = load_export "HandoffFusedTheory.sml";
fun require b msg = if b then () else raise Fail msg;
val left = DB.fetch "HandoffMaterialized" "final_integer_pipeline";
val right = DB.fetch "HandoffFused" "final_integer_pipeline";
val allowed_axioms = ["bool.ETA_AX","bool.SELECT_AX",
  "bool.INFINITY_AX","bool.BOOL_CASES_AX"];
fun audit thy th =
  let val (oracles,axs) = Tag.dest_tag (tag th)
      val context = List.concat (map (fn t =>
        map (fn (n,_) => t ^ "." ^ n) (DB.axioms t))
        (thy :: Theory.ancestry thy))
  in require (null (hyp th)) "readback theorem has hypotheses";
     require (List.all (fn x => x="DISK_THM") oracles)
       "unexpected readback oracle";
     require (List.all (fn a => List.exists (fn b => a=b)
       allowed_axioms) context) "unexpected readback axiom";
     print ("HANDOFF_READBACK_TAG," ^ thy ^ "," ^
       String.concatWith ";" oracles ^ "," ^
       String.concatWith ";" axs ^ "\n") end;
val _ = audit "HandoffMaterialized" left;
val _ = audit "HandoffFused" right;
val _ = require (is_eq (concl left) andalso is_eq (concl right))
  "readback result is not equality";
val _ = require (aconv (concl left) (concl right))
  "mismatched full final theorem";
val result = optionSyntax.dest_some (rhs (concl left));
val (rows,_) = listSyntax.dest_list result;
val _ = require (length rows = 4) "readback row count";
val _ = List.app (fn row =>
  let val (pairs,_) = listSyntax.dest_list row
  in require (length pairs = 129) "readback row length";
     List.app (fn pair => ignore (pairSyntax.dest_pair pair)) pairs
  end) rows;
val _ = print "HANDOFF_MATCHED_EXACT_FINAL_THEOREM,516\n";
val _ = print "HANDOFF_READBACK_ONLY_DONE\n";
