# Substituting modular theta nodes into the principal xi evaluator

2026-11-11. Paper composition interface, submitted for independent review. Certified modular evaluations of the full kernel P can replace direct Gaussian summation at the retained Fourier nodes. This note gives point, derivative, Taylor, and panel error bounds for that substitution. It supplies no new spectral fact, numerical scan, or Lean proof.

## 1. Pinned inputs and acceptance boundary

All paths below are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
| --- | --- |
| `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md` | `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99` |
| `audit/REVIEW_PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md` | `ECBC1125309A4AA81EBFF709A9637A0AD7D554A1ABBAF9E350AAF2969F3A85D2` |
| `integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md` | `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D` |
| `audit/REVIEW_PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md` | `9C2C4348EC29A5C3B4ACD6221CFE96F011C191395877E3654FC69DD81C7987ED` |
| `prime-estimates/PRINCIPAL_THETA_MODULAR_PILOT_2026-11-11.md` | `F0833712D50FBE36BDC8E29173A277CCBDC2C0CBAF4A1F7CA86F4F80B28E752D` |
| `independent-feasibility/REVIEW_PRINCIPAL_THETA_MODULAR_PILOT_2026-11-11.md` | `DC6B6117AD793BF2983231373F54710A65E65F3E73A7E9B73CDB86664D38BA9F` |

The pilot review accepts four external coefficient evaluations, not a complete quadrature grid or a proof-producing interval implementation. Arbitrary node enclosures below are explicit mathematical inputs to a composition lemma. They must be produced and proved inside a final theorem; they are not new permanent hypotheses allowed at the Goldbach root.

The source target remains the unhalved `TernaryGoldbach.Explicit.xiF` at commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, with the Mathlib pin recorded in the inputs.

## 2. Exact function, domain, and nodes

Fix a real b, r>0, and positive rational kappa with

```
|b|+r<pi/4,       kappa<=cos(2*(|b|+r)).
```

Keep this same exact b for every node and throughout a Taylor disk or panel. Define

```
F_b(s)=exp(-I*b*(s-1/2))*xiF(s)
      = integral_R P(v+I*b)*exp((s-1/2)*v) dv.
```

The accepted full kernel is

```
P(w)=sum_(n>=1) (8*pi^2*n^4*exp(9w/2)-12*pi*n^2*exp(5w/2))
                    *exp(-pi*n^2*exp(2w)).
```

It already includes the differentiated-theta normalization. No extra factor 2, added constant, or n=0 Gaussian term belongs in the node values.

Let the center s0=sigma+I*t satisfy `0.4968<=sigma<=2` and `|t|<=T`, with T>=1. Choose h>0 rational, K a nonnegative integer, V=K*h, and nodes v_k=k*h for -K<=k<=K. Supply complex rational centers p_k and nonnegative rational radii e_k with

```
|P(v_k+I*b)-p_k|<=e_k.                                     (N)
```

A dyadic endpoint box can be converted to such a disk with a proved norm bound. Every box must enclose the value at the exact common b, not merely at a displayed approximation to b. Its modular-reduction, root, reduced-series, and rounding errors are all included in e_k.

For k<0 one may use exact evenness

```
P(v_k+I*b)=P(-v_k-I*b).
```

Replacing the argument by `|v_k|+I*b` without an additional proved conjugation step is incorrect. If kernel conjugation is used, transport the full complex enclosure. The k=0 node occurs once, with full trapezoid weight h. Do not halve it or duplicate it. For positive derivative order its weight is exactly zero. An enclosure containing zero, even an extremely small one, does not prove the node value is zero.

## 3. Analytic bounds for each Taylor coefficient

Use the constants from the corrected Fourier note:

```
C=3*kappa,  q=C/2,  z0=3*C/2,
A=(2048/C^2+96/C)*(1+z0)/z0,
M=A/q,     D=A*(1/q+1/q^2).
```

For every integer j>=0 the exact Taylor coefficient is

```
f_j = F_b^(j)(s0)/j!
    = integral_R (v^j/j!)*P(v+I*b)*exp((s0-1/2)*v) dv.       (C)
```

Differentiation is justified by the accepted Gaussian domination on compact s sets. Let `Den=exp(2*pi*r/h)-1`, which is positive. The infinite-trapezoid error for (C) is bounded by

```
Q_0 = 2*M*exp(T*r)/Den,
Q_j = 2*D*exp((T+1)*r)/Den,       j>=1.                    (Q)
```

For the derivative case, on Im(w)=+r or -r use

```
|w|^j/j! <= exp(|w|) <= exp(|Re(w)|+r).
```

The additional exp(|Re(w)|) changes the accepted boundary-integral majorant from M to D. The factor exp(r) remains. Thus (Q) is not obtained by simply reusing the undifferentiated bound. The division by j! is already included; for ordinary derivatives multiply the final coefficient error by j!.

Put R=exp(2V). The omitted discrete nodes have bounds

```
S_0 = (A/q)*exp(-q*R),                  require q*R>=1,
S_j = A*exp(-q*R)*(R/q+1/q^2), j>=1,    require q*R>=2.     (S)
```

The second formula uses `|v|^j/j!<=exp(|v|)` and then the coarser majorant `A*exp(4|v|-q*exp(2|v|))`. Its continuous tail has the stated integral. It bounds the omitted discrete samples only after that majorant becomes decreasing, hence the stronger threshold 2. For a packet containing any positive derivative order, impose q*R>=2 for all coefficients. These bounds are uniform in every finite j under consideration, though deliberately conservative.

## 4. Node and finite-arithmetic errors

The ideal finite sum using exact full-kernel values is

```
C_j = sum_(k=-K..K) w_(j,k)*P(v_k+I*b),
w_(j,k) = h*(v_k^j/j!)*exp((s0-1/2)*v_k).
```

Substituting (N) changes it by at most

```
B_j = h*sum_(k=-K..K) e_k*(|v_k|^j/j!)
                             *exp((sigma-1/2)*v_k).        (B)
```

Use v^0=1 also at v=0; for j>0 the zero-node summand is zero. The signed exponential and the parity of v^j must be preserved in the actual center sum. The absolute values in (B) bound errors only. One may replace the exponential by exp(3*|v_k|/2) for a coarser bound uniform in sigma.

Suppose certified weight centers w_hat_(j,k) satisfy `|w_(j,k)-w_hat_(j,k)|<=d_(j,k)`, and the computed sum f_hat_j differs from the exact rational sum of `w_hat_(j,k)*p_k` by at most eta_j. Then

```
|f_j-f_hat_j| <= E_j,
E_j = Q_j+S_j+B_j+sum_k d_(j,k)*|p_k|+eta_j.               (E)
```

To see that no mixed term is missing, split each product as `w*(P-p)+(w-w_hat)*p`, then account for summation arithmetic. A certified upper bound for |p_k| and the real exponentials may replace their exact values in the radius calculation. Shared pi, b, modular factors, or arithmetic errors need not be independent.

There is no additional direct-Gaussian truncation term in (E). A modular node radius e_k already encloses the full P value, including its reduced-series tail. The old error from truncating P to its first N unreduced Gaussian terms is replaced by B_j, not added to it. If an individual node instead uses direct summation, its direct tail belongs inside that node's e_k; the same composition formula still applies. Q_j and S_j remain because node evaluation does not remove quadrature error or the omitted Fourier nodes.

## 5. Point and panel outputs

For a point output, (E) with j=0 gives the ball centered at f_hat_0 with radius E_0 for the actual F_b(s0).

For a Taylor packet through degree d and any 0<=rho<1, the accepted Cauchy bound gives

```
|F_b(s0+z)-sum_(j=0..d) f_hat_j*z^j|
 <= sum_(j=0..d) E_j*rho^j + D*rho^(d+1)/(1-rho),
                                      whenever |z|<=rho.   (P)
```

The constant D bounds F_b on the unit disk about s0 because its real part lies within distance one of the original sigma interval. This is a bound on the entire function, independent of the imaginary coordinate; obtaining coefficient balls by (E) only needs the center's |t|<=T. If a different coefficient algorithm samples an outer Cauchy circle numerically, its own evaluations must use a work height covering that circle.

For a straight panel, enclose the polynomial on its actual parameter segment and add the radius in (P). Exclusion of zero by this complete enclosure proves panel nonvanishing. Midpoint exclusion alone does not. A first-order alternative is `|f_hat_0|-E_0>D*ell` for a panel whose points are within ell of the midpoint and remain in the original real strip. Neither criterion is guaranteed to succeed when the function is small or has a zero on the panel.

To recover xi at a point, enclose `m(s)=exp(I*b*(s-1/2))` by m_hat with radius e_m and prove |m(s)|<=M_m. From an F_b ball with center f_hat and radius E, a final rounded product has error at most

```
M_m*E + e_m*|f_hat| + eta_product.
```

For zero counts recovery is unnecessary: with one fixed b, m is an entire nonzero multiplier and has zero winding on closed contours. If different b values are used on different panels, their F_b values cannot be concatenated as one function without explicit normalization or the correction `xiF'/xiF=F_b'/F_b+I*b`.

## 6. Optional FFT batching and exact scales

At fixed sigma, fixed b, and a base ordinate t_base, define for each coefficient order j a signed-node array

```
a_(j,k)=(v_k^j/j!)*p_k*exp((sigma-1/2)*v_k)*exp(I*t_base*v_k).
```

Embed -K,...,K into distinct residues modulo L, with L>=2K+1, and zero-pad the remaining entries. For `t_l=t_base+2*pi*l/(L*h)`, the desired finite coefficient center is h times its unnormalized positive DFT. Therefore:

* A normalized positive radix-two output is multiplied by h*L.
* An unnormalized Bluestein output is multiplied by h.

The j! factor is already in the input array and must not be applied again. Negative nodes retain their signed power v_k^j, and zero occurs once. The finite arithmetic error of the chosen transform, after the appropriate scale, replaces the direct-sum eta_j and includes the cost of constructing its input centers. Node errors still use (B), with the same exact finite map. Count each rounding stage once under a declared error split.

Only output ordinates in |t_l|<=T inherit (Q). The finite DFT's periodicity supplies no periodicity of F_b. Off-grid values need the Taylor/panel argument or a separately certified evaluation.

## 7. Remaining leaves and scope

The corrected analytic Fourier note supplies paper arguments for (C), (Q), (S), and the unit-disk remainder. The modular plan supplies a paper route to (N); its four-point pilot is accepted external evidence for four particular nodes only. An actual packet still requires every retained exact node, its modular word and series/rounding certificate, trustworthy serialization, finite weights and arithmetic, and the strict enclosure comparisons.

The future Lean composition lemma can be proved by finite triangle inequalities after the analytic quadrature and tail lemmas are formalized. It must be instantiated with proved node inequalities, not an assumed evaluator correctness predicate. The primitive arithmetic checker, source theta adapters, analytic identities, and full packet are not yet formal proofs.

This substitution changes neither the separate conductor-one family height 60343058 nor the narrow principal strip obligation through one million. It establishes no zero-free rectangle, zero multiplicity, count saturation, or final Goldbach theorem. It only specifies how valid node evidence becomes valid point and panel evidence for the exact existing function.
