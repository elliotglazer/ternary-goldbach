open HolKernel Parse boolLib bossLib RawPairRoundTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "RawPairRound" :: Theory.ancestry "RawPairRound";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n)
  (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs)
  "unexpected context axiom";
val _ = print ("RAW_PAIR_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("round_scaled_real_residual",round_scaled_real_residual,
  ``!s r:int. 0 < s ==>
    abs (real_of_int r - real_of_int (round_scaled s r) * real_of_int s)
      <= real_of_int s / 2``),
 ("round_scaled_real_error",round_scaled_real_error,
  ``!s r:int. 0 < s ==>
    abs (real_of_int (round_scaled s r) - real_of_int r / real_of_int s)
      <= 1 / 2``),
 ("round_scaled_coordinate_error",round_scaled_coordinate_error,
  ``!g s r:int. 0 < g /\ 0 < s ==>
    abs (real_of_int (round_scaled s r) / real_of_int g -
         real_of_int r / (real_of_int s * real_of_int g))
      <= 1 / (2 * real_of_int g)``),
 ("modu_le_coordinate_sum",modu_le_coordinate_sum,
  ``!z:complex. modu z <= abs (RE z) + abs (IM z)``),
 ("pair_value_exact_product",pair_value_exact_product,
  ``!g s ur ui wr wi:int. 0 < g /\ 0 < s ==>
    pair_value g (ur,ui) * pair_value s (wr,wi) =
    pair_value (s*g) (ur*wr-ui*wi,ur*wi+ui*wr)``),
 ("four_product_coordinate_errors",four_product_coordinate_errors,
  ``!g s ur ui wr wi:int. 0 < g /\ 0 < s ==>
    abs (RE (pair_value g (four_product_round s (ur,ui) (wr,wi)) -
             pair_value g (ur,ui) * pair_value s (wr,wi)))
      <= 1 / (2 * real_of_int g) /\
    abs (IM (pair_value g (four_product_round s (ur,ui) (wr,wi)) -
             pair_value g (ur,ui) * pair_value s (wr,wi)))
      <= 1 / (2 * real_of_int g)``),
 ("four_product_round_error",four_product_round_error,
  ``!g s ur ui wr wi:int. 0 < g /\ 0 < s ==>
    modu (pair_value g (four_product_round s (ur,ui) (wr,wi)) -
          pair_value g (ur,ui) * pair_value s (wr,wi))
      <= 1 / real_of_int g``)];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("RAW_PAIR_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "RAW_PAIR_ROUND_EXACT_AUDIT_DONE_GENERIC_ONLY\n";
