open HolKernel Parse boolLib bossLib SourceInverseRootTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceInverseRoot" :: Theory.ancestry "SourceInverseRoot";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_INVERSE_ROOT_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("source_inverse_root_adjacent_squares",source_inverse_root_adjacent_squares,
  ``!A D S:num. 0 < A ==>
    (source_inverse_root A D S) ** 2 * A <= D*S*S /\
    D*S*S < (SUC (source_inverse_root A D S)) ** 2 * A``),
 ("source_sqrt_bracket",source_sqrt_bracket,
  ``!r:num. !t:real.
    0 <= t /\ (&r) pow 2 <= t /\ t < (&r+1) pow 2 ==>
    &r <= sqrt t /\ sqrt t < &r+1``),
 ("source_inverse_root_scaled_enclosure",source_inverse_root_scaled_enclosure,
  ``!A D S:num. 0 < A ==>
    &(source_inverse_root A D S) <= &S * sqrt ((&D:real)/&A) /\
    &S * sqrt ((&D:real)/&A) < &(source_inverse_root A D S)+1``),
 ("source_inverse_root_real_error",source_inverse_root_real_error,
  ``!A D S:num. 0 < A /\ 0 < S ==>
    abs (&(source_inverse_root A D S)/&S - sqrt ((&D:real)/&A)) < 1 / &S``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_INVERSE_ROOT_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_INVERSE_ROOT_EXACT_AUDIT_DONE\n";
