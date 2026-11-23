# Independent review of the full P2 replacement

Verdict: the preferred compact route passes this bounded mathematical and source-level review. It preserves the full production statement and uses no new analytic hypothesis. It has not been implemented or compiled in Lean, so this is not a kernel or transitive-axiom validation claim.

The reviewed artifact is `agents/prime-estimates/RESUME_PRIME_NEXT_2026-11-11.md`, SHA256

    C6D0D0C844F3A01F3C37B217B9121BACED0210CD75D2CEB250A07DDE2CCD04EB

The preferred section uses C=1.43 and an integer split at 10^6. This supersedes the valid but less economical C=1.4, 10^9 split later in that note. In particular, the preferred proof does not depend on the newly proposed global P6 proof or the extended sieve table through 10^9.

## Exact statement and sources checked

The target is `TernaryGoldbach.Prelim.sum_vonMangoldt_div_le_log`, in `Prelim/LambdaMu.lean:535` at source commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`:

    for every real x>=1,
    sum_(n in Finset.Icc 1 floor_nat(x)) (Lambda(n):Real)/n <= log(x).

The source integer helper at line423 assumes N>=30. Its current proof has a local `Fact PlattGRH` binder, inherited through `psiN_le`. The proposed replacement removes that dependency mathematically while retaining the same public domain, constant, finite-sum carrier and real-floor convention.

I read the entire source proof at LambdaMu:423–544, not just its theorem type. The unconditional ingredients immediately preceding it are `sum_log_le:362`, `abel_Ioc:384` and `sum_inv_le_log:403`. The tiny finite theorem is `mertens_small:46`.

I also checked Mathlib `NumberTheory/Chebyshev.lean:441`, its definition of psi, and `Analysis/SpecialFunctions/Log/Monotone.lean:78`. The inspected Mathlib checkout reports HEAD `56a005855ea17e0b0958f73ec801ae140b0a1679`, matching the pinned source's lake manifest.

## Coarse psi input and its domain

Mathlib's unconditional theorem is exactly

    Chebyshev.psi(t) <= log(4)*t + 2*sqrt(t)*log(t), t>=1.

It does not require t>=10^27. That latter restriction belongs to a different Helfgott theorem and is not imported here. Mathlib defines psi using `Ioc 0 floor_nat(t)`; at natural t=N this is the same finite sum as `LambdaMu.psiN N`, using `Nat.floor_natCast` and `Ioc 0 N = Icc 1 N`.

The antitone theorem for log(t)/sqrt(t) holds on `[exp(2),infinity)`. The lower endpoint500000 is safely inside that domain. The exact comparisons 2.72^2<500000, 2.7^14>500000 and700^2<500000 justify

    log(t)/sqrt(t) <= log(500000)/sqrt(500000) <14/700=.02.

Together with log(4)=2log(2)<1.387, this gives psi(t)<=1.427t<1.43t for every real t>=500000. Division by t and the identity sqrt(t)^2=t are legitimate because this domain is positive. No estimate at smaller t is implicitly used.

## All positive-use psi calls in the factorial proof

For N>=10^6 set M=N/2 by natural division. The source inequalities are

    2M<=N<=2M+1, M>=500000, M<N.

The existing convolution identity gives

    N*A(N)=sum_(m=1..N)log(m)+R,
    R=sum_(n=1..N)Lambda(n)*(N/n-floor(N/n)).

On n<=M, use only the fractional-part bound and Lambda(n)>=0, obtaining a total at most psi(M). On M<n<=N, natural division gives N/n=1 exactly. The source Abel identity on **Ioc M N**, with w(n)=N/n-1, is

    sum_(M<n<=N)Lambda(n)*w(n)
      =psi(N)*w(N)-psi(M)*w(M+1)
       +sum_(M<n<N)psi(n)*(w(n)-w(n+1)).

The boundary is w(M+1), not w(M). Also w(N)=0 exactly. This removes psi(N) before any numerical upper bound is applied. The only positive-use coarse psi calls are consequently:

1. psi(n), for n in Ioo M N, corresponding to the original source call at line475;
2. psi(M), corresponding to line495.

Both lie inside the established domain t>=500000. In particular, the proof does not apply the coarse bound termwise in the original lower interval1<=n<=M.

The positive difference w(n)-w(n+1)=N/[n(n+1)] gives

    sum_(M<n<N)psi(n)*(w(n)-w(n+1))
       <=C*N*sum_(M<n<N)1/(n+1)
       <=C*N*(log N-log(M+1))<=C*N*log2.

The harmonic reindexing is exactly to Ioc(M+1,N), as in the source. The final logarithmic comparison uses N<=2M+1<2(M+1), valid for both parities. The lower boundary cancels most of the retained psi(M):

    w(M+1)>=1-2/(M+1),
    psi(M)*(1-w(M+1))<=2psi(M)/(M+1)<=2C.

Thus R<=C*N*log2+2C. All multiplications that use a psi upper bound have nonnegative coefficients.

## Final large-branch inequalities

For C=1.43, log2<.694 and C*.694=.99242. Combining R<=.99242N+2.86 with the unconditional factorial bound gives

    N*A(N)<=NlogN-.00758N+logN+3.86.

Apply `Real.log_le_sub_one_of_pos` to N/1000. Since 2.7^7>1000, log1000<7, and hence logN<=N/1000+6. The remaining excess is at most

    -.00658N+9.86<0 for N>=10^6.

The strict negative margin is large; at the lower endpoint it is -6570.14. Dividing by positive N proves the required weak inequality. No analytic estimate or finite check at N=10^6 is omitted.

## Finite branch and real endpoints

For1<=n<=700, `Small.psi_lt_small_700` has exactly the required finite sum and coefficient1.03883. It is backed by the existing kernel computation and does not have a Platt binder.

For701<=n<10^6, the unconditional `SmallTab.small_table:1082` applies directly, without calling the conditional `psi_two_sided` wrapper. Its theta-plus-nonprime definition is converted to the desired psi sum by the unconditional `PsiTwoSided.thS_add_ppS:65`. It gives psi(n)<=n+sqrt(n). Since26.47^2<701 and .03883*26.47>1, sqrt(n)<=.03883n. Thus psi(n)<=1.03883n on the whole remaining finite range.

For30<=N<10^6, retain the existing source factorial proof and replace its two global psi calls by that finite helper. Their arguments are M and M<n<N, all strictly below10^6. No finite-table endpoint equality is needed. For1<=N<30, `mertens_small` covers the range because its actual upper endpoint is100.

For real x>=1, N=floor_nat(x)>=1 and N<=x. The finite sum is exactly A(N), and logN<=logx. At x=1 the sum and logarithm are both zero. At every other integer or noninteger boundary, this is the original source wrapper. The 10^6 integer endpoint belongs to the coarse branch; a real x whose floor is below10^6 belongs to the finite branch. There is no uncovered interval.

## Independent arithmetic and acceptance boundary

I independently replayed eleven rational comparisons, rather than merely accepting the author's successful script: the exponential-power lower comparisons at7 and14, the antitone-domain comparison, the square-root cutoff, the1.427<1.43 bound, the log4 bound, C*.694=.99242, the residual at10^6, the two finite701 conversion comparisons, and M=500000 atN=10^6. All passed with exact Fraction arithmetic.

No defect was found in the preferred argument. Its remaining work is formalization of the definition bridges, the unconditional finite psi helper, and the revised integer proof, followed by exact theorem-type and transitive-axiom checks. Removing a Fact binder in source without completing those steps would not count as a proved replacement.

Section5 of the author's note, concerning a possible Rosser–Schoenfeld finite-zero certificate, is explicitly outside this P2 proof and outside this bounded review. It supplies no premise here. This review does not claim closure of P1, P3, P4, P5, P6, P7, the QRH campaign or the original Goldbach theorem.
