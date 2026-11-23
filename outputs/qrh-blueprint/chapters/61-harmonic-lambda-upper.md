# Next prime route: full P2 from coarse Chebyshev bounds

Date2026-11-11. Source23b2d68ca344203d4384e0aff7affa4ec034bef9;
matching Mathlib56a005855ea17e0b0958f73ec801ae140b0a1679.
Research only. No Lean build, implementation, canonical edit, axiom, or new
hypothesis was introduced. The original10^27 endpoint and binary input remain.

## Result selected

A complete unconditional paper route now supplies the original P2 contract:
for every real x>=1,

    sum_{1<=n<=floor x} Lambda(n)/n <=log x.

This is `Prelim/LambdaMu.lean:535 sum_vonMangoldt_div_le_log`, used in
GcdSums and TypeI2Proof/TypeI2Large. Its original constant and entire domain
are preserved. The route uses only existing unconditional elementary source
and finite prime certificates. It does not require the full sharp global P1
coefficient1.03883, QRH, the local fixed-gap tail, XiMass, or a zero computation.

The key point is quantitative: the factorial remainder argument requires
C*log2<1, not C close to1. Thus C=1.4 is sufficient in the large branch.

## Preferred compact variant: no extended sieve and no P6 dependency

This refinement supersedes the1e9 split in sections1–4 below; those sections
remain a valid fallback. It preserves the identical P2 conclusion.

Use C=1.43 and split at integer N=10^6. For t>=500000,
`Real.log_div_sqrt_antitoneOn` gives log(t)/sqrt(t)<=14/700=.02 because
log(500000)<14 and sqrt(500000)>700. The logarithmic bound follows from
exp14>2.7^14>500000. Mathlib's elementary psi theorem therefore gives

    psi(t)<=(1.387+.04)t=1.427t<1.43t.

For N>=10^6, M=floor(N/2)>=500000, so the exact same factorial/Abel
argument in section2 yields

    R<=C*N*log2+2C<=.99242N+2.86,

using log2<.694 and1.43*.694=.99242. Combining with sum_log_le gives

    N*A(N)<=NlogN-.00758N+logN+3.86.

The tangent inequality at1000 gives logN<=N/1000+6, since log1000<7
(exp7>2.7^7>1000). The residual is therefore at most

    -.00658N+9.86<0  (N>=10^6).

For30<=N<10^6 all original P2 psi calls lie below10^6 and can be bounded
using only SmallPsi700 and SmallTab as detailed in the finite proof of the
preceding research note. Below30 use mertens_small. AtN=10^6 the coarse
branch applies; all real x>=1 then follow by the original floor wrapper.

Thus the preferred full P2 argument needs neither the new global P6 paper
replacement nor PsiSieveMain.sieve_table3. Its only prime finite inputs stop
strictly below10^6 (plus the existing tiny Mertens certificate). All six new
rational checks for this variant pass in the companion script. No new prime
or zeta computation is required. Its coarse numerical comparisons have large
margin, despite C being close to the limiting1/log2 for the fractional-part
method. Independent review is requested for this refinement.

## 1. Unconditional coarse psi on its actual needed range

Mathlib `Mathlib/NumberTheory/Chebyshev.lean:441`, `Chebyshev.psi_le`, gives
psi(t)<=log4*t+2sqrt(t)log(t) for every t>=1. Definitions use the same finite
von Mangoldt sum as the source psiN, after Ioc0N=Icc1N and floor casts.
For t>=1e8, use `Real.log_div_sqrt_antitoneOn` and log(1e8)<=19 to obtain
log(t)/sqrt(t)<=19/10000. Also log4<1.387 by twice `Real.log_two_lt_d9`.
Consequently

    psi(t)<=1.3908t<1.4t  (t>=1e8).

This exact source argument was also checked in the earlier EBound research
(`outputs/qrh-blueprint/chapters/13-prime-power-error.md`, section2). It is
independent of the newly established P6 paper route. That route would give
an alternative1.4 bound already from12100, but this strengthening is not
needed here and adds an unnecessary dependency.

## 2. Exact factorial-remainder argument for integer N>=1e9

Write psi(k)=sum_{n<=k}Lambda(n), A(N)=sum_{n<=N}Lambda(n)/n, M=floor(N/2),
and

    R=sum_{n<=N} Lambda(n)*(N/n-floor(N/n)).

The divisor identity already used at `LambdaMu:425` gives

    N*A(N)=sum_{m=1}^N log(m)+R.

Split at M. On n<=M the fractional part is at most1, so the lower piece of R
is at most psi(M). On M<n<=N, floor(N/n)=1 exactly. Set w(n)=N/n-1.
The unconditional `LambdaMu.abel_Ioc:384` gives

    R<=psi(M)-psi(M)*w(M+1)
       +sum_{M<n<N}psi(n)*N/[n(n+1)].

The Abel endpoint atN is zero because w(N)=0. In this expression the only
psi upper-bound arguments are M and the integers M<n<N. Since N>=1e9,
all are at least5e8, comfortably inside the1e8 domain of section1. No bound
is applied to psi(k) for small k here; the entire lower block was retained
as psi(M) before cancellation.

Let C=1.4. Positivity and psi(n)<=Cn give

    sum_{M<n<N}psi(n)*N/[n(n+1)]
      <=C*N*sum_{M<n<N}1/(n+1)
      <=C*N*(log N-log(M+1))<=C*N*log2.

The middle inequality is the existing `sum_inv_le_log:403`; the last uses
N<=2M+1<2(M+1). Also N>=2M gives

    w(M+1)>=1-2/(M+1),
    psi(M)*(1-w(M+1))<=2psi(M)/(M+1)<=2C.

Thus **R<=1.4Nlog2+2.8**. This is the same exact discrete argument as the
current `sum_vonMangoldt_div_le_log_large:423`, with its coefficient changed
only in this large branch. Floors and the odd/even N distinction are fully
accounted for by the inequalities2M<=N<=2M+1.

The unconditional `sum_log_le:362` supplies

    sum_{m=1}^N log m<=NlogN-N+1+logN.

As log2<.7, it follows that

    N*A(N)<=NlogN-.02N+logN+3.8.

Use `Real.log_le_sub_one_of_pos` on N/100. Since log100<5 (exp5>2.7^5>100),

    logN<=N/100+4.

Therefore

    N*A(N)<=NlogN-.01N+7.8<=NlogN

for N>=1e9. In fact the final rational comparison needs only N>=780;
the larger split exists solely to keep every psi argument in its established
coarse range. Division by positiveN proves A(N)<=logN.

## 3. Finite and real ranges, with no new certificate request

For1<=N<30 use the existing unconditional `LambdaMu.mertens_small:46`,
which wraps `Small.mertens_small'` and covers all N<=100.
For30<=N<1e9, use the **original** factorial proof with its1.03883 coefficient,
but replace its psi calls by the finite upper bound established in
`RESUME_PRIMES_2026-11-11.md`:

* Below1e6 the source SmallPsi700 and SmallTab bounds give psi(n)<=1.03883n.
* On1e6<=n<1e9, `SieveTab.sieve_table3` gives theta(n)<=n+.1sqrt(n).
  The finite nonprime argument gives NP(n)<1.4262sqrt(n). Hence
  psi(n)<n+1.5262sqrt(n)<=1.0015262n<1.03883n.

This finite nonprime argument was independently audited in the earlier P6
note: its cubic/fourth-root psi arguments are below1e6, and it uses no global
conditional psi theorem. The old P2 proof's psi calls are M and M<n<N, so
all are strictly below1e9 in the finite branch. No unchecked endpoint1e9
is used. At N=1e9 section2 applies.

For real x>=1 set N=floor x>=1. The finite sum is exactly A(N), and
logN<=logx by monotonicity. This is the original wrapper atLambdaMu:535;
there are no fractional-endpoint corrections and no change to its type.

## 4. Future integration and exact acceptance boundary

When implementation resumes, extract the finite psi upper bound into an
unconditional helper, retain the current small-N factorial proof, and add the
large-N proof of section2. Remove the local Fact binder from both
`sum_vonMangoldt_div_le_log_large` and its real wrapper only after their
exact types and transitive axioms are checked. Preserve the public names and
all GcdSums/TypeI2 applications.

The paper route does not use the theorem being proved as a hypothesis. It
also does not claim P1 is globally solved: only finite P1 and coarse large
psi enter. P3, P4, P5 and P7 on their full unbounded ranges remain separate.

`resume_prime_next_20261111_cert.py` checks the exact rational constants,
the large-branch argument domain, and the finite/large margins. It exits0.
Independent review has been requested. No Lean validation is claimed.

## 5. Primary-source check of the tempting sharp-P1 alternative

The following source summary is deliberately separate from the unconditional
P2 proof above.

Rosser–Schoenfeld(1962), Theorem12, states the sharp1.03883 global psi bound.
Its proof on printed pp.77–80 uses TableI for the unbounded range. TableI's
b=20 row has epsilon=.0047629, valid for every x>=exp20. Section6 explicitly
uses the first25000 zeta zeros on the critical line, taking A=exp9.99. Thus
this is not a computation-free replacement. The relevant primary pages are
73(TableI convention),74(row),78(finite-zero input),79(Theorem28), and80(table
justification). [Primary paper](https://denisevellachemla.eu/Rosser-Schoenfeld-1962.pdf).

A future **proved** version of just that one row would join the existing
finite sieve before1e9: exp20<1e9. It would yield uniform
abs(psi(t)-t)<epsilon*t for all t>=1e6, since the finite error is at most
.002t there. P4 follows from epsilon<.0064. The Abel calculation with
A=1e6 then gives, for y>=2.5e7,

 sum nLambda(n) <=(1+3epsilon)y^2/2+(1-epsilon)A^2/2,

so a safe normalized coefficient is
1+3epsilon+A^2/(2.5e7)^2=1.0158887<1.022, preserving P5. P1 also follows
from the small finite branch and1+epsilon<1.03883. These are our deductions,
not additional claims quoted from the paper.

The concrete certificate option is to prove zeta RH through a rational height
slightly exceeding exp9.99 (for example21808, after certifying that comparison),
with zero completeness and multiplicities, and then formally reconstruct the
single TableI row using the explicit formula/zero-free estimates behind
Theorem28. The original paper's first25000 zeros are evidence for the scale,
not a certificate imported here. One must determine the actual required zero
count and verify all enclosures; assuming RHBelow21808 would merely introduce
a new missing hypothesis. The analytic reconstruction and its rational error
certificate are also unfinished. This is a quantitatively bounded alternative
project, not a discharge of P1/P4/P5 and not needed for our P2 result.