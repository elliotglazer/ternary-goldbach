# Next rational xi panel: parameters and stopping rule

2026-11-11. This is an envelope-only pilot specification. No P, theta, xi, zeta or L-function value was evaluated, and no old Arb coefficient was used as a certified input. The proposed run would use 929 nonnegative nodes and seven Taylor coefficients. The exact analytic and arithmetic allocation below gives total disk error less than 1/10, conditional on the stated node and weight certificates actually being produced.

## 1. Fixed target and selected parameters

Keep the original function and geometry:

`F_b(s)=exp(-i*b*(s-1/2))*xiF(s)`, `b=pi/4-1/33`,

`s0=3/5+14i`, `rho=1/64`,

`rectangle=[379/640,389/640]+i*[1791/128,1793/128]`.

The rectangle is inside the disk because each coordinate displacement from s0 is at most 1/128. The polynomial and all node values must be newly certified for this exact b. The previously accepted nodes at b=pi/4-1/1000001 are inapplicable.

Select

`a=kappa=1/66`, `T_work=14`, `h=1/256`, `K=928`, `V=Kh=29/8`, `d=6`.

Using T_work=14 does not change b. The general Fourier bound permits any fixed admissible b and any work bound containing the coefficient center; the old choice T=32 was sufficient but unnecessary. No numerical outer-circle samples are proposed. The analytic unit-disk estimate supplies the Taylor remainder independent of the imaginary coordinate.

Here b+a=pi/4-1/66 and `cos(2*(b+a))=sin(1/33)>=1/66`; the latter follows already from `sin x>=x-x^3/6` at x=1/33. Thus the same envelope constants apply:

`A=46687168/3`, `M=2054235392/3`, `D=30813530880`, `q=1/44`.

The scalar experiment searched only seven h denominators, three V values and three degrees. It is a modest design comparison, not an optimality claim. At V=29/8,d=6 the analytic disk-error upper bounds are:

| 1/h | Nonnegative nodes | Analytic disk error, rounded up |
| ---: | ---: | ---: |
| 192 | 697 | 33.684017114982 |
| 208 | 755 | 7.349312407781 |
| 224 | 813 | 1.607980685167 |
| 240 | 871 | 0.356290544774 |
| 256 | 929 | 0.083404690728 |
| 320 | 1161 | 0.007497318632 |
| 384 | 1393 | 0.007325835769 |

The chosen denominator is the first in this list below the analytic allocation 1/8. V=7/2 has an unnecessarily large spatial tail at this h; V=15/4 adds nodes without being needed. Degree 5 has a large Cauchy remainder; degree 6 suffices. The receipt retains all 63 comparisons. Relative to the old h=1/512,K=2048,d=12 pilot, this design reduces the node and coefficient workload while retaining a useful absolute-error target.

## 2. Complete error allocation

Let `G=sum_(j=0)^6 rho^j <64/63`. The checked bounds are:

| Term | Rational decimal upper bound |
| --- | ---: |
| Q0 | 0.044099035744 |
| Qj, each j>=1 | 2.014753071915 |
| S0 | 0.000008651087 |
| Sj, each j>=1 | 0.012562284388 |
| Cauchy remainder `D*rho^7/(1-rho)` | 0.007117395068 |
| `Q0+S0+(Qj+Sj)*(G-1)+Cauchy` | 0.083404690728 |

Positive-degree coefficient errors need not themselves be below 1/10: their disk contributions are weighted by rho^j. This is why using Qj as a uniform unweighted disk error would overbudget the run. The stronger derivative cutoff q*exp(2V)>=2 is checked exactly by a rational lower enclosure.

Require every nonnegative node to have a complex rational center p_k and a certified Euclidean radius

`e_k <= 2^-24`.

Use full-kernel evenness and conjugation to transport negative nodes, with identical radii, and count zero once. The common-radius bound gives, for every coefficient,

`B_j <= h*(2K+1)*2^-24*exp(5V/2)`

`< (1857/256)*2^-24*2^14 = 1857/262144 <1/128`.

The envelope and node radius also give

`|p_k| <= A*exp(V/2)+2^-24 <2^27`.

Require every signed weight center to enclose

`w_(j,k)=h*v_k^j/j!*exp((1/10+14i)*v_k)`

with radius `d_(j,k)<=2^-48`. Then its aggregate contribution per coefficient is at most

`sum_k d_(j,k)|p_k| <=1857/2^21 <1/1024`.

Choose node centers on the grid 2^-32 and weight centers on 2^-64, but verify the above total radii after this rounding; the grids are not proofs of those radii. Sum the center products as exact integers over denominator 2^96, so eta_j=0. All signed powers are retained. At zero the six positive-degree weights are exactly zero.

The resulting total error about the newly computed degree-6 polynomial is bounded by

`analytic_error + G*(1857/262144+1857/2097152)`

`<=0.091500568239 <1/10`.

Every displayed decimal is an upward rational rounding of a rational upper bound. There is no floating-point evaluation. The split `w(P-p)+(w-w_hat)p` includes all product error; no mixed term is omitted or double-counted.

## 3. Deterministic workload and available backend

There are 929 nonnegative nodes, 1857 signed nodes, seven coefficients and 12999 center products. Six products at k=0 are known zero. A direct weight implementation needs at most 1856 nontrivial complex exponentials, reusing each across all seven orders via exact rational multiplication by v_k/(j+1). Node phases, exp factors and pi can be shared where their identities are exact. No FFT or off-grid interpolation is proposed.

The high-level node workload can also be bounded before evaluating values. For v in [0,29/8],

`tau=exp(2v)*(-cos(2/33)+i*sin(2/33))`.

The scalar checks give `Im(tau)>3/50` and `|tau|<2048`. After a certified nearest-integer translation, use |Re(t)|<3/5. Stop when the terminal lower height is at least 2/5; otherwise an overlapping guard Im(t)<1/2 permits S. Such an S increases height by more than 100/61. Since

`(3/50)*(100/61)^4 >2/5`,

at most four S steps are necessary under this guarded procedure. Refinement is needed to certify a guard, but the overlapping height thresholds prevent a forced exact-equality decision. A translation can use a rational midpoint with error strictly below 1/10, then certify the resulting real interval lies in (-3/5,3/5). The actual retained word must still pass every guard.

Thus the proposed cap is 3716 S steps, with one more translation per node than its S count. Each step needs its own certified reciprocal and positive-real square-root branch. The complete type and phase permutation must be retained. None of the five-step word at T=10^6 is reusable as a word for this grid.

At the terminal point, retain sixteen paired modes of the required classical theta type: n=1,...,16 for theta3/theta4, or n=0,...,15 for theta2. The value and first two derivatives share each exponential. This is at most 14864 terminal-mode complex exponentials, not three times that number. Theta3/theta4 have the exact constant mode in the value; their positive derivatives do not. Theta2 has no constant mode.

There is a simple uniform analytic tail allowance. With terminal Y>=2/5, pi>3 and derivative order j<=2, the omitted pairs are bounded by

`2*16*sum_(k>=0) (17+k)^4*exp(-(6/5)*(16+k)^2)`.

Use `(17+k)^4<=17^4*(k+1)^4`, `(16+k)^2>=256+32k`, `exp(1)>2`, and `sum (k+1)^4/2^k=300`. The prefactor is below 2^30 and the common exponential is below 2^-307. Hence each omitted terminal jet has error below 2^-277. This estimate covers the integer and half-integer tails together; it deliberately starts earlier than their actual first omitted modes.

For every S input, |1/t|<=50/3 and |A(t)|<5. The infinity norm of the exact triangular jet transformation is bounded by

`5*((3/4)*(50/3)^2+3*(50/3)^3+(50/3)^4) <2^19`.

This bounds the largest row; the other two are smaller. Four transforms cost at most 2^76. The final P reconstruction has norm factor at most

`8*(6*2048+4*2048^2)<2^28`.

The omitted terminal-series contribution to P is therefore below 2^-173, much smaller than 2^-24. This bounds the analytic tail only. Roundoff and interval overestimation in seeds, words, roots, phases and transport must still fit the actual node-radius test. No estimate here proves that fixed-precision evaluation will meet it.

The current `integration/r1over8_p_node_exact_20261111.py` provides useful rational arithmetic, Machin pi, range-reduced Taylor exp and reduced-angle cis routines. Its `run()` is a fixed T=10^6 node: it consumes a fixed five-inversion word, assumes terminal theta2 at height >=9, and retains four modes. It cannot be run unchanged on the proposed grid. Required work is a generic checked word generator, all three terminal types and the new tail certificate, with every interval operation propagated from serialized inputs.

The elementary argument domains are manageable, but must be enforced. Seeds use exp(2v) with 0<=2v<=29/4 and prefactors use exp(v/2) with v/2<=29/16. Weight exponential real parts have magnitude at most 29/80; their phases have magnitude at most 203/4. The existing Taylor range reduction can cover these. Terminal Gaussian exponents can be much larger: the existing positive-exp helper has a 16-squaring cap. Avoid overflowing that cap when evaluating exp(-x) by certifying x>=384 and returning [0,2^-384], or its outward-rounded [0,2^-320], from exp(1)>2. For x<384, range reduction to <=1/2 takes at most ten squarings. This underflow enclosure is an additional proved branch, not silent replacement by zero.

## 4. Future bounded run and exact stopping rule

This note does not authorize or execute the run. A future pilot should keep the above parameters immutable and use at most 929 nodes, four S steps per node and sixteen terminal modes. A reasonable resource policy is 320-bit outward working intervals, one optional retry at 512 bits, and a fixed wall-time cap with resumable records. The cap is an operational stop, not a prediction of runtime.

Stop and report incomplete on any unverified seed/word identity, unresolved guard at the refinement cap, rejected arithmetic witness, excess node radius, excess weight radius, or exhausted resource cap. Preserve the failing input and partial records. Do not silently widen a budget, import an Arb value, change b, or count unresolved nodes as certified.

If all coefficients are certified, compute a rational U with

`U>=sum_(j=1)^6 |fhat_j|*rho^j`.

L1 norms of rational complex coefficients suffice and avoid square-root evaluation. Accept the whole disk in the positive-real half-plane only if

`Re(fhat_0)-U >1/10`.

Together with the certified error below 1/10, this proves Re(F_b)>0 on the disk and hence on the existing closed rectangle. Use the constant rational surrogate image vertex 1 at all five vertices; all four crossing contributions are zero. If the comparison fails, report an inconclusive panel, even if an old Arb pilot passed. No old coefficient center or observed sign enters this certificate.

## 5. Exact planning evidence

The new standard-library scalar script is `prime-estimates/rational_panel_budget_20261111.py`, SHA256 `7F6BBFA8DA690593121F287EB21BEADFA37D9C5EE6132744C5808687904AC013`. Its deterministic receipt is `prime-estimates/rational_panel_budget_20261111.json`, SHA256 `B344780B1A7DD6D58C33BC73E9B49AD6FAB1AF70966123F70130977B756A59EF`.

The script uses a 48-term alternating Machin enclosure for pi and a 64-term nonnegative Taylor enclosure after exponential range reduction. Its first omitted term is divided by `1-t/(N+1)` for a geometric all-index tail, then every squaring is rounded outward to a 192-bit dyadic grid. Negative exponentials are bounded by reciprocals of positive lower bounds. It evaluates only envelope constants and design inequalities. It does not import any node producer or numerical library.

The analytic inputs remain the reviewed Fourier note `6920406603A615022B7277407BF12FE3837C54B053BBB131DA23CC8C35387F99`, node-substitution note `5950604713D39C0A60194D58453D72E74E947120CB110252739D728BFCF1E571`, and frontier review `1ACF909F6EC6449D00441F468333193195AE4AF4F7D9DBACA71C228FA997F53C`. The old disk/rectangle is reused only for its exact geometric target. No full rational node-to-panel packet exists as a consequence of these scalar checks, and no Lean validation is claimed.
