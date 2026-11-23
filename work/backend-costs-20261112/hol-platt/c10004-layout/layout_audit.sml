open HolKernel Parse boolLib bossLib C10004LayoutTheory;
fun require b msg = if b then () else raise Fail msg;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val axs = List.concat (map (fn thy => map (fn (name,_) => thy ^ "." ^ name)
  (DB.axioms thy)) ("C10004Layout" :: Theory.ancestry "C10004Layout"));
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected axiom";
val _ = print ("C10004_LAYOUT_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [("layout_checked",layout_checked),
 ("layout_old_properties",layout_old_properties),
 ("layout_tensor_properties",layout_tensor_properties),
 ("layout_exactly_once",layout_exactly_once),
 ("layout_permutation",layout_permutation),
 ("layout_preserves_residue",layout_preserves_residue),
 ("tensor_source_residue",tensor_source_residue),
 ("fine_cell_checked",fine_cell_checked)];
val _ = List.app (fn (name,th) =>
  let val (oracles,axioms) = Tag.dest_tag (tag th)
      val _ = require (null (hyp th)) "open layout theorem"
      val _ = require (List.all (fn x => x="DISK_THM") oracles) "unexpected oracle"
  in print ("C10004_LAYOUT_THEOREM," ^ name ^ ",oracles=" ^
       String.concatWith ";" oracles ^ ",axioms=" ^ String.concatWith ";" axioms ^
       "," ^ Parse.thm_to_string th ^ "\n") end) roots;
val _ = print "C10004_LAYOUT_AUDIT_DONE_NO_CHARACTER_DFT_ANALYTICS\n";
