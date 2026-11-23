# Range reduction for the actual raw logarithm

The Horner/center result must next be joined to the existing SourceArithmetic
definitions source_log_domain, source_log_from_two and source_raw_log129. Do
not replace the program by an arbitrary supplied logarithm approximation.

For K = 2^k*D, the actual source_log_domain gate supplies D > 0 and
K <= A <= 2*K. Prove K > 0, A > 0, A+K > 0 and 3*(A-K) <= A+K using natural
subtraction under the stated inequality. The reduced argument is

    v = (&(A-K):real) / &(A+K),

and the exact ratio identity is (1+v)/(1-v) = &A/&K. The logarithm identity is

    ln (&A / &D) = &k * ln 2 + ln (&A / &K).

Use the existing positive-input LN_DIV, LN_MUL and logarithm-of-power results,
with the actual natural-to-real cast identities and all positivity conditions.

At grid S, each actual 45-term center, including the computed ln(2) center,
has error at most e = 7/(4*S) + 2^-135. The integer numerator

    &k * source_log_center S 1 3 45
      + source_log_center S (A-K) (A+K) 45

therefore has normalized logarithm error at most (k+1)*e. Prove the integer sum
and cast equalities and triangle estimate; an assumed log2 approximation is
not the final contract.

For source_raw_log129, S=2^137, D=1 and the output divisor is 256. Apply the
accepted round_scaled_coordinate_error to the actual final rounding, at output
grid 2^129. Prove 256*2^129=2^137. This adds at most 2^-130. For k <= 18 the
exact rational bound is

    19 * (7/(4*2^137) + 2^-135) + 2^-130 < 2^-128.

The required resulting theorem is the accuracy of the actual
source_raw_log129 k x, normalized by 2^129, under source_log_domain x 1 k and
k <= 18. Every later concrete source input must establish that gate, including
any internally chosen exponent. Exponential phase production, exact complex
target identities and the complete production benchmark remain required.

The generic estimates do not measure numerical throughput or justify an
aggregate campaign discount. Retain the existing fixed precision and term
schedule until a separately checked and measured replacement warrants changing it.
