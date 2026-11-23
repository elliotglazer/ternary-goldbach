# Review of the square-root finite EM magnitude bound

2026-11-11. PASS at conditional source/paper scope, without correction. The complete finite EM expression and the actual stored-vector error contracts imply full-P20 output norms below65,85,113,173 and163 in the five selected bands. This review does not select a transform input bound, runtime width, precision assignment or price schedule.

Reviewed author: `audit/SQRT_HEAD_FINITE_EM_MAGNITUDE_2026-11-11.md`, SHA256 `03680BE7C2518CA0065244E840DC64203D529E26BE2E867F4C31A37652009904`. Paths here are relative to `work/qrh-campaign/agents`, except the explicitly named blueprint source. I read the complete frozen author, its nine cited interfaces and their relevant proofs. All nine source hashes and the author hash match. The independent checker performs61 fixed integer/rational and hash checks. It imports no author program, reads no inventory, and evaluates no Hurwitz, elementary, coefficient, root, prime, zero or transform value. No build, declaration, proof emission or frozen edit occurred.

## Complete finite formula and head estimate

At k=0 the scaled source identities give R0=lambda0=E0=1. Consequently the exact finite approximation is

    sum_(n=0)^(N-1) (n+z)^(-s)
      + b^(-s) [b/(s-1)+1/2+(1/6)sum_(r=1)^m gamma_r E_(2r-1)],

where s=1/2+it, z=1+a in[1,2], b=N+z, E_l=(s)_l/(6b)^l and gamma_r=6^(2r)B_(2r)/(2r)!. This is exactly scaled-source251B95AE section2 and joint-sourceAA1A7464 equation(2) specialized to zero. The final m159 sourceE6F0F3B2 changes the finite correction count while preserving this identity and its stated remainder. No factor of6, b or D is omitted. All signed Bernoulli terms remain.

For positive real x, the complex power norm at this s is x^(-1/2), independently of the sign of t. Since z>=1, each finite head term is bounded by(n+1)^(-1/2). For k>=2, decreasing x^(-1/2) gives k^(-1/2)<=integral over[k-1,k]. Thus the finite head is at most2sqrt(N)-1. N=1 is covered by an empty comparison sum. This argument does not use an absolutely convergent infinite degree-zero Dirichlet series.

For the endpoint, |s-1|>=1/2 and |b^(-s)|=b^(-1/2). The pole-type contribution is therefore at most2sqrt(b), with the half and correction contribution bounded by(1/2+|S0|/6)/sqrt(b). The improvement comes from retaining this real-power modulus. It neither discards the pole term nor assumes cancellation.

The first-four E factors are bounded by1/2 under the source's P<=32,m64 index range. In particular N=ceil((V+160)/3) supplies sufficient denominator6(N+1), even for the largest retained rising factor. The finite S0 sum is strictly below4*(1/2)/(1-1/4)=8/3. Its second endpoint numerator is below17/18<1.

For the final band, m159 has largest stored E index344 and last factor s+343. The reviewed Euclidean estimate7000^2+(689/2)^2<7009^2 covers this and the longer remainder product. Since7009/9006<17/20, the full finite correction is strictly below4*(17/20)/(1-(17/20)^2)=1360/111. Its second endpoint numerator is below1/2+680/333<3. Reducing a signed finite sum does not automatically reduce its norm; the proof correctly applies a fresh positive absolute majorant instead.

## Root brackets, remainder and coarse centers

The five square brackets in the author establish ell<sqrt(N+1)<=sqrt(b)<w and sqrt(N)<w. They imply the complete finite-expression bound4w-1+kappa/ell. The parameters are

|N|ell|w|kappa|Strict coarse cap|
|---:|---:|---:|---:|---:|
|220|14|15|1|60|
|387|19|20|1|80|
|720|26|27|1|108|
|1720|41|42|1|168|
|1500|38|39|3|156|

Every kappa/ell<1/2 leaves more than1/2 before the listed cap. The analytic finite remainder R<2^-116 and a conservative additional eta=2^-100 together fit this gap. Therefore the caps hold for true coarse U0 and also for stored coarse centers under the original error contracts. The latter are below eta/4 in the first four bands and below.107eta in the final band.

I checked the final remainder inequality directly as the fixed rational comparison `(312/635)*(7009/9006)^318<2^-116`. The source's finite EM theorem and all-order Bernoulli estimate remain inherited analytic obligations. This review does not infer that theorem from a scalar inequality or promote the existing paper construction to kernel validation.

## Finite translation and its numerical errors

The bounded object is the finite translation of the true coarse coefficient vector, followed by the actual source arithmetic. It is not identified with the exact fine-anchor jet. First-four shifts have |tau|<=1/2; the unshifted right endpoint uses only its supplied P20 coefficients. Final shifts are0,1/4,1/2,-1/4, with the actual output2^-k postscale from source4096 to normalization8192. All endpoints and both height signs remain included.

For j>=1 the accepted absolute-series argument gives |U_j|<=3A^j/j!. The rational factorial majorant H(x)=1+x+x^2/[2(1-x/3)] bounds each finite positive sum, since successive ratios from degree2 onward are at most x/3. This yields degree-zero translation increments795/304 and1155/272. The positive-degree output coefficient envelopes remain6*(5/4)^k/k! and(15/2)*(7/8)^k/k!, respectively. The final7/8 already includes output postscaling.

The delivered first-four numerical vector has the weighted norm-sum bound W=4eta+330*2^-110 on weights4^-k. The final vector has a per-slot error beloweta and hence weighted sum below4eta/3. These are errors relative to the finite translated vector. The first bound is a sum of norms justified by the positive suffix-matrix argument, not a cancellation-based evaluation bound. Both already include source and translation rounding. No second seed/translation error is added. The analytic finite-shift bias stays in the separate actual-function radius.

At |h|<=1/4 the positive-degree ideal polynomial contributes at most1515/688 or20895/11392. I independently checked

    795/304 +1515/688 <79/16,
    1155/272+20895/11392<111/16.

These leave more than1/16 before the proposed increments5 and7. Adding the weighted numerical vector error once is correct. The intermediate stored degree-zero bounds C0+3 and C0+9/2 are also valid, but substituting those looser bounds and then adding the whole translation increment again is not the proof used for the final caps.

## Actual evaluation and current grid scope

For a full degree19 polynomial, twenty direct coefficient conversions, nineteen product rounds, nineteen optional addition rounds and one optional export give at most59 additive perturbations. If each has complex norm at most2^-60 and exact displacement satisfies |h|<=1/4, every perturbation has output amplification at most1. Thus the total is at most59*2^-60<2^-54. Exact additions and export have zero contribution and need not be performed as additional rounds.

The source weighted numerical error is below2^-90 in both classes. Together these fit the1/16 margin. The strict full-P20 output caps65,85,113,173,163 follow for the stored polynomial and the specified rounded evaluator.

This is a magnitude-only grid floor. It includes the current full-P20 b0=94/min65 shape because every named gate satisfies the looser60-bit condition. Its actual approximation admission still requires the separate weighted evaluation-error proof and full alpha budget. The argument does not admit an all-grid60 circuit. Direct conversion from original stored coefficients, exact argument, and exact grid alignment remain premises. At b0<=100, export to grid100 is an exact checked shift. If any replacement circuit adds a round beyond the stated schedule or approximates the displacement, that work and error require a separate join.

No coefficient or polynomial value was checked. No source Taylor order was reduced. Shorter-output and finite-difference evaluators do not inherit the result without a bound relative to the same finite polynomial. The old source/shift work and all actual-height domains remain unchanged.

## Optional raw-input consequence

For1<=a<c<=265800, |(a/c)^(-s)|=sqrt(c/a)<=sqrt(c)<516. A head center with complex error at most1 is therefore below517. This is only a magnitude relaxation of the retained much tighter head error; actual grid100 encoding and source association remain necessary.

Exact grid100 assembly gives a uniform raw norm below173+517=690, and a final-band-only norm below163+517=680. An admitted single regrid at p>=80 contributes at most2^-p. Adding the augmented1 gives strict bounds692 and682. The arithmetic is sound, but these are optional successor inputs. A conductor spanning other bands cannot use682 without a matching domain policy. Neither replaces V_width16384 or V_error8828 in the ongoing combined pricing pass.

Actual source enclosures, input bindings, canonical normalization, cache contracts, error propagation and successful sign/count certificates remain separate. The report establishes no automatic end-to-end saving, precision drop, runtime improvement or standard-rule implementation.

## Independent fixed evidence

The new independent script `prime-estimates/review_sqrt_head_em_magnitude_20261111.py`, SHA256 `ADEB0AB5B12F9854B6D54ACDFC53375251046F5DD4FC9DEE4B680FC24C912844`, verifies the author and nine source pins, all five root brackets and coarse caps, complete correction constants, the final fixed remainder bound, rational translation/evaluation constants, perturbation margins and optional raw-input bounds. It completed61 checks on its first run.

The exclusive1812-byte same-stem JSON has SHA256 `169CCDB6FF8ED4704D934109C469407229AE28BE24CC4CD1ED94B24C66770822`. It records all nine verified source hashes and the exact margins. These checks support the source derivation above; they do not replace the generic finite EM, norm, matrix or rounding arguments. The verdict is PASS for this conditional mathematical refinement only.
