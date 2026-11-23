# Base-gap hybrid: retain the rational approximation and exact totient

Research only. No Lean compilation or source implementation was performed. The existing pointwise eta2 theorem has substantive Platt-dependent Type I/II inputs. This chapter describes how its future replacement can cover part of the base gap without a character-family estimate; it does not assume those other minor inputs have already been replaced.

## Target and the important budget distinction

Put y=x/49, with x>=4.9e26 and y>=1e25. The gap consists of alpha in `majorArcs 8 150000 y` but outside `majorArcs 8 150000 x`. The exact consumer needs

    |S etaStar x alpha| <= y*ghatY(y,150000),             (G)

not necessarily the older uniform .0121*y or the sufficient relaxed surrogate .01398*y. `ghatY` is defined in MinorArcs/LinftyLevels.lean:351 as

    1.398*max(gx(y,150000),hfun(y))+(17/3)*(670/150000)^3.

The major-constants worker's `base_gap_variable_budget_results.json` records a paper lower bound above .0471215 uniformly in y and above .0598081 at y=1e25. Its fallback uniform lower bound is .0404194. These lower bounds and their analytic proofs are separate research inputs, not assumed compiled theorems. The actual value at the starting scale is about .0602.

Consequently a direct eta2 upper envelope of .027 or .038 is useful for (G), even though it exceeds .01398. Comparing only with the latter would incorrectly reject this hybrid route. Conversely an endpoint comparison near .0602 alone does not prove a result for all larger y.

## Denominator normalization: approximate 2 alpha, not alpha

The reduced rational a/q supplied by wide-arc membership has delta=(alpha-a/q)*y. The parity-preserving gap geometry is

    q odd:  q<=150000, 600000/(49q)<=|delta|<600000/q;
    q even: q<=300000,1200000/(49q)<=|delta|<1200000/q.

Let d=gcd(q,2), Q=q/d and A=2a/d. Since gcd(a,q)=1, A/Q is reduced and

    2alpha=A/Q+2delta/y,
    1<=Q<=150000,
    600000/49 <= Q*|delta| <600000.                      (D)

At convolution scale z=w*y the twist in `Approx2` is Delta_w=2w*delta. The effective parameter is

    t_w=max(2,|Delta_w|/4)*Q=max(2Q,w*Q*|delta|/2),
    r_w=t_w/2=max(Q,w*Q*|delta|/4).

Thus r_w>=max(Q,(150000/49)*w). Keeping Q, instead of replacing r_w by min(1,w) times an arc-exclusion level, is the gain in this route. The exact totient ratio is Q/phi(Q), not q/phi(q).

`Approx2`, MinorArcs/TypeI.lean:60, additionally requires Q<=3z^(2/3)/4 and

    |Delta_w|*Q <= (4/3)*z^(1/3).

By (D), the left side is <1200000*w. For w in [.05,8] and y>=1e25 this condition holds with ample room. Also z>=5e23>2.16e20 and Q<=150000<z^(1/3)/6. The same reduced approximation therefore works throughout that integration interval; no fresh Dirichlet approximation or exclusion from major arcs at scale z is needed. The permissible upper w from this inequality is roughly3703 at the starting scale, far beyond8.

## Exact direct envelope and crossing inequality

The first case of `TernaryGoldbach.MinorArcs.theorem_3_1_1`, PointwiseBound.lean:68, gives, with f=Q/phi(Q),

    |S eta2 z alpha|/z <= B(z,Q,t_w),

    B(z,Q,t) = ((R(z,t)*log t+.8764)*sqrt(f)+2.526)/sqrt(t)
             +(2/t)*(f*((13/4)*log t+7.82)+13.66*log t+37.55)
             +3.8*z^(-1/6).

R is the source definition at PointwiseBound.lean:26:

    R(z,t)=.27125*log(1+log(4t)/(2log(9z^(1/3)/(2.004t))))+.41415.

The .8764 and3.8 constants include the source corrections to Helfgott. They must not be replaced by the older .5 and3.36.

For any interval [w0,w1] on which the hypotheses above hold, the unconditional smoothing transport `norm_S_etaStar_le_of_pointwise` in Prop1123b.lean:33 gives

    |S etaStar x alpha|/y
      <= integral_(w0)^(w1) B(wy,Q,t_w)*phi(w) dw
         +17*(integral_0^w0 phi+integral_w1^infinity phi),
    phi(w)=w^2*exp(-w^2/2).                             (V)

The exact sufficient direct crossing is that the right side of (V) is at most ghatY(y,150000), for every y>=1e25 and every delta in (D). This is the preferred finite classifier in (Q,phi(Q),Q|delta|), rather than a single cutoff in the original q.

At fixed Q, y and delta, the right side is

    A(Q,y,delta)*sqrt(f)+B1(Q,delta)*f+C(Q,y,delta),

with nonnegative coefficients obtained by integrating the three displayed source terms. This dependence makes exact-totient certificates straightforward. It also explains why substituting the global `Fr` envelope too early can lose a useful large-prime branch. `GBound.norm_S_eta2_le_gx` at line52 does exactly that substitution and imports the separate Mertens/totient dependency.

## A simple uniform direct branch

The independent-feasibility worker derived the following paper bound, without numerical quadrature. On w in [.05,8], Q<=150000 and (D), one has t_w<=2400000, z>=5e23, and R(z,t_w)<.68. Also t_w>=2Q. The functions

    (.68*log t+.8764)/sqrt t,
    1/sqrt t,
    (a*log t+b)/t  (for the positive source coefficients)

are decreasing throughout t>=200000. Their derivatives prove this directly. Together with 3.8*z^(-1/6)<.000428 and integral_0^infinity phi<1.254, this gives, for Q>=100000,

    U(Q,f)=1.254*[((.68log(2Q)+.8764)sqrt(f)+2.526)/sqrt(2Q)
                    +(f*((13/4)log(2Q)+7.82)+13.66log(2Q)+37.55)/Q
                    +.000428]+.000709002.              (U)

The last term bounds both omitted tails: integral_0^.05 phi<=.05^3/3, and integral_8^infinity phi<=(8+1/8)exp(-32). The source trivial eta2 estimate is17z.

For 100000<=Q<=150000 and f<=1.05, evaluation at Q=100000 bounds U by 379020785151/10000000000000=.0379020785151<.038. The numerical scalar choices supplied by that worker are log200000<12.21, sqrt(1.05/200000)<.002292, and1/sqrt200000<.002237. This sits below even the fallback uniform ghat lower bound .0404194. It covers every prime Q in that interval, and any composite satisfying the same totient condition. It is uniform in both y and the entire gap-twist interval, not merely at a sampled delta.

The independent worker owns the exact arithmetic and scalar proof in `agents/independent-feasibility/BASE_GAP_ALTERNATIVES.md`. This report does not elevate that paper branch to a Lean theorem. Proving R<.68 and the elementary logs/powers is part of that bounded certificate, while replacing the original theorem's Type I/II inputs remains a separate substantial prerequisite.

More generally (U)<=.0404 is an explicit conservative totient classifier that avoids any all-y numerical integration. If the stronger uniform lower bound .04712 is independently established, the classifier can use .04712 instead. For composite Q with larger f, use the full variable crossing (V), not an endpoint comparison.

## Selected-modulus diagnostics, not certificates

`base_gap_hybrid_diagnostic.py` uses floating 256-point Gauss quadrature on [.001,8], the source B, exact integer totients, and elementary upper bounds on the two omitted tails. It is exploratory: no quadrature remainder or interval-rounding certificate is supplied. The rows below use y=1e25 and the minimum allowed absolute delta=600000/(49Q).

| Q | phi(Q) | direct envelope diagnostic |
|---:|---:|---:|
| 50021 | 50020 | .0452191 |
| 75011 | 75010 | .0372572 |
| 100003 | 100002 | .0325658 |
| 149993 | 149992 | .0270364 |
| 30030 | 5760 | .1110562 |
| 60060 | 11520 | .0799506 |
| 90090 | 17280 | .0663962 |
| 120120 | 23040 | .0583422 |
| 150000 | 40000 | .0457524 |

At the limiting upper delta=600000/Q, the diagnostics for Q=149993 and150000 are .0224876 and .0382210. The upper endpoint itself is excluded from the source gap; these are limiting tests only. No monotonicity in delta is inferred from two samples.

These tests suggest that a richer direct classifier can cover some large composite denominators and primes below100000. They do not prove coverage: delta continuity, quadrature errors and all-y comparisons still have to be certified. In particular Q=120120 barely fits the starting-scale ghat budget, whereas Q=90090 does not; a global cutoff Q>=100000 needs more careful worst-modulus and all-y analysis than these few rows.

The moebius worker reports an additional possible improvement by retaining the raw Type II square-root product before the final arithmetic-geometric-mean bound. Its separate diagnostic at w=1 gives an approximately2.5% improvement for Q=150000. That refinement cannot be silently substituted into (V); it needs its own exact source-level combination and integration.

## Spectral complement and the exact remaining crossing

The original reconstruction uses characters modulo q, where q=Q or2Q; it cannot simply be changed to modulus Q because alpha, rather than2alpha, is being reconstructed. For the moduli/twists not certified by (V), define the actual etaU Mellin kernel

    F(s,delta)=mellin(u -> etaU(u)*exp(2*pi*i*delta*u))(s).

For each primitive character chi, let Z_chi(delta) be the multiplicity-weighted absolute zero sum of |F(rho,delta)|. A QRH explicit-formula estimate would give normalized character error at most y^(-1/8)*Z_chi(delta)+r_chi(y,delta). With the exact Gauss weights, a sufficient spectral crossing is

    main(q,delta)+(1+Wq)*d
      +y^(-1/8)/phi(q)*sum_psi |tau_q(psi)|*Z_(primitive(psi^-1))(delta)
      +1/phi(q)*sum_psi |tau_q(psi)|*r_(primitive(psi^-1))(y,delta)
        <=ghatY(y,150000),                             (S)

where Wq=sum_psi |tau_q(psi)|/phi(q) and d bounds normalized coprime removal. The zero-sum worker's paper bound main<=.000481 and the source d<=2e-9 can be reused after their listed proofs. Exact Gauss weights are sqrt(c) only when q/c is squarefree and coprime to c, otherwise zero; c is the conductor. A failed direct classifier does not remove those weights or allow an assumed 1/sqrt(c) improvement in the zero sum.

Small Q does force large twist: |delta|>=600000/(49Q). For example Q=1,101,1009 give lower bounds12244.9,121.24,12.14. The existing twice-integration-by-parts paper kernel suppresses a bounded low-height band like delta^-2, but grows quadratically in zero height. The stationary range gamma approximately -2*pi*delta*u remains and needs signed contour estimates or explicit height counts. Main-term Fourier decay is not an all-zero Mellin bound.

The gain from the direct branch is concrete: large prime Q>=100000, including the formerly problematic Q=149993, need no character-family estimate if the independent Type I/II replacements and simple branch are proved. The complement still contains medium primes and large composite Q with many small factors. Their inducing conductor distributions may help, but no such improvement is proved here. Thus this is a partial bypass of the large-conductor family bottleneck, not a completed base-gap proof.

## Dependency and validation order

1. Preserve the q-to-Q parity normalization, derive Approx2 at each w, and prove the fixed-interval convolution inequality using existing unconditional transport.
2. Independently replace the Type I/II and prime/Mobius inputs underlying `theorem_3_1_1`. Its current Fact binder is not cosmetic. Avoid the unnecessary global Fr substitution when using exact phi(Q).
3. Certify the simple U(Q,f)<=.038 branch and a uniform lower bound on the actual ghat envelope. This already gives a nonempty, useful all-y direct region with no large numerical table.
4. If useful, certify a finite exact-totient classifier using (V), with delta cells and analytic all-y control. Do not run a full150000-modulus quadrature before proving a workable uniform comparison scheme.
5. Establish (S) on the precise remaining region with actual smoothing, multiplicities and remainder terms. The smaller family/twist region should be recorded in that theorem's internal proof, not hidden as an extra assumption in the final base-gap result.

No new conclusion is claimed for the full10^27 theorem. Completed work here is the exact crossing formulation, corrected denominator/scaling, source dependency audit, a peer-derived uniform direct branch, and selected diagnostic examples that identify useful and difficult regions.
