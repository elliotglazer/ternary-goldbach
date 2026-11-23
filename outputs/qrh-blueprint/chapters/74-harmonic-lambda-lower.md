# P3: an elementary factorial-kernel replacement

Date: 2026-11-11. Research status: complete paper argument with exact rational certificate replay and independent mathematical review; not implemented or compiled in Lean. Canonical source remains unchanged. This removes the need for either PlattGRH or QRH from P3 itself. It does not settle the remaining P1/P4/P5/P7 prime estimates or the full Goldbach theorem.

## Exact contract and consumer

At source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`, `TernaryGoldbach/Prelim/LambdaMu.lean:1086`, `mertens_lower_nat`, says for every natural N >= 1:

    log(N+1) - log(3/sqrt(2)) <= sum_{1<=n<=N} Lambda(n)/n.

The real wrapper `log_sub_le_sum_vonMangoldt_div` at line 1170 says, for x >= 1:

    log x - log(3/sqrt(2)) <= sum_{1<=n<=floor x} Lambda(n)/n.

Both currently have `[Fact TernaryGoldbach.PlattGRH]`. The replacement below preserves both conclusions, all endpoints, and their constants, while deleting this premise. The finite branches of the existing proof can be retained.

The direct Type I consumer is `MinorArcs/TypeI2Large.lean:17`, `sum_min_floor_le`; its calls to the upper harmonic bound P2 and this lower bound occur at lines 82 and 87. Subtracting the bounds gives exactly the existing `logPlus (6*U*V*abs(delta)*q/(sqrt(2)*x))`. No budget relaxation, replacement constant, or new assumption is needed for this P3 edge. That consumer still uses other prime bounds, so its whole Platt premise cannot yet be deleted merely from this result.

## Certificate and accepted checks

Define A(x) = sum_{1<=n<=floor x} Lambda(n)/n and T(y) = log(floor(y)!). Put d=24 and a_j=j/24. The 45 nonzero rational coefficients c_j, with 1<=j<=72, are recorded exactly in `resume_p3_exact_kernel_20261111.json`. Define

    K(u) = sum_j c_j floor(a_j*u).

The accepted certificate consists of:

1. sum_j c_j*a_j = 1 exactly;
2. K(u)<=0 on 0<=u<1;
3. K(u)<=u on 1<=u<=24;
4. S := sum_j c_j*a_j*log(a_j) >= .2665;
5. B := sum_j abs(c_j) <= 5.51.

Items 2 and 3 reduce to finitely many rational inequalities. The complete breakpoint set is {0} union {24*i/j : 1<=j<=72, 1<=i<=j}, which contains 1589 points. At every breakpoint b check K(b)<=0 if b<1, and K(b)<=b otherwise. Every floor in K is constant on each half-open interval between consecutive breakpoints. The threshold 1 is itself a breakpoint. Thus the endpoint checks imply the whole inequalities, even though some c_j are negative. At the right endpoint 24 check directly. Moreover, exact slope normalization gives

    K(u+24) = K(u)+24.

Reducing any u>=0 modulo 24 proves K(u)<=u for all u>=1. On a residue v<1 the stronger K(v)<=0 suffices for K(v)<=v.

`resume_p3_verify_20261111.py` reads only the exact coefficient JSON, uses Python Fraction throughout its acceptance checks, and verifies the slope, every breakpoint, interval constancy at each midpoint, the periodic increment, logarithm boxes, and final constants. It does not accept any floating LP output. The earlier floating search and exact-recovery script were discovery aids; they are not proof inputs.

For the log bounds, the verifier chooses rational boxes and then checks the exact rational definitions already present in the source: `Small.chkLow` in `Prelim/SmallMertens.lean:23`, with soundness `Small.le_log_of_chk` at line 45; and `Small.chkStep` in `Prelim/SmallPsi.lean:28`, with soundness `Small.log_lt_of_chk` at line 69. Each uses denominator 10^6. The 45 integer logarithm boxes, along with the resulting rational S bound, are saved in `resume_p3_log_certificate_20261111.json`. No new analytic logarithm algorithm is needed for the eventual Lean proof.

The signed-log evaluation uses

    S = sum_j (c_j*j/24)*log j - log 24,

because the normalized slope is 1. Use each lower log endpoint for nonnegative coefficients and each upper endpoint for negative coefficients, then subtract the upper endpoint for log 24. This gives the exact certified lower bound

    S >= 4408399385263794221 / 16536005552338593750 > .2665.

Also,

    B = 6796561283852302 / 1234688414574615 < 5.51.

The coefficient JSON retains older coarse metadata `B_upper=7`; the accepted sharper inequality is recomputed from the exact coefficients by the verifier and recorded in the log certificate. No conclusion relies on that old metadata. The checker also verifies log 3 < 1.1 and log 10000 < 9.211 using the same existing `chkStep` formula.

## The factorial minorant

For every x>0, the kernel inequalities and Lambda(n)>=0 imply

    x*A(x) >= sum_{1<=n<=floor(3x)} Lambda(n)*K(x/n).

Indeed, for n<=x use K(x/n)<=x/n. For x<n<=3x use K(x/n)<=0. Terms with n>3x would vanish because every a_j<=3. No positivity of c_j is assumed or used here.

Expand K and interchange finite sums. The elementary divisor identity gives

    sum_{n<=floor y} Lambda(n)*floor(y/n) = T(y).

Thus the preceding inequality becomes

    x*A(x) >= sum_j c_j*T(a_j*x).                       (1)

The exact existing integer identity is already used in `LambdaMu.lean:426`: `ArithmeticFunction.sum_Ioc_mul_zeta_eq_sum` together with `ArithmeticFunction.vonMangoldt_mul_zeta`. The real argument version follows by taking M=floor y, using floor(y/n)=M/n for positive integer n, and adding zero terms above M. This needs a short floor/division lemma and finite support extension; it is not a prime number estimate.

## Elementary factorial residual

For every y>=1, write f(y)=y*log y-y. Then

    abs(T(y)-f(y)) <= 1+log y.                         (2)

Here is an explicit proof, so (2) is not an assumed Stirling estimate. For integers M>=1, the source `LambdaMu.sum_log_le` at line 362 proves

    log(M!) <= f(M)+1+log M.

The complementary bound log(M!)>=f(M)+1 follows by induction: the induction increment is precisely M*log(1+1/M)<=1, obtained from log t<=t-1. Now set M=floor y>=1. Since f'(t)=log t>=0 on [1,infinity), f(M)<=f(y), giving the upper half of (2). Since 0<=y-M<1 and log t<=log y for M<=t<=y,

    f(y)-f(M) <= (y-M)*log y <= log y.

This gives T(y)>=f(y)+1-log y, which implies the required lower half. One can prove the displayed comparison either by integrating log or by the elementary log inequality and algebra; it requires no asymptotic factorial theorem.

## Uniform large-integer bound

Let N>=10000. All a_j*N>=N/24>=1 and a_j<=3. From (1), (2), and the triangle inequality for the signed c_j,

    A(N) >= log N - 1 + S - B*(1+log(3N))/N.

The normalization sum c_j*a_j=1 is essential: it gives coefficient exactly 1 on log N, not a weaker c*log N. Also, negative c_j cause no problem because both sides of (2) are available.

Use S>=.2665, B<=5.51, and log 3<=1.1. The function (log t+2.1)/t is decreasing for t>=10000. For example its derivative is -(log t+1.1)/t^2<0; this can alternatively be proved from log(t/10000)<=t/10000-1. Therefore

    B*(1+log(3N))/N <= 5.51*11.311/10000 = .006232361,
    A(N) >= log N - .739732361.

Since log(N+1)<=log N+1/N<=log N+.0001,

    A(N) >= log(N+1) - .739832361.                     (3)

The exact rational margin between .74 and .739832361 is 167639/10^9>0. The original proof already contains a completely elementary proof of `.74 <= log(3/sqrt(2))` at `LambdaMu.lean:1152`: sqrt(2) gives 2.12<=3/sqrt(2), then log(2.12)=log 2+log 1.06, `Real.log_two_gt_d9`, and `Real.one_sub_inv_le_log_of_pos` suffice. Combining that unchanged calculation with (3) gives the exact P3 integer target for every N>=10000.

## Finite coverage and real endpoint

The intervals cover all cases with overlap at 10000:

| N | Input |
|---|---|
| 1 | Existing elementary log/sqrt argument in `mertens_lower_nat` |
| 2 | Existing exact equality A(2)=log(2)/2 |
| 3<=N<=10000 | `MertWalk.mertens_lower_le` |
| N>=10000 | The factorial-kernel argument above |

`MertWalk.mertens_lower_le` is at `Prelim/SmallMertensLower.lean:284`, has only the two range hypotheses, and imports `LogWalk`. Its finite proof checks prime-power completeness by trial division and walks rational log/harmonic-sum bounds through 10002. It does not consume a bounded-RH or Platt result. No extension of this finite table is needed.

For any real x>=1, N=floor x>=1 and log x<=log(N+1). The existing real wrapper is therefore unchanged. This explicitly handles noninteger x immediately below an integer, where a bound with log N alone would not have been sufficient.

## Future implementation order, not frozen declarations

1. A small certificate module defines the coefficient list and log endpoints. Prove the rational slope, B bound, breakpoint inequalities, and log checker successes in bounded chunks, using kernel computation. No native evaluation trust or heartbeat override is needed as a proof principle; runtime remains to be measured.
2. A generic floor-step lemma lifts the breakpoint checks to K(u)<=0 for u<1 and K(u)<=u globally, including the period-24 argument.
3. A generic finite divisor-sum lemma proves (1) for this kernel; reuse the actual arithmetic-function convolution APIs cited above.
4. Prove the integer lower factorial bound and its real floor residual (2). Reuse the existing unconditional upper bound `sum_log_le`, or move that small helper to the new module if needed to avoid imports back into LambdaMu.
5. Combine the signed residual estimate with the coefficient/log certificate to prove (3) for N>=10000.
6. Keep the existing N=1, N=2 and MertWalk branches and the real wrapper, deleting only the P3 Platt binders once the replacement is compiled and audited.

To avoid an import cycle, the new kernel module must not import LambdaMu if LambdaMu will import it. The two elementary factorial helpers can live together below LambdaMu, with `sum_log_le` retained as an alias if preserving its public name is useful. The new result has no dependency on P1, P2, P6, psi/theta bounds, zeta zeros, QRH, or an unproved analytic input.

This is a substantive complete paper route, not a claim of kernel-checked completion. Outstanding work is the Lean implementation, compilation, and exact type/axiom audit. The coefficient and finite arithmetic checks have been replayed independently by the mellin worker; the review artifact is maintained in that worker's directory.
