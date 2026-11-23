# Independent review of the principal count formal bridge

2026-11-11. PASS as a paper derivation and source-level implementation ledger, with one nonblocking declaration-name correction. I found no missing mathematical premise, Gamma-branch error, contour-sign error or multiplicity factor error in the reviewed argument. This is a new review of the derivation, not an inference from the earlier numerical top-count replay. No Lean theorem, compiled interface, full dependency-axiom closure or numerical certificate is established by this review.

## Pin and source checks

Reviewed `moebius/PRINCIPAL_COUNT_FORMAL_BRIDGE_2026-11-11.md`, SHA256:

`0A2F4766FCB77668C5461E8A63B97327EF2E6F595E66F805544A7EFA49A4A028`.

I independently confirmed target commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, Lean version `v4.35.0`, and the inspected Mathlib commit `56a005855ea17e0b0958f73ec801ae140b0a1679`. The latter checkout is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib`. The checked target and Mathlib files listed below have no tracked working-tree diff. The Mathlib commit read used a command-local `safe.directory` setting; no persistent Git configuration was changed.

The one exact API correction is **`Real.eq_Gamma_of_log_convex`**, at `Mathlib/Analysis/SpecialFunctions/Gamma/BohrMollerup.lean:307`. It is not `Real.BohrMollerup.eq_Gamma_of_log_convex`. The inner namespace ends at line 302, whereas the similarly named section continues. Its actual hypotheses are convexity of `Real.log o f` on `Ioi 0`, the positive-real recurrence, positive values and `f 1 = 1`, and its conclusion is `EqOn f Real.Gamma (Ioi 0)`. These match the argument after this naming correction. The frozen producer remains unchanged; this review is the erratum.

## 1. The normalized Gamma construction is sufficient

The kernel is defined only on `u>0`. Its value at zero may be assigned arbitrarily because the integral is over `Ioi 0`. Clearing positive denominators reduces its two bounds to

`(u-2)exp(u)+u+2 >= 0`,

`(u^2-6u+12)exp(u)-u^2-6u-12 >= 0`.

I independently expanded their general coefficients. The first cancels through degree two and then has coefficient `(n-2)/n!`. The second cancels through degree four and then has coefficient `(n-3)(n-4)/n!`. Absolute convergence permits the finite polynomial products and rearrangements. Thus `0<=k(u)<=1/12` is an all-positive-real argument, not a finite numerical test.

For any `a>0` and `Re z>=a`, the integrand and its first two complex derivatives are bounded respectively by

`exp(-a*u)/12`, `u*exp(-a*u)/12`, `u^2*exp(-a*u)/12`.

These are integrable on the whole positive half-line, including its zero endpoint. Measurability follows from continuity on `u>0`. Taking a smaller positive `a` in a neighborhood of any fixed `z` proves complex differentiability under the integral and then analyticity on the open right half-plane. The same bounds justify the two real differentiations used later. In particular `|R(z)|<=1/(12 Re z)`. No unproved cancellation at `u=0` or uniform estimate reaching `Re z=0` is needed.

Write `h(x)=Re H(x)` for positive real `x`. The imaginary part is zero there because both the logarithm and integrand are real. Direct differentiation gives

`h''(x)=1/x+1/(2x^2)+integral exp(-xu)u^2 k(u)du`.

Since `u^2 k(u)=u/(exp u-1)-1+u/2`, this becomes

`h''(x)=1/x^2+integral exp(-xu)u/(exp u-1)du`

`=sum_(n>=0) 1/(x+n)^2`.

For the last equality, expand `1/(exp u-1)=sum_(n>=1) exp(-nu)`. All terms in the resulting real integral are nonnegative, so Tonelli is available; the finite integral bound above ensures the result is finite. This proves strict positivity, and hence the required convexity of `h-h(1)`.

Integration on `[x,x+1]` is also justified by nonnegativity and continuity. Its partial sums telescope exactly to

`sum_(n=0..M) [1/(x+n)-1/(x+1+n)] = 1/x-1/(x+M+1)`.

Passing to the limit yields `h'(x+1)-h'(x)=1/x`. Therefore the derivative of `D(x)=h(x+1)-h(x)-log x` vanishes on the connected interval `x>0`. The stated limit determines this constant without Stirling's formula: the elementary main term is `(x+1/2)log(1+1/x)-1`, which tends to zero, while both remainder values tend to zero by the explicit `1/(12x)` bound. Thus `D=0`.

Consequently `f(x)=exp(h(x)-h(1))` is positive, normalized at one, log-convex, and satisfies `f(x+1)=x*f(x)`. The actual `Real.eq_Gamma_of_log_convex` theorem applies. `Complex.Gamma_ofReal`, at `Gamma/Basic.lean:419`, identifies the real values with the complex Gamma function. On the right half-plane, `exp L` and Gamma are analytic; `Gamma/Deriv.lean:65,77` provides the Gamma differentiability input. Equality at positive real points accumulating at one suffices for `AnalyticOnNhd.eqOn_of_preconnected_of_frequently_eq`, at `Analytic/IsolatedZeros.lean:238`. One must construct the punctured accumulation witness, for example using `1+1/n`; equality on a complex open neighborhood is neither supplied nor required.

This proves `exp(L(z))=Gamma(z)` for `Re z>0`, with `L(1)=0` and real values on positive reals. Subtracting `H(1)` loses no imaginary phase. The proof does not assume an undetermined imaginary constant or infer the normalized logarithm from pointwise principal `log Gamma`. The standard Laplace expression has the same domain and logarithm distinction in [DLMF 5.9.10_2](https://dlmf.nist.gov/5.9.E10_2); the new uniqueness argument avoids using its real Stirling constant as an input.

These integrations, limits, convexity and analytic-continuation adapters remain Lean tasks. Their paper justification is present; they are not being accepted as unspecified hypotheses.

## 2. Phase allowance and Hardy realness

For `z=1/4+it/2`, `t>0`, the principal argument is `pi/2-atan(1/(2t))` and

`log|z|=log(t/2)+(1/2)log(1+1/(4t^2))`.

Substituting these into the imaginary part of `(z-1/2)Log z-z` reproduces exactly the note's two explicit positive correction terms. Their sum is at most `1/(16t)+1/(8t)=3/(16t)`. The remainder bound is `1/3`; `H(1)` is real. Therefore the claimed phase error is at most `1/3+3/(16t)`.

At `t>=1500`, division by `pi>3` makes this strictly less than `1/8`. At `t>=14`, the undivided error is at most `1/3+3/224<.347`. Both comparisons follow from elementary rational inequalities; no numerical Gamma evaluation or known zero count fixes the phase.

On the critical line, the source reflection and conjugation make xiF real. Its product factor is precisely

`-(t^2+1/4)*pi^(-1/4)*|Gamma(1/4+it/2)|`.

This is negative and nonzero. The remaining factor is `exp(i theta(t))*zeta(1/2+it)`, which is therefore real. This uses the proved exponential representation of Gamma. It does not treat a small computed imaginary interval as proof of realness. The normalization omits the conventional xi factor `1/2`, consistently with the source; that positive scaling has no argument effect.

## 3. Real zeros, poles and finite multiplicities

I read the actual `Explicit/ZetaGrowth.lean:17,19,30,64,156` and `Explicit/Xi.lean:19,21,24,28,37,40,43,51,56,78`. For real `0<x<1`, the sawtooth is nonpositive and the real power `t^(-x-1)` is positive on `t>1`. Integrability is supplied by the source theorem. Hence `Izeta(x)<=0` is real and

`zetaF(x)=x+x(x-1)Izeta(x)>=x>0`.

The proof at `x=1/2` in the source really does generalize in this way. The nonzero Gamma factor gives xiF nonvanishing inside the real critical strip, and the existing strip exclusions and values at zero and one cover the rest of the real axis. This removes the potential real-zero term from the doubling argument without a finite zero certificate.

The auxiliary head-rectangle discussion is also consistent. `ZetaDatum.zetaF_ne_zero_strip:190` covers `-1<Re s<0`; right-half-plane nonvanishing and the special values at zero and one supply the remaining real boundary points. The large count contour uses entire xiF throughout, so it has no zeta pole, Gamma pole or trivial-zero contribution to subtract. In particular xiF's values at zero and one are both one.

Since xiF is entire and xiF(2) is nonzero, the analytic identity theorem excludes infinite order at every point. Every actual zero has a finite positive natural multiplicity. Source `Landau.lean:25,31,40` and Mathlib `Meromorphic/Divisor.lean:79,99` provide the relevant divisor representation and finite support, but the conversion to actual zero order is still required. The note correctly keeps `.toNat` behind nonnegativity and finite-order proofs.

Multiplication by locally analytic nonzero factors preserves order by `Analytic/Order.lean:524`. Holomorphic reflection uses composition with derivative `-1`, via line 588. Antiholomorphic conjugation is not that composition theorem: conjugate a local factorization and show `z -> conjugate(g(conjugate z))` is analytic. Source `XiPartial.xiF_conj:669` and its subsequent logarithmic-derivative identity have no Platt binder. The conjugation-order adapter remains new formal work, explicitly acknowledged by the producer.

For the source residue theorem, use a ball large enough that the rectangle lies strictly inside `ball c (R/2)`, not merely inside `closedBall c R`. A concrete choice for `[-1,2] x [-T,T]` is `c=2`, `R=2*(T+4)`: the distance is at most `3+T<T+4`. Then `xiF(c)!=0` is available. `rectInt_logDeriv_mul` does not require the auxiliary sphere to be zero-free; the note's stronger optional ball-boundary condition is unnecessary. This observation removes no rectangle-boundary obligation.

## 4. The exact contour constant and orientation

The local top hypothesis is nonvanishing of actual zeta on `[1/2,2]+iT`, `T>0`. It suffices. The source xi/zeta equivalence covers the critical strip on that segment; xi strip exclusions cover its remaining real parts. For hypothetical zeros with `Re<1/2` at ordinate `T`, `s -> 1-conjugate(s)` puts them on the covered part of the same top edge. Conjugation then excludes the bottom edge. The vertical edges at `-1` and `2` are zero-free by the unconditional source strip theorem.

On `Re s=2`, the absolutely convergent Dirichlet series gives `Re zeta(2+it)>=1-sum_(n>=2)n^-2>1/4`. The strict bound follows by separating `n=2` and using the strictly decreasing integral comparison for the tail. The initial zeta value is positive. Thus the vertical argument is canonically fixed at zero initially, without traversing a million sampled points.

Along `P: 2 -> 2+iT -> 1/2+iT`, the principal logarithms of `s` and `s-1` are continuous: their vertical pieces have positive real part and their horizontal pieces have imaginary part `T>0`. At the final point their arguments add exactly to `pi`. The Gamma/pi-power argument change is theta(T), because its starting point uses `L(1)=0`. The zeta argument change is `pi*S(T)` by definition along the same path. The exact factorization therefore gives

`A=pi+theta(T)+pi*S(T)`.

No count value is used to choose this integer contribution.

Let `J(s)=1-conjugate(s)`. Along `J(P)`, xi values are conjugates of those along P, so its argument increment is `-A`. Reversing that path changes the increment to `+A`. Hence `U=P followed by reverse J(P)` runs from `2` to `-1` through the upper boundary and has increment `2A`. Reversed conjugation of U runs through the lower boundary from `-1` back to `2` and has increment `2A`. The total is `4A`.

I checked the explicit source orientation at `RectResidue.lean:22`: bottom left-to-right, top right-to-left, right bottom-to-top and left top-to-bottom. The constructed traversal has exactly these orientations, with subdivisions at real height zero on the vertical sides and at real part one-half on the top and bottom. It is counterclockwise. Source `rectInt_logDeriv_mul:391` applies to xiF with `h=1`, once these finite subdivision/log-derivative FTC equalities are formalized.

All zeros inside the full rectangle are nontrivial, none is real, and conjugation pairs upper and lower zeros with equal multiplicity. The total multiplicity is `2N(T)`, not `N(T)` or a count of distinct zeros. Thus

`4A=2*pi*(2N(T))`, and `N(T)=1+theta(T)/pi+S(T)`.

The `+1`, factor two and orientation are justified independently. The remaining path-integral and finite-carrier lemmas are formalization work, not a gap hidden by a diagram.

## 5. Closed heights and exact acceptance boundary

At a zero-free ordinate, open and closed top conventions agree. At a general height `t>0`, restrict the already finite zero support to the compact strip through `t+1`; choose a positive gap before the least strictly larger ordinate, if one exists. Then `N(u)=N(t)` for every `t<u<t+epsilon`, including multiplicities at height t. Those u are zero-free ordinates. This establishes the stated right-local constancy and permits continuous upper and lower count bounds to pass to t. It does not define S(t) artificially at a zero and does not change the exact formula's zero-free-height hypothesis.

The sign-completeness implication also has the right multiplicity logic: disjoint strict-sign brackets provide distinct zeros of order at least one, and equality of their number with total analytic multiplicity forces both completeness and simplicity. No simplicity premise is used.

The twelve implementation tasks in the producer remain unproved in Lean. The new normalized Gamma construction and symmetric count proof are accepted here at paper level, with the declaration-name erratum above. I request no substantive mathematical revision. No numerical packet was rerun, no new spectral location was certified, and neither frozen research package was changed. A future formal closure still needs the explicit integral, phase, carrier, symmetry, interval-enclosure and residue proofs and the normal type/axiom audit. The final Goldbach theorem may not retain any of these missing statements as new permanent hypotheses.
