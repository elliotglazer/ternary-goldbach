# Independent denominator-rectangle review

Research review, 2026-11-11, against ternary-goldbach commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean builds or canonical source edits.

## Verdict and exact scope

No blocking source or mathematical defect was found in the generalization from Q90090 to every natural reduced denominator in [90090,100000]. The argument covers all y>=10^25 and the complete permitted source twist interval

    1200000/49 <= u=q|Delta| <= 1200000,
    2alpha=A/q+Delta/y modulo an integer, gcd(A,q)=1.

It bounds the actual etaStar sum by the unchanged ghatY(y,150000). The general small/large Type I2 formulas are used on every central w bin; no endpoint band specialized to q90090 is borrowed. Thus there is no missing twist splice or parity-specialized endpoint premise.

This is conditional research coverage. The original analytic Type I/II producers remain required, including prime estimates, the squared-prime-log input, and Mobius/Liouville bounds. An external exact interval certificate does not discharge those producers or their current PlattGRH-dependent source declarations. The analytic domination, arithmetic checker and consumer application still require formal Lean proofs.

## Source domains and fixed Vaughan parameters

Direct source checks included `TypeITotal.typeI1_le:101`, its `muBound`, `TypeIITotal.typeII_637:331`, and `Assembly.norm_S_le_parts:65`, together with the small/large Type I2 contracts checked in the immediately preceding middle-band review.

The source permits arbitrary admissible U,V. Consequently the fixed coefficient a=1/(1152 sqrt(180180)), chosen at Q0=90090, can be used for every q in the rectangle. No first-choice equality tying a to the varying q is needed. The lower floor bounds alpha*T^2<=U and beta*T<=V remain uniform on .05<=w<=8 and y>=10^25.

The important enlarged constraint is qV<=H: it follows from 768*q<=76800000<T, since T>79000000. This was checked at Q1, rather than inherited from q90090. The conditions 16V<=H, V>=2.5e7, V>=2e*q, U>=sqrt3, U<=min(z/4,z/e,H/2), UV<=z, 3.5z/U<=H and V<=z/4 follow from the same fixed floor bounds. Assembly uses natural U,V and includes its 3log(z) remainder.

For the entire enlarged twist interval, w*u<=9600000<4T/3. Together with q<=H and the inherited coprimality/exact phase representation, this proves the Approx2 error requirement. Large central phases are allowed by `typeI2_le_large`: its phase domain has a lower threshold and no additional upper restriction. The choice epsilon_large=.03 remains distinct from the relative floor error 10^-8.

## Odd denominators and totient substitutions

The source Type I leading term and muBound use 2q/phi(2q), whereas Type II uses phi(q). Equality with q/phi(q) is valid for even q but not odd q. The wide certificate handles this correctly by independently requiring both

    q/phi(q)<=1001/192,
    2q/phi(2q)<=1001/192.

I independently recomputed totients through 200000 using an Eratosthenes-style totient sieve, a different algorithm from the author's trial division. All 9911 stored triples (q,phi(q),phi(2q)) agree, the q list is exactly every integer from 90090 to 100000, and both exact inequalities hold for every row. In particular phi(q)>=90090/(1001/192)=17280.

Using M=2.8*(1001/192) therefore bounds the actual source mu coefficient for either parity. The Type I leading ratio is replaced by this same certified constant directly. The G1/G2 saturation proof remains pointwise in the actual q and valid with the larger M. G2 includes the b=576 factor:

    G2(q)=M+log(16*b*q^2/3)+log(b*q).

The copied `constants` function was compared directly with the previously reviewed core. Its only textual expression changes are replacing the even-q leading ratio by MAXR and replacing scalar fraction construction in an unused raw helper by interval division. All other q dependence is enclosed by ordinary interval operations. No assumption of monotonicity in q has been inserted.

Every replacement of phi(q) by 17280 occurs in a denominator of a nonnegative upper-bound expression, so it enlarges the result. The interval q treatment also preserves the Type II correction, logarithmic denominators and Type I quadratic terms. Their positivity and logarithmic-over-power decrease conditions are checked uniformly by the interval assertions.

## Phase and scale cells

The threshold K(q)=q/(2c2) is enclosed as an interval. The small branch is included whenever D_lo<=K_upper, and the large whenever D_hi>=K_lower. These tests may retain an unnecessary bound but cannot exclude the actual branch. Taking the maximum on overlapping cells is safe. The large bound uses max(K_lower,D_lo) in its decreasing reciprocal-D term and D_hi in its increasing logPlus term. The small and large source domains both include equality.

The compact scale variable r=1/(log(y)/3+log(9/601200)) covers every finite y>=10^25. The dyadic k<=8 construction uses upper enclosures of v0 and log 2, so T>=(w_lo*10^25)^(1/3)*2^k holds throughout each scale cell. Setting the lower scale to Y0*2^(3k) is the correct cubic conversion. Capping k weakens bounds at remote scales; it does not restrict y.

The Type II main term increases with r for each fixed q, and its denominator shift h(q,w_lo) has a positive interval lower bound. Interval q and the right r endpoint therefore give an upper bound. The consumer lower envelope uses the left r endpoint. This does not assume monotonicity of the slack in either q or y.

All 11 adjacent closed u cells cover [1200000/49,1200000]; all 128 adjacent r cells cover the compact scale interval. The 159 Gaussian w bins cover [.05,8], with the previously reviewed exact mass enclosures and Simpson remainder. Both trivial tails with coefficient 17 are retained. Subtracting the identical small-remainder expression from the common core is valid interval algebra, as in the middle review, not subtraction of an unrelated estimate.

## Evidence, pins and coverage union

Independent inventory checks passed: 9911 consecutive denominator rows, 11 adjacent twist cells, 128 adjacent scale cells in each, all 1408 exact gaps positive, and dyadic powers in [0,8]. The minimum stored lower gap is 75993793/10^12 on u in [65000,85000], scale cell32.

Frozen source artifacts independently verified:

| File in agents/moebius | SHA256 |
|---|---|
| RESUME_COVERAGE_EXTENSION_2026-11-11.md | D81FDF9FCF7ACF10FAF829435860DE3D833816681D1738975CA52110B4760129 |
| resume_coverage_wide_certificate.py | 3DBFE3B106C263306E471952CDF3CEC1AE2E3972D52AD760B9D62F7351357F42 |
| resume_coverage_wide_certificate.json | BCD764CA10B3591D9B685649C6817749BDE5383C12D932744B9895C3BCB68056 |

The full independent replay completed with exit code 0. All 1408 cells passed and the resulting JSON matched the frozen author's JSON exactly. Its output is `resume_coverage_wide_certificate-independent.json`, with log `resume_coverage_wide_certificate-independent.log`, both in the audit directory. Author files were not modified.

This review supports proceeding with the parent's exact research-coverage union with the complete integer interval [90090,100000]. The interval contains 9911 integers, not 9911 necessarily new denominators. Intersect and deduplicate against the prior actual set before reporting a new union or prime/composite counts. This review does not independently certify a subsequent union computation.

No new theorem, axiom, sorry, canonical import or sealed result was introduced.
