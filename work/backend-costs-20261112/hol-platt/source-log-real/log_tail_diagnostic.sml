load "SourceLogTailTheory";
open HolKernel Parse boolLib bossLib SourceLogTailTheory;
val _ = ((
print "AUDIT_PARSE_BEGIN,sl_log_difference_diff\n";
let val expected = ``  !x:real. 0 <= x /\ x < 1 ==>
    ((\y:real. ln (1+y) - ln (1-y)) diffl (2 / (1-x pow 2))) x`` in
 if aconv(concl sl_log_difference_diff) expected andalso null(hyp sl_log_difference_diff) then print "AUDIT_PARSE_PASS,sl_log_difference_diff\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_odd_term_diff\n";
let val expected = ``  !n:num. !x:real.
    ((\y:real. 2 * y pow (2*n+1) / &(2*n+1)) diffl
      (2 * x pow (2*n))) x`` in
 if aconv(concl sl_odd_term_diff) expected andalso null(hyp sl_odd_term_diff) then print "AUDIT_PARSE_PASS,sl_odd_term_diff\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_log_partial_zero\n";
let val expected = ``  !n:num. sl_log_partial n 0 = 0`` in
 if aconv(concl sl_log_partial_zero) expected andalso null(hyp sl_log_partial_zero) then print "AUDIT_PARSE_PASS,sl_log_partial_zero\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_remainder_zero\n";
let val expected = ``  !n:num. sl_remainder n 0 = 0`` in
 if aconv(concl sl_remainder_zero) expected andalso null(hyp sl_remainder_zero) then print "AUDIT_PARSE_PASS,sl_remainder_zero\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_remainder_suc\n";
let val expected = ``  !n:num. sl_remainder (SUC n) =
    (\x:real. sl_remainder n x - 2 * x pow (2*n+1) / &(2*n+1))`` in
 if aconv(concl sl_remainder_suc) expected andalso null(hyp sl_remainder_suc) then print "AUDIT_PARSE_PASS,sl_remainder_suc\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_remainder_diff\n";
let val expected = ``  !n:num. !x:real. 0 <= x /\ x < 1 ==>
    (sl_remainder n diffl (2 * x pow (2*n) / (1-x pow 2))) x`` in
 if aconv(concl sl_remainder_diff) expected andalso null(hyp sl_remainder_diff) then print "AUDIT_PARSE_PASS,sl_remainder_diff\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_remainder_mvt\n";
let val expected = ``  !n:num. !v:real. 0 < v /\ v <= 1/3 ==>
    ?c:real. 0 < c /\ c < v /\
      sl_remainder n v = v * (2 * c pow (2*n) / (1-c pow 2))`` in
 if aconv(concl sl_remainder_mvt) expected andalso null(hyp sl_remainder_mvt) then print "AUDIT_PARSE_PASS,sl_remainder_mvt\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_remainder_derivative_bound\n";
let val expected = ``  !n:num. !x:real. 0 <= x /\ x <= 1/3 ==>
    0 <= 2 * x pow (2*n) / (1-x pow 2) /\
    2 * x pow (2*n) / (1-x pow 2) <= (9/4) * (1/3) pow (2*n)`` in
 if aconv(concl sl_remainder_derivative_bound) expected andalso null(hyp sl_remainder_derivative_bound) then print "AUDIT_PARSE_PASS,sl_remainder_derivative_bound\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_remainder_bound\n";
let val expected = ``  !n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (sl_remainder n v) <= (9/4) * (1/3:real) pow (2*n+1)`` in
 if aconv(concl sl_remainder_bound) expected andalso null(hyp sl_remainder_bound) then print "AUDIT_PARSE_PASS,sl_remainder_bound\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_log_partial_error\n";
let val expected = ``  !n:num. !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial n v)
      <= (9/4) * (1/3:real) pow (2*n+1)`` in
 if aconv(concl sl_log_partial_error) expected andalso null(hyp sl_log_partial_error) then print "AUDIT_PARSE_PASS,sl_log_partial_error\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_log_partial45_error\n";
let val expected = ``  !v:real. 0 <= v /\ v <= 1/3 ==>
    abs (ln ((1+v)/(1-v)) - sl_log_partial 45 v) <= 1 / (2:real) pow 135`` in
 if aconv(concl sl_log_partial45_error) expected andalso null(hyp sl_log_partial45_error) then print "AUDIT_PARSE_PASS,sl_log_partial45_error\n" else raise Fail "exact root mismatch" end;
print "AUDIT_PARSE_BEGIN,sl_log_two45_error\n";
let val expected = ``  abs (ln 2 - sl_log_partial 45 (1/3)) <= 1 / (2:real) pow 135`` in
 if aconv(concl sl_log_two45_error) expected andalso null(hyp sl_log_two45_error) then print "AUDIT_PARSE_PASS,sl_log_two45_error\n" else raise Fail "exact root mismatch" end;
print "ALL_AUDIT_PARSE_CHECKS_PASS\n"; OS.Process.exit OS.Process.success)
 handle ex => (print("AUDIT_PARSE_FAILURE,"^General.exnMessage ex^"\n"); OS.Process.exit OS.Process.failure));
