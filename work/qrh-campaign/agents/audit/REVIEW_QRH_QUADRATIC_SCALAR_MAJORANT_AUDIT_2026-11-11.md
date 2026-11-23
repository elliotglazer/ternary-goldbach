# Independent review: quadratic scalar majorant

Verdict: **PASS at the stated conditional source/mathematics scope.** No correction to the frozen author report is requested. The nine-term scalar estimate, its parameter dependencies, and the inspected finite assembly are consistent. This is not validation of the full quadratic sieve, global QRH provider, Lean elaboration, or transitive axiom closure.

Reviewed author: `QRH_QUADRATIC_SCALAR_MAJORANT_AUDIT_2026-11-11.md`, SHA-256 `8E0B2679F9122C0F97C42A85896EAA867CFB5FB905E83482F8E38C3977168279`. Its exact bookkeeping script and receipt match `8D3A758A7885CCA0DEEF2801765D15076D94EED855BFBF719EA73DBF634F1375` and `AC7191B34649E32F1602C347D818958A3DB3BD750C67E206B20026C79C4DBA6F`. I read the script rather than execute it. Independent integer bookkeeping and all 22 source-table hashes are recorded in `qrh_quadratic_scalar_majorant_source_review_20261111.json`, SHA-256 `882E851A12C15D1A8A569B17383C08EFF57BF1B94F97705D1FD98911FB6F5E1A`.

## Scalar mechanism and quantifiers

I inspected the complete selected helper chain in [PoissonConstants.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/PoissonConstants.lean:80), especially the theorem at line 562, together with [GlobalBinLoss.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/GlobalBinLoss.lean:76). Write P=MX, T=C P^eta, K=T X^2/M, N=X/q, and g=Bq. The constant is selected before the varying C,M,X,q,G. It may depend on the old sieve-exponent witness, fixed profile and seminorms, eta, truncation orders, and fixed B,C1. Neither uniformity as eta approaches zero nor uniformity over arbitrary Schwartz profiles follows.

The domains matter: 1/2<=alpha<=2, 0<eta<=1, eta*l>=4, eta*A>=4, M,X>=1, 1<=q<=X, G nonzero with norm g=Bq, 4<=C, B<=C<=C1, B>=1, and the explicit K>=1 condition. K>=1 is not inferred merely from M,X>=1. If C1<max(4,B), the admissible C range is empty; applications must supply a nonempty range. The scalar theorem allows arbitrary nonnegative CD,CS,CT,CP; their being valid analytic constants is a separate requirement.

Expanding the definitions gives nine positive terms. After bounding each of the 15 unit-budget entries by U>=1 and each required shape by S>=0, their numerical allowances are

    16, 24, 24, 65536, 1536, 10, 6, 32768, 1.

Their sum is 99921<262144. The product degrees are respectively 7,7,8,3,2,7,8,2,4, so each is bounded by its allowance times U^8*S. The retained error coefficient is 16384*2*2=65536; the source error coefficient is 16384*2=32768. The dual-tail coefficient is 6*256=1536. The principal term retains the square of the divisor count. These are actual terms, not nine copies of an assumed common analytic bound.

The primitive finite maximum H bounds 19 fixed quantities. The seven scale monomials g,K,N,2KN,N^2,gN^2,KN are at most (2C1+B)P^4. Thus each eta-power is bounded by H P^(4eta). Each unit-budget entry is a product of at most eight such controlled factors, giving U=(H P^(4eta))^8. The second eighth power contributes H^64 P^(256eta), not P^(32eta).

The remaining three powers come from the shape bound. Put Z=X^(2alpha-1)M^(1-alpha) and F=M+X+Z. Exact exponent algebra gives

    T*sqrt(M)*K^(alpha-1/2)=T^(alpha+1/2)*Z.

Together with 2^(alpha-1/2)<=4 and T^(alpha+1/2)<=T^3, this bounds T*a0 by 4C1^3 P^(3eta)Z. The first part of b0 is at most M because K>=X^2/M and N<=X; its other part is at most T*a0. The truncation terms KM/T^l and KN/T^l are at most C1. For the tail, t=Mq/(BX^2), tK=Tq/B, t>=1/(BP^2), and 1+tK>=P^eta. Consequently min(1,t)^2(1+tK)^A>=1/B^2, including t below one. No unmentioned large-t assumption is needed. A valid common S is (2+4C1^3+B^2+C1)P^(3eta)F. Therefore the total loss is exactly 256eta+3eta=259eta.

I checked the actual exponent identity and monotonicities in [ArithmeticBins.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/CubicSieve/ArithmeticBins.lean:499). The exact checks on rational sample exponents in the author's script are only bookkeeping; the all-real-alpha argument is the identity and inequalities above.

## Actual finite and analytic interfaces

[PoissonComparison.lean](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/PoissonComparison.lean:184) has the actual centered identity: six times the difference equals the Moebius-weighted retained sum, plus six times the tail, minus the centered source, plus the Fourier-zero/sqrt(M) principal-difference term. The latter does not cancel. Its norm estimate keeps all four blocks. The coefficient homogeneity at lines 463–481 is exact: diagonal square-root energy factors multiply to the nonnegative energy. It does not divide by that energy, and hence covers the zero vector and empty coefficient family.

The definitions at RetainedDualBounds:412–420, PrincipalDensity:282–295, PrincipalMajorants:84–89 and SeedDefects:337–343 reproduce the nine terms and their normalizations. Finite dyadic partitioning preserves the outer count of bins; coefficient twists contract energy. Actual `masked_poisson_complete` at PoissonComparison:333 requires squarefree G containing the bad primes, injective admissible columns in the stated norm interval, a common ray, coprimality, scale lower bounds, and W(0)=0. Those are not supplied by the scalar theorem and are correctly kept separate in the report.

The infinite sum is split by the norm of the **squarefree part**, not total ideal norm. At [DyadicColumns.lean:562](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/DyadicColumns.lean:562), actual summability is obtained before indicator splitting, including the closed low boundary and strict high complement. The family tail at ScaleCaps:453–480 combines 2M/N with the column count 128N and the divisor count; this explains 256M before the external factor six. Its Fourier-decay input remains conditional here.

I also checked the distinct finite high-square-part argument at [RetainedDualBounds.lean:531](C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/openai-math/lean/OAI/NumberTheory/DirichletL/QuadraticSieve/RetainedDualBounds.lean:531). On a fixed square-part fiber, equality of squarefree parts reconstructs the original ideal, so the row map is injective. The changed coefficients are an ideal-zero mask times the original coefficients and contract energy. Summing fibers therefore produces a sum of sieve norms at M/norm(A)^2, with no missing fiber cardinality. The actual retained fibers ensure this argument of the old sieve bound is at least one and at most M. HighKernelGeometry:77–181 supplies the finite inverse-square estimate 1024 and the separate cardinal estimate 128sqrt(M/K). This use of the old exponent is locally noncircular; it is not a transitive dependency audit.

Finally SelectedExponents:600–655 retains the large-gcd contribution, uses the actual selected threshold to bound F by 3M, and adds the extra divisor loss to obtain 260eta. The high contribution's 3eta loss is enlarged to 260eta using MX>=1. The report does not incorrectly identify 259eta with the final annular loss.

## Remaining proof boundary

The useful unresolved inputs are the actual principal truncation, small/large principal and middle estimates, uniform source/dual errors, radial Fourier/Poisson identities, and radial lattice-tail estimate. The foundational ideal count/factorization, finite-field quadratic identities, finite-operator bounds and old reverse sieve exponent also remain inherited. Reading their consumer contracts and local assembly is not proving their entire derivations. In particular the arbitrary scalar constants cannot be used as actual Fourier bounds without the four analytic producer contracts.

All author source-table hashes match. No Lean source, frozen report, or receipt was altered; no build or analytic evaluation was performed. The final Goldbach roots and their allowed hypotheses remain unchanged. No spectral data, global-provider validation, or new root premise follows from this review.
