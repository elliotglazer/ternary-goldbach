# Connections still required for the actual raw phase

The Horner module addresses integer rounding against an explicitly defined ideal
recurrence. It does not by itself identify that recurrence with an exponential,
prove the actual input phase range, normalize the output or close a source block.
The final raw contract remains the one in source-log-range/NEXT_PHASE_CONNECTION.md.

## Actual phase and its domain

Let q = source_raw_log129 k x, qhat = real_of_int q / 2^129,
theta = -(5/64)*ln(&x), and u = real_of_int(-5*q)/2^135.
First prove u=-(5/64)*qhat using the actual integer casts and exact grid identity.
The accepted raw-log theorem then gives abs(u-theta)<=(5/64)*2^-128.

The domain source_log_domain x 1 k gives x>=1 and 1<=x/2^k<=2.
The accepted slr_log_decomposition gives

    ln(&x) = &k*ln(2) + ln(&x / &(2**k)).

The inspected transcTheory.LN_LE is the useful form
0<=v ==> ln(1+v)<=v. At v=1 it gives ln(2)<=1. LN_MONO_LE and LN_1 bound the
reduced logarithm between 0 and ln(2). With k<=18 this yields 0<=ln(&x)<=19,
without requiring a new variable-exponent monotonicity proof. Thus
abs(theta)<=95/64, and the actual log error leaves abs(u)<=2 with ample margin.
These are proposed proof steps, not yet completed HOL theorems.

## Analytic identity and Taylor remainder

The ideal Horner recurrence must be identified with the degree-72 complex
Taylor polynomial. An append lemma at general starting index can use the
coefficient k!/(k+j)!, followed by specialization at k=0. Every factorial
denominator is positive; the exact index shifts must be proved.

The inspected MCLAURIN_ALL_LE theorem accepts an explicit sequence of real
derivatives. One possible instantiation for the two coordinates uses
cos(t+n*pi/2) and sin(t+n*pi/2). The angle-addition identities at pi/2 turn
their derivatives into the successor terms. This avoids four separate cases
for n modulo 4, but still needs the derivative and coefficient identities.
SIN_BOUND and COS_BOUND bound the derivative values by 1 in absolute value.
Separate remainder points for the two coordinates are sufficient.

For abs(u)<=2 and 73 terms, each coordinate remainder is bounded by
2^73/73!, giving the coarse complex modulus bound 2^74/73!. The finite rational
comparison belongs in HOL once the generic remainder is connected to seh_ideal.

The existing complex EXP_IMAGINARY identifies the sine/cosine pair with the
unit imaginary exponential. MODU_UNIT supplies unit modulus, and
COMPLEX_MUL_ARG or COMPLEX_EXP_ADD supplies the exact time recurrence. These
facts do not establish the numerical approximation on their own.

## Normalization and output rounding

Convert the unscaled integer Horner error to an error divided by 2^131.
Then prove the actual source_regrid 9 error on output grid 2^122 using the
accepted coordinate rounding theorem and a complex modulus bound. The state
consumer needs the output grid, not the internal grid.

A coordinate mean-value bound gives a sufficient coarse phase perturbation
bound 2*abs(u-theta). Combining the actual-input phase bound, ideal Taylor
remainder, Horner rounding and final regrid gives the existing proposed budget

    9/2^131 + 2^74/73! + 2*(5/64)*2^-128 + 2^-122 < 2^-120.

The EM producer has separate period reduction, pi approximation and two regrids.
None of the raw-only range facts or rounding constants silently discharges it.
No precision reduction, iteration reduction or campaign runtime saving is claimed.
