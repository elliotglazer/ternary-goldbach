# Independent review of the modular-node xi disk

2026-11-11. **PASS for the complete stated disk, at external interval-arithmetic and reviewed-paper scope.** No producer correction is required. I read the frozen report and implementation, checked their analytic composition, replayed every retained node and weight, reconstructed every exact coefficient sum, and independently computed the coefficients on a different direct-kernel quadrature grid. This accepts a local closed-disk nonvanishing calculation, not a Lean theorem or a spectral-completeness result.

## Frozen inputs and review artifacts

Paths below are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `prime-estimates/PRINCIPAL_MODULAR_XI_PANEL_PILOT_2026-11-11.md` | `85EDD45B5DEB8E96AEC957AA956E90AEBEC4B9B0C9BE31C7D06FA52DAE6E2D49` |
| `prime-estimates/principal_modular_xi_panel_pilot_20261111.py` | `626A931E23A0B3585C0803D34D920BE759E792B230638BDD0E48155874203416` |
| `prime-estimates/principal_modular_xi_panel_pilot_20261111.json` | `0B01EC0CA4A0102816CFB22DE51AE5751975288AC1544F5ABBABCA84BF4A8608` |
| `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571` |
| `major-constants/REVIEW_PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD` |
| `independent-feasibility/review_principal_modular_xi_panel_pilot_20261111.py` | `83BDB95C0FAE588233A002BD57F7D2045802F86B627A2B4FE72193A0766641ED` |
| `independent-feasibility/review_principal_modular_xi_panel_pilot_20261111.json` | `FA3AB96CDCDCDE2AAB9DE8DCD76B35BF52C2BFA0E1F11146E5C69B01F8B75DE6` |

The producer imports its previously reviewed elementary modular helper, SHA256 `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14`. The independent implementation instead imports the earlier independent review helper, SHA256 `60B92C3B84B988FC7AB2FB45AB114798C55A4F392A9282F6D7CDD26F1AD75E1C`, for its rational Machin pi enclosure, 384-bit arithmetic, independently written theta series and jet transport. The new script asserts the frozen producer and composition hashes.

## Actual function and admissible parameters

The same exact b is used everywhere:

```
b=pi/4-1/33,
F_b(s)=exp(-i*b*(s-1/2))*xiF(s),
s0=3/5+14i, rho=1/64, degree=12.
```

Here xiF is the unhalved source function from the accepted Fourier identity. Its kernel is the full P, with coefficients 8*pi^2 and -12*pi. The node formula and final Fourier weights introduce neither an additional factor of two nor an n=0 Gaussian term.

The producer uses r=kappa=1/66, h=1/512, K=2048, V=4 and work height T=32. I checked the strict strip inequalities, the center's real-part and ordinate conditions, the positive trapezoid denominator, and `q*exp(8)>2`. The latter is the required derivative-tail monotonicity condition. The constants recomputed exactly are

```
C=1/22, q=1/44, z0=3/44,
A=46687168/3, M=2054235392/3, D=30813530880.
```

The quadrature strip radius r and the Taylor-disk radius rho have different roles. There is no need for rho<=r. The Taylor remainder comes from the separate analytic unit-disk bound by D, not from treating the quadrature strip as a disk in s.

## Every node, sign and weight

All 2,049 nonnegative node records were checked. For each exact v=k/512, I evaluated the original P-series directly, independently replayed the recorded modular word with 32 reduced pairs instead of 20, and checked both results inside the stored rational and raw binary P intervals. All 495 inversions satisfy the strict domain and growth conditions. The square-root branch, type permutation, reverse word order, and ordinary derivative normalization are those checked in the preceding independent modular review; the new replay instantiates them at every retained node.

There are 8,200 rational interval containment checks, including the four displayed analytic parameter enclosures, and 8,196 raw binary node containment checks. These are complete checks, not a sampled subset of the grid. The direct P evaluation uses 64 positive Gaussian frequencies at every node, a different series and cutoff from the modular route.

The negative-node identity is

```
P(-v+ib)=P(v-ib)=conj(P(v+ib)).
```

The first equality uses evenness of the complete kernel. It would be wrong for an individual displayed Gaussian term. The second uses conjugation of its normally convergent real-coefficient series. The implementation negates the full center's imaginary part and preserves the radius. My independent direct grid uses the same proved identity. The zero node is included exactly once. Its order-zero weight is h; each positive-order weight is exactly zero.

I reconstructed each node's rational center and L1 error radius from its outward display endpoints, then checked that radius against the independently enclosed actual P value. All 53,261 signed weight triples were checked against

```
h*v^j/j! * exp((s0-1/2)*v), j=0,...,12.
```

The signed v is retained inside the power and exponential. Absolute values appear only in the error bound. In particular, the odd negative-node weights are not replaced by positive ones, and the factorial is applied exactly once.

The two integer numerators for each coefficient were independently accumulated from every stored weight/node center product. They equal the producer's numerators with denominator 2^256. Python integer arithmetic performs these finite products and sums exactly, so the claimed summation error zero is correct within the external execution model. No floating accumulation is hidden in that particular claim.

## Complete coefficient error accounting

For each j, I recomputed the quadrature error Q, the omitted-node error S, the weighted node errors B, and the exact rational weight-error sum. The identity

```
w*P - w_hat*p = w*(P-p) + (w-w_hat)*p
```

explains the split and shows that no mixed term is missing. The node radius already includes the reduced-theta tail and modular arithmetic error. There is no reason to add the old unreduced-Gaussian cutoff error to these modular node balls. Quadrature and omitted spatial nodes still require their separate Q and S terms.

The positive-order Q bound uses D and `exp((T+1)*r)`, including the extra exp(r). It is not the order-zero formula. The omitted positive-order samples use the decreasing envelope with threshold `q*exp(2V)>=2`, and the correct integral `A*exp(-qR)*(R/q+1/q^2)`. Both sides of the signed grid are included.

The coefficients are `F_b^(j)(s0)/j!`, not ordinary derivatives. The saved errors are below 1.509e-12 for j=0 and 6.894e-11 for every positive j. The independent direct finite sums also lie within the producer's combined node and weight error around each exact rational center, before adding Q or S.

## Independent changed-mesh computation

I repeated the entire coefficient calculation using h=1/640, K=2560, V=4 and the original P-series with 64 frequencies at all 2,561 nonnegative nodes. The exact b and center remain unchanged, so this is a second quadrature for the same F_b. This route uses no modular node values. It uses the sharper permissible analytic work height T=14, since the only coefficient center has ordinate exactly 14.

For this direct node series, `pi*cos(2b)>9/50`. At a nonnegative v put `alpha=(9/50)*exp(2v)`. If c4 and c2 are the absolute kernel coefficients and u=N+1, its omitted tail is bounded by

```
(c4*(4/alpha)^2+c2*(2/alpha))
 * exp(-alpha*u^2/2)/(1-exp(-alpha*(2*u+1)/2)).
```

This follows by splitting the Gaussian, bounding its n^4 and n^2 moments, and summing the remaining geometric majorant. The tail is added to the direct node enclosure before summing any Fourier weights. Finite arithmetic rounding remains inside the interval calculation.

The changed-mesh Q+S bounds are approximately 5.865e-18 for the constant coefficient and 2.757e-16 for each positive coefficient. For all 13 orders, the whole independently computed coefficient ball, including Q and S, lies inside the producer's certified error ball about its rational center. This is stronger than agreement at selected s values. Across the original-grid and changed-grid checks, the independent implementation evaluates 295,040 positive Gaussian terms directly.

## Why the full closed disk is covered

The unit-disk Cauchy bound gives the remainder

```
D*rho^13/(1-rho)=40121785/387381625547900583936.
```

For every complex z with |z|<=rho, the accepted analytic composition and all coefficient bounds therefore give

```
|F_b(s0+z)-f_hat_0|
 <= sum_(j=1..12) |f_hat_j|*rho^j
    + sum_(j=0..12) E_j*rho^j
    + D*rho^13/(1-rho).
```

This uses an upper bound on the entire polynomial variation. It does not evaluate the polynomial only at sample points or silently omit polynomial arithmetic error. The norms of the exact rational coefficient centers are enclosed outward; the final radius and comparisons are rational.

I checked every component of the saved final comparison. The polynomial variation is below 1.783184580413, the error plus remainder is below 2.707e-12, and the constant center norm is above 19.560256634913. The exact rational margin is greater than 17.77707205449. Thus the full closed disk, including its boundary, excludes zero for F_b.

The independent changed-mesh coefficients and their own analytic errors give a separate positive whole-disk margin, approximately 17.77707205450143. That second calculation applies the same analytic disk inequality to its own interval coefficients. It is not merely a test at the center.

Finally, `exp(i*b*(s-1/2))` is entire and never zero. Therefore this disk contains no zero of the actual xiF. No recovery of xi derivatives is claimed; such a packet would need the appropriate product derivatives. No particular polygon half-plane certificate or closed-contour zero count follows automatically from this local disk result.

## Scope and remaining implementation

The independent final run exited zero in 6.4859716 seconds of internal wall time, excluding interpreter startup and final receipt serialization. The producer's recorded 12.1064312 seconds is likewise a bounded external prototype measurement. Neither number estimates high-height grids or complete proof production.

The implementations share the external Arb backend for elementary interval operations. My different pi construction, precision, node series, cutoffs and quadrature mesh provide independent mathematical and algorithmic checks, not a verified replacement for that arithmetic backend. The paper analytic identities, interval checker, serialized arithmetic consumption and Lean instantiation remain separate work. This review supplies no new axiom, no global spectral assumption, no high-height scan and no completeness certificate. Only new review artifacts were written; producer files and canonical sources were not modified.
