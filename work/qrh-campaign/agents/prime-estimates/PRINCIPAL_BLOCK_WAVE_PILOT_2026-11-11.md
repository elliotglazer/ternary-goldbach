# Two bounded principal wave-recurrence pilots

2026-11-11. Both short blocks completed with all operation-error tests passing. They cross the saddle cutoffs N=17 to 18 and N=397 to 398. Every one of the 34 direct Khat point enclosures lies inside the corresponding recurrence enclosure. No high-height Euler-Maclaurin, zeta, Gamma, FFT, zero count, Lean build, or dependency change was used.

This is external arithmetic evidence for recurrence correctness and its source-expression interpretation. The isolated interval signs are recorded, but no sign-chain completeness, new zero count, or new spectral coverage is asserted.

## 1. Frozen inputs and outputs

Paths for the new outputs are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
| --- | --- |
| New script `prime-estimates/principal_block_wave_pilot_20261111.py` | `A35976CBB906FA01A8F275C1C6262DD55835D442A179DEC1CEA22471FA132F34` |
| New receipt `prime-estimates/principal_block_wave_pilot_20261111.json` | `B3C699860BBE37132305DD5C23AC5FDC1E82742AF85F97C3E75EA98FDC9BDA56` |
| Pinned elementary helpers `prime-estimates/principal_k0_point_certificates_20261111.py` | `9A84F801745C8F9DD7CAD2F0E41F7633F8AFB850895C68845D4119E675543A22` |
| Root theorem `work/qrh-blueprint/turing-scalars/PRINCIPAL_BLOCK_WAVE_ERROR_2026-11-11.md` | `F93CEC28EB94AB14BF6F10B74828C39D0634AA11D7D9A400377A8A4302D20EE0` |
| Its review `mellin/REVIEW_PRINCIPAL_BLOCK_WAVE_ERROR_2026-11-11.md` | `B0D2C9233FF50EC1F82514E032E1D5B8BA3E74AA5731C22E452821E29A69E6A0` |

The elementary helper source is hash-checked before import. It supplies exact rational interval arithmetic, outward 128-bit dyadic rounding, Machin pi, atanh log, square-root comparison witnesses, and the reviewed stable F formula. Its earlier point pilot is not rerun by import. The underlying Khat assembly remains `E14AC6AD...B6D6`, independently reviewed at `A39ED6F3...73633`; the block theorem records their full pins.

All interval endpoints and centers in the receipt are exact rational strings. The computation uses Fraction and integer arithmetic. No floating result participates in an acceptance comparison.

## 2. Exact block geometry and cutoff certification

In each block h=1/64, B=16, M=m, and all samples j=0,...,16 are retained. From the certified rational pi interval [pL,pU], the program checks

`floor(128*m^2*pL)=floor(128*m^2*pU)=k`.

It sets t0=(k-8)/64. Thus the endpoints were selected without a floating approximation to the cutoff.

| M | k | Exact t0 | Exact top | A |
| ---: | ---: | --- | --- | ---: |
| 18 | 130288 | 16285/8 = 2035.625 | 16287/8 = 2035.875 | 11 |
| 398 | 63698027 | 63698019/64 = 995281.546875 | 63698035/64 = 995281.796875 | 41 |

The script checks strictly that

`t0+8h < 2*m^2*pL <= 2*pi*m^2 <= 2*m^2*pU < t0+9h`.

It also excludes the adjacent cutoffs for m-1 and m+1. Separately at every sample it certifies the exact floor using `2*pU*N^2<t_j<2*pL*(N+1)^2`, plus squared interval bounds for a. Consequently N=m-1 at j=0,...,8 and N=m at j=9,...,16. Both blocks stay above 1500 and below one million.

The rational A is chosen as `2*ceil(sqrt(M))+1`, and `(A-1)^2>=4*M` is checked. Hence it meets the block theorem's requirement `A>=2*sqrt(M)+1`. No phase or correction is continued across the floor transition. Each uses the independently certified N at its own exact rational height.

## 3. Initialization and exact center updates

For every 1<=n<=M, including the initially inactive final wave, define

`w_n(t)=n^(-1/2)*exp(-i*t*log n)` and `r_n=exp(-i*h*log n)`.

All M initial wave boxes and rotation boxes are computed from the elementary intervals. The error in log(n) is multiplied by t0 or h before the trigonometric evaluation. The complete argument interval is reduced by a certified integer multiple of 2*pi, and checked to lie in [-4,4]. Sine/cosine use the degree-48 exponential tail and include the reduced argument radius. Positive reciprocal square-root intervals supply the wave amplitudes.

Centers use a separate 48-bit dyadic grid. A real coordinate x is rounded by

`round48(x)=floor(2^48*x+1/2)/2^48`.

This is a specified nearest rounding rule, including negative inputs and ties. The complex center is obtained by rounding each coordinate of the rectangle midpoint. For a center v and rectangle [a,b]+i[c,d], its recorded Euclidean error upper bound is

`max(abs(v.re-a),abs(v.re-b)) + max(abs(v.im-c),abs(v.im-d))`.

The sum bounds the Euclidean norm; it is not an unconverted coordinate radius. No assertion is made that a rotation center has modulus exactly one.

At every step the program forms the exact rational product q_n*v_(n,j), rounds its two coordinates to 48 bits, and records a bound on the difference. All M waves are updated at every step, so the final wave already has nine checked updates when it becomes active at sample 9. Each block initializes afresh; no previous block's terminal radius is silently reused.

For these samples the program uses the prescribed rational budgets

```
e = 19/(1000*t_top),
E0 = e/(64*M),
delta = min(1/(2*B),e/(128*M*B)),
eta = e/(128*M*B).
```

Every initial radius is checked against E0, every rotation radius against delta, and every update's norm upper bound against eta. It verifies B*delta<=1/2 and the uniform wave bound

`2*(E0+B*(delta+eta))=e/(16*M)`.

For additional explicit tracking, each state stores an individual radius R_(n,j). If d_n is the actual recorded rotation radius and q_n*v_(n,j) is rounded with error b_(n,j), the update is

`R_(n,j+1)=R_(n,j)+d_n*(abs(v.re)+abs(v.im))+b_(n,j)`.

This follows by splitting with the exact unit r_n, not by assuming q_n is a unit. Every stored radius is checked to remain within e/(16*M). The actual center product and rounding error can be recomputed from adjacent states and the initial rotation record.

## 4. Active sums, fresh phases, and corrections

At each sample, only the first N certified wave centers enter the sum S. They are added exactly as rational dyadics, so the center-summation rounding error is zero. The exact active wave sum differs from S by at most the sum of its active recorded radii, which is checked to be <=e/16.

The program computes a new interval for

`thetaHat(t)=t/2*log(t/(2*pi))-t/2-pi/8+1/(48*t)`

at every sample. Its trigonometric box is converted to a 48-bit center u with Euclidean radius d_u, checked against e/(16*A). The phase is not advanced using a constant-ratio recurrence.

The correction J is independently recomputed with the actual N and the stable even sinc representation of F. This avoids the removable quotient and respects the source branch at a cutoff. A real 48-bit center j0 is extracted with error d_J<=e/4.

The final nominal real number is `2*Re(u*S)+j0`. This rational calculation is exact before one final nearest rounding to 48 bits. Its error b_final is checked to be <=e/8. The reported recurrence radius is

`R_K = 2*(sum_active R_(n,j) + d_u*(abs(S.re)+abs(S.im))) + d_J + b_final`.

The same exact-unit split as in the theorem proves this is a valid absolute Khat error bound. The program checks R_K<=3e/4. This also checks a sharper explicit bound than merely reporting the theorem's generic e allowance.

## 5. Full direct comparisons and numerical summaries

Every sample is also evaluated by the direct formula

`sum_(n=1..N) 2*cos(thetaHat(t)-t*log n)/sqrt(n) + J(t)`.

This recomputes each cosine rather than using wave centers. All 7054 direct summand records are retained, including argument reductions, output intervals, and full terms. For each sample the entire direct interval is contained in `[k_j-R_K,k_j+R_K]`. The two calculations share the proved elementary semantics, so this is a diagnostic of assembly and recurrence, not an independent proof oracle. A separate reviewer is assigned different-precision direct evaluation of all 34 points.

| Quantity | M=18 block | M=398 block |
| --- | ---: | ---: |
| Largest initial norm radius | <2.651e-15 | <3.410e-15 |
| Largest rotation norm radius | <2.438e-15 | <3.391e-15 |
| Largest center-update norm bound | <3.363e-15 | <3.521e-15 |
| Largest final Khat arithmetic radius | <1.458e-12 | <2.661e-11 |
| Largest direct Khat interval width | <1.227e-27 | <1.103e-27 |
| e | approximately 9.3326e-6 | approximately 1.9090e-8 |
| Inconclusive isolated Hardy intervals | 0 of 17 | 0 of 17 |

These display bounds are conservative summaries; exact rational quantities are in the receipt. Representative final centers are:

| M | j | Active N | Approximate Khat center |
| ---: | ---: | ---: | ---: |
| 18 | 0 | 17 | -2.042551533353944 |
| 18 | 8 | 17 | -2.288972290577853 |
| 18 | 9 | 18 | -2.306467253515791 |
| 18 | 16 | 18 | -2.338259050488652 |
| 398 | 0 | 397 | -0.4762787010355325 |
| 398 | 8 | 397 | 0.5386423841266392 |
| 398 | 9 | 398 | 0.6670050052460965 |
| 398 | 16 | 398 | 1.419111627123311 |

The first block's isolated labels are all negative. In the second block samples 0 through 3 are negative and samples 4 through 16 positive. These labels report the interval tests only. No zero-location or count inference is made from them in this pilot.

## 6. Rational Hardy enclosures and retained trace

Since e=.019/t_top and 1<=t_j<=t_top, R_K<=3e/4 is within `.019*t_j^(-3/4)`. The program additionally checks this by the exact positive fourth-power inequality

`R_K^4*t_j^3 < (19/1000)^4`.

The accepted analytic assembly then gives `abs(hardyZ(t_j)-k_j)<.47*t_j^(-3/4)`. A rational outward upper bound H_j for that last radius is computed using two positive square roots of t_j^3 and an upward dyadic division. The independent check is `H_j>0` and `H_j^4*t_j^3>=(47/100)^4`. The receipt stores `[k_j-H_j,k_j+H_j]` and its isolated sign classification. The rational H_j may exceed the exact .47 radius by outward rounding; no rounded-down radius is used.

The full trace includes 416 initial wave records, 416 rotation records, 7072 wave states, 6656 recomputable center updates, all individual propagated state radii, all 34 floor/phase/correction records, and every direct point summand. Per-step summaries record the count and maximum/sum of center-rounding bounds. The exact rounding rule and all adjacent centers permit checking each update rather than trusting those summaries.

The script completed in 14.3448 seconds of measured wall time and 14.21875 seconds of CPU time. Its execution session was 20741 and exited zero. No live process remains. A guard would stop it before ten minutes. These are external Python measurements, not Lean runtime or large-scale throughput estimates.

The generic checker, source-function bridges, block theorem and analytic K0 theorem still require Lean implementation before these data could be formal certificates. The present result tests the selected recurrence and error accounting at two cutoff transitions only. It provides no full scan, sign-chain completeness, or additional spectral coverage.
