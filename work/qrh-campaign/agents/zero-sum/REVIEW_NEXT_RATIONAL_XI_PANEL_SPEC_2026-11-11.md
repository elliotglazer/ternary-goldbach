# Independent review of the next rational xi panel specification

2026-11-11. **PASS as a conditional paper specification and exact scalar allocation**, with the four-inversion control-flow clarification in section 5 required of the future producer. The sharper fixed sixteen-mode tail and its exact transport are explicitly accepted below. No theta, P, xi, zeta, or L value was evaluated. This review does not certify any coefficient, half-plane comparison, or actual rectangle nonvanishing.

## 1. Frozen inputs and replay

Paths in this note are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
| --- | --- |
| `prime-estimates/NEXT_RATIONAL_XI_PANEL_SPEC_2026-11-11.md` | `92E778B5D9C767D18461CD0B239F94FD38B15023B13576FFBBC2EFFE8D00E957` |
| `prime-estimates/rational_panel_budget_20261111.py` | `7F6BBFA8DA690593121F287EB21BEADFA37D9C5EE6132744C5808687904AC013` |
| `prime-estimates/rational_panel_budget_20261111.json` | `B344780B1A7DD6D58C33BC73E9B49AD6FAB1AF70966123F70130977B756A59EF` |
| `integration/PRINCIPAL_XI_FOURIER_EVALUATOR_2026-11-11.md` | `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99` |
| `integration/PRINCIPAL_MODULAR_NODE_SUBSTITUTION_2026-11-11.md` | `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571` |
| `integration/PRINCIPAL_THETA_MODULAR_ACCELERATION_2026-11-11.md` | `C64EDFEB89B0F15B8B225241248BC7A751C385247843CE3AFEBF8FCF0382E84D` |

All hashes were checked. The author module was imported and its `run()` result compared to the frozen receipt, including all 63 planning rows; its main routine was not executed and the receipt was not overwritten.

The independent check uses 64-term alternating Machin bounds, 80 exponential terms after reduction to at most 1/4, and 256-bit outward dyadic rounding. Its 48 exact checks passed, including independent bounds no larger than every published selected decimal upper bound. It imports the author module only for the separately labelled replay; its second computation is independent of the author's arithmetic functions. No numerical special-function library is imported.

| Review artifact | SHA256 |
| --- | --- |
| `zero-sum/review_rational_xi_panel_20261111.py` | `91AC87941CFE6FE82A62AEF8A2524B3F68B5E8DFCA02038101B74559C71EE8B9` |
| `zero-sum/review_rational_xi_panel_20261111.json` | `1E937D647901A28D8A5CF837E71D0A40FEB984170E7123D0BA0227038DFB3315` |

Run from the workspace root using `work/qrh-campaign/interval-env/Scripts/python.exe work/qrh-campaign/agents/zero-sum/review_rational_xi_panel_20261111.py`. This writes only the review receipt. The observed run exited zero in about 1.8 seconds; this is not a node-production timing estimate.

## 2. Function, domains, and analytic allocation

The actual counted function is the entire

`F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, with `b=pi/4-1/33`.

It keeps the source's unhalved xi normalization. One fixed b is used for every node, derivative and contour point. There is no Hardy-realness assumption and no evaluation of the meromorphic Gamma-zeta product at its exceptional points.

Here `a=kappa=1/66`, `b+a=pi/4-1/66`, and `sin(1/33)>1/66`. Thus the reviewed strip envelope applies. Its constants recompute to

`A=46687168/3`, `M=2054235392/3`, `D=30813530880`, `q=1/44`.

The normalized coefficient integral contains `v^j/j!`. For positive order, shifting to Im(v)=±a costs the extra `exp(a)` and replaces M by D. Accordingly Qj has `exp(15*a)` whereas Q0 has `exp(14*a)`. This factor is present. The derivative spatial expression uses `q*exp(2V)>=2`, also checked, rather than the weaker undifferentiated threshold.

The recomputed upward bounds are Q0 <= .044099035744, Qj <= 2.014753071915, S0 <= .000008651087, Sj <= .012562284388 and Taylor tail <= .007117395068. Weighting positive orders by `G-1=sum_(j=1)^6 (1/64)^j` gives analytic disk error <= .083404690728.

`T_work=14` bounds the coefficient center, not every point in the target rectangle. This is legitimate here: no outer-circle values are sampled; the entire-function unit-disk bound D supplies the Taylor tail independently of height. The target disk need not lie inside the real strip used for the center bound, since the accepted D proof already enlarges that real strip by one.

## 3. Node, weight, and exact finite arithmetic

The node-radius allocation follows from `|v|^j/j!<=exp(|v|)` and the source uniform bound `|sigma-1/2|<=3/2`. Hence the conservative factor `exp(5V/2)` is valid, even though the actual center's real offset is only 1/10. With 1857 signed nodes, radius at most 2^-24 and h=1/256, each coefficient's node error is at most `1857/262144<1/128`.

The source P envelope, dropping its decreasing Gaussian factor, gives `|p_k|<=A*exp(V/2)+2^-24<2^27`. A weight-radius bound 2^-48 therefore gives coefficient error at most `1857/2097152<1/1024`.

The product decomposition `w(P-p)+(w-w_hat)p` is exact; it neither omits a cross term nor assumes independent errors. Grid choices alone do not establish either radius bound. The producer must prove them after rounding. Once both centers lie on the proposed dyadic grids, complex center products and their sums have exact common denominator 2^96, so the claimed zero summation error is valid with exact integer arithmetic.

Negative nodes require both evenness and conjugation: `P(-v+ib)=conj(P(v+ib))` for real v,b. The zero node is counted once; its six positive-order weights vanish exactly. No absolute values replace signed powers in the center sums.

The independent final total is bounded by the same rational decimal

`0.091500568239 < 1/10`.

## 4. Explicit acceptance of the fixed sixteen-mode tail and transport

The derivatives here are ordinary derivatives in tau, not logarithmic derivatives and not derivatives of a composed modular argument. This agrees with the source-faithful theta jet formulas in the pinned modular note.

For terminal height Y>=2/5 and j=0,1,2, a paired mode at positive t contributes at most `2*4^j*t^(2j)*exp(-(6/5)t^2)`. The first omitted t is 17 for theta3/theta4 and 16.5 for theta2. For the kth omitted pair, `16+k<=t<=17+k`, so all three orders and all three types are bounded by

`32*(17+k)^4*exp(-(6/5)*(16+k)^2)`.

This deliberately decouples the polynomial upper bound from the exponential lower argument. Since `17+k<=17(k+1)`, `(16+k)^2>=256+32k`, and `e>2`, summing gives a bound strictly below

`32*17^4*300*2^-307 < 2^-277`.

The exact moment `sum_(k>=0)(k+1)^4/2^k=300` and the integer prefactor were independently checked. This proves the sharper fixed-case claim without presuming the separate general terminal-tail supplement. Constant modes are included only in theta3/theta4 order zero, never in their positive derivatives or theta2.

For one S step, with A(tau)=(-i*tau)^(-1/2) on its source principal branch, the exact rows are

`A*g`,

`A*(-g/(2*tau)+g'/tau^2)`,

`A*(3*g/(4*tau^2)-3*g'/tau^3+g''/tau^4)`.

Every S input retains height >3/50, so `|1/tau|<50/3` and `|A|<5`. The displayed third-row bound is larger than both other row bounds and is strictly below 2^19. Translation phases have modulus one and only permute types. They do not amplify exact jet errors, although their numerical errors still need accounting.

With at most four S steps, exact transport amplifies the common terminal radius by less than 2^76. At the original point, the exact reconstruction

`P(w)=exp(w/2)*(6*tau*theta3'(tau)+4*tau^2*theta3''(tau))`

has norm factor at most `8*(6*2048+4*2048^2)<2^28`. Therefore the omitted-series contribution to the full P node is less than 2^-173. **This fixed sixteen-mode and transport claim passes.** It bounds exact analytic truncation only. Seed uncertainty, square roots, phases, intermediate points, finite arithmetic and interval dependency must additionally pass the final 2^-24 node-radius check.

## 5. Required control-flow clarification

The scalar inequality `(3/50)*(100/61)^4>2/5` proves that four inversions are sufficient, but does not force every possible sequence of overlapping guard choices to stop there. Its guaranteed lower bound is still below 1/2. An implementation that selects the `Y<1/2` inversion guard whenever available can take a fifth inversion even when stopping is already possible.

To enforce the advertised cap, after the fourth inversion the producer must refine and certify the stop guard, using the known strict bound above; it must not choose another inversion. Earlier it may stop at a certified terminal height >=2/5 or take S after certifying Y<1/2. Exact equality at 2/5 before the fourth step is not a termination problem: the upper guard remains strict. After the fourth, the derived lower bound is strictly greater than 2/5, so convergent enclosures can certify stopping without an equality oracle.

This implements the spec's phrase “at most four S steps are necessary.” With this clarification, the caps 3716 S steps and 14864 paired-mode exponentials are valid mathematical workload bounds. They do not bound interval refinements or runtime. The fixed precision/retry policy may still report incomplete.

The suggested negative-real exponential branch is also valid as an inequality: for exact x>=384, `0<exp(-x)<2^-384`, and [0,2^-320] is an outward enlargement. Below 384, ten halvings suffice to reduce to <=1/2. Uncertain interval arguments require a certified branch or enclosure covering both possibilities; a midpoint comparison alone is insufficient.

## 6. Conditional whole-rectangle conclusion

The real and imaginary half-widths of the stated rectangle are each exactly 1/128. Therefore its squared corner distance is `2/128^2 < 1/64^2`; all four closed edges and their interiors lie in the certified disk.

If newly proved coefficients give a rational `U>=sum_(j=1)^6 |fhat_j|rho^j` and `Re(fhat_0)-U>1/10`, then the strict error bound proves Re(F_b)>0 throughout the disk. This is a whole-region implication, stronger than checking vertices or sampled edges. The constant polygon with all five vertices equal to 1 lies in the same convex right half-plane and has winding zero. Homotopy and the argument principle then apply to this one entire function, subject to the existing formal contour adapters. Multiplication by its entire nonzero normalizer preserves xi zeros and orders.

No existing Arb coefficient, old observed sign, approximate midpoint value, or old modular word is an accepted input to this conclusion. The actual 929 node certificates, weights, seven coefficient centers and final strict comparison are still absent from this packet. Failure of any radius or comparison is an inconclusive future pilot, not evidence of a zero or a reason to change the domain. No Lean proof or full rational node-to-panel certificate is claimed by this review.
