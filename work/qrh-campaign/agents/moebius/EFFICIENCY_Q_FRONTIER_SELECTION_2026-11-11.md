# Joint binary/principal selection on the proposed Q frontier

2026-11-11. Conditional paper cost selection with exact integer/rational certificates. No prime, zeta, zero or other special-function evaluation; no Lean/MM0 builds or source edits. The analytic frontier is **pending proof and independent acceptance**. This note supplies its exact Goldbach cutoff allocation and cost implications, not the frontier theorem or a new finite-RH certificate.

## 1. Confirmed proposed input and conservative even cutoff

The major-constants author confirmed the following proposed uniform parameters before this note was frozen:

    A=10^16, N=10^27, 1<=Q<=50 (real Q allowed),
    H(Q)=4*10^10*Q,
    a(Q)=31/1000+2261/(1000Q),
    |theta(x)-x| < a(Q)*sqrt(x)*(log x)^2, A<=x<=N.

All analytic and finite spectral hypotheses of that proposed theorem still have to be discharged. In particular this is not a substitution into the older Johnston/Büthe initialization theorem at heights below its bootstrap. The new direct proof is intended to supply its own A-domain argument. The author reports that the pending reciprocal-head repair preserves the displayed coefficients; any coefficient or domain change requires recomputing this note's allocation.

Use the same conservative rational bounds as the author's scalar plan:

    sqrt(N)<3163*10^10,
    log(N)<63,
    U=(3163*10^10)*63^2=125539470000000000.

The square-root comparison is an integer square inequality. The logarithm bound follows from log10<231/100<7/3. The companion script supplies finite rational geometric-series witnesses for the coarse log inequalities used here; it calls no transcendental evaluator.

Define an even integer cutoff

    B(Q)=2*max(A, ceil(a(Q)*U+3)).                   (1)

Then B>=2A and B-4-2a(Q)U>=2. Consequently the two-endpoint theta error is strictly below B-4. For odd n with A+B<=n<N, put y=n-4 and z=n-B. Both endpoints lie in [A,N], and

    theta(y)-theta(z) > (B-4)-2a(Q)U > 0.

A prime in (n-B,n-4] gives the binary reduction through B. For the lower range, the proved Bertrand theorem supplies an odd prime A<p<2A. As proved in the prior hybrid note, base3 covers odd n<=B+3, and p covers [B+5,A+B]. Thus every Q in the proposed domain would yield a complete finite ternary reduction from a **proved** binary theorem through B(Q), without explicit ladder or patch-prime records. No new hypothesis is added to the desired final theorem.

These are sufficient cutoffs, not optimal analytic bounds. The small added integer margin in (1) avoids rounding ambiguities even if a later adapter weakens a strict estimate to a non-strict one. Certifying a convenient larger even B is also valid, but increases the binary workload and should be priced.

## 2. Exact selected rows and the saturation point

| Q | Required height H | Sufficient even B from (1) |
|---:|---:|---:|
| 1 | 40000000000 | 575472930480000006 |
| 2 | 80000000000 | 291628188810000006 |
| 4 | 160000000000 | 149705817975000006 |
| 8 | 320000000000 | 78744632557500006 |
| 16 | 640000000000 | 43264039848750006 |
| 32 | 1280000000000 | 25523743494375006 |
| 47 | 1880000000000 | 20000000000000000 |
| 48 | 1920000000000 | 20000000000000000 |
| 50 | 2000000000000 | 20000000000000000 |

For comparison, the author's convenient rounded cutoffs are respectively 6e17,3e17,1.5e17,8e16,5e16,3e16, and 2e16 at Q48/50. Formula (1) improves some of those choices without changing the analytic coefficient or requesting any new prime data.

The exact first real Q at which allocation (1) reaches its floor 2A is

    Q_sat = 2261*U / [1000*(A-3)-31*U]
          = 283844741670000000 / 6108276429999997,
    46 < Q_sat < 47.

The denominator is positive. The ceiling condition is exact: ceil(aU+3)<=A if and only if aU+3<=A. Thus Q47 is the first integer Q reaching the floor. Under monotonically increasing complete principal cost and no separate benefit to another consumer, Q48 and Q50 are dominated by Q47. For a real-valued parameter choice the corresponding endpoint is Q_sat itself. Its rational height is admissible to the mathematical proposed theorem; a checker that only supports integral or block-aligned heights must round upward and charge the actual ceiling.

This dominance is about the stated gap use and allocation. Extra high spectral information might serve a different consumer, and a particular checker can have block-dependent costs. Account for those effects rather than claiming an unconditional runtime ordering.

## 3. Exact pairwise switching test

Let C_bin,S(B) be the complete binary generation/proof cost in system S, already optimized over admissible L, anchor layout, source proof, exceptions and assembly. Let C_pr,S(H) include all additional compatible principal spectral work, production and checking. Let F_S(Q) denote any remaining Q-dependent analytic proof/scalar/assembly costs. The actual candidate objective is

    T_S(Q)=C_bin,S(B(Q))+C_pr,S(H(Q))+F_S(Q)+common_S.

For Q_j>Q_i, the higher height wins exactly when

    C_bin,S(B_i)-C_bin,S(B_j)
       > C_pr,S(H_j)-C_pr,S(H_i)+F_S(Q_j)-F_S(Q_i).   (2)

This equation is usable without a linear model. It must be evaluated separately for Lean and for the chosen MM0 acceptance implementation. A PA arithmetic proof, a native admissible checker and a Lean kernel reduction are not interchangeable calibration points. Reusable analytic libraries and genuine prior finite-RH evidence may cancel; unproved strip certificates and schematic arithmetic libraries do not.

## 4. Illustrative linear-binary / H log H model

For sensitivity only, freeze

    C_bin,S(B)=c_b*B+constant,
    C_pr,S(H)=c_h*H*log H+constant,
    F_S(Q)=constant,

with c_b,c_h>0. These coefficients include complete work under the named architecture; they are not measured here. Set H0=4e10, b_Q=B(Q)/A, and

    lambda=c_h*H0/(c_b*A).

After scaling cost by c_b*A, candidate cost is

    b_Q + lambda*Q*log(H0 Q).                       (3)

For any pair Q_i<Q_j, its exact switching value is

    lambda_ij=(b_i-b_j)/[Q_j log(H0Q_j)-Q_i log(H0Q_i)].

Below that value the higher Q wins; above it the lower Q wins. There is no hidden transfer of a historical core-year estimate into lambda.

The following **outward rational intervals** bracket the switching values for the displayed active grid. All decimal endpoints are exact multiples of10^-6, produced by rational arithmetic from coarse rigorous log bounds, not numerical logarithm calls.

| Neighboring Q values | Enclosure for lambda_ij |
|---|---|
| 1 -> 2 | (1.090871, 1.107039) |
| 2 -> 4 | (0.265473, 0.269610) |
| 4 -> 8 | (0.064651, 0.065705) |
| 8 -> 16 | (0.015755, 0.016023) |
| 16 -> 32 | (0.003841, 0.003910) |
| 32 -> 47 | (0.001243, 0.001291) |

For example, lambda>1.107039 makes Q1 cheapest on this displayed grid; lambda<0.001243 makes Q47 cheapest. Between neighboring switch intervals, the corresponding intermediate grid candidate is cheapest. Within an interval the coarse log bounds do not determine that pair's ordering. Non-neighbor comparisons follow by adding cost differences because the switch intervals are strictly ordered. This identifies the lower envelope of this grid, not the optimum among all real Q or every integer1,...,50.

The inequalities used to build the table are 69/100<log2<7/10, 109/100<log3<11/10, and 23/10<log10<231/100. Powers of two give the Q1–32 entries. The bounds45<47<48 give a coarse bracket at Q47; Q48=3*16 and Q50=5*10 give the others. The certificate uses

    log n = 2 sum_{j>=0} z^(2j+1)/(2j+1), z=(n-1)/(n+1),

whose K-term tail is at most `2z^(2K+1)/[(2K+1)(1-z^2)]`. This follows by integrating the finite geometric series for1/(1-z^2); all terms are positive. Exact checks use K=8 for n2,3 and K=32 for n10. They certify only coarse scalar bounds, not spectral data or model runtimes.

## 5. An interior Q can be optimal

The smooth conservative cutoff beneath (1) is

    b_cont(Q)=max(2,c0+c1/Q),
    c0=(2U*(31/1000)+6)/A,
    c1=2U*(2261/1000)/A.

The exact B(Q)/A exceeds b_cont(Q) by less than2/A and agrees with the floor after saturation. Before saturation, the relaxed model is

    f(Q)=c0+c1/Q+lambda*Q*log(H0Q).

Its derivatives are

    f'(Q)=-c1/Q^2+lambda*(log(H0Q)+1),
    f''(Q)=2c1/Q^3+lambda/Q > 0.

Therefore it has a unique minimizing interior point when the derivative changes sign in [1,Q_sat]. The point solves

    lambda=c1/[Q^2*(log(H0Q)+1)].                   (4)

If lambda>=c1/(log H0+1), the relaxed optimum is Q1. If lambda<=c1/[Q_sat^2*(log(H0Q_sat)+1)], it is the saturation endpoint. Between these extremes it is interior. Above saturation binary cost is constant and spectral cost increases. For integral Q, check the adjacent integers around the relaxed optimum and the endpoint, with the exact even B and actual implementation costs. The tiny cutoff rounding affects normalized binary cost by less than2e-16; it does not justify discarding real checker chunking costs.

This differs from the prior fixed-B hybrid model. There, increasing H expanded covered range like H^2 while retaining a ladder suffix, which could force an interior maximum under the stated model. Here the ladder is absent and increasing H reduces the binary cutoff like1/H, so the relaxed tradeoff is convex and may have an interior minimum. Applying the earlier endpoint-only conclusion to this Q frontier would be incorrect.

## 6. Restore L, source proof and complete-system costs

The linear c_b is a local approximation. In the exact joint frontier, source proof and the initial range depend on L, anchor work is roughly proportional to B/L, and coverage/source lookup costs can change with prime density and the selected span. A fixed large L can be wasteful at smaller B. Optimize or bound these terms at each row before applying (2).

For example, a model `beta*B/2 + min_L[sigma*L^p+alpha*B/(2L)]` produces a nonlinear binary term proportional to B^(p/(p+1)) in addition to the linear coverage cost. Its marginal saving, rather than a constant c_b, belongs in the derivative test. In a differentiable region the general first-order balance is

    -B'(Q)*C_bin,S'(B(Q))
      = H0*C_pr,S'(H0Q)+F_S'(Q).

Real algorithms have piecewise costs, finite blocks, proof import and memory constraints; exact candidate comparisons are safer than pretending this derivative is a measured law. The source proof must survive reuse and provenance checks, and source/factor caches must not become hidden oracles. Each candidate still needs a complete binary certificate through its allocated B.

The single decision-driving calibration is the ratio of **complete marginal binary cost removed** to **complete marginal principal spectral cost added** between two neighboring candidate rows. A useful bounded future comparison would combine one complete binary block including source/anchor provenance with one complete principal RH certificate block at the intended high-height algorithm. A low-height easy function value, an unverified zero list, or schematic MM0 mask throughput does not supply those coefficients. Actual successful finite RH verification and the fresh analytic frontier remain required before any row becomes a complete proof route.

## Artifacts and status

`efficiency_q_frontier_20261111.py` and its JSON receipt contain the exact B values, gap margins, saturation rational, outward switch intervals and rational logarithm witnesses. Their outputs are scalar research evidence only. The author confirmed the frontier coefficients and real-Q domain in the coordination handoff; this note deliberately remains conditional on the pending analytic proof and its unchanged hypotheses. Earlier frozen reports are unchanged.
