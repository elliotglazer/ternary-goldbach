# Extending the full Type I/II certificate to a denominator interval

Research, 2026-11-11. Source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build, canonical source edit, new axiom or new assumed analytic estimate. The existing Type I/II producer conditions remain explicit. New coverage counts require independent review and exact set recomputation.

## Rectangle

The completed exact certificate covers all natural reduced denominators

    90090 <= q <= 100000,

all scales y>=1e25, and all permitted twists

    1200000/49 <= u=q|Delta| <= 1200000,
    2alpha=A/q+Delta/y modulo an integer,
    gcd(A,q)=1.

It compares the full smoothed bound with the unchanged ghatY(y,150000). There are9911 integers in this denominator interval, but this is not a count of newly covered denominators. Some were already in the preceding classifier union.

Unlike the single-denominator proof, this certificate uses the general small/large Type I2 formulas throughout .05<=w<=8 for the whole twist range. It does not borrow either endpoint band from a theorem specialized to q90090. The tails retain the unconditional coefficient17.

## Parameters and the critical floor constraint

Set Q0=90090, Q1=100000, z=wy, T=z^(1/3), H=3T^2/4 and choose

    U=floor(aT^2), a=1/(1152sqrt(2Q0)),
    V=floor(bT), b=576.

The coefficient a is fixed at Q0 throughout the rectangle. This is allowed because the source general Type I/II inequalities accept arbitrary admissible U,V. No first-choice identity involving the actual q is invoked.

Let epsilon_floor=10^(-8), alpha=a(1-epsilon_floor), beta=b(1-epsilon_floor). On .05<=w<=8,y>=1e25 we have T>79000000 and

    alpha*T^2<=U<=a*T^2,
    beta*T<=V<=b*T.

For every q in the interval, qV<=H follows from

    768*q <= 768*100000 =76800000 <79000000<T.

This restriction is checked, not extrapolated from q90090. The16V condition is weaker. All other size hypotheses follow from the same fixed U,V bounds as the reviewed middle certificate, including U>T^2/489600-1>(14/3)T, V>=576T-1>2.5e7, V>2eq, UV<z and V<=z/4.

The rational approximation condition holds uniformly because wu<=8*1200000=9600000<4T/3. This covers the entire enlarged twist range. Coprimality and the exact phase identity remain source hypotheses inherited from the reduced rational approximation.

## Both totient ratios are needed

The Type II expression uses phi(q), while the Type I muBound and leading coefficient use2q/phi(2q). For odd q these are different. The rectangle must not reuse the even-q identity from the q90090 proof.

The script verifies exactly, for every integer q from90090 through100000,

    q/phi(q) <= F,
    2q/phi(2q) <= F,
    F=1001/192.

It stores q,phi(q),phi(2q) for all9911 integers. The totients are computed by integer trial division and Euler's product formula. This is an external finite arithmetic verification, to be replayed using standard totient and factorization theorems in Lean. It is not an additional analytic hypothesis.

Consequently phi(q)>=Q0/F=17280, and the uniform mu coefficient is M=2.8F. The Type I leading2q/phi(2q) is bounded by F directly. Both parity cases are covered.

The two global weighted-log caps become

    G1(q)=M/2-(3/2)logalpha+(1/2)log(2q^2),
    G2(q)=M+log(16bq^2/3)+log(bq).

These have the same saturation proof as the reviewed middle certificate. The interval computation encloses their dependence on q. In particular it uses the new b576 G2 formula and does not silently substitute q/phi(q) for2q/phi(2q).

## Enclosing the denominator dependence

The exact script represents q by the closed interval[Q0,Q1] in every algebraic and logarithmic term of the general source formulas. It uses the lower bound17280 for phi(q). All quantities that multiply reciprocal totients are nonnegative, so that substitution enlarges the bounds.

The shared analytic core is copied from the reviewed small-band certificate with two explicit changes:

1. The exact-even-q expression q/phi(q) in the Type I leading coefficient becomes the verified bound F for2q/phi(2q).
2. The unused raw helper's scalar fraction300000/(2q) becomes interval division so that the helper can be evaluated with interval q.

The resulting standalone helper is included in `resume_coverage_wide_certificate.py`. The old certificate files and canonical Lean files remain unchanged. All other q appearances, including q^2, logq, log(2q), reciprocal q, the Type II correction and phase threshold, receive ordinary outward interval arithmetic.

The small/large threshold K(q)=q/(2c2) is itself an interval. A cell permits the small branch whenever its lower D=wu can be below K_upper, and permits the large branch whenever its upper D can be above K_lower. If both are possible, the certificate takes the larger remainder. In the large branch it uses Dlo=max(K_lower,w0*u0) and Dhi=w1*u1. The proof that the reciprocal-D logarithmic term decreases and the positive logPlus term increases is unchanged.

The Type II logarithmic correction uses

    L=log(1/(alpha*beta)),
    h(q,w0)=log(beta/(2q))+log(w0)/3-log(9/601200),
    Phi<=log(2q)*log(1+L*r/(1+h(q,w0)*r)).

The interval lower bound for h is positive. The function increases in r for each q, so interval q followed by endpoint r bounds is valid. No monotonicity in q is assumed.

## All-scale and all-twist finite coverage

Use the reviewed compact variable

    r=1/(log(y)/3+log(9/601200)).

The whole range y>=1e25 lies in[0,rmax]. The128 r-cells use the same certified dyadic lower-scale powers k from0 through8. Each w-bin evaluates the decreasing normalized errors at T>=(w0*1e25)^(1/3)*2^k. The Type II main term is evaluated at rhi, and the ghat lower envelope at rlo. The consumer remains the fixed source ghatY(y,150000), independent of q.

The u edges are

    1200000/49,33000,40000,50000,65000,85000,110000,
    150000,250000,400000,26400000/49,1200000.

Thus11 closed u-cells cover the entire required interval. Each of the1408 u/r cells integrates159 w-bins with exact Gaussian mass upper bounds and the explicit fourth-derivative remainder. Both trivial tails are included. All arithmetic deciding success uses exact fractions with outward rational rounding.

The source analytic contracts are unchanged: `TypeITotal.typeI1_le`, `TypeI2Sum.typeI2_le_small`, `TypeI2Large.typeI2_le_large` with epsilon_large=.03, `TypeIITotal.typeII_637`, and `Assembly.norm_S_le_parts`. The existing1.03883,1.0064,.511, squared-prime-log and Mobius/Liouville producer estimates remain obligations. This interval certificate does not prove them.

## Review and counting gates

The exact replay result is appended below after completion. A passing scalar certificate is conditional paper evidence, not a Lean theorem. Independent review must check the two totient ratios, interval-q substitutions, fixed-U admissibility, and complete u/r coverage. The parent then recomputes the precise union with the prior73579-denominator list. No coverage count is changed by this note alone.

## Completed exact replay

The wider certificate exited successfully. All1408 scale-and-twist cells passed. The minimum exact lower gap is

    75993793/1000000000000 = .000075993793.

It occurs on u in[65000,85000], r-cell32, using dyadic power8. The finite totient verification contains9911 triples and checks both ratios for every integer in the denominator rectangle.

| u interval | certified gap lower bound |
|---|---:|
|[1200000/49,33000]|0.001410294155|
|[33000,40000]|0.000952295100|
|[40000,50000]|0.000531776282|
|[50000,65000]|0.000131724345|
|[65000,85000]|0.000075993793|
|[85000,110000]|0.000219457728|
|[110000,150000]|0.000377482841|
|[150000,250000]|0.000571805905|
|[250000,400000]|0.000867920231|
|[400000,26400000/49]|0.001050449281|
|[26400000/49,1200000]|0.001131283938|

An earlier narrower certificate for90090<=q<=90500 remains saved as `resume_coverage_rectangle_certificate.py/.json`, with margin.000136851183. The wider result supersedes it for coverage. Neither rectangle has been added to any central count by this worker.

The full source and interval argument is ready for independent review. This is an external exact arithmetic certificate plus paper proof, conditional on the original Type I/II producers. No Lean theorem or PlattGRH removal is claimed.
