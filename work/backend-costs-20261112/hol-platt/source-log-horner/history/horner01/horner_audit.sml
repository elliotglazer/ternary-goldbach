open HolKernel Parse boolLib bossLib SourceLogHornerTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceLogHorner" :: Theory.ancestry "SourceLogHorner";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_LOG_HORNER_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val program_types = [
 ("source_log_horner",type_of ``source_log_horner``,``:num -> num -> num -> num -> num -> int``),
 ("source_log_center",type_of ``source_log_center``,``:num -> num -> num -> num -> int``),
 ("slh_ideal",type_of ``slh_ideal``,``:real -> num -> num -> real``)
];
val _ = List.app (fn (name,actual,expected) =>
  (require (actual = expected) (name ^ ": wrong program type");
   print ("SOURCE_LOG_HORNER_TYPE," ^ name ^ "," ^ type_to_string actual ^ "\n"))) program_types;
val roots = [
 ("slh_ideal_append",slh_ideal_append,
  ``!n k:num. !v:real.
    slh_ideal v (SUC n) k = slh_ideal v n k + v pow (2*n) / &(2*(k+n)+1)``),
 ("slh_partial_eq_ideal",slh_partial_eq_ideal,
  ``!n:num. !v:real. sl_log_partial n v = 2*v*slh_ideal v n 0``),
 ("slh_ratio_range",slh_ratio_range,
  ``!A B:num. 0 < B /\ 3*A <= B ==>
    0 <= (&A:real) / &B /\ (&A:real) / &B <= 1/3 /\
    0 <= ((&A:real) / &B) pow 2 /\ ((&A:real) / &B) pow 2 <= 1/9``),
 ("slh_nat_square_real",slh_nat_square_real,
  ``!A:num. real_of_int ((&A:int) ** 2) = (&A:real) pow 2``),
 ("slh_den_positive",slh_den_positive,
  ``!B k:num. 0 < B ==> 0 < ((&(2*k+1):int) * &B ** 2)``),
 ("slh_unrounded_value",slh_unrounded_value,
  ``!grid A B k:num. !w:int. 0 < B ==>
    real_of_int ((&grid:int) * &B ** 2 + &(2*k+1) * &A ** 2 * w) /
      real_of_int ((&(2*k+1):int) * &B ** 2) =
    (&grid:real) / &(2*k+1) + ((&A:real) / &B) pow 2 * real_of_int w``),
 ("slh_actual_step_error",slh_actual_step_error,
  ``!grid A B n k:num. 0 < B ==>
    abs (real_of_int (source_log_horner grid A B (SUC n) k) -
      ((&grid:real) / &(2*k+1) + ((&A:real) / &B) pow 2 *
        real_of_int (source_log_horner grid A B n (SUC k)))) <= 1/2``),
 ("slh_affine_contraction",slh_affine_contraction,
  ``!a b c u h:real. 0 <= c /\ c <= 1/9 /\
    abs (u-h) <= 1 /\ abs (a-(b+c*u)) <= 1/2 ==>
    abs (a-(b+c*h)) <= 1``),
 ("source_log_horner_error",source_log_horner_error,
  ``!grid A B:num. 0 < B /\ 3*A <= B ==>
    !n k:num. abs (real_of_int (source_log_horner grid A B n k) -
      (&grid:real) * slh_ideal ((&A:real) / &B) n k) <= 1``),
 ("slh_center_unscaled_error",slh_center_unscaled_error,
  ``!grid A B n:num. 0 < B /\ 3*A <= B ==>
    abs (real_of_int (source_log_center grid A B n) -
      (&grid:real) * sl_log_partial n ((&A:real) / &B)) <= 7/4``),
 ("source_log_center_error",source_log_center_error,
  ``!grid A B n:num. 0 < grid /\ 0 < B /\ 3*A <= B ==>
    abs (real_of_int (source_log_center grid A B n) / (&grid:real) -
      sl_log_partial n ((&A:real) / &B)) <= 7 / (4 * (&grid:real))``),
 ("source_log_center45_error",source_log_center45_error,
  ``!grid A B:num. 0 < grid /\ 0 < B /\ 3*A <= B ==>
    abs (real_of_int (source_log_center grid A B 45) / (&grid:real) -
      ln ((1 + (&A:real) / &B) / (1 - (&A:real) / &B)))
      <= 7 / (4 * (&grid:real)) + 1 / (2:real) pow 135``),
 ("source_log_two45_error",source_log_two45_error,
  ``!grid:num. 0 < grid ==>
    abs (real_of_int (source_log_center grid 1 3 45) / (&grid:real) - ln 2)
      <= 7 / (4 * (&grid:real)) + 1 / (2:real) pow 135``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_LOG_HORNER_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_LOG_HORNER_EXACT_AUDIT_DONE\n";
