# Explicit-theta point pilot for the source xi function

2026-11-11. **PASS for five external point enclosures.** This uses the repaired, independently reviewed theta evaluator and elementary ball arithmetic. There is no builtin zeta or Gamma evaluation, numerical FFT, zero search, high-height computation, contour, winding or Lean proof.

The points are fixed as 0, 1, 2, 1/2+2i and 629/1250+2i. The last real part is exactly .5032. All five resulting xi enclosures have strictly positive real part. This is point nonvanishing only; no segment or rectangle between the points is certified.

## 1. Target, source pins and normalization tests

The target is the actual doubled xi function

\[
 \operatorname{xiF}(s)=s(s-1)\operatorname{completedRiemannZeta}_0(s)+1
\]

from `TernaryGoldbach/Explicit/Xi.lean`, at the existing pinned Goldbach revision `23b2d68ca344203d4384e0aff7affa4ec034bef9`. It is not the commonly halved xi. Source `xiF_zero` and `xiF_one` give value 1 at 0 and 1. At 2, `xiF_eq`, Gamma_R(2)=1/pi, and `riemannZeta_two` give xiF(2)=pi/3. The latter zeta value is in the pinned Mathlib `NumberTheory/LSeries/HurwitzZetaValues.lean:226`.

The script verifies the following two input-file hashes before running:

* `../integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`: `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`.
* `../audit/REVIEW_PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`: `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2`.

Those pins include the repaired derivative-tail threshold and the normalized/unnormalized FFT distinction. This pilot uses only undifferentiated direct trapezoid sums, with their explicit factor h; it does not invoke either FFT convention.

The overlap/containment checks against 1 and pi/3 are normalization consistency tests. They are not the proof of the numerical enclosure formula. That proof consists of the accepted source identity, its explicit analytic error bounds and the finite interval calculation below.

## 2. Exact kernel and recovery of unshifted xi

Use the reviewed holomorphic even kernel

\[
 P(w)=\sum_{n\ge1}
 \left(8\pi^2n^4 e^{9w/2}-12\pi n^2e^{5w/2}\right)
                         e^{-\pi n^2e^{2w}}.
\]

The entire identity and its contour shift are

\[
 \operatorname{xiF}(s)=\int_{\mathbb R}P(v)e^{(s-1/2)v}\,dv,
\]

\[
 F_b(s)=e^{-ib(s-1/2)}\operatorname{xiF}(s)
       =\int_{\mathbb R}P(v+ib)e^{(s-1/2)v}\,dv.
\]

The script first encloses F_b, then recovers actual xi by multiplying by exp(+ib(s-1/2)). The sign and the shift by 1/2 are both retained. No approximate meromorphic product at s=0 or 1 is used.

Take the fixed rational parameters

\[
 b=1/8,\quad r=1/4,\quad\kappa=1/2,\quad T=2,
 \quad h=1/64,\quad K=192,\quad V=Kh=3,\quad N=12.
\]

Here |b|+r=3/8<pi/4. Also cos(2(|b|+r))>=1-2(3/8)^2=23/32>1/2, so kappa is admissible without a numerical cosine assumption.

For k>=0, evaluate the finite kernel P_N(kh+ib) by the displayed series. For k<0, the accepted identity P(-w)=P(w) and real coefficients give

\[
 P(kh+ib)=P(-kh-ib)=\overline{P(-kh+ib)}.
\]

Accordingly the negative-node approximation is the conjugate of the positive-node finite sum. It is not the direct finite theta sum at a negative real argument, and it does not assume that an arbitrary truncated theta expression is even. The k=0 term is included only once and is evaluated directly as a complex ball.

## 3. Extending the envelope to include s=0

The reviewed note states its real strip as [.4968,2]. Its point-evaluation envelope uses that strip only through |Re(s)-1/2|<=3/2. The exact entire identity has no such restriction. The same inequality holds on the larger real interval [0,2], so every undifferentiated envelope and quadrature estimate used here remains valid there with identical constants. Thus the s=0 check is within an explicitly justified extended domain; it is not an unsupported extrapolation through a pole.

Set, as in the accepted note,

\[
 C=3\kappa=3/2,\quad q=C/2=3/4,\quad z_0=3C/2=9/4,
\]

\[
 A=(2048/C^2+96/C)(1+z_0)/z_0=113984/81,
 \qquad M=A/q=455936/243.
\]

Then |P(v+iy)|<=A exp(|v|/2-q exp(2|v|)) for |y|<=|b|+r. Multiplying by exp((Re(s)-1/2)v), for any Re(s) in [0,2], gives the same integrable envelope A exp(2|v|-q exp(2|v|)). On the shifted quadrature lines the remaining factor exp(-Im(s)*Im(w)) is bounded by exp(Tr), since |Im(s)|<=2 for all five points.

## 4. The three analytic errors and finite arithmetic

The computed finite sum is

\[
 S_N(s)=h\sum_{k=-K}^{K}\widetilde P_N(kh+ib)e^{(s-1/2)kh},
\]

with the reflected negative-node convention above. The accepted bounds give

\[
 E_{\rm quad}=\frac{2M e^{Tr}}{e^{2\pi r/h}-1},\qquad
 E_{\rm space}=M e^{-q e^{2V}},
\]

\[
 E_{\rm theta}=h(2K+1)A e^{2V-q(N+1)^2}.
\]

The script checks q exp(2V)>1, the required monotonicity threshold for the undifferentiated discrete spatial tail. Each expression is evaluated with outward real ball arithmetic. The actual error norm is at most their sum. A square with that positive upper radius in both coordinates encloses the entire complex error disk and is added to the finite sum ball.

The upper-rounded diagnostic sizes are:

| Error source | Bound, rounded upward |
|---|---:|
| Infinite trapezoid quadrature | 1.354e-40 |
| Omitted spatial nodes | 7.382e-129 |
| Finite differentiated-theta series | 3.067e-49 |

Arithmetic error is retained separately inside every ball for pi, complex exponentials, powers, finite sums, h multiplication and the recovery phase. It is not discarded or estimated from a floating-point residual. The script checks that each final real-plus-imaginary radius is less than 10^-30.

Only elementary FLINT ball operations are used. There is no builtin zeta, Hurwitz zeta, Gamma or L-function call in the script, including its diagnostics.

## 5. Actual enclosures and retained evidence

The displayed decimals below are abbreviated views of the exact dyadic intervals in the receipt:

| s | xiF(s), abbreviated |
|---|---|
| 0 | 1 |
| 1 | 1 |
| 2 | 1.047197551196597746154214461093167628066 |
| 1/2+2i | 0.906199716625872222604561084017455628164, imaginary interval contains 0 |
| .5032+2i | 0.906199895127530677565612821540806248170 + 0.000269755077633280153386326405135252176 i |

All five complex balls are finite and have strictly positive real part. The source values 1 are contained at s=0,1; the interval difference with pi/3 contains zero at s=2. At the critical-line point the imaginary interval contains zero, but its realness is not inferred from that numerical containment.

The receipt stores exact rational endpoints of every real and imaginary ball for:

* All 193 nonnegative finite kernel sums P_N(kh+ib), k=0,...,192; these determine the 192 negative nodes by the stated conjugation rule.
* Six individual theta terms at k=0,32,192 and n=1,12, as formula checkpoints.
* For each point, the separate positive and negative weighted sums, the single zero node, the h-scaled trapezoid sum, the shifted F_b enclosure, the recovery factor, and the final xi enclosure.
* Every analytic error expression, all exact rational parameters, source pins and the producing script hash.

The complete finite terms can therefore be independently regenerated from the formula and checked against retained aggregates. Printed decimal diagnostics are not used as proof inputs. The receipt is 520,539 bytes; its size mostly comes from exact dyadic endpoints at very small theta values.

The run used 160-bit ball precision, python-flint 0.9.0 and FLINT 3.6.0. It evaluated 193*12=2316 finite theta terms and direct weighted sums for the five points. Internal computation after constant setup took about .040 seconds. This excludes interpreter startup, input hashing, output serialization and independent review. It is a small pilot timing, not a production forecast.

## 6. Reproduction, review and limits

Frozen producer files:

* `principal_xi_point_pilot_20261111.py`: SHA256 `264183495A1345B2EE6774D49F20864B4E218D14B09F73F23DF24E2A8BD653B2`.
* `principal_xi_point_pilot_20261111.json`: SHA256 `BC521AE8AC5A53E7331909E0C80DB9B347905675D0680E3D192F0B3A29446A6D`.

Read-only recomputation from the repository root:

```powershell
& work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/principal_xi_point_pilot_20261111.py --recompute
```

That mode regenerates every ball and requires exact agreement of all non-timing receipt fields. It does not overwrite the receipt. The producer has a 60-second loop guard; the actual run finished far below it. Acceptance requires the explicit `PASS_EXTERNAL_XI_POINTS_ONLY` status and all point/error assertions, not merely an exit code.

Independent review has been requested with a different unshifted quadrature, precision and theta cutoff. The external arithmetic and analytic adapters are not kernel-checked here. This result validates a small instance of the repaired evaluator, including source normalization and recovery phase. It supplies no high-height or whole-contour evidence, and does not enlarge any existing zero-free domain.
