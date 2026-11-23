open HolKernel Parse boolLib bossLib SourceLogTailTheory;
fun require b s = if b then () else raise Fail s;
val allowed = ["bool.ETA_AX","bool.SELECT_AX","bool.INFINITY_AX","bool.BOOL_CASES_AX"];
val ancestry = "SourceLogTail" :: Theory.ancestry "SourceLogTail";
val axs = List.concat (map (fn thy => map (fn (n,_) => thy ^ "." ^ n) (DB.axioms thy)) ancestry);
val _ = require (List.all (fn a => List.exists (fn b => a=b) allowed) axs) "unexpected context axiom";
val _ = print ("SOURCE_LOG_TAIL_AXIOMS," ^ String.concatWith ";" axs ^ "\n");
val roots = [
 ("sl_log_difference_diff",sl_log_difference_diff,
  ``!x:real. 0 <= x /\ x < 1 ==>
    ((\y:real. ln (1+y) - ln (1-y)) diffl (2 / (1-x pow 2))) x``),
 ("sl_odd_term_diff",sl_odd_term_diff,
  ``!n:num. !x:real.
    ((\y:real. 2 * y pow (2*n+1) / &(2*n+1)) diffl
      (2 * x pow (2*n))) x``),
 ("sl_log_partial_zero",sl_log_partial_zero,
  ``!n:num. sl_log_partial n 0 = 0``),
 ("sl_remainder_zero",sl_remainder_zero,
  ``!n:num. sl_remainder n 0 = 0``),
 ("sl_remainder_suc",sl_remainder_suc,
  ``!n:num. sl_remainder (SUC n) =
    (\x:real. sl_remainder n x - 2 * x pow (2*n+1) / &(2*n+1))``),
 ("sl_remainder_diff",sl_remainder_diff,
  ``!n:num. !x:real. 0 <= x /\ x < 1 ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x``),
 ("sl_remainder_mvt",sl_remainder_mvt,
  ``!n:num. !v:real. 0 < v /\ v <= 1/3 ==>
    ?c:real. 0 < c /\ c < v /\
      sl_remainder n v = v * (2 * c pow (2*n) / (1-c pow 2))``),
 ("sl_remainder_derivative_bound",sl_remainder_derivative_bound,
  ``!n:num. !x:real. 0 <= x /\ x <= 1/3 ==>
    0 <= 2 * x pow (2*n) / (1-x pow 2) /\
    2 * x pow (2*n) / (1-x pow 2) <= (9/4) * (1/3) pow (2*n)``),
 ("sl_remainder_bound",sl_remainder_bound,
  ``!n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (sl_remainder n v) <= (9/4) * (1/3:real) pow (2*n+1)``),
 ("sl_log_partial_error",sl_log_partial_error,
  ``!n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial n v)
      <= (9/4) * (1/3:real) pow (2*n+1)``),
 ("sl_log_partial45_error",sl_log_partial45_error,
  ``!v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial 45 v) <= 1 / (2:real) pow 135``),
 ("sl_log_two45_error",sl_log_two45_error,
  ``abs (ln 2 - sl_log_partial 45 (1/3)) <= 1 / (2:real) pow 135``)
];
val _ = List.app (fn (name,th,expected) =>
  let val (oracles,taxs) = Tag.dest_tag (tag th)
      val _ = require (aconv (concl th) expected) (name ^ ": changed conclusion")
      val _ = require (null (hyp th)) (name ^ ": open hypotheses")
      val _ = require (List.all (fn s => s="DISK_THM") oracles) (name ^ ": oracle")
      val _ = require (null taxs) (name ^ ": axiom tags")
  in print ("SOURCE_LOG_TAIL_ROOT," ^ name ^ "," ^ thm_to_string th ^ "\n") end) roots;
val _ = print "SOURCE_LOG_TAIL_EXACT_AUDIT_DONE\n";
