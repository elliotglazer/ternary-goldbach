# A complete principal sign certificate through height1500

External computation, 2026-11-11. All1069 required strict sign changes have been constructed and replayed using explicit Euler–Maclaurin point enclosures. Together with the separately reviewed complete zero count, the mathematical implication is finite RH and simplicity through height1500. The new sign data still await independent review. This is not a kernel theorem, a new allowed assumption, or a certificate through one million.

## Frozen artifacts and observed result

| Artifact | SHA256 |
|---|---|
| `principal_signs_1500_20261111.py` | `5DADC07911BBE024947F1CA6EC2FFCE0CDF205DC63EFD1968D2B545B9E1C182A` |
| `principal_signs_1500_20261111.json` | `542346DEB342369A1D53601DC051AFADB39149DB34C6E7426C33AB4094BC8CF4` |
| Imported frozen `psi_head_counts_20261111.py` | `D7F187FA357EACA184A2214F8952B396B9D2DF42348580993005B7DA00252A9A` |
| Independently counted head JSON | `82AD7ACDFFBCAC24D190A98ACB78BF66471249D09BFE2C43051ADD2AAEC0D030` |

The sign JSON is140847 bytes and contains1070 strictly ordered rational samples, starting at14 with negative sign and ending at1500 with positive sign. Every adjacent sign alternates. All values are recomputed by replay; diagnostic printed intervals are not trusted inputs.

A bounded pilot on[14,100] found29 changes among173 half-unit samples in.12 seconds, without making a completeness claim for that pilot. The full scan used no zero-location hints:

| Dyadic step | Strict sample values | Observed sign changes | Cumulative time |
|---:|---:|---:|---:|
| 1/2 | 2973 | 1055 | 1.82s |
| 1/4 | 5945 | 1067 | 4.39s |
| 1/8 | 11889 | **1069** | 9.69s |

Previously evaluated dyadic points were cached. The final1070-point replay exited0 and took.65 seconds. These are measured timings for this bounded computation only. There is no extrapolation to height one million and no spacing assumption underlying the grid: refinement stopped only after the observed lower count matched the independently obtained total count.

## Exact real function being signed

For t>=14 define

\[
\theta_0(t)=\frac t2\log\frac{t}{2\pi}-\frac t2-\frac\pi8,
\qquad V(t)=\Re\left(e^{i\theta_0(t)}\zeta(1/2+it)\right).
\]

The mathematical sign reduction is the reviewed §1 of `PRINCIPAL_COMPLETENESS_ROUTE_2026-11-11.md`, SHA256 `AC1FA5C0308D24C9CB19FEBF6A2C231B42C6E25113E534D4C23FE62E4CE2D92C`. Its independent route review is `audit/PRINCIPAL_COMPLETENESS_ROUTE_REVIEW_2026-11-11.md`, SHA256 `FB268AD7ACE08954435194D51BF6FC3C358AE7838E8CCFAE7087B0E0F84EAA11`.

Precisely, normalized analytic log-Gamma defines theta and the Hardy function Z. Source xi reflection/conjugation and its Gamma factorization imply that Z is real and continuous. The reviewed Binet estimate gives

`|theta-theta0| <= 1/3+3/(16t) < .347`,

so `V=Z*cos(theta-theta0)` with cosine>.939. Therefore V has the same signs and zeros as Z, and a zero of V is an actual critical-line zeta zero. This is an analytic identity, not an inference from a small computed imaginary part. Normalized Gamma/Binet, continuity and realness remain explicit formal proof obligations even though no Gamma evaluator is used for the point signs.

## Explicit point enclosures

The imported head evaluator's finite function g(s) is the entire pole-cancelled EM expression described and reviewed in the head certificate. For each exact rational sample t, take s=1/2+it. Parameters are N=500, M=32 and128-bit ball arithmetic. All logs, powers and rational Bernoulli coefficients are rebuilt by `Evaluator(500)`.

The uniform EM error is bounded using sigma0=-1/10 and S=|s|:

\[
|zetaF(s)-g(s)|\le
\frac{4(S+1)\prod_{j=0}^{63}(S+j)501^{1+1/10-64}}
{6^{64}(64-1-1/10)}.
\]

This enlarges |s-1| by S+1 and every rising-factorial factor by S+j. The actual real part1/2 exceeds sigma0. The error disk is enclosed by a coordinate square. Dividing the resulting zetaF ball by s-1 is safe because Re(s-1)=-1/2. Elementary interval log/exp and a pi enclosure then evaluate the real part defining V.

No Taylor/Cauchy block remainder is used in this sign checker: `finite(s)` receives a scalar complex ball, not a power series. No builtin zeta, indexed-zero, zero-count, S-function, Gamma or historical Gram/Rosser routine is called. The only earlier spectral input is the separately completed head contour certificate, checked by exact hashes and metadata. The external FLINT enclosure contract remains part of the numerical trust boundary pending formal replay.

Acceptance at a sample requires the computed real interval to be strictly positive or strictly negative. An interval containing0 is an inconclusive result and stops the run; it is never assigned a sign by its midpoint. The search had explicit time, point-count and refinement limits; exhausting a limit before matching1069 would have produced `INCOMPLETE`.

## Compression and replay

The full 1/8 grid supplied11889 proved nonzero signs with1069 changes. Consecutive equal-sign runs were compressed to one sample each, retaining14 in the first run and1500 in the last. Thus there are1070 ordered samples, all actual grid points, with alternating strict signs. Discarded samples are unnecessary for the existence argument.

Replay independently checks:

* the frozen evaluator and head-certificate hashes;
* the head status, endpoint heights, N(14)=0 and N(1500)=1069;
* the sign script's own hash and fixed numerical parameters;
* exactly1070 rational samples, first14 and last1500, strictly increasing;
* every strict sign by a fresh explicit EM evaluation;
* alternation across each of the1069 adjacent pairs.

The accepted head count has its own complete contour replay and independent review in `moebius/PSI_HEAD_COUNTS_REVIEW_2026-11-11.md`, SHA256 `0BD2AF981C7F8A201F15597A7EE4C7B9812053C4987231C8EB02E5A6AA8BA491`. Reading its metadata is only a composition reference to that separately checked component; it is not a replacement for its mathematical or eventual kernel proof.

## Completeness and exact endpoints

Each open interval between consecutive retained samples contains a zero of V by continuity. The intervals are disjoint and their endpoints are certified nonzero, giving1069 distinct critical-line zeros in (14,1500). Every such zero has positive analytic multiplicity.

The independent contour count contains exactly1069 zeros of all real parts in the critical strip with positive ordinate through1500, counted with multiplicity. The height14 rectangle excludes every lower positive zero, and the head contour separately certifies the top boundary nonzero. Hence the1069 line zeros exhaust that entire carrier, each with multiplicity1. There is no capacity for an off-line zero, an undetected even-multiplicity zero, an additional root in one interval, or a repeated bracketed zero. Simplicity follows from equality with the complete count; it was not used to choose or accept the samples.

Conjugation supplies the negative ordinates, and the height14 rectangle includes the real axis. Therefore, if the new sign computation and its analytic bridges are accepted, every nontrivial zero with |Im rho|<=1500 has Re rho=1/2, and its multiplicity is1. In particular the principal (.4975,.5025) strip is discharged through1500 externally. Neither global QRH nor bounded RH is assumed in this low-height implication.

The principal strip on1500<|gamma|<=1000000 remains unproved. Formalizing the head count, EM arithmetic, normalized Hardy-realness/sign reduction, intermediate-value argument and multiplicity saturation is still required before this becomes a Lean-proved leaf. No source or frozen artifact was changed by this experiment.
