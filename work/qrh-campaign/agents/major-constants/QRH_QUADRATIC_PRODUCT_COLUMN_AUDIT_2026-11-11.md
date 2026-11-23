# Quadratic squarefree product-column source audit

2026-11-11. Source baseline: `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`. This is a bounded mathematical reading of actual proof bodies, not a Lean build, an expanded-axiom check, or validation of the global QRH provider. No source, prior report, or numerical evaluator was changed or run.

The finite product-column argument has no identified mathematical defect. It uses one divisor multiplicity loss, four bad-prime sectors, and the sharp quadratic operator estimate with its dimensions reversed. The latter is a substantive analytic input. I traced its finite exponent bootstrap and threshold assembly below, but did not validate its complete masked-Poisson and scalar-majorant foundations. Consequently this report does not establish the sharp quadratic sieve independently.

## 1. Exact target and actual function

`Descent/Quadratic.lean:77–119`, `quadratic_squarefree_product_column_energy`, states: for every real epsilon>0 there is C>0 such that, for all K,X>=1, finite ideal sets of rows and ordered pairs P, and arbitrary complex coefficients a(p),

    sum_k |sum_{p in P} q_k(gen(p.1*p.2))*a(p)|^2
      <= C*(K*X)^epsilon*(K+X)*sum_{p in P}|a(p)|^2.

Each row k must be admissible and have norm<=K. Each PRODUCT p.1*p.2 must be squarefree and have norm<=X. Squarefreeness of the two factors separately would not suffice. No injectivity of the product map, individual coefficient bound, fixed cardinality, spectral hypothesis, or conductor-dependent constant is assumed.

Here O is the fixed Eisenstein integer ring, `gen=primaryGenerator`, and `q=CanonicalQuadraticSieve.quadraticRow`. `QuadraticSieve/CoprimeBilinearBound.lean:522–579` defines admissibility as nonzero, squarefree, with all prime factors excluding the lambda prime and residue characteristic 2. The row is the cube of the actual `idealSexticRow` on its singleton ideal family when admissible, and zero otherwise. The norm is the SQUARED Euclidean operator norm of

    matrix(M,N)[I,J] = q_J(gen(I)),

on admissible ideals of norms at most M,N. It is not a normalized average or a supremum over independently chosen characters. The result's C is selected before K,X, all finite sets, and coefficients. This is uniformity over these actual ideal families in the fixed field, not a theorem uniform over number fields.

## 2. Squarefree columns, bad primes, and matrix orientation

`ProductColumns.lean:432–507` proves `squarefree_all_column_energy` for an injectively indexed squarefree column family, including the two excluded prime factors. Its right side is

    4*sieveNorm(X,K)*sum_j |a_j|^2.

The proof partitions columns into E=badPrimeSector(J), indexed by the powerset of the two fixed bad primes. `UnrestrictedCharacters.lean:185–276` supplies the squarefree reconstruction J=sectorBadIdeal(E)*goodSquarefreePart(J), admissibility and norm decrease of the good part, and good-part injectivity WITHIN a fixed sector. There are exactly four sectors (`:250–261`). Injectivity across different sectors is not claimed or needed.

Within one sector, multiplicativity gives a single row-dependent factor q_k(gen(sectorBadIdeal(E))). Its norm is at most one, including cases where it vanishes. Removing this factor is therefore a valid upper bound. No reciprocal is taken. The remaining matrix is the conjugate transpose of a submatrix of matrix(X,K). `family_squared_norm_le` (`CoprimeBilinearBound.lean:600–617`) is proved by injective submatrix restriction. The identification uses the real-valued quadratic-row identity `canonical_quadraticRow_star` (`Eisenstein/ConstantTermSupport.lean:288–295`) and invariance of the operator norm under conjugate transpose. It does not use exact interchange reciprocity between the two ideal arguments. In particular the factor 262144 appearing elsewhere in the sharp sieve's reverse inequality is not an omitted factor in this adapter.

Cauchy across the FOUR sector sums costs four, and the coefficient energies partition exactly. Thus the cost is four, not sixteen. Restricting the nonnegative row-energy sum from all of idealRange(K) to the requested rows and applying `sieveNorm_sharp X K` proves `finite_squarefree_quadratic_energy` (`Descent/Quadratic.lean:44–75`) with constant four times the sharp constant.

The row facts are actual-source adapters: `SquareParts.lean:142–150` reduces argument multiplicativity to the finite quadratic kernel, `DivisorBlocks.lean:147–154` reduces the norm bound to the actual sextic-row bound and handles the inadmissible zero branch. Their deeper finite-field character foundations are retained, not reproved here.

## 3. Repeated products: the exact one-factor loss

Let T=image(P, product), and f(J)=sum_{p in P, product(p)=J} a(p). Finite fiber reindexing gives EXACT equality of the original row sum with sum_{J in T}q_k(gen(J))*f(J). For every fiber, finite Cauchy gives

    |f(J)|^2 <= number_of_pairs_in_fiber(J)
                  *sum_{product(p)=J}|a(p)|^2.

Summing over J counts each coefficient once. `Descent/SieveComposition.lean:53–92`, `column_fiber_sieve`, proves precisely this operation for an arbitrary kernel and an arbitrary target sieve inequality; it uses no positivity of the complex row sums. Only the resulting squared norms and scalar upper constants are nonnegative.

`ProductColumns.lean:80–93`, `product_fiber_card`, injects a nonzero-product fiber into `idealDivisors J` by its first coordinate. The first coordinate divides J. Equality of first coordinates forces equality of second coordinates by cancellation; its nonzeroness follows from J!=0. Squarefreeness ensures J!=0 in the caller. There is no cancellation at a zero ideal and no assumed unique factorization of a pair as a product. The finite set P contains no repeated identical ordered pair, but it can contain many distinct pairs with the same product, all of which are paid for.

Write Q(epsilon/2) for the constant from section 2 and D(epsilon/2) for the ideal divisor bound. The fiber bound is D(epsilon/2)*X^(epsilon/2), hence the result before final absorption is

    Q(epsilon/2)*D(epsilon/2)*(KX)^(epsilon/2)
      *X^(epsilon/2)*(K+X)*sum_p|a(p)|^2.

Since K>=1 and X>=1, X^(epsilon/2)<=(KX)^(epsilon/2). This is exactly the source's epsilon split. There is ONE divisor factor, not its square. Empty row/column/pair families give zero energy without an exceptional division. The unit ideal is allowed; its fiber argument remains valid. No claim of positive energy for every family is required.

## 4. Divisor subpower bound: checked proof rather than a black box

`QuadraticSieve/FiniteOperator.lean:281–413` contains a complete elementary proof of the bound used here. For a nonzero ideal I, normalized prime-factor multisets inject its divisors into submultisets of normalizedFactors(I). Therefore

    divisorCard(I) <= product_{P|I}(e_P+1).

For fixed epsilon>0 choose a finite norm cutoff N so that n^epsilon>=2 for n>=N. The ideal set of norm<=N is finite. Put b=2^epsilon>1 and c=1+1/(b-1). Bernoulli's inequality gives e+1<=c*b^e. For the finitely many small primes this gives e_P+1<=c*(norm(P)^epsilon)^e_P, since norm(P)>=2. For all remaining primes e_P+1<=2^e_P<=(norm(P)^epsilon)^e_P. Multiplying gives

    divisorCard(I) <= c^(number_of_small_ideals)*norm(I)^epsilon.

The norm-product identity and nonzero normalized-factor reconstruction are used explicitly. Counting ALL small ideals, rather than only prime ideals, is a harmless upper bound. The constant is selected solely from epsilon and the fixed field. This does not provide a practical numerical value of the constant or a uniform bound as epsilon tends to zero. Remaining arithmetic foundations here are finite ideal-norm balls, factorization/cancellation and multiplicativity of ideal norm; the local argument introduces no L-function or zero-location input.

## 5. Actual fixed-factor and hybrid consumption

`Descent/Quadratic.lean:178–197` proves `quadratic_fixed_factor_energy` by factoring q_k(gen(B)) out of each row and using its norm<=1. B is arbitrary, including zero; the proof does not divide by B or assume B*(p.1*p.2) squarefree. The squarefree-product theorem with this factor follows at `:214–229`.

`Descent/HybridReduction.lean:45–83` then applies that theorem with the actual coefficient

    a(p)=sum_{c in cset(p.1)} beta(c,p.1,p.2)
            *sum_{P in Pset} coef(p.2,P)
                 *inverseCubicKernel(P, c*(mBad*p.1)).

The cubic kernel remains inside the squared sum. A separate finite Cauchy step pays the supplied bound on card(cset(p.1)), using |beta|<=1. This is not an inference of a mixed fourth moment from a second moment, nor an arbitrary replacement of the kernel by a positive surrogate.

Two similarly named statements are weaker and must not be substituted silently. `ProductColumns.lean:123–173`, `product_quadratic_norm`, assumes bounded coefficients on a supported Cartesian product and pays a squared pointwise divisor bound together with an extra product-length factor. `bounded_nonzero_quadratic_norm` (`:608` onward) treats general nonzero columns with a pointwise lengthScale and an extra X*lengthScale^2. Neither is the selected arbitrary-coefficient squarefree product-column bound.

## 6. What supplies sharpness, and what this reading checked below it

`LogarithmicLoss.lean:474–477` obtains `sieveNorm_sharp` from `hasSieveExponent_one`. The relevant definition is the QUADRATIC namespace's `HasSieveExponent` in `CubicSieve/FirstCoreCutoff.lean:501`: for every positive loss, a uniform bound C(MN)^loss*(M+N^alpha). The file path does not turn this into `HasCubicExponent`.

I checked these upper proof bodies, not merely their import graph:

* `FirstCoreCutoff.lean:505` gives exponent two from the initial quadratic bound. Its reverse inequality retains the factor 262144. The underlying initial bound and arithmetic reciprocity are separate foundations.
* `SelectedExponents.lean:566` combines selected small-gcd Poisson costs with the large-gcd estimate. The scalar cost has exponent 259*eta; the additional divisor loss yields 260*eta. The large-gcd contribution is retained, with its support and divisor constants. In the threshold range N^(2-1/alpha)<=M, the shape N^(2alpha-1)*M^(1-alpha) is at most M, and N<=M, so the three-term shape is at most 3M.
* `LogarithmicLoss.lean:83–229` transfers the annular bound through seven scales 1,2,...,64, separately accounting for free and divided coefficients. Their coefficient energies partition. The high term is combined with the retained low-row sieve norm. The low-row argument invokes the OLD exponent alpha (including the reverse constant), producing a 6*eta loss, not the exponent being proved.
* `LogarithmicLoss.lean:392–469` chooses eta=min(1,rho/600) and sufficiently large finite integer derivative orders. This pays both 260*eta and 6*eta within rho. The cases N^2<=M and N<=28 are covered by the initial bound. No limiting uniformity in derivative order is asserted.
* `SelectedExponents.lean:459–543` lifts shell estimates to the full column ball. Its finite dyadic-shell Cauchy loss is bounded by a small power; coefficient energies again partition exactly. At `:404–453`, enlarging M to max(M,N^beta) supplies the missing region below the threshold. The product enlargement is bounded by (MN)^3 and paid by using epsilon/3. Thus a threshold estimate is not applied outside its domain.
* `PoissonComparison.lean:112–155` uses alpha_n=1+1/(n+1), with alpha_(n+1)=2-1/alpha_n, to iterate finitely from two. For each requested positive final loss a finite n suffices; `:83` absorbs the remaining N^(alpha_n-1) into a further small power. It never takes a limit of the constants C_n. This produces exponent one with a loss-dependent constant.

These are acyclic implication steps at the level inspected: the improved bound is assembled from the old exponent hypothesis, initial estimates and the new analytic Poisson inputs. I found no occurrence of an assumed QRH beta cap in those bodies. This is not a transitive no-circularity or axiom verdict on every deeper imported producer.

## 7. Exact remaining boundary

The target's finite reduction is now exposed; its hardest retained input is still the sharp quadratic sieve. The following cuts specify where this bounded audit stops.

1. `AnnularLifting.lean:483–544`, `HasSieveExponent.annular_energy_from_scalar_cost`, was read through its assembly. It bounds small-gcd blocks by the supplied scalar majorant divided by SIX, sums them with divisor weights, and adds the large-gcd high-kernel term; the external assembly factor is sixteen. The six is from the actual norm of `6*annularRayGcdBlock`, not an unrecorded normalization. Its small-gcd analytic producer is `CubicSieve/ArithmeticBins.lean:438`, `HasSieveExponent.annular_small_gcd_complete`, which calls `masked_poisson_complete` and an exact active-gcd/Poisson-difference identification. I inspected that contract and initial adapter, not the complete masked-Poisson proof below it.
2. `PoissonConstants.lean:562`, `poissonComparisonMajorant_selected_power`, supplies the essential 259*eta majorant. Its contract and parameter selection were inspected: finite primitive constants are bounded before M,X,q,G; the explicit outside factor is 262144*H^64*poissonShapeConstant. The bound is uniform for 4<=C, B<=C<=C1, 1<=q<=X, norm(G)=B*q and selectedK>=1. I did not validate all constituent Fourier/derivative, principal-difference and scalar-envelope estimates below its full body. This is a precise unvalidated quantitative leaf, not an accepted theorem solely because its caller composes correctly.
3. The high-kernel branch `HighKernelGeometry.lean:136` applies the OLD sieve exponent to square-part descendants M/norm(A)^2, and uses inverse-square norm sum<=1024 and count<=128*sqrt(M/K). Its displayed bounds keep those descendants in the old theorem's domain. I inspected this reduction; the square-part operator decomposition and ideal-count estimates remain inherited foundations.
4. Under the finite part remain the actual sextic/quadratic character norm, star and multiplicativity laws, primary-generator multiplication, ideal factorization and finite operator restriction/norm facts. The local adapters were read as specified above; the foundational finite-field and algebraic constructions were not revalidated exhaustively.

This boundary is substantive: removing it would require auditing actual masked Poisson evaluation and the selected scalar majorant, not another product-fiber or exponent-budget wrapper. No conclusion about provider validity, finite spectral certification, practical constants, or runtime follows from the present result.

## Source pins

Paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. A whole-file hash binds the cited ranges; it does not claim every declaration in that file was checked.

| Source | SHA-256 |
|---|---|
| Descent/Quadratic.lean | `1A7449EA20381B280C7920C47C49BBC3B5C7478E911F98D23E6CAAB529741A16` |
| Descent/SieveComposition.lean | `2B271CDDF6328B32252A44FB9FEF0F945E56FD85BA1EC11ED00F00DFA9FC4BEA` |
| Descent/HybridReduction.lean | `BB6BC1D1C10F933D551BED6775D41756C56F6AA4C8410DB38A9E7D72625AF5E4` |
| QuadraticSieve/ProductColumns.lean | `B3CBB538BB0A8A18F2F0853BCF0A45E3EDC3E619A9310BB6E798DEDD9CF08C84` |
| QuadraticSieve/CoprimeBilinearBound.lean | `FCB07617E92E671559105F156013B13ECCDC2B1F9E72AE05203680462A353D10` |
| QuadraticSieve/UnrestrictedCharacters.lean | `8F1B25CE87886B991793D6300694B0740554936ABD855DF4802235BB4FA80B42` |
| QuadraticSieve/FiniteOperator.lean | `4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF` |
| QuadraticSieve/SquareParts.lean | `5EB514F253D6CDD739B1C405B59305A4F69ACDF3C5C8BAF7A62A79727E6FC357` |
| QuadraticSieve/DivisorBlocks.lean | `41458D0EB675CCBDCC9F9FAD95AFEE7AF76ED46C16FD719DC658921EFDCF837D` |
| Eisenstein/ConstantTermSupport.lean | `F0DCFD87EB6C4368D22D3634771ED10B04FBE421B8FBBBF24EB20BE97633B426` |
| QuadraticSieve/LogarithmicLoss.lean | `1ACE302D012B37AC436117CC8513F94954774AA2FF7F35992E7B10F339FB4234` |
| QuadraticSieve/SelectedExponents.lean | `08CB24AAB4C0C42BC96CF1D845C2AC269699178FD2447199DE6232B4465788B2` |
| QuadraticSieve/PoissonComparison.lean | `428339EF45AACFAB07DE6594CE4BCC58945746C0B326DC1098910396A9F74925` |
| CubicSieve/FirstCoreCutoff.lean | `F7C16F712BC622AE9C048678A4D776EC78C45F6502CFFAF7CD7B36BB20156FB1` |
| QuadraticSieve/AnnularLifting.lean | `C46E96E87880A8C9D26C7BC2FE04BBA03E768869632D26C4325502794B72E7B2` |
| CubicSieve/ArithmeticBins.lean | `99CDCE95094560A32F5E7601A4DA24554B47883C8F5683DC43CC23BCAD661A2A` |
| QuadraticSieve/PoissonConstants.lean | `E0914B906B537C1D987169FAC2943E49E47F62579F719E485A46C20117ACCFF2` |
| QuadraticSieve/HighKernelGeometry.lean | `289AE0174FB5214B20F8CBC957A137D95216591D4D7F2433B69E953AA486D070` |
