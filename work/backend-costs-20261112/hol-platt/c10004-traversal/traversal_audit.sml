open HolKernel Parse boolLib bossLib C10004TraversalBaseTheory;
fun require b message = if b then () else raise Fail message;
val allowed = ["bool.BOOL_CASES_AX","bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX"];
val ancestry = "C10004TraversalBase" :: Theory.ancestry "C10004TraversalBase";
val axs = List.concat (map (fn thy => map (fn (name,_) => thy ^ "." ^ name)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected ancestry axiom";
val _ = print ("TRAVERSAL_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("ft_take_spec",ft_take_spec, ``!n xs. ft_take n xs =
   if n <= LENGTH xs then SOME (TAKE n xs,DROP n xs) else NONE``),
 ("ft_pairs_genlist",ft_pairs_genlist, ``!n f. ft_pairs (GENLIST f (2*n)) =
   SOME (GENLIST (\j. tx_sub (f (2*j)) (f (2*j+1))) n)``),
 ("ft_chunks_genlist",ft_chunks_genlist, ``!n width f.
   ft_chunks n width (GENLIST f (n*width)) =
   SOME (GENLIST (\i. GENLIST (\j. f (width*i+j)) width) n)``),
 ("ft_heads_tails_genlist",ft_heads_tails_genlist, ``!n columns f.
   ft_heads_tails (GENLIST (\i. GENLIST (f i) (SUC columns)) n) =
   SOME (GENLIST (\i. f i 0) n,
     GENLIST (\i. GENLIST (\j. f i (SUC j)) columns) n)``),
 ("ft_transpose_genlist",ft_transpose_genlist, ``!columns n f.
   ft_transpose columns (GENLIST (\i. GENLIST (f i) columns) n) =
   SOME (GENLIST (\j. GENLIST (\i. f i j) n) columns)``),
 ("ft_concat_flat",ft_concat_flat, ``!rows. ft_concat rows = FLAT rows``),
 ("ft_concat_blocks",ft_concat_blocks, ``!n width f.
   ft_concat (GENLIST (\i. GENLIST (\j. f (width*i+j)) width) n) =
   GENLIST f (n*width)``)
 ];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,axioms) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open theorem")
      val _ = require (List.all (fn x => x="DISK_THM") oracles)
        (name ^ ": unexpected oracle")
      val _ = require (null axioms) (name ^ ": nonempty axiom tags")
  in print ("TRAVERSAL_THEOREM," ^ name ^ ",oracles=" ^
    String.concatWith ";" oracles ^ ",axioms=" ^ String.concatWith ";" axioms ^
    "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "C10004_TRAVERSAL_BASE_AUDIT_DONE_GENERIC_ONLY\n";
