open HolKernel Parse boolLib bossLib SourceInitialTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceInitial" :: Theory.ancestry "SourceInitial";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_INITIAL_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("si_grid_factor",si_grid_factor,
  ``!a b:num. a <= b ==> (2:num) ** b = 2 ** a * 2 ** (b-a)``),
 ("si_shift_value",si_shift_value,
  ``!r a b:num. a <= b ==>
    source_pair_value (2 ** b) ((&r:int) * &(2 ** (b-a)),0) =
      complex_of_real (&r / (2:real) pow a)``),
 ("source_initial_success",source_initial_success,
  ``!A D a b initial. source_initial A D a b = SOME initial ==>
    0 < D /\ D <= A /\ a <= b /\
    initial = ((&(source_inverse_root A D (2 ** a)):int) * &(2 ** (b-a)),0)``),
 ("source_initial_value",source_initial_value,
  ``!A D a b initial. source_initial A D a b = SOME initial ==>
    source_pair_value (2 ** b) initial =
      complex_of_real (&(source_inverse_root A D (2 ** a)) / (2:real) pow a)``),
 ("source_amplitude_norm",source_amplitude_norm,
  ``!A D:num. 0 < D /\ D <= A ==>
    modu (complex_of_real (sqrt ((&D:real) / &A))) <= 1``),
 ("source_initial_accuracy",source_initial_accuracy,
  ``!A D a b initial. source_initial A D a b = SOME initial ==>
    modu (source_pair_value (2 ** b) initial -
      complex_of_real (sqrt ((&D:real) / &A))) < 1 / (2:real) pow a /\
    modu (complex_of_real (sqrt ((&D:real) / &A))) <= 1``),
 ("source_amplitude_inverse_sqrt",source_amplitude_inverse_sqrt,
  ``!A D:num. 0 < A /\ 0 < D ==>
    complex_of_real (sqrt ((&D:real) / &A)) =
      complex_of_real (1 / sqrt ((&A:real) / &D))``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_INITIAL_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_INITIAL_EXACT_AUDIT_DONE\n";
