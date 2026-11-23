# Choose spectral precision from the certified error budget

2026-11-11. Proposed arithmetic design and exact scalar checks. This is not a new spectral evaluator, a completed FFT correctness proof or an estimate of the number of successful production panels.

The fixed small-EM development uses deliberately large dyadic precisions. Its precision should not become a requirement for every production character and height block. Use a parameterized arithmetic checker: each certificate declares its actual dyadic precision, the checker validates the error budget, and difficult outputs receive separate higher-precision or direct certificates. Easy outputs can retain a shared coarse transform.

## A normalized radix-two error calculation

Let n=2^m. Suppose each exact input has modulus at most B=2^b. Divide the inputs by B before the transform, so their exact moduli are at most one. Use normalized butterflies

    (x,y) -> ((x+w*y)/2, (x-w*y)/2),  |w|=1.

Every exact intermediate then has modulus at most one. This normalization is important: one must not apply the following bound to an unnormalized transform while keeping the same intermediate magnitude assumption.

Let epsilon=2^(-p). Suppose the initial normalized-input error, twiddle error and each completed butterfly-output rounding error are all at most epsilon in complex modulus. A coordinate dyadic grid with step2^(-p-1) permits the required complex rounding error, with a suitable directed enclosure. Actual input enclosures and twiddle enclosures must be certified; declarations of their errors are not sufficient.

If e_j is the maximum error after stage j, then

    e_0 <= epsilon,
    e_(j+1) <= (1+epsilon/2)*e_j + 3*epsilon/2.

To derive it, expand the difference between w*y and its approximation. The two propagated input errors contribute at most (1+epsilon/2)*e_j; the exact |y|<=1 makes the twiddle term at most epsilon/2, and rounding adds epsilon. No approximate twiddle is assumed to have exact modulus one.

For m*epsilon/2<=1/2, the factor (1+epsilon/2)^m is at most2. A binomial expansion bounded by the geometric series gives this without a numerical exponential. Summing the recurrence therefore yields

    e_m <= (2+3*m)*epsilon.

Undoing the normalization and requesting the unnormalized DFT gives error at most

    n*B*(2+3*m)*2^(-p).

The final power-of-two scaling can be represented exactly. If it is rounded again, its error needs a separate term. Likewise, a root-number, gamma or other normalization factor applied later needs its own certified magnitude and error; none is free.

To allocate at most tau=2^(-s) to this transform contribution, it is sufficient to choose

    p >= s + ceil(log2(n*B*(2+3*m))).

This is an integer bit-length calculation. It concerns fractional bits after scaling by B, not fractional bits of the original unscaled values. Retain b as an exact exponent; normalized intermediate numerators then need about p bits rather than p+b bits. This bound is sufficient, not optimal.

For the illustrative length n=2^19 and transform error allocation2^-53:

| Exact input magnitude bound B | Sufficient normalized fractional bits p |
|---:|---:|
| 1 | 78 |
| 2^20 | 98 |
| 2^60 | 138 |

An independent exact-Fraction recurrence calculation checked all three rows and the stated sufficient bound. One fewer bit fails this particular bound in each row; that does not prove that the actual transform needs as many bits. These B values are examples, not measured bounds for our L-function blocks.

The combinatorial FFT identity, array permutation, root-of-unity identities and input-to-L-function semantics remain separate proof obligations. The calculation applies directly only to the stated normalized radix-two schedule. A mixed-radix or Bluestein implementation must propagate its own additional operations and scaling.

## Production selection and fallback

Assign the transform only part of the final certificate margin. Analytic truncation, interpolation, input evaluation, correction terms and subsequent arithmetic all consume their own budgets. A small FFT error cannot repair an insufficient analytic remainder bound. Strong cancellation may force large p even with normalized intermediates.

A production generator can try a modest p, certify the resulting enclosures, and retain every output whose final sign/nonvanishing test succeeds. Failed outputs may be retried at higher p or checked by a separate direct evaluator. Rechecking every easy character at the precision needed by one hard character is unnecessary if the exact-output and completeness interfaces permit separate certificates.

The checker verifies the retained successful certificates and their complete domain coverage. It need not replay unsuccessful producer experiments. The cost model nevertheless charges those experiments to generation. For each retained precision level, record counts of whole batches, retained outputs, direct fallbacks, maximum intermediate magnitude bounds and the actual arithmetic sizes.

This strategy is compatible with both finite critical-line/Turing and strip certificates. Neither method may infer completeness from sampled successful signs or from a few nonvanishing panels. The complete count or contour argument remains required.

The immediate implementation requirement is a precision-parameterized dyadic arithmetic and transform theorem, rather than a copy of the small-EM pilot's fixed512/1024-bit allocations. Lean and MM0 may use different proof representations, but both estimates should price the same certified error propagation and actual arithmetic sizes. No new throughput ratio is asserted here.
