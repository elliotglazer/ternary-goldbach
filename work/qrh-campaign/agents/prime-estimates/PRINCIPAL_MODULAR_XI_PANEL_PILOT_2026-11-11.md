# One modular-node xi Taylor disk

The bounded external pilot completed all 2049 nonnegative kernel nodes and all 13 Taylor coefficients. Its complete error bound excludes zero throughout the closed disk

\[
|s-(3/5+14i)|\le1/64.
\]

This is an external interval-arithmetic result using the accepted paper identities, not a Lean theorem or a verified elementary-arithmetic checker. It covers this disk only; it is not a sign chain, zero count, high-height scan, or spectral-completeness claim.

## Frozen dependencies and artifacts

Paths in this section are relative to `work/qrh-campaign/agents/`.

| Artifact | SHA256 |
|---|---|
| `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571` |
| `major-constants/REVIEW_PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `FB75E5919ECFD5F7800290C64DD1C0DFFCA7EA4FDFAE4B5FB4BFBBF4B3B27DAD` |
| `prime-estimates/principal_theta_modular_pilot_20261111.py` | `EAFAC6A19BE3947CBF6D4BA6F900FE3E8BAB58E1C1963E0C1DC35A61A6F55B14` |
| `prime-estimates/principal_modular_xi_panel_pilot_20261111.py` | `626A931E23A0B3585C0803D34D920BE759E792B230638BDD0E48155874203416` |
| `prime-estimates/principal_modular_xi_panel_pilot_20261111.json` | `0B01EC0CA4A0102816CFB22DE51AE5751975288AC1544F5ABBABCA84BF4A8608` |

The script checks the first three pins before running. It imports the frozen helper without executing that helper's four-point main program or modifying its bytes. The helper's pin check also binds the accepted modular-theta source. Its reduced series, explicit principal square root, S/T transformations and ordinary derivative jets are reused unchanged. The composition note binds the accepted Fourier identity, analytic tails and Cauchy remainder.

## Function and exact parameters

The target is the actual unhalved source function, under one fixed normalization:

\[
F_b(s)=e^{-ib(s-1/2)}\operatorname{xiF}(s),\qquad
b=\pi/4-1/33.
\]

The retained kernel is the full differentiated theta kernel P from the accepted Fourier identity. The exact parameters are

\[
s_0=3/5+14i,\quad T=32,\quad r=\kappa=1/66,\quad
h=1/512,\quad K=2048,\quad V=Kh=4,\quad d=12,\quad\rho=1/64.
\]

The script verifies `b>0`, `b+r<pi/4`, `kappa<cos(2*(b+r))`, the center's real-strip and height conditions, a positive trapezoid denominator, and `q*exp(2V)>=2`. The last condition is the stronger derivative-tail threshold, not just the undifferentiated threshold 1.

The rational envelope constants are

\[
C=1/22,\quad q=1/44,\quad z_0=3/44,\quad
A=46687168/3,\quad M=2054235392/3,\quad D=30813530880.
\]

They are recomputed from the accepted formulas, not fitted to the output. T=32 safely bounds the center's ordinate 14. The Cauchy remainder uses the analytic unit-disk bound; it does not require a separate numerical outer-circle evaluation.

## Every kernel node and the negative half

For each k from 0 through 2048, let `v=k/512` and compute P at the exact argument `w=v+i*b`. The initial modular parameter is evaluated as

\[
\tau=e^{2v}(-\cos(2/33)+i\sin(2/33)),
\]

which equals `i*exp(2w)`. It is not a computation at an approximate displayed b. Every S/T decision is checked by strict interval inequalities. The reduced sums retain 20 integer pairs and 20 half-integer pairs; their explicit derivative tails are added before reverse jet propagation. The full node P is reconstructed from `exp(w/2)*(6*tau*theta3'+4*tau^2*theta3'')`.

The receipt retains each integer word, final P interval, dyadic center and radius. The imported pinned code deterministically reconstructs all intermediate roots, reduced terms and propagation jets. This pilot does not repeat the large intermediate trace for each of 2049 nodes. There are 495 S inversions across these nodes.

For k>0 the negative node is obtained from both identities

\[
P(-v+ib)=P(v-ib)=\overline{P(v+ib)}.
\]

The first is the accepted full-kernel evenness, not evenness of an individual Gaussian term. The second follows from the normally convergent series with real coefficients. Both transport the complete complex enclosure. The center's imaginary part is negated and the radius is unchanged. The zero node appears once, with full trapezoid weight h; it is not doubled or halved.

## Rational centers, weights and exact finite sums

Set `S=2^128`. For each computed complex box with outward integer endpoints `[a/S,c/S]` and `[d/S,f/S]`, choose

\[
x=\lfloor(a+c)/2\rfloor,\quad y=\lfloor(d+f)/2\rfloor,
\quad e=\max(x-a,c-x)+\max(y-d,f-y).
\]

Then `(x+i*y)/S` is a rational center and `e/S` bounds its Euclidean error by the L1 inequality. This conversion includes the elementary, modular, reduced-series and rounding errors. It does not confuse componentwise radii with a complex norm radius.

For every signed node and j=0,...,12, the exact weight is

\[
w_{j,k}=h\frac{v_k^j}{j!}\exp((s_0-1/2)v_k).
\]

Its interval is converted by the same rule to integer center `(u+i*v)/S` and error `a/S`. All 53261 such triples are retained. Powers of negative nodes keep their sign; only error weights use absolute values. At k=0 the j=0 power is one, while every positive-j weight is exactly zero.

Products of weight centers and node centers have denominator S squared. Their real and imaginary numerators are summed using exact Python integers. Thus the finite summation error `eta_j` in the composition theorem is exactly zero. The denominator and both integer numerators of every final coefficient center are retained. There is no floating summation step hidden in that claim.

## Four distinct errors and the disk calculation

For each coefficient `f_j=F_b^(j)(s0)/j!`, the receipt separately records:

1. `Q`: the accepted infinite-trapezoid error, using M at j=0 and the larger derivative formula with D and the additional factor exp(r) at j>0.
2. `S`: the omitted spatial-node error, using the derivative expression at j>0 and the verified monotonicity threshold 2.
3. `node_error`: an outward upper bound for `h*sum e_k*abs(v_k)^j/j!*exp((sigma-1/2)*v_k)`.
4. `weight_error`: the exact rational sum of weight radii times the L1 norms of node centers.

Their sum bounds the error of the exact rational coefficient center. The decomposition is `w*(P-p)+(w-w_hat)*p`, so no mixed product has been omitted. The old unreduced-Gaussian truncation allowance is not added again: reduced tails already belong to the node radii.

The constant coefficient has error less than `1.509e-12`. Each positive-degree coefficient has error less than `6.894e-11`; these are intentionally rounded-up decimal summaries of exact saved rational bounds. The saved constant center is approximately

\[
\widehat f_0=15.918852745419784+11.366343602642310i.
\]

For the whole disk, the complete error relative to the rational polynomial is

\[
E_{\rm poly}=\sum_{j=0}^{12} E_j\rho^j+
D\frac{\rho^{13}}{1-\rho}<2.707\,10^{-12}.
\]

The Cauchy remainder alone is less than `1.036e-13`. To avoid any unaccounted polynomial-evaluation rounding, the script encloses every norm of the exact rational coefficient center and sums

\[
U\ge\sum_{j=1}^{12}|\widehat f_j|\rho^j,
\qquad U<1.783184580413.
\]

It also obtains an outward rational lower bound L for `abs(f_hat_0)`, with `L>19.560256634913`. All final comparisons use the saved fractions, not these decimals. In particular,

\[
L-U-E_{\rm poly}>17.77707205449>0.
\]

Therefore every actual F_b value on the complete closed disk lies in the disk centered at the exact rational constant coefficient with radius `U+E_poly`, which excludes zero. The normalization multiplier is entire and nonzero, so this same disk contains no zero of xiF. This is not a claim that xi derivative jets follow by multiplying the F_b jets by one scalar; no xi derivative packet is produced. Nor is a disk exclusion being presented as a separately specified polygon half-plane receipt.

## Work and acceptance boundary

The final run completed in 12.1064312 seconds of measured internal wall time and 12.0 seconds process CPU, excluding subsequent JSON serialization. Its receipt is 11621888 bytes. There were 2049 modular evaluations, 4097 signed node contributions, 53261 weight evaluations and exact center products. A 240-second computation guard remained far away. The parameters were not adjusted or tuned after an unsuccessful disk test. A preceding run at the same parameters was repeated only to bind the final composition/review hashes into the receipt.

No builtin theta, zeta, Gamma, Hardy-Z or Riemann-Siegel value is used. The elementary intervals still rely on the external Arb backend, and integer arithmetic/serialization on the external Python execution. Formal source adapters, analytic identities, interval-checker soundness and Lean instantiation remain unimplemented here. Independent replay should check all words and node radii, signed weights and integer sums, the four error components, the full disk comparison, and preferably compute the coefficients by an alternate direct kernel/quadrature route. Agreement at sample points would not replace the whole-disk error proof.
