open HolKernel Parse boolLib bossLib C10004TraversalRefinementTheory;
fun require b message = if b then () else raise Fail message;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val ancestry = "C10004TraversalRefinement" :: Theory.ancestry "C10004TraversalRefinement";
val axs = List.concat (map (fn thy => map (fn (name,_) => thy ^ "." ^ name)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected ancestry axiom";
val _ = print ("REFINEMENT_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("ftr_genlist_pair",ftr_genlist_pair,
  ``!xs. GENLIST (\i. tx_pair i xs) (LENGTH xs) = xs``),
 ("ftr_chunks_any",ftr_chunks_any,
  ``!n width xs. LENGTH xs = n*width ==>
  ft_chunks n width xs = SOME
    (GENLIST (\i. GENLIST (\j. tx_pair (width*i+j) xs) width) n)``),
 ("ftr_transpose_any",ftr_transpose_any,
  ``!width rows. EVERY (\row. LENGTH row = width) rows ==>
  ft_transpose width rows = SOME
    (GENLIST (\j. GENLIST (\i. tx_pair j (tx_row i rows)) (LENGTH rows)) width)``),
 ("ftr_concat_shape",ftr_concat_shape,
  ``!width rows. EVERY (\row. LENGTH row = width) rows ==>
  ft_concat rows = tx_flatten (LENGTH rows) width rows``),
 ("ft_tensor_refines",ft_tensor_refines,
  ``!cache xs. LENGTH xs = 4800 ==>
    ft_tensor cache xs = SOME (tx_tensor_selected cache xs)``),
 ("ft_checked_refines",ft_checked_refines,
  ``!roots xs. ft_checked roots xs = tx_checked roots xs``)
 ];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,axioms) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open theorem")
      val _ = require (List.all (fn x => x="DISK_THM") oracles)
        (name ^ ": unexpected oracle")
      val _ = require (null axioms) (name ^ ": nonempty axiom tags")
  in print ("REFINEMENT_THEOREM," ^ name ^ ",oracles=" ^
    String.concatWith ";" oracles ^ ",axioms=" ^ String.concatWith ";" axioms ^
    "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "C10004_TRAVERSAL_REFINEMENT_AUDIT_DONE_GENERIC_ONLY\n";
