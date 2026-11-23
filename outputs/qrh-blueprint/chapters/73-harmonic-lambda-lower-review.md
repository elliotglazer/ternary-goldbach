# Independent P3 floor-kernel review

Date:2026-11-11. Verdict: PASS as an unconditional mathematical replacement route for the original P3 integer and real statements, using the recovered rational certificate plus the existing small-range theorem. No mathematical defect was found in the floor kernel, the factorial identity, or the full-real endpoint/remainder argument. This is not a claim of Lean implementation, new kernel validation, or an approved frozen declaration.

The exact accepted coefficient artifact is prime-estimates/resume_p3_exact_kernel_20261111.json, SHA256 E11FE1B1A244BE354E575C84596DB551EF5684141438165B97F26B886B8EBAF8. It contains45 rational coefficients with d=24 and m=72. The recovery script resume_p3_exact_20261111.py has SHA256 F0FF96B9807DA97A200BAB476B09A489BD264639E7C774FC9FD3F06F0582DF86. Its floating active-constraint selection is only a discovery step; none of that floating selection is trusted in this review.

I wrote and ran mellin/resume_p3_review_exact_20261111.py. It reads only the rational JSON, independently checks the full constraints, and uses a separate rational logarithm enclosure. It exited0 with PASS_INDEPENDENT_EXACT_AUDIT. No LP float, numerical optimizer, or exploratory objective value enters an acceptance decision.

## 1. Exact original conclusion

The pinned source is ternary-goldbach23b2d68. Prelim/LambdaMu.lean:1086 currently states mertens_lower_nat, under Fact PlattGRH:

    log(N+1)-log(3/sqrt2)<=sum_(n in Icc1N) Lambda(n)/n,
    N>=1.

Its real wrapper at line1169, log_sub_le_sum_vonMangoldt_div, concludes

    log(x)-log(3/sqrt2)<=sum_(n in Icc1 floor(x)) Lambda(n)/n,
    x>=1.

The proposed route preserves these statements, including N+1 in the integer result and the complete real domain. It does not merely prove a lower bound involving log N and leave a floor gap.

For N=1,2, the existing elementary branches are independent of Platt. For3<=N<=10000, Prelim/SmallMertensLower.lean:284, MertWalk.mertens_lower_le, has precisely the needed conclusion and no Fact PlattGRH binder. That file imports LogWalk and uses finite kernel arithmetic for its certificates. I inspected this source interface and did not rebuild or independently revalidate its entire transitive proof. The new argument below covers every integer N>=10000, so the junction has an overlap and no omitted endpoint.

## 2. The entire floor-kernel domain is certified

Let a_j=j/24 and

    K(u)=sum_(j in support) c_j floor(a_j u).

The rational normalization is exactly sum_j c_j a_j=1. The independent checker verifies it as Fraction equality.

Every possible jump on[0,24] occurs at u=24*i/j with1<=j<=72,1<=i<=j. The positive breakpoint set has1588 points; my checker adds0, obtaining1589 points, with1 and24 explicitly included. At every point it verifies

    K(u)<=0 if0<=u<1,
    K(u)<=u if1<=u<=24.                                     (K0)

The finite checks imply the full continuum assertions: on each interval from a breakpoint a up to but excluding the next breakpoint, all floors are constant and equal their values at a. Floors are right-continuous. Below1 the required upper bound is constant0; above1 the upper bound u increases. The point1 is itself a breakpoint and is checked with the correct right-side target1. The point0 gives K(0)=0. For extra independent sanity checks, the script verifies exact constancy at every midpoint; these checks are not a substitute for the elementary constancy proof.

The period relation is exact for every real u:

    K(u+24)=K(u)+sum_j j*c_j=K(u)+24.

For u>=1 write u=24k+r with integer k>=0 and0<=r<24. If r>=1 use K(r)<=r. If r<1 use K(r)<=0<=r. Thus K(u)<=u for every u>=1, and the below1 conclusion remains K(u)<=0. No positivity of K is required or claimed. Signed coefficients do not invalidate this argument because the complete kernel, not its individual terms, is bounded.

## 3. Von Mangoldt identity and inequality direction

Write A(x)=sum_(1<=n<=floor x) Lambda(n)/n. For x>0 and every integer n>=1, nonnegativity of Lambda and(K0) give

    Lambda(n)K(x/n)
       <=Lambda(n)*(x/n)*1_(n<=x).

In particular, for n>x the kernel is nonpositive and its terms must not be dropped from a lower-bound derivation. They are retained in the finite sum below. For n>3x every floor is0, since max a_j=3. Hence

    sum_(n<=floor(3x)) Lambda(n)K(x/n)<=x A(x).                (V1)

For any real t>=0,

    sum_(n>=1) Lambda(n)floor(t/n)
       =sum_(1<=r<=floor t) sum_(n divides r) Lambda(n)
       =sum_(1<=r<=floor t) log r
       =log(floor(t)!).                                      (V2)

All sums in(V2) are finite. The first equality counts the multiples of n up to floor t; equivalently floor(t/n)=floor(floor(t)/n) for integer n>=1. The divisor identity sum_(n divides r)Lambda(n)=log r also covers r=1, whose contribution is0.

Expanding K linearly in(V1) and applying(V2) therefore gives

    x A(x)>=sum_j c_j log(floor(a_j x)!).                    (V3)

No inequality is multiplied by a signed c_j during this step: it is an exact finite identity after the already proved kernel inequality. There is no hidden prime-number-theorem, Chebyshev, QRH, or zero-location input.

## 4. Explicit factorial remainder for real arguments

For every real t>=1, let L(t)=log(floor(t)!) and g(t)=t log t-t. The required bound is

    |L(t)-g(t)|<=1+log t.                                    (F)

It follows from elementary integral comparisons, not a delicate Stirling asymptotic. With M=floor t>=1,

    g(M)+1<=sum_(r=1)^M log r<=g(M)+1+log M.

Also0<=g(t)-g(M)=integral_M^t log u du<=log t. Therefore

    1-log t<=L(t)-g(t)<=1+log M<=1+log t,

which implies(F). This explicitly includes noninteger t and integer endpoints. In the large branch N>=10000, every a_j N>=N/24>1, so no use of(F) occurs outside its domain.

Let S=sum_j c_j a_j log a_j and B=sum_j|c_j|. From normalization and(F),

    sum_j c_j L(a_jN)
       >=N log N+(S-1)N-B*(1+log(3N)).                       (F2)

The error bound uses absolute coefficients, so their negative signs are handled correctly. Since a_j<=3 and a_jN>=1, every error1+log(a_jN) is nonnegative and at most1+log(3N).

## 5. Independent exact logarithms and the numerical margin

The independent checker encloses log q by binary range reduction to1<=r<=2 and the positive atanh series

    log r=2 sum_(k>=0) z^(2k+1)/(2k+1), z=(r-1)/(r+1).

After40 terms, its exact upper tail is

    2*z^81/[81*(1-z^2)].

The log2 enclosure is combined with the reduced argument using the correct reversed endpoints for negative binary exponents. Signs of c_j a_j are handled explicitly when summing the lower/upper bounds for S. All acceptance comparisons are rational.

The checker establishes

    S>.26659>.2665,
    B=6796561283852302/1234688414574615<5.51,
    log10000<9.211, log3<1.1,
    log3-(log2)/2>.74.

The function(log N+2.1)/N decreases for N>=10000, since its derivative is(-log N-1.1)/N^2<0. Consequently(F2),(V3) imply

    A(N)>=log N-.7335-5.51*(log N+2.1)/N
         >=log N-.7335-.006232361
         =log N-.739732361.

Finally log(N+1)-log N=log(1+1/N)<=1/N<=.0001, so

    A(N)>=log(N+1)-.739832361
         >log(N+1)-.74
         >=log(N+1)-log(3/sqrt2).                             (P3N)

The exact final rational constant is739832361/10^9, strictly below.74. The source already gives an independent elementary proof of log(3/sqrt2)>=.74 inside LambdaMu.lean:1152. Either that proof or the reviewed rational log enclosure suffices.

This margin is comfortably positive after including every floor, factorial and N+1 correction. Merely comparing the LP objective constant about.733404 with log(3/sqrt2) would not have been sufficient; the accepted argument includes the complete error terms above.

## 6. Real wrapper and status of the certificate

For real x>=1 set N=floor x. Then N>=1, A(x)=A(N), and x<N+1. The already inspected source wrapper uses log x<=log(N+1), so(P3N) and the finite branches prove the exact real conclusion. No interval between integers, and no range near1, is omitted.

The coefficient-recovery script uses floating values to choose an active rational linear system, then rechecks rational constraints. That is acceptable only as discovery. The reviewed artifact is the fixed rational JSON, and the independent checker does not read the LP JSON, import the recovery script, or depend on float-based support selection. Even an incorrect optimizer would not affect this audit if it happened to output the same valid certificate.

The JSON's advertised loose B_upper=7 is not the constant used in the final large-branch proof. The stronger bound B<5.51 is independently verified from the actual coefficients. Future Lean replay must prove that stronger inequality (or retain a separately sufficient sharper objective/error budget); copying only the JSON metadata B_upper=7 would lose the displayed.74 margin. Similarly, all1588 positive breakpoint constraints and the exact normalization need proof-producing replay, not assumed Boolean outputs.

Remaining implementation work is finite rational certificate replay, the floor-period/interval lemma, the finite von Mangoldt-factorial rearrangement, the real factorial remainder, and the decreasing error bound. The source finite MertWalk theorem and its imports still require the campaign's normal focused build and axiom audit when implementation resumes. Nothing here authorizes native_decide/ofReduceBool shortcuts or new premises.

This route removes the need for the former Platt-dependent large-N psi lower-bound argument in P3. It does not claim that the public Lean theorem has already been changed or that other prime contracts are solved.

## Final handoff binding

The finalized author note `prime-estimates/RESUME_P3_2026-11-11.md`, SHA256 `7F35B0E4CB702FCC3843D0E7D1E00370BE3AEA1398A651C73EF7825315687E03`, has also been read and agrees with this audit. The author's additional verifier `resume_p3_verify_20261111.py`, SHA256 `7002F1F95CCA2F17D242600F2F5F155AA00CCE915637AA122B43489D5A1D1D16`, accepts its logarithm boxes using the actual `Small.chkLow` and `Small.chkStep` rational formulas. I compared those formulas with `SmallMertens.lean:23` and `SmallPsi.lean:28`; they agree, including the upper Taylor remainder and the exponent decomposition. The resulting logarithm certificate JSON has SHA256 `2398BB85D3382E60F9C7DCE2BAA526DB59373D7BE0B0080D35A0B645C3EEB226`. This additional binding does not replace the independent rational replay recorded above and does not assert a Lean proof.
