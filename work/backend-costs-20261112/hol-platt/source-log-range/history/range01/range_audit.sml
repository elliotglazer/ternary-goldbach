open HolKernel Parse boolLib bossLib SourceLogRangeTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceLogRange" :: Theory.ancestry "SourceLogRange";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_LOG_RANGE_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val program_types = [
 ("source_raw_log129",type_of ``source_raw_log129``,``:num -> num -> int``),
 ("source_log_from_two",type_of ``source_log_from_two``,``:num -> num -> num -> int -> num -> num -> num -> int``),
 ("slr_numerator",type_of ``slr_numerator``,``:num -> num -> num -> num -> int``),
 ("slr_error_bound",type_of ``slr_error_bound``,``:num -> real``)
];
val _ = List.app (fn (name,actual,expected) =>
  (require (actual = expected) (name ^ ": wrong program type");
   print ("SOURCE_LOG_RANGE_TYPE," ^ name ^ "," ^ type_to_string actual ^ "\n"))) program_types;
val roots = [
 ("slr_domain_bounds",slr_domain_bounds,
  ``!A D k:num. source_log_domain A D k ==>
    0 < D /\ 0 < (2:num) ** k * D /\ 0 < A /\
    0 < A + (2:num) ** k * D /\
    3 * (A - (2:num) ** k * D) <= A + (2:num) ** k * D``),
 ("slr_reduced_ratio",slr_reduced_ratio,
  ``!A D k:num. source_log_domain A D k ==>
    (1 + (&(A - (2:num) ** k * D):real) / &(A + (2:num) ** k * D)) /
    (1 - (&(A - (2:num) ** k * D):real) / &(A + (2:num) ** k * D)) =
    (&A:real) / &((2:num) ** k * D)``),
 ("slr_log_decomposition",slr_log_decomposition,
  ``!A D k:num. source_log_domain A D k ==>
    ln ((&A:real) / &D) = (&k:real) * ln 2 +
      ln ((&A:real) / &((2:num) ** k * D))``),
 ("slr_reduced_center_error",slr_reduced_center_error,
  ``!grid A D k:num. 0 < grid /\ source_log_domain A D k ==>
    abs (real_of_int (source_log_center grid
      (A - (2:num) ** k * D) (A + (2:num) ** k * D) 45) / (&grid:real) -
      ln ((&A:real) / &((2:num) ** k * D))) <= slr_error_bound grid``),
 ("slr_abs_sub_triangle",slr_abs_sub_triangle,
  ``!a b c:real. abs (a-c) <= abs (a-b) + abs (b-c)``),
 ("slr_affine_error",slr_affine_error,
  ``!k a b c d e:real. 0 <= k /\ abs (a-c) <= e /\ abs (b-d) <= e ==>
    abs ((k*a+b)-(k*c+d)) <= (k+1)*e``),
 ("slr_numerator_error",slr_numerator_error,
  ``!grid A D k:num. 0 < grid /\ source_log_domain A D k ==>
    abs (real_of_int (slr_numerator grid k A D) / (&grid:real) -
      ln ((&A:real) / &D)) <= ((&k:real)+1) * slr_error_bound grid``),
 ("slr_from_two_numerator",slr_from_two_numerator,
  ``!grid out_div k A D:num.
    source_log_from_two grid 45 out_div (source_log_center grid 1 3 45) k A D =
      round_scaled (&out_div) (slr_numerator grid k A D)``),
 ("slr_raw_regrid_error",slr_raw_regrid_error,
  ``!k x:num.
    abs (real_of_int (source_raw_log129 k x) / (2:real) pow 129 -
      real_of_int (slr_numerator ((2:num) ** 137) k x 1) / (2:real) pow 137)
      <= 1 / (2:real) pow 130``),
 ("slr_raw_budget",slr_raw_budget,
  ``!k:num. k <= 18 ==>
    ((&k:real)+1) * slr_error_bound ((2:num) ** 137) + 1 / (2:real) pow 130
      < 1 / (2:real) pow 128``),
 ("source_raw_log129_error",source_raw_log129_error,
  ``!k x:num. source_log_domain x 1 k /\ k <= 18 ==>
    abs (real_of_int (source_raw_log129 k x) / (2:real) pow 129 - ln (&x))
      <= 1 / (2:real) pow 128``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_LOG_RANGE_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_LOG_RANGE_EXACT_AUDIT_DONE\n";
