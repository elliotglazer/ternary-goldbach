# Global totient bound without a hidden finite-RH input

Research only, 2026-11-10. No Lean compilation or source changes. This note separates the exact classical theorem, the current proof dependency, and an elementary alternative that changes only the treatment of remote minor-arc levels.

## Assessment

The desired inequality is classically unconditional, with exactly the coefficient 2.50637. Its usual proof is not merely a small primorial calculation. Its analytic part uses verified zeta zeros. Replacing the current `E1_window` application by a citation to that theorem would leave substantial unformalized mathematics and would hide a different finite-RH computation.

The current repository already contains an elementary finite kernel strong enough to settle the exact inequality for extremely large finite denominator ranges. The bounded next task should extract that restricted theorem. For the remaining unbounded range, either prove a genuine analytic product estimate or use a weaker elementary totient bound and a separately audited remote-level estimate. The latter avoids proving the sharp global Rosser–Schoenfeld inequality, but it changes the minor-arc numerical argument.

## What the primary source establishes

[Rosser and Schoenfeld, *Approximate formulas for some functions of prime numbers* (1962)](https://denisevellachemla.eu/Rosser-Schoenfeld-1962.pdf), Theorem 15, equations 3.41–3.42, proves for n>=3

    n/phi(n) < exp(gamma) loglog n + 2.50637/loglog n.

The coefficient 2.5 works except at n=223092870, the product of the first nine primes. Section 9 checks primorial intervals through theta(313), covering log n<294. The remaining proof uses its Theorem 33, Lemma 15, product estimate 3.29, and explicit theta estimates. Crucially, section 6, page 78, invokes the first 25000 zeta zeros on the critical line, citing Lehmer, and sets A=exp(9.99). Section 8 propagates those inputs through Lemmas 6 and 13 to the product estimate. Thus the theorem is unconditional in classical mathematics, while a fully formal reproduction must prove or replace those finite computations. It has no dependence on Platt's later verification specifically.

## The actual source dependency

In `MinorArcs/GBound.lean`, `norm_S_eta2_le_gx` uses `Prelim.div_totient_lt` at the effective radius

    r=max(1,|Delta|/8)q,

where q is the denominator of the approximation to 2alpha. The theorem needs q>=1, r>=3 and q<=r. The bound is used twice, in the first square-root term and in the coefficient L. No E1-window information is consumed directly by GBound.

`Prelim/MertensProduct.lean` proves `div_totient_lt` by

    div_totient_eq_prod + exch + F_all + elementary monotonicity.

`F_all` has three ranges:

* prime x<=100000: `MertProd.mertens_product_kernel`, with no Fact binder;
* 100000<=x<1e12: `F_mid`, presently Fact-dependent;
* x>=1e12: `F_large`, presently Fact-dependent.

Here x is the largest prime in the comparison primorial, not the integer q. Confusing these two variables makes the required finite verification seem much larger than it is.

`F_large` takes the upper bound for E2Lambda from `E2_le_of` and `E1_var`. `E1_var` uses `E1_win_num` through the window ending near exp(20000), and `E1_diff` beyond. `E1_win_num` instantiates the abstract `E1_window` with Gaussian smoothing delta=8e-8, alpha=4247 and beta=3e-13. That instantiation calls `Explicit.tsum_gsm_leH` with `Explicit.rh_upto_1e8`.

The abstract `E1_window` itself has no Fact binder. It is a deterministic integration argument conditional on a smoothed prime-sum envelope. Therefore a replacement should target that envelope or bypass the window, rather than rewriting the abstract integration theorem.

Removing this one call is insufficient. `F_large` also uses a Fact-dependent theta estimate; `F_mid` uses Fact-dependent E2 and psi/theta envelopes. The original source's final `div_totient_lt` Fact binder is substantive, not just an unused section variable.

## Exact sufficient analytic content

Let

    P(x)=product_(p<=x) p/(p-1),  L=log x,
    theta(x)>=x(1-epsilon),     0<=epsilon<1,
    E2Lambda(x)<=E,
    log P(x)<=log L+gamma+E+h.

The last inequality already follows from the source's log-series comparison. It permits h=3/floor(sqrt x), or the sharper h=7/(6floor(sqrt x)) used by `F_mid_gen`.

Define eta=E+h and d=-log(1-epsilon). If 0<=eta, 0<L-d, and

    exp(gamma)*L*exp(eta)
      < exp(gamma)*(L-d)+2.50637/(L-d),

then `F_all`'s desired primorial bound follows, provided the function `G t+2.50637/t` is increasing for t>=L-d. This is a direct sufficient certificate using only an upper E2 bound and a lower theta bound. No variation bound for all later E1 values is intrinsically necessary.

A conservative easier inequality is

    exp(gamma)*[L*(exp(eta)-1)+d] < 2.50637/L.

Indeed the right-hand correction at L-d is at least 2.50637/L. For small eta and epsilon the required scale is approximately

    eta*L^2 + epsilon*L < 2.50637/exp(gamma) = approximately 1.4072.

This calculation is an assessment of the necessary accuracy, not a proof of an available E2 envelope. Qualitative Mertens or qualitative PNT does not provide the required constants and starting point.

The existing large-range proof is stricter for convenience: it gets eta*L^2<=.6174, uses exp(eta)<=1+2eta, and handles theta with a small explicit relative error. `F_mid_gen` exposes its sufficient hypotheses directly:

    E + 7/(6S0) <= .0196,
    ctheta/S0 <= 2.37/316,
    1.95*[1.02*(E+7/(6S0))*Lm^2 +2*(ctheta/S0)*Lm] <2.5,

with S0<=floor(sqrt x), S0>=316, Lm>=log x, and |theta(x)-x|<=ctheta*sqrt x. A candidate unconditional or QRH estimate should first be checked against this explicit interface. Its proof has no Fact binder; the current sources of E and ctheta do.

## A finite exact theorem is already within reach

Let p_k be the k-th prime and k=omega(q). The existing elementary exchange argument proves

    q/phi(q) <= product_(j<=k) p_j/(p_j-1),
    product_(j<=k) p_j <= q.

Therefore `mertens_product_kernel` plus the existing final monotonicity proof suffices whenever p_k<=100000. For k<=3, the current unconditional `bigF_gt` supplies the bound because the product is at most 3.75. For k>=4 the existing monotonicity argument starts from log(theta(p_k))>=log4, safely on the increasing side of the function.

An especially convenient explicit cutoff is

    R=2^1000.

A tiny finite certificate of

    product_(p<=2000) p >2^1000

implies p_k<2000 whenever q<=R. Thus the existing kernel handles every q<=R, for every real r>=max(3,q), including r>R. A direct trial-division BigInt diagnostic in this session found 303 primes through 2000 and a product of bit length 2799, so there is ample margin. This diagnostic has not been translated into a Lean certificate. It requires only primality and integer multiplication, with no zeta computation.

The suggested first theorem is consequently

    1<=q<=2^1000,  r>=3,  q<=r
      ==> q/phi(q) < Fr(r).

Most of its proof is already present in `div_totient_lt`; replace its unrestricted `F_all` call by the finite kernel after the primorial cutoff argument. This theorem alone does not justify all unbounded off-larger-arc denominators.

## Elementary fallback for the unbounded range

There is a simple global estimate

    q/phi(q) <=sqrt(2q),   q>=1.

For each odd prime p, `p/(p-1)<=sqrt p`, since p<=(p-1)^2. The factor for p=2 contributes only an extra sqrt2. Multiply over the distinct prime divisors and use rad(q)<=q. This proof is independent of PNT and zero estimates.

For q<=r it gives `q/phi(q)<=sqrt(2r)`. Replacing Fr(r) by this value in the pointwise algebra makes the leading term decay like

    [R(z,2r)log(2r)+.8764]/(2r)^(1/4).

The remaining L term decays at least like a logarithm times r^(-1/2), apart from the original z^(-1/6) term. In the actual first-branch domain, `2r<=z^(1/3)/3`; this bounds R(z,2r) above by an explicit O(log r) expression. Consequently a rough O(log^2(r)r^(-1/4)) envelope is available by elementary algebra.

The exact elementary integral is

    integral_R^infinity log^2(r) r^(-1/4) dr/r
      =R^(-1/4)*[4log^2R+32logR+128].

At R=2^1000 its scale is below 2e-69 before an explicit envelope coefficient. This explains why a weak bound can be adequate only in a remote layer. It does not by itself prove the integrated minor-arc budget.

Required additional work is specific:

1. Carry this envelope through the eta2-to-etaStar convolution, including both w tails and valid approximation choices.
2. Preserve a nonincreasing layer function. Simply switching from exact Fr to sqrt(2r) at R creates an upward jump and violates the existing summation hypotheses. A monotone envelope can flatten the tiny raised tail across preceding levels, but its extra contribution must be bounded.
3. Bound the discrete layer sum, its sig/Dx factor, and the terminal term `ghat(r2)*(sig-cL(r2-1)*sig/Dx)` uniformly. The integral displayed above does not cover the terminal term automatically.
4. Choose r2 satisfying every current `NumericsGoal` condition. In particular the additional constraint `2r2<=(2sqrt(x/784))^.6` is stronger asymptotically than taking r2 near y^(1/3). A growing choice of order x^.3 remains possible, but it must be proved.

The original finite numerical cells need no change when this remote range is inactive. The proof that covers all larger x would need a new bound and cannot be claimed by retaining the old `NumericsGoal` theorem unchanged.

## Recommendation and limits

First extract and independently audit the finite exact totient theorem through q<=2^1000. It is a bounded source-level task with an elementary certificate. In parallel, compare two explicit remaining obligations: a direct E2/theta certificate meeting the displayed analytic inequality, and a monotone remote-level envelope based on sqrt(2q). The latter has huge numerical slack and avoids recreating historical zero verification, but requires a new convolution and final-tail argument.

No complete replacement for the sharp global `Fr` theorem has been proved in this note. No finite-RH fact has been silently accepted. The exact classical result, the finite elementary extraction, and the proposed weaker global route have different proof statuses.
