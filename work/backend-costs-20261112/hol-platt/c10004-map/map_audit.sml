open HolKernel Parse boolLib bossLib C10004MapTheory;
fun require b message = if b then () else raise Fail message;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val axioms = List.concat (map (fn thy => map (fn (name,_) => thy ^ "." ^ name)
  (DB.axioms thy)) ("C10004Map" :: Theory.ancestry "C10004Map"));
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axioms)
                "unexpected axiom";
val _ = print ("C10004_AXIOMS," ^ String.concatWith ";" axioms ^ "\n");
val roots = [("finite_map_checked",finite_map_checked),
 ("map_permutation",map_permutation),("unit_map_distinct",unit_map_distinct),
 ("unit_map_complete",unit_map_complete),("coordinates_checked",coordinates_checked),
 ("labels_checked",labels_checked)];
val _ = List.app (fn (name,th) =>
  let val (oracles,axs) = Tag.dest_tag (tag th)
      val _ = require (null (hyp th)) "open theorem"
      val _ = require (List.all (fn x => x="DISK_THM") oracles) "unexpected oracle"
  in print ("C10004_THEOREM," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "C10004_MAP_AUDIT_DONE_NO_CHARACTER_SEMANTICS\n";
