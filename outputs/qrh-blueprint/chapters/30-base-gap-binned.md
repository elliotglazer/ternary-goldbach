# Fixed-bin direct base-gap classifier

Research result: the existing eta2 pointwise envelope, integrated with explicit error bounds and compared with the actual all-y ghat lower envelope, proves the desired base-gap consumer bound on each of these denominator-ratio rectangles:

| Reduced denominator Q | Upper bound for Q/phi(Q) | Certified minimum comparison margin |
|---|---:|---:|
|50000<=Q<=150000|8/5|.001802178004|
|60000<=Q<=150000|2|.002366115932|
|100000<=Q<=150000|4|.001541888122|
|120000<=Q<=150000|1001/192|.000478361880|
|125000<=Q<=150000|11/2|.000326702754|

Every margin is rounded DOWN from an exact rational comparison. In particular, the first rectangle covers every prime Q>=50000 in range. The fourth covers the smooth composite Q=120120, whose totient is23040 and ratio is1001/192. No assertion is made here that every Q>=120000 satisfies that ratio; a finite arithmetic classifier can check it exactly. The tests are monotone in the denominator lower cutoff and ratio upper cutoff once the displayed upper cutoff150000 is fixed.

These results are paper deductions from the source pointwise theorem. That theorem's Type I/II dependencies still need their planned Platt-free replacements. This work does not discharge those dependencies or the spectral complement. No Lean compilation was run.

The reproducible script is base_gap_binned.py. It performs exact Fraction arithmetic for all decision inequalities, with directed rounding to rational multiples of10^-12. It checks161 fixed w intervals and16 fixed twist-product intervals per rectangle. It does not enumerate all150000 denominators and does not use uncertified quadrature. The output base_gap_binned_results.json contains every cell's margin and diagnostic affine coefficients.

## Exact normalization and source input

Let y=x/49>=Y=10^25. The wider major arc supplies a reduced a/q and delta=(alpha-a/q)y. Reduce2a/q to A/Q. Then Q=q for odd q and Q=q/2 for even q. The source gap gives

    1<=Q<=150000,
    D=Q*|delta| in[600000/49,600000).

At convolution scale z=w*y, the source Approx2 twist is2w*delta and

    t_w=max(2Q,wD/2).

The source first branch, PointwiseBound.theorem_3_1_1, divided by z, is

    B(z,t,v)=((R(z,t)*log(t)+.8764)*sqrt(v)+2.526)/sqrt(t)
       +(2/t)*(v*((13/4)*log(t)+7.82)+13.66*log(t)+37.55)
       +3.8*z^(-1/6),

where v=Q/phi(Q). The source constants.8764 and3.8 remain unchanged.

For .01<=w<=8, z>=10^23>2.16e20. Also Q<=150000<z^(1/3)/6. The approximation error condition follows from

    1.5*D*w^(2/3)<=1.5*600000*4=3600000<Y^(1/3).

The remaining Approx2 denominator-height condition follows from these stronger size bounds. Thus the same rational approximation is valid over every interval used below.

The source smoothing transport, norm_S_etaStar_le_of_pointwise_Ici or its finite-interval variant, gives

    |S_etaStar(alpha,x)|/y <= integral_0^infinity B(wy,t_w,v)*phi(w)dw

where the pointwise theorem applies, with the source trivial bound17 on omitted intervals. Here phi(w)=w^2*exp(-w^2/2).

## Fixed partitions and direct monotonicities

The w endpoints are

    .01,.025,.05,.10,.15,...,7.95,8.

The D endpoints divide[600000/49,600000] into16 equal rational intervals. Inclusion of the excluded right endpoint only enlarges the bound.

For a rectangle Q0<=Q<=Q1 and v<=V, a w interval[l,u] and D interval[D0,D1], define

    t_min=max(2Q0,lD0/2),
    t_max=max(2Q1,uD1/2).

Then t_min<=t_w<=t_max. Once R is replaced by a nonnegative fixed upper value, the functions

    (R*log(t)+.8764)/sqrt(t), 1/sqrt(t),
    (a*log(t)+b)/t for a,b>0

are decreasing for t>=t_min>=100000. This follows directly from differentiation. Thus all non-R terms can be evaluated at t_min with v=V. The final3.8*z^(-1/6) term is bounded using z>=lY. These are legitimate simultaneous bounds; there is no unsupported monotonicity claim for the whole original R-dependent expression.

## All-y comparison through a common R parameter

Use the exact reference

    r(y)=R(y,300000),
    H0=log(1200000), v0(y)=log(9*y^(1/3)/601200).

The independently reviewed lower envelope in BASE_GAP_VARIABLE_BUDGET.md is

    ghatY(y,150000)>=a*r(y)+b,
    a=1.398*12.61153*2.3286/547.723,
    F0=1.78*2.478081+2.50637/2.478088,
    L0=F0*((13/4)*12.61153+7.82)+13.66*12.61153+37.55,
    b=1.398*((.8764*2.3286+2.526)/547.723+L0/150000).

These are exact rational a,b. For y>=Y,

    .41415<=r(y)<.583405.

The script independently certifies the upper endpoint from directed log bounds at Y. The lower endpoint follows because the inner logarithm is nonnegative.

For the fixed w/t cell, set

    Hi=log(4*t_max),
    di=log(300000/t_max)+(1/3)*log(l).

Its R denominator is bounded below by v0(y)+di. Let V0 be any certified positive lower bound for v0(Y), and dLo a lower bound for di. All cells verify V0+dLo>0. If dLo>=0 use lambda_i=1. If dLo<0 use

    lambda_i=V0/(V0+dLo).

Indeed v/(v+d) decreases with v when d<0, so this ratio controls every y>=Y. Then choose a rational

    k_i>=max(1, (Hi/H0)*lambda_i).

With q=H0/(2v0(y))>=0,

    R(wy,t_w) <= .41415+.27125*log(1+k_i*q)
              <= .41415+k_i*(r(y)-.41415).

The first step uses log(4t_w)<=Hi and the denominator lower bound. The second uses log(1+kq)<=k*log(1+q) for k>=1,q>=0. This last inequality follows by differentiation in q, or Bernoulli's inequality.

This gives an affine upper envelope in the same r(y) as the lower bound. It avoids extrapolating an endpoint calculation and avoids an infinite y-grid.

## Exact Gaussian integration bounds

For each interval[l,u], h=u-l and m=(l+u)/2, use the upper bound

    M_i = h/6*(phi_upper(l)+4phi_upper(m)+phi_upper(u))
             +84*h^5/2880.

This is Simpson's formula WITH an explicit fourth-derivative error. It is not sampled quadrature being treated as a proof. We have

    phi''''(w)=(-12+39w^2-14w^4+w^6)*exp(-w^2/2),
    |phi''''(w)| <=12+78/e+224/e^2+216/e^3<84.

The maxima of w^(2k)*exp(-w^2/2) are(2k/e)^k; the final rational comparison uses e>2.7. The script verifies that bound from a positive Taylor sum.

Each phi_upper(w) is w^2 divided by the positive Taylor sum for exp(w^2/2) through degree120, rounded upward. Since that sum is a lower bound for the exponential, the resulting phi value is an upper bound. The extra Simpson error is exact rational and is added before the final upward rounding. Hence M_i>=integral_l^u phi.

The two omitted tails use the source trivial factor17:

    17 integral_0^.01 phi <=17*.01^3/3,
    17 integral_8^infinity phi <=17*(8+1/8)*exp(-32)
                               <17*(65/8)*10^-13.

The last exponential inequality is checked by a positive Taylor lower bound. Both tails are retained.

## The finite sufficient test

For each D cell j and w cell i, replace R by.41415+k_i*(r-.41415), t by t_min, v by V, log(t_min) by a directed upper rational, square roots by directed upper rationals, and3.8*(lY)^(-1/6) by a directed upper rational. Call this positive affine function E_ij(r). It is nonnegative throughout r>=.41415.

Then

    U_j(r)=sum_i M_i*E_ij(r)+TAIL=A_j*r+B_j

is a certified upper bound for the normalized smoothed sum on the whole rectangle and D cell. Its comparison with a*r+b is affine. It therefore suffices to check the TWO rational inequalities

    U_j(.41415)<=a*.41415+b,
    U_j(.583405)<=a*.583405+b.

The script performs both for all16 cells. All five listed rectangles pass strictly. The worst cell is the first D cell in every listed rectangle. The comparison margin is the minimum of both endpoints and all cells, rounded downward to10^-12.

The positivity of E is important: replacing each Gaussian mass by an upper bound would not be legitimate for a negative integrand. Although B_j or an intermediate constant term can be negative after affine expansion, the original evaluated E is positive since its R upper bound is at least.41415 and every unexpanded source term is positive.

No unproved monotonicity in D is used. D is divided into cells and every cell is checked. No unproved monotonicity in y is used: the reference-r interval proof covers all y.

## Monotone use as an arithmetic classifier

Once a rectangle is certified, any actual denominator Q satisfying Q0<=Q<=Q1 and Q/phi(Q)<=V lies in it. Increasing Q0 or decreasing V preserves validity of the same cell bounds; decreasing Q1 also preserves it. For actual Q the totient comparison is the integer inequality denominator(V)*Q<=numerator(V)*phi(Q).

The listed rectangles can be unioned with the parent's coarse U classifier. There is no need to enumerate denominators with transcendental calculations. The finite arithmetic union can be checked separately. The present certificate already demonstrates two substantial additions: primes down to50000, and Q=120120 with its large exact totient ratio.

The Q=90090 ratio1001/192 is not covered. Exploratory work suggests its direct envelope is too large at the smallest scale using this final pointwise theorem. No impossibility claim is made for sharper raw Type II bounds or a spectral treatment of that remaining region.

## Remaining formal proof obligations

The computational inequalities are exact, but a Lean proof still needs the Gaussian Simpson remainder lemma, the elementary log/root certificate bridge, the affine R comparison, the finite partition integration assembly, and the source pointwise theorem with its own Platt-dependent inputs replaced. These are explicit obligations. Merely importing the pointwise theorem under its existing Fact PlattGRH would not solve the user goal.

The consumer remains |S_etaStar|<=y*ghatY(y,150000). The ghat function, minor-arc cell bounds, lower-J value, and corrected final major1.0404/minor1.0376/nonprime.00271 budget all remain unchanged.

## Exact denominator counts

The integer-only script `base_gap_coverage_counts.py` applies the five certified rectangle tests using a totient sieve. No transcendental evaluation is used for this enumeration. Its output `base_gap_coverage_counts.json` records both the accepted and the remaining denominators explicitly, and pins the parent's coarse classifier JSON by SHA256.

On the full domain 1 <= Q <= 150000, the five-rectangle union contains 73,578 denominators: 8,715 primes and 64,863 composites. Its smallest member is 50003. It contains every one of the coarse classifier's 49,034 accepted denominators, so their combined union is the same set. There are 24,544 additions to the coarse set, consisting of 998 primes and 23,546 composites.

The remaining set has 76,422 members: 5,133 primes, 71,288 composites, and the unit Q=1. Its smallest member is 1 and its largest is 119910. These are denominator counts for sufficient arithmetic criteria, not counts or percentages of completed proof obligations. The analytic integration lemmas and the no-Platt replacement of the underlying Type I/II theorem remain separate obligations.

Independent statement audit found no mathematical defect in the binned argument and replayed all five positive margins. Diagnostic floating-point A/B fields must not be used as formal certificates; the exact Fraction expressions in the script are the authoritative computations.

## Raw square-root tangent extension

The separate experiment `base_gap_raw_tangent.py` and its JSON output retain the raw Type II square-root product from the Moebius worker's `BASE_GAP_RAW_COMPARISON.md`. This adds a sufficient twist-dependent region, but does not increase the all-twists denominator counts above.

Write r=R(y,300000) and c_i(r)=k_i*(r-.41415)/.27125, with the same kappa certificate and Gaussian bins as before. On a fixed Q/D/w cell, freeze t at its lower endpoint and ell at a certified upper bound for log(t). The raw leading term is at most sqrt(q_i(r)), where

    q_i(r) = (V/t_min)*(.30214*ell+.7468)
             *((c_i(r)+.5)*ell+.002*c_i(r)+log(2)_upper).

This is a positive affine function of r. For any positive rational h,

    sqrt(q_i(r)) <= q_i(r)/(2*h)+h/2.

The proof is the nonnegativity of (sqrt(q_i(r))-h)^2. Choose h as a rational upper square root of q_i at the midpoint of each r cell. No numerical optimization or assumption about the sign of the tangent's constant coefficient is needed. The full expression stays positive before replacing its Gaussian mass by an upper bound.

Divide [.41415,.583405] into eight equal rational intervals and keep the previous 16 D intervals and 161 w intervals. Add the exact raw remainder

    2.5257/sqrt(t_min)
    +[13.2*V+2*(16.267*ell+24.42)]/t_min
    +3.77*(w_lo*1e25)^(-1/6)
    +3*log(w_lo*1e25)/(w_lo*1e25).

The logarithmic last term decreases throughout the relevant positive range. The same omitted-tail constant applies. Every tangent integral is affine in r; checking its difference from the ghat lower bound at both interval endpoints covers all y>=1e25. The script stores exact rational A and B coefficients, as well as downward-rounded gaps. Diagnostic floating-point fields are not certificates.

The resulting sufficient region is

    90090 <= Q <= 150000,
    Q/phi(Q) <= 1001/192,
    13200000/49 <= D=Q*|delta| <= 600000.

All nine D cells in that range pass, uniformly in y, with minimum margin greater than .000786242533. At the single Q=90090, the corresponding minimum exceeds .000835787582. These bounds inherit the same unresolved Type I/II inputs as the original direct classifier.

The seven smaller D cells fail this particular upper-envelope comparison. The first cell's worst computed gap is approximately -.005064172 for the whole Q rectangle, or -.005014627 at Q=90090 alone. These negative values do not prove that the actual smoothed sum exceeds its allowed bound. They show that this first-choice envelope and these cells do not settle the remaining twists. The Moebius worker's separate modification of the Type I/II parameters addresses a very small-twist interval; a middle-twist interval still needs a valid bound before Q=90090 can be counted as covered for every gap point.
