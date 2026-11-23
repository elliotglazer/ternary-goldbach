# Q90090 middle twists through the general Type I2 bound

Research, 2026-11-11. Source pin `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean build or canonical source edit. The analytic argument below reduces the remaining middle band to a finite rational certificate. Its source Type I/II estimates still have their original prime and Mobius obligations. An independent review is required before accepting the new coverage.

## Source route and scope

The old strategy used `typeI2_le_small` below a moving w cutoff and kept the simplified raw bound above it. That cannot close the whole middle interval. At u150000,y1e25 the retained raw-above integral alone is approximately.06217893, already larger than the complete allowance.06018401.

The existing source provides a different route. `MinorArcs/TypeI2Large.lean:223`, `typeI2_le_large`, permits arbitrary U,V and epsilon in(0,1] when

    Approx2 alpha z Delta_z A q H,
    z>0, qV<=H, 16V<=H, U>=1, V>=2.5e7, UV<=z,
    |Delta_z|>=1/(2c2).

It complements `TypeI2Sum.typeI2_le_small` without imposing an upper restriction on |Delta_z|. Its generality permits the same Vaughan parameter improvement above the small-twist cutoff. The existing first-choice theorem already invokes this large lemma at epsilon=.07, but then simplifies it substantially. The present route retains every term and uses epsilon=.03.

Keep q=90090, phi(q)=17280, y>=1e25, z=wy and T=z^(1/3). On the entire central interval .05<=w<=8 use

    U=floor(T^2/(1152sqrt(180180))),
    V=floor(576T),
    H=3T^2/4,
    epsilon_large=3/100.

This multiplies the original V by128 and divides U by128. It preserves UV/z approximately1/(2sqrt(180180)). The full Type I1 and Type II bounds are `TypeITotal.typeI1_le:101` and `TypeIITotal.typeII_637:331`. Assembly still uses `Assembly.norm_S_le_parts:64`, including3logz. Type I2 uses its small or large lemma according to the actual phase. Both omitted w tails use the unconditional17 bound in `Prop1123.norm_S_eta2_le_trivial:30`.

The target middle domain is

    33000 <= u=q|Delta| <= 26400000/49,
    2alpha=A/q+Delta/y modulo an integer,
    gcd(A,q)=1,
    y>=1e25.

The prior reviewed small-band certificate covers1200000/49<=u<=33000 at every scale. The prior reviewed raw-tangent certificate covers26400000/49<=u<=1200000 at every scale. Thus a successful reviewed middle certificate would cover all permitted twists for this single denominator, without changing ghatY, the original4.9e26 endpoint, BinaryGoldbachInput, or the final10^27 endpoint. It would not settle q=1 or any other unclassified denominator.

## Structural conditions at every scale

Write

    a=1/(1152sqrt(180180)), b=576,
    epsilon_floor=10^(-8), alpha=a(1-epsilon_floor), beta=b(1-epsilon_floor),
    p=ab, etaL=8log2, c=1+etaL*p.

As before, T>79000000 on the central interval. Both epsilon_floor*aT^2 and epsilon_floor*bT exceed1. Therefore

    alpha*T^2<=U<=aT^2,
    beta*T<=V<=bT.

For qV<=H it suffices that768q<=T, and768*90090=69189120<79000000. The16V condition is weaker. Since sqrt180180<425,

    U>=T^2/489600-1>(14/3)T,

so3.5z/U<H and U>=sqrt3. We also have U<=min(z/4,z/e,H/2), V>=576T-1>2.5e7, V>2eq, V<=z/4 and UV<=pz<z. These verify all common source hypotheses.

The approximation error requires wu<=4T/3. On this entire middle band wu<=8*(26400000/49)<4310209, whereas4T/3>105333333. Coprimality and the exact phase identity are inherited from the same reduced rational approximation. No new finite-RH or zero-location premise enters.

Type I1 is bounded using minInv<=1 and logFourierBound<=2-log4, which hold for every phase. Type II has no small-phase restriction. Type I2 splits at D=wu=q|Delta_z|=K, where

    K=q/(2c2), c2=6pi/(5sqrt32).

The source small lemma allows D<=K; the large lemma allows D>=K. These closed domains cover the boundary.

## Exact normalized large-branch remainder

The first two Type I2 terms are identical in the two source lemmas. They contain the mu-weighted logarithm and the quadratic correction. Use the all-scale treatment from `RESUME_MINOR_2026-11-11.md`, with the new a,b. In particular

    M=2.8q/phi(q),
    G1=M/2-(3/2)logalpha+(1/2)log(2q^2),
    G2=M+log(16bq^2/3)+log(bq).

For G2, min(H/(2V),U)>=3T/(8b), so the mu saturation denominator is logT-log(16bq^2/3). The saturation proof is unchanged. Merely retaining the old b=72 formula would be incorrect.

Let C=2sqrt(32c)/pi and let epsilon=3/100. The remaining normalized terms in `typeI2_le_large` are bounded by

    A0 + Dcoef*g(D) + B(D)/T + C2/T^2,

where

    A0=1.0064*C*(1+(1+epsilon)/e)*p,
    Dcoef=C*(1+epsilon)*sqrt(3+2epsilon),
    g(D)=(1.03883+logq+logPlus(6pD/sqrt2))/D,
    C2=Dcoef*1.0064*b,
    B(D)=1.0064*C*(1+epsilon)/e*p*(4b/3)
       +1.0064*(3c/2)*(2+(1+epsilon)/epsilon*logPlus(2pD))*(4b/3)
       +1.0064*(35*32*c2/(3pi^2))*(3/4).

This is obtained directly by dividing the four large-remainder lines in the source by z, using UV/z<=p, V/H<=4b/(3T), H/z=3/(4T), V/z<=b/T^2 and cPlus<=c. No source remainder is omitted. The1.03883 term is an existing conditional prime input, not a newly proved unconditional estimate.

B(D) increases with D. The function g(D) decreases for every D>0. On the branch where logPlus is zero its derivative is negative. On the other branch, its derivative has numerator1-(1.03883+logq)-log(6pD/sqrt2)<0 because1.03883+logq>1. The two formulas agree at the branch point.

For a cell w in[w0,w1],u in[u0,u1], the large branch therefore uses

    Dlo=max(K_lower,w0*u0), Dhi=w1*u1,
    A0+Dcoef*g(Dlo)+B(Dhi)/T+C2/T^2.

K_lower is a certified lower bound for K. If the cell intersects both phase branches, take the maximum of the small remainder bound and this large remainder bound. The exact script also encloses K upward to decide when the small branch remains possible. This covers the entire phase interval rather than sampling its endpoints.

## Dyadic lower scales in the compact variable

Use the same compact variable as the accepted small-band proof:

    v=log(y)/3+log(9/601200), r=1/v,
    0<r<=rmax.

The Type II main term and the consumer lower bound remain increasing functions of r. The main-term formula uses

    L=log(1/(alpha*beta)),
    h(w0)=log(beta/(2q))+log(w0)/3-log(9/601200)>0,
    Phi<=log(2q)*log(1+L*r/(1+h(w0)*r)).

Unlike the first certificate, keep a better lower bound for T in each r-cell. Let its right endpoint be rhi, and let v0_upper enclose log(1e25)/3+log(9/601200) upward. Define

    k=max(0,min(8,floor((1/rhi-v0_upper)/log2_upper))).

If k>0, exact rational arithmetic verifies

    k*log2_upper<=1/rhi-v0_upper.

For every actual y in that r-cell, this implies

    log((wy)^(1/3)/(w*1e25)^(1/3))
      =v-v0>=klog2,
    T>=(w0*1e25)^(1/3)*2^k.

For k=0 the original endpoint lower bound remains valid. The cap8 merely weakens the lower bound for remote scales; it does not restrict y. It is enough to suppress the scale errors and permits reuse of only nine possible lower scales. The earlier exploratory model used cap128; the exact certificate uses cap8 and must be read on its own results.

Every normalized remainder previously shown decreasing in T is evaluated at this certified lower scale. The new large remainder is also decreasing in T since its T-dependent coefficients are nonnegative. The compact-r comparison still uses the right endpoint for the Type II main upper bound and the left endpoint for the consumer lower bound. There is no assumption that the complete expression or the final slack is monotone in y.

## Finite certificate design and status

The script is `resume_middle_certificate.py`. It imports the earlier interval utilities and sets the new parameters only in memory. It does not edit the reviewed small-band certificate or the pinned source.

The u edges are

    33000,40000,50000,65000,85000,110000,150000,250000,400000,26400000/49.

There are nine closed u-cells,128 r-cells and159 Gaussian w-bins. The w-masses have the same explicit Simpson remainder84*(w1-w0)^5/2880, and both tails retain

    17*.05^3/3+17*(65/8)*10^(-13).

Each decision uses exact fractions, rational log/root enclosures and outward rounding. The shared central expression removes the small-branch remainder before inserting the appropriate small/large maximum. Subtraction is performed as interval arithmetic enclosing an exact algebraic identity, not by subtracting an unrelated upper bound from an estimate.

The diagnostic scripts `resume_middle_large_model.py`, `resume_middle_allscale_model.py` and `resume_middle_dynamic_model.py` are separate. They identify the useful parameter choice but do not certify coverage. The first fixed-error all-scale attempt failed near the middle scales. The dyadic-scale design removes that avoidable loss. Exact replay results are recorded below after completion.

## Remaining conditions

Even if every scalar cell succeeds, the result remains conditional on the original Type I/II analytic producers, including the large lemma's1.03883 input. The new algebra does not discharge the Mobius profile, global psi estimates, or the other prime moments. The finite rational replay, analytic domination and source applications also remain to be formalized in Lean.

Before changing the all-twist denominator count, independently review the full source formula, global G2 cap for b576, dyadic lower-scale proof, mixed small/large cells, and the exact two endpoint overlaps with the already accepted certificates.

## Exact replay result

The completed exact replay exited successfully. All1152 u/r cells passed. The minimum certified gap is139563943/10^12=.000139563943 on the u-cell[65000,85000]. Every cell includes all w in[.05,8] and both tails. The worst r-cell is31 and uses the conservative dyadic power8.

| u interval | certified gap lower bound |
|---|---:|
|[33000,40000]|0.001013139721|
|[40000,50000]|0.000594193345|
|[50000,65000]|0.000195502292|
|[65000,85000]|0.000139563943|
|[85000,110000]|0.000281971500|
|[110000,150000]|0.000438940805|
|[150000,250000]|0.000632061845|
|[250000,400000]|0.000926494262|
|[400000,26400000/49]|0.001108015909|

The rounded decimals in this table display the exact lower fractions stored in the JSON. All pass/fail decisions use those fractions. The independent reviewer has been sent the completed note, script and output. Pending that review, this is a completed conditional paper calculation with an external exact certificate, not a new Lean theorem or an accepted count update.
