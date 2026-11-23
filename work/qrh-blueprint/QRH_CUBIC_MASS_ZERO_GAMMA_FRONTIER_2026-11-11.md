# QRH cubic, mass, zero-mode and Gamma audit frontier

2026-11-11. This advances the [energy, tail and logarithm frontier](QRH_ENERGY_TAIL_LOG_FRONTIER_2026-11-11.md) through four further bounded source/mathematical reviews. These findings do not validate the complete QRH provider, compile its exports, certify the finite spectrum or remove PlattGRH from the target source.

## Cubic exponent improvement

The [author audit](../qrh-campaign/agents/major-constants/QRH_CUBIC_IMPROVEMENT_ANALYTIC_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/independent-feasibility/REVIEW_QRH_CUBIC_IMPROVEMENT_ANALYTIC_AUDIT_2026-11-11.md) reconstruct the argument below `CubicSieve/FullImprovement.full_improved`. The old exponent assumption concerns the squarefree-ideal sieve norm. The intermediate improved estimate concerns the full element-row norm; those are different objects and require the actual extraction and comparison theorems.

For 4/3<=xi<=2 and 0<theta<1/2, the inspected improvement holds for all M,N>=1, with C chosen before M,N, and has the shape

    elementSieveNorm(M,N) <= C*N^(7*theta)
      * (M + (M*N)^(2/3) + M^(1-xi)*N^(2*xi-1)).

The audit follows the noninjective cube-extraction cover, its nonnegative energy bound and finite unit/bad-prime multiplicities. The old exponent is applied with smaller epsilon allocations to pay the dyadic losses. Actual Poisson dual coefficients retain the conjugation and Gauss factors; their squared norm costs at most 2/N times the original coefficient energy. The radial kernel transfer uses the actual common Fourier density and twists, not an arbitrary kernel with asserted decay. Zero frequency is retained separately.

Convergence of the dyadic majorant is obtained from the initial sieve bound, before using the new estimate. The relevant decay exponents lie strictly between zero and three. In the descendant comparison, the row scale M/e may fall below one, so the proof compares complete monomials; it does not discard a negative power as though M/e>=1. The three loss allocations total 7*theta. Column-shell comparison pays its separate constant.

The subsequent exponent map is (6*xi-4)/(3*xi-1). Above 4/3 its distance from 4/3 contracts by at most 2/3. A finite number of iterations suffices for each requested positive epsilon. No constant uniform in an infinite iteration limit is asserted.

Unresolved lower inputs include the actual trace-normalized Poisson identity, local Gauss/CRT conversion, the uniform radial Fourier separation envelope, the initial sieve and the underlying arithmetic/operator identities. This review establishes the inspected implication conditional on those genuine internal dependencies; it does not turn them into final theorem premises.

## Deleted modes and normalized divisor mass

The [author audit](../qrh-campaign/agents/zero-sum/QRH_DELETED_MODE_MASS_ANALYTIC_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/audit/REVIEW_QRH_DELETED_MODE_MASS_ANALYTIC_AUDIT_2026-11-11.md) reconstruct the finite source-fiber estimate and normalized mass bound used by the two-pass argument. The source-to-child projection is not injective. The proof counts its fibers through actual tuples, nonzero cancellation and ideal-divisor bounds.

The resulting weight is

    d(f)^(9+4*K) * D_K(q,t,r),
    D_K(q,t,r) = d(q)^(5+2*K)*d(t)^(2*K)*d(r)^(2*K).

Weighted Cauchy gives the geometric mean of the two weighted child energies. When both energies are later bounded with a factor A, the resulting factor is A, not A^2. Deleted-prime restoration takes place inside the child lists: the exact masks either preserve the term or kill it on both sides. Outer deleted-mark assignments remain charged in the fiber count.

The divisor small-power estimate and the actual ideal count give a triple sum bounded by C*(B*T*R)^(1+epsilon). No coprimality is inserted into the divisor-product inequality. If a positive scale is below one, the corresponding nonzero-ideal set is empty; nonempty triples imply all three scales are at least one.

With

    kappa = ell + R/2 - j + t + g - theta + 11*eta/2,

the normalized bound has shape

    Z^(-kappa) * sum D_K <= C*Z^(kappa*epsilon).

It holds for Z>0 without adding Z>=1 or kappa>=0. The two finite estimates themselves neither assume nor prove the four child moment bounds. Those are separate obligations in the later two-pass consumer. This is the scope clarification in the independent review of the author's opening description.

The lower boundaries include local Gauss/CRT identities and ideal/cube arithmetic. The later child moments and analytic passage remain separate; their absence from these finite estimates is not a proof of them.

## Marked zero frequency

The [author audit](../qrh-campaign/agents/integration/QRH_MARKED_ZERO_MODE_ANALYTIC_AUDIT_2026-11-11.md) and [independent review](../qrh-campaign/agents/moebius/REVIEW_QRH_MARKED_ZERO_MODE_ANALYTIC_AUDIT_2026-11-11.md) reconstruct `physical_marked_zero_bound`. Its constant is chosen after positive loss and b, nonnegative L and B, and Phi, but before the variable finite pools, slots, character, bounded W and scale parameters. The actual arithmetic and disjoint-slot hypotheses remain in force.

At frequency zero, unequal residual supports vanish by the actual character row. Since the original residual supports are disjoint, the only equal-support case is the pair of empty supports. The remaining expression is exactly Z^(-D) times the truncated second zero mode. The signed Mobius divisor sum is evaluated first as the product of 1-1/Norm(P), which lies in [0,1]. Taking absolute values term by term before this evaluation would lose that cancellation.

Pairwise-disjoint slot lists give a mark bound 2^(number of selected primes), followed by a uniform ideal-norm small-power bound. The support condition W(x)!=0 implies x<=b. Together with the actual ideal count this bounds the squared coefficient mass by C*X^(1+epsilon), for every X>0. When bX<1 the support is empty. No lower support cutoff, smoothness of W or upper bound on the number of slots is added.

Normalization by X^(-1) leaves C*Y*X^epsilon. Taking X=Z^D, Y=Z^m and epsilon=loss/(L+1), with Z>=1 and D<=L, gives C*Z^(m+loss). Negative D and m are included. The radial Fourier value at zero is absorbed into an existential constant depending on Phi; it is not numerically evaluated.

The remaining lower foundations are the exact normalized overlap/ray identity and its Gauss conversions, fixed quotient-character identities, and ideal-factorization/norm facts. The marked zero-frequency argument is finite. It does not supply the separate nonzero-frequency Poisson or retained-window estimates.

## Gamma growth

The [author audit](../qrh-campaign/agents/prime-estimates/QRH_GAMMA_GROWTH_ANALYTIC_AUDIT_2026-11-11.md) and [coordinator's independent review](REVIEW_QRH_GAMMA_GROWTH_2026-11-11.md) reconstruct the two Gamma estimates used by the primitive-logarithm proof.

For p,d>0, the convergent beta integral bounds the modulus of Gamma(p+it)/Gamma(p+d+it) by Gamma(p)/Gamma(p+d). Conjugation supplies the denominator with opposite imaginary part where required. In the actual Hecke application p=1.1 and d=.8. These positivity conditions are proved before invoking the integral.

The reciprocal Gamma function is entire. Reflection on the nonreal region, followed by a natural-number shift to the left, gives a fixed-strip bound C*exp(pi*abs(Im(z))). For abs(Im(z))>=1 every recurrence factor has norm at least one; this is the lower bound needed to compare the reciprocal at z with the reciprocal at the shifted point. Entire continuity on the remaining compact rectangle covers real poles of Gamma as zeros of its reciprocal. No division at a Gamma pole is used.

The constants may depend on the fixed strip. The temporary uncompleted-L exponential-growth witness may also depend on the conductor. That does not assert a conductor-uniform growth constant; the later Phragmen-Lindelof boundary argument controls its final uniform constant separately. The Gamma constants here are existential, with no numerical Gamma evaluation or sharp exponential rate claimed.

The independent library inspection used the target Mathlib cache, not a compiled copy of the QRH-pinned Mathlib revision. It therefore does not establish version compatibility. General Gamma/integration library foundations, the actual theta functional equation, principal residue, final continuation and family bridge remain outside this bounded verdict.

## Verification and next work

The coordinator read the eight reports and inspected the recorded cubic wrapper/dyadic arguments, deleted-mode/mass bodies, marked zero-mode bodies and Gamma source ranges. All eight report hashes below match. All 141 source-table entries in these reports were checked against current file bytes, including repeated entries. The deleted-mode receipt adds checks of its 28 author pins and five further review pins; the zero-mode receipt adds 25 pins. These counts are byte checks, not a percentage of the QRH proof validated.

QRH source remains at 4eaee87548250b2682affda7d05d947c05554bae and clean. The target remains at 23b2d68ca344203d4384e0aff7affa4ec034bef9, with only the two preexisting untracked QrhMellin/QrhNumeric files observed in its status. No Lean declarations, source edits, builds, toolchain changes or analytic evaluations were made for this consolidation.

The next source work addresses quadratic product columns, retained-source pushes/live-key counts, original trace-normalized Poisson and the principal residue. Reports arriving on those topics are not accepted by this entry. The global provider still needs complete mathematical and compatible kernel validation. The selected finite spectral family, low principal-zero data, finite-prime replay, revised Goldbach proofs and final assembly remain unfinished. No selected final premise, spectral requirement or numerical reserve changes here.

## Evidence pins

| Artifact | SHA256 |
|---|---|
| Cubic author | 1727E899339761F828A0D5B56F776884C63E9BB810EF5E0606C9E88E85AC10BD |
| Cubic review | 0FB95170974269A2967C811BEE01C3AB919CCE5871E8320E742205C5E76EC1F8 |
| Deleted-mode author | B7575C743474BBF80AA421937AFDAD10590EA76BE21FB421B6225DDEC8CAA859 |
| Deleted-mode review | 943B4229968A6901E909A9AE51159B52ADBE5DAE331B0F28E2B78A4DBA03B8CB |
| Zero-mode author | AC63CCA803785C2E4ECBE0AB8C9373206CA19ADE741BBD8A26B5AB5D168BF8DB |
| Zero-mode review | E0E5A316FE5B64E0AF3E33F95CED30F2BABD5220559BE76DD66BBA13D17ED741 |
| Gamma author | A7D461828B1832622C66F5E450BB25EAF3C98EE4B75BD3BD240DE00B5861A7FF |
| Gamma review | 20E4EC7C79A2FD89142FD9A01CF441E07811648AF59F30434E601DF3322D0291 |

DRAFT_ANCHORS: 0 created
UNREGISTERED_SORRIES: 0 introduced
DRAFT_IMPORT_VIOLATIONS: 0 introduced
SEALED_THIS_TURN: 0
