# A complete scalar budget for two principal production heights

2026-11-11. Research-only conditional feasibility plan. The exact scalar calculation below gives disk error less than `1/63<1/10` at either selected height, provided the stated finite node and weight inequalities are actually certified. No node, theta, xi, zeta, or L-value was evaluated. No production array, contour, or Lean proof was generated. These choices are conservative and are not an optimization or a throughput forecast.

## 1. Source contracts and target

Use the corrected Fourier plan `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md`, SHA256 `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, and the accepted composition plan `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md`, SHA256 `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571`. They identify the actual unhalved source `xiF`, its entire normalization, and the coefficient errors used here. The general reduced theta tail is `THETA_JET_TAIL_TWO_FIFTHS_2026-11-11.md`, SHA256 `478DEDD2DC613670A5B2E6ECA18317733006D82CDE06860719302301B80FFE88`; its independent review is SHA256 `8C81655B87AA6855AEE4A28D34A8713FFEC95CABEEE8F538E82888A0409304CD`.

Choose `T=1000000` or `T=60343058`, put `U=T+1`, and fix

```
b=pi/4-1/U, r=kappa=1/(2U),
F_b(s)=exp(-i*b*(s-1/2))*xiF(s).
```

This exact b is common to all nodes and panels using that row. For any center `s0=sigma+i*t` with `.4968<=sigma<=2` and `|t|<=T`, the target is a polynomial enclosing `F_b(s0+z)` throughout `|z|<=rho`, with error below 1/10. It does not assert that the polynomial or function avoids zero.

The analytic domain conditions hold: b is positive, `b+r=pi/4-1/(2U)<pi/4`, and `cos(2(b+r))=sin(1/U)>=1/(2U)=kappa`. The latter follows from the elementary sine Taylor lower bound for `0<=1/U<=1`. All parameters except b are rational. The irrational b must be enclosed through its exact definition in each finite evaluation.

The work bound applies to coefficient centers, not to numerical samples of an outer Cauchy circle. No outer-circle sampling is used; the accepted unit-disk bound is independent of the imaginary coordinate. A future computation requiring other centers above T must select a larger work bound before using this plan.

## 2. Explicit choices

Write `U<2^p`, with p=20 and p=26 respectively. Use the exact envelope constants

```
C=3/(2U), q=C/2, z0=3C/2,
A=(2048/C^2+96/C)*(1+z0)/z0,
M=A/q, D=A*(1/q+1/q^2).
```

The following coarse powers of two suffice:

```
A<2^(11+3p), M<2^(12+4p), D<2^(13+5p).
```

For example, using `U>=1`, `A<2^11 U^3`, then multiplying by `4U/3` gives the M bound. Also `1/q+1/q^2<=28U^2/9`, which gives `D<2^13 U^5`. The script independently checks these inequalities against the exact rational constants.

Let `e_D=13+5p`, `J=e_D+12`, and take `h=3/(UJ)`. This is a positive rational step, not necessarily a dyadic step. The finite Fourier and direct-sum formulas permit it. Choose V and K so that `V=Kh` exactly.

| Parameter | T=1000000 | T=60343058 |
|---|---:|---:|
| p | 20 | 26 |
| r=kappa | 1/2000002 | 1/120686118 |
| q | 3/4000004 | 1/80457412 |
| J | 125 | 155 |
| h | 3/125000125 | 1/3117724715 |
| V | 15 | 18 |
| K | 625000625 | 56119044870 |
| rho | 1/64 | 1/64 |
| Taylor degree d | 19 | 24 |
| common node radius e | 2^-90 | 2^-105 |
| node center norm bound | 2^87 | 2^108 |
| common weight radius werr | 2^-127 | 2^-154 |

The choices satisfy `2V=p+10` and `6(d+1)=e_D+7`. Both selected V values are multiples of three, so K is an integer without rounding the node domain.

## 3. Quadrature and spatial errors

The accepted coefficient normalization is `f_j=F_b^(j)(s0)/j!`. Set `Den=exp(2*pi*r/h)-1`. Since `6r/h=J`, `pi>3`, and `exp(1)>2`,

```
Den>2^J-1>=2^(J-1).
```

Furthermore `Tr<1/2`, `(T+1)r=1/2`, and `exp(1/2)<2`. The accepted derivative coefficient bound uses D in place of M; because `M<D`, all orders satisfy

```
Q0=2M exp(Tr)/Den <2^-9,
Qj=2D exp((T+1)r)/Den <2^-9,  j>=1.                    (Q)
```

Indeed the common upper estimate is `4*2^e_D/2^(J-1)=2^-9`. No point-quadrature formula has been reused as a derivative bound.

For the discrete spatial tail, put `R=exp(2V)` and `x=qR`. Since `R>=2^(2V)` and `U<2^p`,

```
x > (3/4)*2^(2V-p)=768.
```

Thus both applicability conditions, x>=1 for values and x>=2 for positive derivatives, hold. The accepted errors are

```
S0=M exp(-x),
Sj=(A/q^2)*(x+1)*exp(-x), j>=1.
```

Using `x+1<=2 exp(x/2)` and `A/q^2<D`, all are bounded by `2D exp(-x/2)`. Since x>768 and `e_D<=143`,

```
Sj <2^(e_D+1-384)<=2^-240<2^-9.                        (S)
```

The script uses the sharper exact rational lower bound `q*2^(2V)` but does not evaluate an exponential. These are bounds for omitted Fourier nodes. They do not duplicate the theta tail inside each retained node radius.

## 4. Finite nodes, absolute centers, and weights

For every nonnegative k through K, a future producer must supply a rational complex center p_k with a proved Euclidean enclosure

```
|P(kh+i*b)-p_k|<=e.
```

Negative nodes use the full identity `P(-v+i*b)=conj(P(v+i*b))`, with conjugated centers and unchanged radii. Zero occurs once with full weight h. These are enclosures of the full kernel P, including all seed, modular, theta-series and arithmetic errors.

For every retained derivative order, the exact coefficient weight is

```
w_(j,k)=h*(kh)^j/j!*exp((s0-1/2)*kh).
```

By `|v|^j/j!<=exp(|v|)` and `|sigma-1/2|<=3/2`, the node-error contribution satisfies

```
Bj<=h*(2K+1)*e*exp(5V/2)
   <(2V+h)*e*2^(5V)<64*e*2^(5V)=2^-9.                 (B)
```

Here `exp(1)<4`, `h<=1`, and `2V+1<64`. The chosen e is `2^-(15+5V)`. This is a fresh high-height allocation, not a reuse of the small pilot's tolerance.

Before charging errors in weights, an absolute bound for each center is necessary. The accepted envelope gives

```
|P(kh+i*b)|<=A*exp(V/2),
|p_k|<=A*exp(V/2)+e<2^(11+3p+V+1).
```

The center bound is conditional on the actual P-ball enclosure; assigning a rational center alone does not establish it. Let `e_P=11+3p+V+1`, and let L be the bit length of `2K+1`, so `2K+1<2^L`. Requiring every weight-center ball to have radius

```
werr=2^-(e_P+L+9)
```

then gives

```
sum_k werr*|p_k| <2^-9.                               (W)
```

This includes the actual rational h, signed powers and factorials. For j>0 the zero-node weight is exactly zero. Conjugating a node does not justify dropping the sign of a negative-node power.

One possible serialization chooses node-center coordinate grids `2^-(node_bits+2)` and weight-center grids `2^-(weight_bits+2)`, rounding each center coordinate to the nearest grid point. This rounding has Euclidean error less than one quarter of the stated radius. These grids do not prove the radii; the certified elementary calculations plus rounding must pass them. Exact center products and sums have a common dyadic denominator `2^221` or `2^263`, respectively, so their summation error can be zero. This does not mean that the actual coefficients or exact irrational weights are dyadic.

The finite product-error split is `w(P-p)+(w-w_hat)p`. Consequently no independence assumption is used and no cross term is omitted. Denote exact rational center summation error by eta_j=0.

## 5. Complete disk ledger

For every retained j, combine (Q), (S), (B), and (W):

```
|f_j-fhat_j| <4/512=1/128.
```

The finite disk weight sum is less than `1/(1-rho)=64/63`, hence the total coefficient contribution is less than `1/126`.

The accepted unit-disk Cauchy bound gives

```
D*rho^(d+1)/(1-rho)
 <2^e_D*2^(-6(d+1))*64/63=1/126.
```

Therefore for all `|z|<=1/64`,

```
|F_b(s0+z)-sum_(j=0..d) fhat_j*z^j| <1/63<1/10.        (P)
```

This accounts for every analytic and finite-arithmetic term in the accepted composition formula. A later numerical evaluation of the polynomial itself must either be exact or charge its own error. A rational interval evaluation of the polynomial over a complete panel is still required to test nonvanishing. None of the present estimates asserts that such a test succeeds.

## 6. Optional analytic backend bounds, without a precision claim

The general modular-node paper plan can supply a finite analytical truncation recipe at these parameters. This section does not supply actual arithmetic records or a fixed working precision.

For `0<=v<=V`, the exact seed height is `exp(2v)*sin(2/U)>=1/U`. The elementary sine estimate applies because `2/U<=1`. Translations preserve height. Under the reviewed overlapping guards `|Re(t)|<3/5` and `Im(t)<1/2`, each S increases height by more than `100/61`. Choose m with

```
2*100^m>=U*61^m.
```

After m S steps the height exceeds 1/2, so another S cannot pass its guard and the `Im>=2/5` stopping guard can be certified by refinement. The exact comparisons give m=27 and m=35. This use of 1/2, rather than 2/5, covers an implementation that takes an S while both overlap guards are available. There are at most m+1 translations. Guard and branch checks are still required for each actual word.

At any S input the height remains at least 1/U, hence `|1/t|<=U` and `|(-it)^(-1/2)|<=sqrt(U)<=U`. For ordinary theta jets through order two, the accepted triangular S formulas have maximum row sum at most

```
U*((3/4)*U^2+3U^3+U^4)<5U^5<2^(3+5p).
```

Translation phases and type permutations have exact norm one. The final reconstruction

```
P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))
```

has row norm less than `2^(4+9V)`, using `|tau|=exp(2v)<2^(4V)` and `|exp(w/2)|<2^V`. Therefore a common terminal jet error is amplified by less than `2^Ltr`, where `Ltr=m*(3+5p)+4+9V`, equal to 2920 and 4821.

The accepted general tail gives `384*2^(-Mtail)` if `(2Ntheta+1)^2>=20Mtail`. Choose `Mtail=Ltr+node_bits+12`. Then the propagated omitted-series error is less than e/8. The resulting sufficient numbers of retained paired modes are 123 and 157. This leaves more than seven eighths of the node radius for finite terms, phases, seed uncertainty, coefficient errors, branches and arithmetic propagation.

All of those remaining operations must be enclosed with their actual errors. The accepted elementary and modular convergence arguments give finite refinement for a fixed finite node request whose domains and branches are certified. This note supplies neither a universal fixed bit precision nor a bound on refinement attempts. The finite analytic truncation bound is not a substitute for that checker implementation and its actual records.

## 7. Counts and limits of the feasibility claim

| Direct implementation count | T=1000000 | T=60343058 |
|---|---:|---:|
| Nonnegative kernel nodes | 625000626 | 56119044871 |
| Signed nodes in each coefficient sum | 1250001251 | 112238089741 |
| Coefficients per center | 20 | 25 |
| Center products per center, including known zeros | 25000025020 | 2805952243525 |
| Optional total retained mode exponentials | 76875076998 | 8810690044747 |
| Optional total S-step bound | 16875016902 | 1964166570485 |

The mode count uses one exponential shared by the three derivative orders, not three evaluations. It is an upper count for this chosen uniform analytic truncation, not for every conceivable implementation. The word bounds do not count elementary Taylor terms or arithmetic refinements. Center products are per Taylor center; the node table can be cached and shared across all centers having exactly the same b, h and K. Streaming exact sums avoids a requirement to retain all products simultaneously, but no memory or time guarantee is asserted. Optional FFT batching changes the arithmetic ledger and must include its proven transform error and scale; it is not used here.

The script `principal_production_scalar_plan_20261111.py` uses only Python integers, `Fraction`, hashes and JSON. It checks the pinned inputs, every rational parameter, all power-of-two inequalities, the full error ledger and the optional word/tail counts. It allocates no production node array and evaluates no transcendental function. Its JSON is a scalar receipt, not node evidence.

The missing production data are exactly the node inequalities, weight inequalities, and complete strict panel/contour comparisons. Their mathematical derivation is supported by the accepted evaluator plans but has not been instantiated across these grids. The finite records and all analytic adapters also remain to be formalized and kernel-checked. There is no new allowed assumption at the Goldbach root, and no positive spectral margin or feasibility claim about runtime follows from (P).
