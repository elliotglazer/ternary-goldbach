# Exact basegap classifier review

Independent research review, 2026-11-10. No Lean compilation, source implementation or dependency update. The analytic source is pinned calr3/ternary-goldbach commit23b2d68ca344203d4384e0aff7affa4ec034bef9.

## Verdict

The generalized coarse classifier is a valid sufficient paper criterion for every integer4<=Q<=150000. Its exact acceptance list independently reproduces49,034 denominators, including all8,268 denominators in the earlier branch, hence40,766 additions. The smallest accepted denominator is60859. These are exact external arithmetic results, not kernel-checked declarations.

The five binned rectangles also pass this paper/source review and exact replay. The all-y affine R argument is valid; the Gaussian masses have a valid Simpson error bound; directed substitutions are safe when made in the positive unexpanded expression. Both classifiers remain deductions from the existing Platt-dependent Type I/II pointwise theorem. Neither removes that assumption or closes the remaining basegap region.

## Artifacts reviewed

- work/qrh-campaign/base_gap_classifier.py: SHA25636AB1F43EDA37241C500CB4ACFD593E48CDE9474B80FF765CAE0D18F273EBA22.
- work/qrh-campaign/base_gap_classifier.json: SHA2565E54DF4564A88901B46A2EEB805DBE17B4081E400E66CDE5F1C961A2E5B8BD30.
- agents/major-constants/base_gap_binned.py: SHA2568F4C2455217A9C0251A2E3F3692E7ACAA49FF6797771E4CCF0C5B94FDFFE8748.
- agents/major-constants/BASE_GAP_BINNED.md: SHA256AE5A74AF862385CC60CDD86275E1632282EEB52DF71FE8763C13EB53E9F5F31B.

Own replay files are check_base_gap_classifier.py and replay_base_gap_binned.py. Earlier BASE_GAP_DIRECT_REVIEW.md verifies the underlying source theorem, normalization, convolution identity and ghat lower envelope.

## Generalizing the coarse envelope

The chosen wide-arc rational gives reduced denominator Q for2alpha, with Q<=150000 and D=Q*abs(delta)<600000. At scale z=w*y, the exact Approx2 parameter is2w*delta and the pointwise t is max(2Q,wD/2). On w in[.05,8], one still has z>=5e23 and t<=2400000, regardless of how far Q falls below100000. The approximation error condition and Q<=z^(1/3)/6 are unchanged. Thus the prior uniform R(z,t)<.68 proof still applies.

The lower endpoint is now t>=2Q. For Q>=4, log(2Q)>=log8>2; the last inequality follows from the source exp1 upper bound squared being below8. The relevant functions(A*log(t)+B)/sqrt(t) and(A*log(t)+B)/t have negative derivatives there for A,B>0. This justifies evaluating every t-dependent term at2Q. Q=1,2,3 are explicitly excluded by the classifier; no theorem is silently extrapolated to them.

Put phi=Nat.totient(Q) and v=Q/phi>0. After substituting t=2Q, the exact central upper expression is

(.68*log(2Q)+.8764)/sqrt(2phi)
 +2.526/sqrt(2Q)
 +(3.25*log(2Q)+7.82)/phi
 +(13.66*log(2Q)+37.55)/Q+.000428.

This agrees term for term with the script. In particular, sqrt(v/(2Q))=1/sqrt(2phi), and the factor2 in the source2L/t becomes1/Q. No conductor factor or totient square root is missing. The same full Gaussian mass and two trivial tails give U=1.254*central+.000709002.

The acceptance comparison U<=.04712 is sufficient because the independently reviewed source-defined ghatY(y,150000) is strictly greater than.04712 for every y>=1e25. This is a bound on the full original exponential sum through convolution. It does not need a second addition of the separate principal/removal allowances used in a spectral decomposition.

## Coarse arithmetic implementation

The subtraction sieve starts with phi[n]=n and applies n->n*(1-1/p) once for each prime divisor. The condition phi[p]==p identifies primes. This computes the exact natural totient for every tested positive Q.

For the logarithm, n=2Q is enlarged to twice the next multiple of1000. Monotonicity of log makes this conservative. The implementation then range-reduces n=2^k*x with1<=x<2 and k>=0. The positive atanh expansion uses24 terms and bounds its tail by2*z^49/[49*(1-z^2)]. This formula also covers x=1. Combining the upper log2 bound with nonnegative k preserves the direction. Finally ceiling to a multiple of10^-9 preserves an upper bound.

For a positive integer n, isqrt(floor(SCALE^2/n))+1 is strictly greater than SCALE/sqrt(n), including when the latter is an integer. Dividing by SCALE gives the reciprocal-square-root upper bound. The runtime square inequality confirms it for every generated entry. All coefficients multiplying logarithm/root bounds are nonnegative. Exact Fraction comparison controls acceptance; conversion to float occurs only in diagnostic fields.

My independent checker uses a least-prime-factor recurrence for totients rather than the subtraction sieve and a separately implemented atanh recurrence. It reproduced the full ordered accepted list, not only its count. It also checked the root direction for all entries and the monotonicity domain. Results:

- Accepted Q:49,034.
- Earlier Q>=100000,v<=1.05 branch:8,268, all still accepted.
- New Q:40,766.
- Minimum accepted Q:60859.
- Accepted prime Q:7,717.

The minimum exact acceptance margin is positive,40687803398079851649707/88381836250000000000000000000. These counts concern reduced denominators Q, not the original q, rational arcs, characters or zeros. Rejected denominators are inconclusive; this is a sufficient test with deliberately rounded upper bounds.

## Binned geometry and affine R comparison

The binned script uses w in[.01,8], so z>=1e23. This still comfortably satisfies all source size and approximation requirements. The exact parity reduction gives D in[600000/49,600000);16 closed cells cover this interval with harmless endpoint overlap. For w in[l,u], D in[D0,D1], and Q in[Q0,Q1], t_min=max(2Q0,lD0/2) and t_max=max(2Q1,uD1/2) correctly enclose t. Every tested rectangle has t_min>=100000, so the same coefficient monotonicities apply.

Let r(y)=R(y,300000), v0=log(9*y^(1/3)/601200), and H0=log1200000. The actual denominator log at(wy,t) is at least v0+d, with d=log(300000/t_max)+log(l)/3. The script uses downward enclosures V0<=v0(Y) and dLo<=d and checks V0+dLo>0. If dLo>=0, v0/(v0+d)<=1. If dLo<0, v/(v+dLo) decreases for v>-dLo, so V0/(V0+dLo) controls it for every y>=Y. These inequalities have the correct direction even when log(l) is negative.

Combining with an upper bound on log(4t_max)/H0 gives k>=1 with
R(wy,t)<=.41415+.27125*log(1+k*q)
 <=.41415+k*(r(y)-.41415), q=H0/(2v0)>=0.
The second inequality follows from concavity of log, equivalently log(1+kq)<=k*log(1+q). It is valid for all k>=1. The independent source R derivative shows r(y) lies in[.41415,.583405]; the upper endpoint is checked by directed bounds at Y.

For each cell, substituting this nonnegative fixed R upper bound permits decreasing t to t_min and enlarging v to the rectangle's V. Replacing log/root terms by upper bounds is valid in that unexpanded positive expression. The script then stores its exact affine expansion E(r)=ai*r+bi. Although bi may be negative, E(r)>0 throughout r>=.41415. Therefore multiplying by an upper Gaussian mass is legitimate. Treating ai and bi separately as positive would be wrong; the actual implementation does not do that.

## Binned Gaussian masses

For phi(w)=w^2*exp(-w^2/2), direct differentiation gives
phi''''=(-12+39w^2-14w^4+w^6)*exp(-w^2/2).
The global bound12+78/e+224/e^2+216/e^3<84 follows by maximizing w^(2k)*exp(-w^2/2) at w^2=2k. The script certifies e>2.7 with a positive Taylor sum and checks the resulting rational bound.

Simpson's single-panel remainder on an interval of length h is at most h^5*sup(abs(phi''''))/2880. Each sampled phi upper is w^2 divided by a positive Taylor lower sum for exp(w^2/2), then rounded upward. These substitutions and the upward rounding of the total mass preserve an upper integral bound. Thus the161 panel masses are certified mathematical enclosures conditional on the standard Simpson remainder theorem, not unsupported numerical samples. Formalizing or importing that theorem remains Lean work.

The lower omitted tail is bounded by17*.01^3/3. The upper omitted tail is bounded by17*(65/8)*10^-13 using the same Gaussian tail inequality and an exact Taylor proof exp32>10^13. Both tails are included once. The constants ai,bi and masses combine into an affine upper U_j(r). Comparing a*r+b-U_j(r) at both endpoints of the r interval is sufficient for the full interval. All16 D cells are checked separately; no monotonicity in D is assumed.

## Binned results and evidence limits

I replayed all exact calculations. The following lower comparison margins were reproduced:

| Q interval | v upper | Downward-rounded margin |
|---|---:|---:|
|[50000,150000]|8/5|.001802178004|
|[60000,150000]|2|.002366115932|
|[100000,150000]|4|.001541888122|
|[120000,150000]|1001/192|.000478361880|
|[125000,150000]|11/2|.000326702754|

The worst D cell is the first in each rectangle. The conditions are sufficient for every actual Q in the rectangle satisfying the exact integer totient comparison. Enlarging Q0, reducing Q1, or reducing the ratio upper preserves the already proved enclosing rectangle. A separate exact union classifier can count covered Q. No count for that union is asserted by this report.

The stored binned A/B floating values are diagnostics and must not be used as exact Lean certificate data. The Fraction computation or an exact rational serialization must be replayed. The recorded downward-rounded positive gaps are safe lower margins, but their use still depends on proving the analytic enclosure and connecting the actual source parameters.

## Remaining proof obligations

The generalized and binned analytic deductions are sound at paper level. Formal tasks remain: exact finite-totient/certificate verification, log/root bound bridges, Simpson remainder and finite integration assembly, the affine R comparison and actual ghat lower proof, exact source theorem specialization, and replacement of the Type I/II theorem's Platt-dependent inputs. The general off-larger-arcs source theorem remains separately conditional, as documented in the corrected integration map. None of these exact arithmetic runs is a Lean compilation or a root closure claim.

## Addendum: exact rectangle union and package wording

The prior script and note pins above are retained. The binned note was extended with a count section; its new SHA256 is684201B0CC321CD9118D28A28EA62571234A6B0ABF0175F2EC17930F4598AAD1. The analytic binned script remains pinned above without change. Newly reviewed artifacts:

- base_gap_coverage_counts.py: SHA256BBD2E229EE49C6B41DA03B911800ACAAA6CA1088152CA261B98AB3BACF7DDD60.
- base_gap_coverage_counts.json: SHA2563BEB31422A8EB7F107F89D77EFAA374F8DDD030CC67170C2D031B3CED7BDF72E.

The union script uses the five reviewed rectangle predicates, each as the exact integer test den*Q<=num*phi(Q), with domain1<=Q<=150000 and its proper lower cutoff. Its loaded coarse JSON is bound by SHA256 to the previously reviewed file. The sieve computes exact totients, and the unit is separated from both primes and composites. No new analytic condition is introduced by the union.

I independently reconstructed the full union and complement with the least-prime-factor totient recurrence in check_base_gap_union.py. This verified both complete ordered lists, every per-rectangle statistic, the coarse-file hash, all aggregate prime/composite/unit counts, and disjoint full-domain coverage. Results:

| Set | Total | Primes | Composites | Units |
|---|---:|---:|---:|---:|
| Five-rectangle union, also combined union |73578|8715|64863|0|
| Additions to coarse classifier |24544|998|23546|0|
| Remaining in1..150000 |76422|5133|71288|1|

The binned union contains all49034 coarse accepted denominators, so adding the coarse set does not enlarge it. Its minimum is50003 and maximum150000. The complement has minimum1 and maximum119910. Every count and listed containment checks exactly. These are counts of reduced denominators satisfying sufficient conditions, not numbers of completed Lean obligations, proportions of the analytic proof, or statements that rejected denominators cannot be handled.

The updated BASE_GAP_BINNED count section describes these results accurately and keeps the analytic and no-Platt requirements explicit. I also reviewed the assembled outputs/qrh-blueprint/README.md at SHA256FC0C79E0ABB1A795DA59722F9AC2DDFDB5B7D2017BD6D048E573FEB853EBA1FA and chapters/20-base-gap-update.md at SHA256BEBB11E869A22C4E97161EBEA433C5A2CE5E00040D97BD6E846B79BE785EE239. No blocking closure overclaim was found in these versions. They state that the Type I/II input remains conditional, distinguish paper review from Lean verification, and correct the general off-larger-arcs unconditionality error.

Those two assembled files still describe the coarse49034 count plus additional binned rectangles rather than the newly verified73578 combined count. That is accurate but not the newest coverage summary. Updating it should preserve the explicit condition that the pointwise Type I/II theorem's Platt-dependent inputs remain unresolved. The positive-detector discussion cites a separate independent review; it was not re-audited in this bounded union task.
