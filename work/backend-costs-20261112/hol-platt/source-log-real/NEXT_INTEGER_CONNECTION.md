# Connect the analytic tail to the actual integer logarithm

The analytic tail alone does not certify `SourceArithmetic.source_log_horner`,
`source_log_center`, or `source_raw_log129`. The next module must consume the
actual definitions from the corrected SourceArithmetic theory and the accepted
`round_scaled_real_error` theorem from RawPairRound. The original failed
RawPairRound candidate in the analytic staging directory must not shadow the
accepted helper; retain the explicit PRE_INCLUDES ordering used by SourceInitial.

Define the real ideal recurrence by

    H v 0 k = 0
    H v (SUC n) k = 1 / &(2*k+1) + v pow 2 * H v n (SUC k).

Prove its relation to the polynomial in SourceLogTail. A useful intermediate
identity, avoiding an additional finite-sum library, is

    H v (SUC n) k = H v n k + v pow (2*n) / &(2*(k+n)+1).

Induction on n with k generalized proves this identity. It then gives

    sl_log_partial n v = 2*v*H v n 0.

For the actual rounded recurrence, prove for all natural grid,A,B,n,k that
`0 < B` and `3*A <= B` imply

    abs (real_of_int (source_log_horner grid A B n k)
         - &grid * H (&A / &B) n k) <= 1.

Do not assume that a supplied integer approximates the logarithm. Instantiate
the actual rounding theorem at the program's denominator
`&(2*k+1) * &B ** 2` and numerator from source_log_horner_def. Prove denominator
positivity, transport the integer numerator into the reals, and identify its
unrounded value with

    &grid / &(2*k+1) + (&A / &B) pow 2 * real_of_int previous.

The induction uses the contraction `(A/B)^2 <= 1/9`, so one half-unit rounding
error plus the propagated error is at most 1/2 + 1/9, hence at most one unit.
The existing integer-pair initializer type repair is a reminder to check actual
program types explicitly before writing any refinement statement.

Then certify source_log_center, including its final rounding. With grid and B
positive and 3*A <= B, the retained compatible contract is

    abs (real_of_int (source_log_center grid A B n) / &grid
         - sl_log_partial n (&A / &B)) <= 7 / (4 * &grid).

The triangle estimate actually gives at most `(1/2 + 2/3)/grid`; the looser 7/4
constant matches the existing planned assembly. Combine the n=45 instance with
sl_log_partial45_error only after proving 0 <= A/B <= 1/3. This yields an actual
reduced-logarithm enclosure, not yet the complete range-reduced producer.

The subsequent assembly must prove the natural-subtraction range gate,
the identity for `(A-2^k*D)/(A+2^k*D)`, the logarithm scaling identity, the actual
ln(2) center, and the final round_scaled regrid. The raw branch has grid 2^137,
45 terms, output divisor 256 and k <= 18. Its target is the actual integer
source_raw_log129 divided by 2^129 approximating ln(x) within 2^-128 under the
actual range gate. Exponential production and the complete source/sign/count
benchmark remain separate obligations.

No timing or campaign discount follows from these generic proofs. The eventual
benchmark must include actual integer production and first formal acceptance,
with inputs, roots, analytic errors and count conditions discharged.
