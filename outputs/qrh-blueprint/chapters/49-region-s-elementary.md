# An elementary replacement for the quotient large-sieve small-R branch

Research derivation, 2026-11-11. This is a proposed complete mathematical route for the specific `LSQuot6.prop_12_2_4` call to `LSQuot3.regionS`. It is not a compiled Lean theorem. External interval checks are in `work/qrh-campaign/region_s_finite.py`; an independent integer/Fraction replay is in `work/qrh-campaign/region_s_rational.py`. Each writes a JSON result. Independent review is required before calling this branch resolved at blueprint level.

Source: `work/ternary-goldbach`, baseline `23b2d68ca344203d4384e0aff7affa4ec034bef9`. This branch is separate from the Type I/II pointwise and layer-envelope repairs.

## Exact consumer to preserve

In `MinorArcs/LSQuot6.lean:85–90`, the only large-q small-R use has

    q >= 22000000000,  1 <= R < lamQ(q),
    R = Q0/(s*q),  20000*Q0 <= Q,
    Q0 >= 100000, log Q0 <= .6 log Q, s >= 1.

The conclusion is the original quotient bound with numerator `log Q0+1.36`, subsequently weakened to `log Q0+2`. Its finite-small-q and `regionL` alternatives are unchanged.

Let P be the product of all primes <=R together with the prime divisors of q. The unconditional first and last portions of `LSQuot3.regionS` reduce the problem to

    X := P/phi(P) <= .86 + .4 log(qR).                         (RS)

In particular the `Gq_mul_le`, `G_le_mul_Gq`, `G_ge_log`, and `poly_regionS` steps can be reused. The replacement below proves (RS) for this specific domain. It need not preserve the more general c'-parameterized internal statement of `regionS`.

## 1. A deliberately coarse universal totient estimate

For every integer n>=1, set Y=max(2000,log n). Then

    n/phi(n) <= 15 log Y.                                    (T)

This estimate uses no prime number theorem, zero-free region, or finite RH.

First use `Chebyshev.theta_le_log4_mul_x` from Mathlib's `NumberTheory/Chebyshev.lean:191`, together with log4<2, to obtain theta(t)<=2t for t>=0.

For real y>=2 define the finite Euler product

    M(y)=product_(p<=y, prime) (1-1/p)^(-1),
    A(y)=sum_(p<=y, prime) log(p)/(p-1).

Partial summation gives

    sum_(p<=y) log(p)/p
      = theta(y)/y + integral_2^y theta(t)/t^2 dt
      <= 2+2log(y/2) <= 2log y+2.

Also

    sum_(p<=y) log(p)/(p(p-1))
      <= sum_(m>=2) log(m)/(m(m-1)) <= 2.

For the last inequality, summation by parts yields `log2 + sum_(m>=2) log(1+1/m)/m`; bound this by `log2 + sum_(m>=2) 1/m^2 <= log2+3/4 <2`. Hence A(y)<=2log y+4.

Expand M(y) as the convergent sum of 1/m over integers supported on the finite set of primes <=y. Its log-moment is M(y)A(y), by finite products of geometric series and unique factorization. Markov's inequality leaves at least half this mass at log m<=2A(y). The harmonic-sum bound then gives

    M(y)/2 <= sum_(m<=exp(2A(y))) 1/m <= 1+2A(y),
    M(y) <= 8log y+18.                                       (M)

These are elementary series/finite-product proof obligations, not an assumption of (M).

Split the prime divisors of n at Y. The small-prime factor is at most M(Y). If k prime divisors exceed Y, then k log Y<=log n<=Y. Therefore

    log product_(p|n,p>Y) p/(p-1)
       <= k/(Y-1) <= 2/log Y <= 2/7.

Here log Y>7. Since log(4/3)>=2/7, the large-prime factor is <=4/3. This logarithm inequality follows immediately from `log((1+t)/(1-t))>=2t` at t=1/7. Combining with (M),

    n/phi(n) <= (4/3)(8log Y+18)
              <= (4/3)(8+18/7)log Y <15log Y.

The case n=1 is immediate. This proves (T) with generous constants.

## 2. The range log q >= 2000

Write L=log q. By source definitions,

    lamQ(q) = [7.4527 * product_(p|q) gp(p) / kapQ(q)]^3,
    gp(p) = (p/(p-1))*f1p(p),
    kapQ(q) = .3726*(L-Sq(q))+.0274177.

Because `Sq(q)=sum_(p|q) log(p)/p <= L/2`, we have `kapQ(q)>=.18L`. The source `f1p_le_one_add` gives

    gp(p) <= (p/(p-1))*(1+p^(-2/3)).

The finite product of this upper bound over primes <=1000 is less than 5000. For p>1000,

    log gp(p) <= 1/(p-1)+p^(-2/3) <= .0017log p.

Both terms on the left decrease with p, while log p increases; the endpoint inequality at 1000 suffices. Thus

    product_(p|q) gp(p) <= 5000 exp(.0017L),
    log lamQ(q) <= 3log(7.4527*5000/.18)+.0051L-3log L
                 <= .015L.                                  (L)

The final scalar inequality is checked at L=2000, where its left side is less than24.119 and its right side is30. The difference has derivative `.0099+3/L>0`, so it holds at every larger L.

With R<lamQ(q), unconditional Chebyshev gives

    log P <= L+theta(R) <= L+2R
          <= exp(.01L)+2exp(.015L)
          <= 3exp(.015L) <= exp(.02L).

The two scalar facts L<=exp(.01L) and 3<=exp(.005L) hold at2000 and persist by monotonicity. Also2000<=exp(.02L). Hence

    log(max(2000,log P)) <= .02L.

Apply (T): `X<=.3L<=.4log(qR)+.86`, proving (RS) in this range. This branch bypasses both the original sharp global totient theorem and the original1.039 coefficient in the theta bound.

## 3. The range 22000000000 <= q and log q <= 2000

Let k be the number of prime divisors of q. The source exchange bounds `LSQuot4.lamQ_le_k` give

    lamQ(q) <= [7.4527*Gk(k)/kapk(k,q)]^3,
    kapk(k,q)=.3726*(log q-Sk(k))+.0274177.

The first311 primes have log product >2000.766, so k<=310. For each1<=k<=310, substitute the lower bound

    log q >= max(23.8143, log(primorial_k)).

The accompanying Arb script verifies positivity of each resulting denominator and verifies `lamQ(q)<20000` in every case. It enumerates primes by trial division and uses256-bit interval arithmetic for every analytic comparison. This is a finite certificate to replay in Lean, not an empirical sample of q.

The separate rational replay uses24 terms of the positive atanh series after dyadic normalization, with its geometric remainder written explicitly. Integer cube-root brackets bound `p^(-2/3)`; every accumulated bound is rounded outward on the rational grid `10^-18`. It reproduces all310 checks, a maximal lambda upper bound below12167.715, and the small-prime product upper bound below4460.342. Positive Taylor polynomials check the exponential scalar inequalities. No floating-point decision or Arb call is used in this replay. It is still an external certificate calculation awaiting Lean verification.

For every prime p<=20000, both scripts verify `theta(p)<1.039p`. Between consecutive primes theta is constant and the right side increases. Thus this checks `theta(t)<=1.039t` for the entire real interval0<=t<=20000. There are2262 prime endpoints. No broad conditional psi theorem is used.

Consequently R<20000 and

    log P <= V := log q+1.039R <22780 <42000.

The existing `SmallMertensProd.inv_100000` proves `theta(100000)>99685`, as well as the finite product estimate through100000. The exchange proof of `Prelim.div_totient_lt` can therefore be repeated for every integer n with log n<=42000: if the comparison primorial's last prime were at least100000, its log would exceed99685, contradicting log n<=42000. Use the existing finite product theorem at the last comparison prime, followed by the source monotonicity argument. The k<=3 case remains the source bound3.75. The real comparison parameter r>=max(3,n) has no upper limit.

Apply that finite theorem to n=P and r=exp V. The original proof now has

    X < exp(gamma)*log V +2.50637/log V.

Use `LSQuot5.large_q_hS` and `LSQuot6.hcc_large`, which are elementary source results, to obtain the original (RS) exactly. The finite theta certificate supplies the only replaced theta input. This completes the finite branch without a finite-RH assumption.

## 4. Integration and limits

Split at log q=2000 in a new internal small-R provider, then reuse the existing quotient argument after (RS). At equality either branch applies. Together with the unchanged small-q finite Phi2 route and `regionL`, this is a route to the original `prop_12_2_4` constants.

Necessary formal work is explicit: geometric Euler-product mass/log-moment identities; the Markov/harmonic argument; elementary prime splitting; source carrier conversions; the310 lambda checks and2262 theta checks; the finite Mertens exchange specialization; and the exact consumer application. No QRH provider is required for this branch. Source import/axiom validation remains part of eventual Lean implementation.

This result does not repair the principal/nonprincipal/mixed major estimates, moderate prime estimates, Mobius profile, or remaining base-gap denominators. It addresses one previously separate large-sieve obstruction. No draft anchor, custom axiom, or `sorry` is introduced.

## 5. Lean-facing alternative using the existing unconditional Mertens theorem

The constant15 in (T) can be relaxed to20 without changing the final argument: `20*.02L=.4L<=.4log(qR)+.86`. This admits a potentially shorter implementation using existing source results instead of the new logarithmic-moment argument.

`Prelim/PNTMertens.lean:1724`, `sum_mangoldt_div_log_eq`, proves

    sum_(d<=y) Lambda(d)/(d log d) = log log y + gamma + E2(y).

Its `E₂Λ.abs_le` at line934 gives `|E2(y)|<=(log4+6)/log y` for y>=2. These source declarations have no Platt hypothesis. Expanding the logarithm of the finite Euler product, the terms beyond d<=y have prime-power exponent at least2, so their sum is at most

    sum_(p<=y) sum_(k>=2) 1/p^k
      <= sum_(m>=2) 1/(m(m-1)) = 1.

Consequently, for y>=2000,

    log M(y) <= log log y + gamma +(log4+6)/log y+1
              <= log log y +93/35 < log log y+log15.

Here gamma<=.6 follows from the source `exp_gamma_le_sharp<=1.7882` and the cubic Taylor lower bound for exp(.6); log4<=1.4 and log2000>7 are elementary. The exact rational script also checks log15>93/35. Thus M(y)<=15log y. The same large-prime factor <=4/3 proves

    n/phi(n) <=20log(max(2000,log n)).

The finite Euler-product logarithm expansion and its truncated prime-power identity still need Lean proofs/adapters. This alternative replaces a new Markov/log-moment development by an existing unconditional source theorem; it does not import a finite-RH assertion. The already described stronger15-log route remains independently available.
