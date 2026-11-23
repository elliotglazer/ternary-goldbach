# Finite zeta mass with exact source multiplicities

Paper/source proof, 2026-11-11, against `work/ternary-goldbach` commit `23b2d68ca344203d4384e0aff7affa4ec034bef9`. No Lean declarations, builds, numerical evaluations or frozen-file changes were made. The digamma and numerical upper bound on the logarithmic derivative belong to the separate prime-estimates task.

The result here is the finite-set inequality

    sum_(rho in S) m(rho) * (sigma-Re(rho))
       / ((sigma-Re(rho))^2 + (t-Im(rho))^2)
      <= Re(logDeriv xiF (sigma+i*t)),                       (1)

for every finite set S of actual nontrivial zeta zeros, their true multiplicities m, and every real sigma>1 and t. A direct corollary uses any selected subset of `zerosRectD zetaF U` with the source's original `multRectD zetaF U` weights. No height bound, RH/QRH statement, zero count, symmetry closure or simplicity hypothesis is required.

The earlier translated-mass note `mellin/RESUME_PRINCIPAL_2026-11-11.md` stated the argument through WeilBridge. This proof fills in the exact exported-API mismatch: `xi_partial_approx` supplies only a positive containing-square parameter T, whereas `WeilBridge.multRectD_eq_mult` asks for T>=1. We do not infer T>=1 from the implementation or strengthen the theorem. We compare the two divisors on their actual containing balls instead.

## 1. The precise approximation theorem

`Explicit/XiPartial.lean:776`, in namespace `TernaryGoldbach.Explicit`, states that for M>=0 and epsilon>0 there exists a real T with T>0 such that:

1. For every s with `norm(s-1/2)<=M` and `xiF s != 0`,

       norm(logDeriv xiF s
         + sum_(u in sqZeros T) (mult T u : Complex)*(u-s)^(-1))
       <= epsilon.

2. Every rho satisfying `xiF rho=0` and `norm(rho-1/2)<=M` belongs to `sqZeros T`, and `1<=mult T rho`.
3. Every element of `sqZeros T` is a zero of xiF.

There is no finite-height or finite-count hypothesis in this theorem. Its conclusion gives no numerical lower bound on T beyond positivity. Its source proof chooses a large good height, but that internal choice is not an extra exported conclusion available to a consumer.

The definitions at lines 470 and 475 are

    sqZeros T = (zerosIn xiF (1/2) (6*T) (3*T)).filter
      (|Re(u)-1/2|<T and |Im(u)|<T),
    mult T u = (divB xiF (1/2) (6*T) u).toNat.

The actual filter is written with the four strict endpoint inequalities. The nearby documentation's phrase `R=4T` is stale; the definition and proof use 6T. This note uses the definition.

## 2. True order and the common containing disk

Let S be a Finset of complex numbers, with for every rho in S

    riemannZeta rho=0,       0<Re(rho)<1.

`Xi.xiF_eq_zero_iff:55` gives `xiF rho=0`. The entire xiF is not identically zero, since `Xi.xiF_one:35` gives xiF(1)=1; alternatively `xiF_ne_zero_of_one_le_re:40` gives xiF(2)!=0. Its analytic order at each rho is consequently a finite natural number, positive at a zero. Define m(rho) to be that number.

This is also the true order of zeta at rho. The source identity `Xi.xiF_eq:28` and `zetaF_of_ne` give locally

    xiF(s) = s * GammaR(s) * (s-1) * riemannZeta(s).

All prefactors are analytic and nonzero near a strict-strip rho. In particular rho is neither 0 nor 1, GammaR is analytic for positive real part and nonzero there, and zeta is analytic off its pole at 1. Analytic-order additivity therefore identifies the two orders. The already proved `WeilBridge.analyticOrderAt_xiF_eq:38` supplies the xiF-to-zetaF part directly. No numerical multiplicity certificate is inserted.

For the fixed evaluation point s=sigma+i*t, choose the explicit finite real bound

    M = norm(s-1/2) + sum_(rho in S) norm(rho-1/2).

All terms are nonnegative, so M>=0, the evaluation point lies in the closed M-disk, and so does every selected zero. The empty-set case is allowed. Apply the approximation theorem separately for each epsilon>0 with this same M. The returned T can depend on epsilon; none of the selected weights or the target left side in (1) depend on it.

For every selected rho, the theorem now gives rho in sqZeros T. Unfolding this membership and applying `Landau.mem_zerosIn:107` gives

    norm(rho-1/2) < 3*T < 6*T,

where the second inequality uses only T>0. Hence rho belongs to the closed ball on which `divB xiF (1/2) (6*T)` is defined. `MeromorphicOn.AnalyticOnNhd.divisor_apply` identifies this divisor with the finite analytic order of the entire xiF, and taking `.toNat` gives

    mult T rho = m(rho).                                    (2)

The approximation theorem's weaker `1<=mult T rho` is not a replacement for (2). It would lose the weight of any multiple zero.

## 3. Direct transport of original explicit-formula weights

Suppose instead that S is any selected Finset with

    S subset zerosRectD zetaF U,

and keep `m_U(rho)=multRectD zetaF U rho` as its weights. `ZetaZeroSums.zerosRectD_zetaF_strip:39` supplies the strict-strip zeta-zero and xi-zero facts needed in Section 2. This theorem has no PlattGRH binder; the earlier `rh_upto_1e8` declaration in the same file does not enter its proof.

Membership in the original carrier gives its inner-ball condition

    norm(rho-2) < RT(U)/2,       RT(U)=2*(U+3).

It also gives |Im(rho)|<U, hence U>0 whenever there is such a rho. Thus rho belongs to `closedBall 2 (RT U)`. The empty S requires no assumption on U. Membership in the returned xi square supplies `closedBall (1/2) (6*T)` exactly as above.

Apply the source theorem `WeilBridge.divB_eq_of_analyticOrderAt_eq:55` with

    f=zetaF,  center=2,    radius=RT U,
    g=xiF,    center'=1/2, radius'=6*T,

the two actual ball memberships, and the symmetric orientation of `analyticOrderAt_xiF_eq` at rho. Its only differentiability requirements are the source `differentiable_zetaF` and `differentiable_xiF`. Taking `.toNat` yields

    multRectD zetaF U rho = mult T rho.                      (3)

This lower-level source theorem needs no T>=1. We do not apply `multRectD_eq_mult:87` with a missing hypothesis, replace T by max(T,1), or pretend the approximation conclusion persists when its square is changed.

For an arbitrary original finite set of true zeros, a common original height is also available without a global height assumption:

    U = 1 + sum_(rho in S) |Im(rho)|.

Then every selected ordinate is strictly inside (-U,U). The bound `norm(rho-2)<2+U<U+3` places every selected zero in the inner ball. Positive finite analytic order gives divisor-support membership, as in `Datum.mem_zerosIn_of_zeroD:169`. This realizes the entire selected set in one source rectangle if a downstream API wants one. It is unnecessary when that rectangle is already given.

## 4. Positivity and the sign of the approximation

Every u in the returned square is a xiF zero. The source `Xi.xiF_ne_zero_of_one_le_re:40` and `xiF_ne_zero_of_re_nonpos:49` imply

    0<Re(u)<1.

Thus for sigma>1, s cannot be one of those zeros, xiF(s)!=0, and

    Re((s-u)^(-1))
      = (sigma-Re(u))/((sigma-Re(u))^2+(t-Im(u))^2) > 0.     (4)

The denominator is strictly positive because sigma-Re(u)>0. Natural multiplicities remain nonnegative after casting to Real. Hence all omitted square terms have nonnegative real part, including any real nontrivial zeros. No reflection pairs are formed or assumed.

Put

    Q_T = sum_(u in sqZeros T) (mult T u : Complex)*(s-u)^(-1),
    L = logDeriv xiF s.

Since `(u-s)^(-1)=-(s-u)^(-1)`, the theorem's error is `norm(L-Q_T)<=epsilon`, not a bound on L+Q_T. Taking real parts yields

    Re(Q_T) <= Re(L) + epsilon.

By S subset sqZeros T, (2) or (3), and positivity (4),

    sum_(rho in S) m(rho)*Re((s-rho)^(-1))
      <= Re(Q_T) <= Re(L)+epsilon.                          (5)

The first comparison is an ordinary finite subset-sum inequality. It does not discard the natural multiplicities, require any upper bound on their size, or count distinct points in place of multiplicity.

## 5. Removing epsilon and applying the result

The left side A of (5) is fixed. For every positive epsilon the preceding argument provides some square establishing `A<=Re(L)+epsilon`. If A>Re(L), choose epsilon=(A-Re(L))/2, which contradicts (5). Therefore A<=Re(L), proving (1). No convergence theorem for an infinite zero series and no chosen sequence of squares is required.

At sigma=2, the exact finite-carrier corollary is

    for every real U,t and S subset zerosRectD zetaF U,
    sum_(rho in S) (multRectD zetaF U rho : Real)
       * (2-Re(rho))/((2-Re(rho))^2+(t-Im(rho))^2)
      <= Re(logDeriv xiF (2+i*t)).                          (6)

This is the interface needed by the new P4 route. The separate analytic task may substitute any independently proved upper bound B(t) for its right side. That substitution must use xiF's actual logarithmic derivative, with the correct completed-zeta normalization; this note does not prove B(t).

For a finite window count, any proved positive pointwise kernel lower bound kappa on the selected zeros gives

    kappa * sum_(rho in S) multRectD zetaF U rho <= B(t).

This deduction requires no prior count. If a consumer needs all zeros of a bounded ordinate window rather than a subset of a source rectangle, choose U strictly beyond both window endpoints as in Section 3. Real-part membership in (0,1) then places them all in that finite carrier. Endpoints of a chosen closed window are retained by its filter. Both signs of the ordinate are treated explicitly, with no implicit factor of two.

The theorem also allows multiplicity-limited subcollections: replace m(rho) by any nonnegative weight no larger than the true order, then use positivity. A list that repeats a point must have total assigned weight at that point bounded by its true multiplicity. Repeating the full multiplicity once for each duplicate would be invalid. In particular, a symmetry expansion must first establish disjointness or coalesce equal roots; (6) itself needs no symmetry closure.

Neither the origin nor the pole at 1 is a nontrivial zero: the source xiF has value 1 at both. A real nontrivial zero between them would still have been counted by (1); no low-height zero-free theorem is used. The strict source outer heights and an inclusive requested height are compatible because the auxiliary U is chosen strictly larger. There is no assumption that a requested height avoids zero ordinates.

## 6. Implementation boundary and source pins

This completes the finite-set/order/positivity/epsilon argument on paper. A future Lean proof can consume the existing approximation theorem directly, unfold the two finite carriers only for ball memberships, use `divB_eq_of_analyticOrderAt_eq` and natural casts for (3), and finish with a finite sum comparison and the real-order epsilon argument. It does not need to strengthen `xi_partial_approx`, import an infinite Hadamard product, or prove a new quantitative good-height estimate. No Lean validation is claimed here.

The relevant paths are relative to `work/ternary-goldbach/TernaryGoldbach/`:

| File | SHA256 |
| --- | --- |
| Explicit/XiPartial.lean | `8F47E96329BF7F1CC69F82C3AB5A422087F692BECB74EF70A7908BC323623770` |
| Explicit/Xi.lean | `988EDFBCA182F1A7618C88A6EA9B253BFEFEBFA3DA86C3CDC74F5DAC19523D1F` |
| Explicit/WeilBridge.lean | `285F825F4916B8D8F40256090F56E773140AB2FC2C48E3F057F68A838E17C73E` |
| Explicit/ZetaZeroSums.lean | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| Explicit/Landau.lean | `6D2A7B97640A49ECBC61F7406006214DB798E9989D8F25740DF3E42600520656` |
| Explicit/Datum.lean | `42F14B373106D5508F73080BEC1E57992FDCBCB7A0460182AD396534463ACDDE` |

Prior argument checked before writing this refinement: `work/qrh-campaign/agents/mellin/RESUME_PRINCIPAL_2026-11-11.md`, SHA256 `950BD0EC1A67A9591626D5FA527867D127929E7A2028CD7B39A4C1438005F22C`. Its first mass inequality is the assertion now given the direct source-order proof above. Its separate digamma and numerical upper-bound assertions are outside this task.
