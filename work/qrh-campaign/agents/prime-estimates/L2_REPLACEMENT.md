# Major-arc L2: Platt dependency and replacement targets

Source inspected: `work/ternary-goldbach`, commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. This note is a source audit and mathematical derivation. No replacement analytic estimate has been compiled or claimed proved. All ranges retain x >= 4.9e26.

## Exact existing dependency

Write D_q = 1200000/qt(q), Q = Qset 150000, P(delta) = Fourier(etaPlus)(-delta), and

J = sum_(q in Q) integral_|delta|<D_q sum_(b unit mod q) |S_etaPlus(b/q+delta/x,x)/x|^2.

Arc disjointness identifies this with x^-1 times the major-arc integral. `MajorArcs/L2Major.lean:309` proves 8.6296 <= J <= 8.79 under Fact PlattGRH. Its `Jq_bounds` uses precisely two analytic estimates from `MajorArcs/ArcChars.lean:342` onward:

* Principal approximation error <= 2.83e-7*x, ultimately Thm714 at q=1.
* Nonprincipal aggregate is bounded by (4.25e-7*x)^2, obtained from the maximum of |GaussSum(psi)|*|twisted sum| over psi != 1, ultimately Thm714 for primitive characters of conductor <=300000.

The coprime-removal bound <=1e-15*x, character orthogonality, Fourier L2 estimates, the finite sum of mu^2/phi, arc disjointness, and all square-splitting inequalities are unconditional. The exact finite sum bounds are

13.597558 <= sum_Q mPhi(q) <= 13.59756.

Fourier energy on every arc is between .6392 and .640208 because D_q >=4. Hence the full main energy M is at most

M0 = .640208*13.59756 = 8.70526669248.

The current per-q result is

(.63907-.000962)*mPhi(q)*x -3.6e-9*x <= J_q*x
<= (.64034+.000962)*mPhi(q)*x +2.17e-7*x.

The lower side needs only the principal estimate. Nonprincipal cancellation is not needed for a lower bound because its character energy is nonnegative.

## Existing unconditional sieve route is too weak for 9 or 10

`MinorArcs/LargeSieveProof.lean:295`, prop_12_1_2, is an unconditional comparison theorem given a G_q quotient bound. Its numeric corollary cor_12_2_5 at line378 gives, for prime-supported coefficients,

integral_major |S|^2 <= ((log(2Q0)+2)/(log(2*sqrt(x/(2delta0)))+1.33258))*sum|a_n|^2.

The numeric corollary itself still has Fact PlattGRH through LSQuot6.prop_12_2_4 and the Mertens-product inputs. Even granting an unconditional proof of that quotient and ideal prime density, for Q0=150000 and delta0=8 its estimate is about18.31764 at x=4.9e26 and tends to18.70885. The formula used for this diagnostic is

((log300000+2)/(.5logx-log2+1.33258))*(.640208logx-.021095).

This is not a rigorously established bound on J here: it intentionally grants stronger density information than the unconditional Chebyshev source to show that this specific comparison route does not reach9 or10. Coefficient removal cannot repair this factor-of-two loss. Global Parseval alone gives a bound of order .640208logx, about39.3449 at the initial x and increasing. Ordinary multiplicative large sieve has the same scale problem.

This is an obstruction to these source-level routes, not an impossibility theorem about proving J<=10 from QRH. Finite psi tables through1e9 do not supply cancellation for the relevant twisted sums around x>=4.9e26.

## Better explicit upper-bound target

Let a_q = coprimePart q (cP x). Define

g_q(delta) = expTsum a_q (delta/x)/x,

Ep = sum_Q mPhi(q) * integral_|delta|<D_q |g_q(delta)-P(delta)|^2,

N = sum_Q (1/phi(q)) * integral_|delta|<D_q
      sum_(psi mod q, psi!=1) |GaussSum(psi)|^2
          * |Schar(psi^-1,a_q,delta/x)/x|^2.

Exact Bombieri orthogonality gives

J_coprime = sum_Q mPhi(q)*integral|g_q|^2 + N.

For any t>0, the source square-splitting inequality therefore gives

J_coprime <= (1+t)M0 + (1+1/t)Ep + N.

The full/coprime difference has integrated squared norm at most

Eremove <= (sum_Q 2D_q*phi(q))*1e-30 <=7.2e-19.

Indeed phi(q)<=q<=qt(q), so every term 2D_q*phi(q)<=2.4e6 and #Q<=300000. Applying a second square split with u>0 gives

J <= (1+u)*((1+t)M0+(1+1/t)Ep+N) + (1+1/u)*7.2e-19.

Take t=.0034 and u=1e-6. The explicit sufficient targets are:

| Target upper J | Ep bound | N bound | Resulting numeric bound |
| --- | --- | --- | --- |
| 9 | 1e-4 | .23 | 8.994385358318 |
| 10 | 1e-4 | 1.23 | 9.994386358318 |

These are unproved analytic targets. They retain exact Gauss weights and all multiplicities of characters. They are considerably weaker than replacing every Thm714 pointwise estimate.

The even more generic total residual R=sum integral sum_b |s_b-m_qP|^2 gives sqrt(J)<=sqrt(M0)+sqrt(R). This permits R<=.00245333049 for J<=9, or R<=.04486295356 for J<=10. The Ep/N separation is preferable because principal/nonprincipal orthogonality removes their cross term.

The cubic budget's existing A contains |m_q U|^2. A bound on A alone does not imply either of these unweighted estimates: the Fourier multiplier can be small or zero, and m_q vanishes on nonsquarefree q.

## The independent lower-bound target is much smaller

`MinorArcs/MinorTotal.lean:274`, I0_ge, needs J>=8.6296 to deduce the prime-supported major energy >=8.6294. It feeds minor_total, so an upper-only replacement does not close the full proof.

A sufficient replacement is the q=1 estimate

|S_etaPlus(delta/x,x)/x - P(delta)| <= .001 for |delta|<=4.

This is needed only on [-4,4], not out to600000. Every q arc contains this interval. Coprime removal changes the normalized sum by at most1e-15. Set epsilon=.001+1e-15. The unconditional principal-character lower inequality and square split with t=.00354 yield, on these restricted arcs,

J_coprime,restricted >= 13.597558*((1-.00354)*.6392 -8*epsilon^2/.00354)
                     = 8.6300620098466... .

For the full sums apply the lower square split with u=1e-6. The integrated full/coprime difference is bounded by7.2e-19 even using the crude #Q*max phi bound on the restricted arcs. Thus

J >= (1-1e-6)*8.6300620098466... -7.2e-19/1e-6
  > 8.6300533797838
  > 8.6296.

All discarded arc regions and nonprincipal character terms are nonnegative. This proves the mathematical implication without any nonprincipal analytic input. The missing q=1 estimate remains a genuine analytic obligation and has been sent to the Mellin worker. A separately proved uniform q=1 estimate on the full cubic domain with error at most .001 would also cover this local target. The weighted integral target A1 alone does not imply it.

## Source-faithful next lemmas and scratch status

`QrhL2Structure.lean` contains an uncompiled extraction `principal_le_sum_units_sq`, with no PlattGRH and no dummy upper-error premise. It uses the exact `TernaryGoldbach.totient_mul_sum_units` identity and the principal term of a nonnegative finite sum. The file also contains pure rational arithmetic proofs for the three budgets above. No compiler was launched during this assignment.

The next substantive analytic work is to prove Ep<=1e-4 and N<=.23 (or1.23), or another quantitatively sufficient pair, from actual QRH estimates. Proving an integral inequality while simply assuming these targets would be a structural lemma only, not a replacement theorem. A separate local q=1 error<=.001 on |delta|<=4 would preserve the minor-arc lower energy even if the upper work remains open.

The generic new cubic budgets supplied to major_constants are B(J)=2J+17.41053338496, with dynamic budget b=.011670451. Equal splitting gives A<=b^2/(4B(J)), V<=b^2/(4J):

| J | B(J) | A cap | V cap |
| --- | --- | --- | --- |
| 9 | 35.41053338496 | 9.6157423740791e-7 | 3.78331740398336e-6 |
| 10 | 37.41053338496 | 9.10167633416827e-7 | 3.40498566358502e-6 |

These are arithmetic transfer budgets only. The fixed1.0376 minor bound still requires its lower-energy input and all its other Platt-dependent components to be replaced.

