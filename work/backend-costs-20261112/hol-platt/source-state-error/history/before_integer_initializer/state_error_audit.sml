open HolKernel Parse boolLib bossLib SourceStateErrorTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceStateError" :: Theory.ancestry "SourceStateError";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_STATE_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("ss_modu_triangle",ss_modu_triangle,
  ``!z w:complex. modu (z+w) <= modu z + modu w``),
 ("ss_source_mul_eq",ss_source_mul_eq,
  ``!scale u v. source_mul scale u v = four_product_round (&scale) u v``),
 ("ss_source_mul_error",ss_source_mul_error,
  ``!grid scale u v. 0 < grid /\ 0 < scale ==>
    modu (source_pair_value grid (source_mul scale u v) -
          source_pair_value grid u * source_pair_value scale v) <= 1 / (&grid:real)``),
 ("ss_product_error",ss_product_error,
  ``!u v z w:complex. !err eps:real.
    0 <= err /\ 0 <= eps /\ modu z <= 1 /\ modu w = 1 /\
    modu (u-z) <= err /\ modu (v-w) <= eps ==>
    modu (u*v-z*w) <= (1+eps)*err + eps``),
 ("ss_source_update_error",ss_source_update_error,
  ``!grid scale u v z w err eps.
    0 < grid /\ 0 < scale /\ 0 <= err /\ 0 <= eps /\
    modu z <= 1 /\ modu w = 1 /\
    modu (source_pair_value grid u-z) <= err /\
    modu (source_pair_value scale v-w) <= eps ==>
    modu (source_pair_value grid (source_mul scale u v)-z*w)
      <= (1+eps)*err + eps + 1 / (&grid:real)``),
 ("ss_envelope_nonneg",ss_envelope_nonneg,
  ``!initialError stepError roundError.
    0 <= initialError /\ 0 <= stepError /\ 0 <= roundError ==>
    !n. 0 <= source_error_envelope initialError stepError roundError n``),
 ("ss_exact_state_norm",ss_exact_state_norm,
  ``!exact:num->complex. !w:complex.
    modu (exact 0) <= 1 /\ modu w = 1 /\
    (!n. exact (SUC n) = exact n * w) ==>
    !n. modu (exact n) <= 1``),
 ("source_state_error_from_initial_and_step",source_state_error_from_initial_and_step,
  ``!grid scale initial step (exact:num->complex) w initialError stepError.
    0 < grid /\ 0 < scale /\ 0 <= initialError /\ 0 <= stepError /\
    modu (exact 0) <= 1 /\ modu w = 1 /\
    (!n. exact (SUC n) = exact n * w) /\
    modu (source_pair_value grid initial-exact 0) <= initialError /\
    modu (source_pair_value scale step-w) <= stepError ==>
    !n. modu (source_pair_value grid (source_state scale initial step n)-exact n)
      <= source_error_envelope initialError stepError (1 / (&grid:real)) n``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_STATE_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_STATE_EXACT_AUDIT_DONE_CONDITIONAL_PRODUCERS\n";
