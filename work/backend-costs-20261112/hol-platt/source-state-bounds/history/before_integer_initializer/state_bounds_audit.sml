open HolKernel Parse boolLib bossLib SourceStateBoundsTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceStateBounds" :: Theory.ancestry "SourceStateBounds";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_BOUNDS_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("source_envelope_linear_prefix",source_envelope_linear_prefix,
  ``!initialError delta (N:num).
    0 <= delta /\ initialError + 3 * &N * delta <= 1 ==>
    !n. n <= N ==>
      source_error_envelope initialError delta delta n
        <= initialError + 3 * &n * delta``),
 ("source_raw_envelope_lt_dyadic96",source_raw_envelope_lt_dyadic96,
  ``!n. n <= 90000 ==>
    source_error_envelope (1 / (2:real) pow 98)
      (1 / (2:real) pow 120) (1 / (2:real) pow 120) n
      < 1 / (2:real) pow 96``),
 ("source_raw_state_error_lt_dyadic96",source_raw_state_error_lt_dyadic96,
  ``!initial step (exact:num->complex) (w:complex).
    modu (exact 0) <= 1 /\ modu w = 1 /\
    (!n. exact (SUC n) = exact n * w) /\
    modu (source_pair_value (2 ** 120) initial-exact 0) <= 1 / (2:real) pow 98 /\
    modu (source_pair_value (2 ** 122) step-w) <= 1 / (2:real) pow 120 ==>
    !n. n <= 90000 ==>
      modu (source_pair_value (2 ** 120)
        (source_state (2 ** 122) initial step n)-exact n) < 1 / (2:real) pow 96``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_BOUNDS_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_BOUNDS_EXACT_AUDIT_DONE_CONDITIONAL_PRODUCERS\n";
