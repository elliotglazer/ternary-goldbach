# Independent review: quadratic squarefree product-column energy

2026-11-11. Verdict: **PASS for the bounded source and mathematical audit described here.** No substantive correction to the frozen author report is required. This verifies the finite product-column mechanism and the inspected upper sharp-sieve assembly, not the complete analytic foundation of the sharp quadratic sieve or the global QRH provider.

Reviewed author: `../major-constants/QRH_QUADRATIC_PRODUCT_COLUMN_AUDIT_2026-11-11.md`, SHA-256 `9E4A104441FA0B154132CF3F1AAE9E560EBD34EC368BB77484EAB38F3EEF758B`. All eighteen source hashes in that report were independently compared with the current files and match. Source baseline is `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`; the exact byte hashes below bind this review. No builds, Lean declarations, source edits, numerical evaluators or scans were performed. Whole-file hashes bind the indicated readings; they do not certify every declaration in those files.

## 1. Exact conclusion and its domain

The selected statement is `Descent/Quadratic.lean:77`, `quadratic_squarefree_product_column_energy`. For every epsilon>0 it chooses one C>0 before K,X, the finite row and ordered-pair sets, and the complex coefficient function. For K,X>=1 it bounds

    sum_{k in rows} |sum_{p in pairs} q_k(gen(p.1*p.2))*a(p)|^2
      <= C*(KX)^epsilon*(K+X)*sum_{p in pairs}|a(p)|^2.

Every row is admissible of norm<=K. Every PRODUCT p.1*p.2 is squarefree of norm<=X. The latter is stronger than asking the two factors separately to be squarefree. The statement does not assume an injective product map or pointwise bounded coefficients. It neither divides by coefficient energy nor requires it to be positive. Empty families and zero coefficients are valid; the unit ideal is allowed. Squarefreeness excludes zero products, precisely where the divisor injection needs this exclusion.

The actual row and squared operator norm are defined in `QuadraticSieve/CoprimeBilinearBound.lean:522–579`. Admissibility means nonzero and squarefree, with prime factors excluding the lambda prime and residue characteristic two. This is the quadratic definition, not the differently restricted cubic definition. The kernel is the cube of the actual ideal sextic row for the singleton ideal family, and zero on inadmissible row ideals. Its matrix has entries

    matrix(M,N)[I,J] = q_J(primaryGenerator(I)),

and sieveNorm is the square of its Euclidean operator norm. There is no averaging normalization, free character choice, or formal replacement by a model kernel in the inspected reduction. Uniformity is over these families in the fixed Eisenstein ring, not over all number fields.

## 2. Actual coefficients, repeated products and one divisor loss

Set phi(p)=p.1*p.2, T=phi(pairs), and f(J)=sum_{phi(p)=J}a(p). The proof first rewrites each row sum exactly as sum_{J in T}q_k(gen(J))*f(J). `Descent/SieveComposition.lean:53–90` implements this finite reindexing and then uses

    |f(J)|^2 <= card(phi^-1(J) intersect pairs)
                    *sum_{phi(p)=J}|a(p)|^2.

The fibers partition the source, so the second sum counts every a(p) exactly once. This is Cauchy–Schwarz for arbitrary complex coefficients, not a positivity assertion about the row sums. `Descent/Fibers.lean:98–136` supplies the underlying finite expansion estimate; the specialization uses unit weights. Multiplication by the supplied nonnegative sieve bound is legitimate.

`QuadraticSieve/ProductColumns.lean:80–93` proves the fiber cardinality bound by p |-> p.1. If phi(p)=J!=0, then p.1 divides J and p.1!=0. Equality of first coordinates forces equality of second coordinates by cancellation. This is injectivity into the finite set of ideal divisors of J, not injectivity of the product map. Distinct ordered pairs with equal products are retained and paid for. There is no missing multiplicity factor or unordered-pair quotient.

Taking the sharp squarefree energy bound and ideal-divisor bound both at epsilon/2 gives the intermediate scalar

    Cq*Cd*(KX)^(epsilon/2)*X^(epsilon/2)*(K+X).

Since X<=KX, this is at most Cq*Cd*(KX)^epsilon*(K+X). The selected conclusion pays exactly ONE divisor bound. This agrees with the actual calls at `Descent/Quadratic.lean:87–117`.

The similarly named supported-product theorem at `ProductColumns.lean:123–168` is different: it bounds each grouped coefficient pointwise, squares that bound, and uses the supported-column length estimate. Its divisor constant is squared and it carries an additional product-length factor. Likewise the general nonzero-column statement near line 608 has a pointwise lengthScale and extra X*lengthScale^2. Neither was substituted for the selected arbitrary-coefficient squarefree result in this review.

## 3. Why arbitrary squarefree columns cost four

The core `squarefree_all_column_energy`, `ProductColumns.lean:432–507`, first assumes distinct squarefree column ideals and gives exactly

    energy <= 4*sieveNorm(X,K)*sum_j|a_j|^2.

It partitions the columns by their bad-prime sector E, a subset of two fixed bad primes. There are four sectors. Within one sector, J=sectorBadIdeal(E)*goodSquarefreePart(J). The good part is admissible, has norm at most norm(J), and is injective on that sector. It need not be injective across sectors.

For fixed k and E, actual multiplicativity factors q_k(gen(sectorBadIdeal(E))) out of the row sum. Its norm is at most one, even when zero, so dropping it is valid without division. On the remaining good columns, the relevant matrix is the conjugate transpose of an injective submatrix of matrix(X,K). The row's real-valuedness identifies that conjugate transpose with the required kernel. `family_squared_norm_le` at `CoprimeBilinearBound.lean:600–613` is indeed an injective submatrix restriction followed by squaring; it does not conceal reciprocity or a conductor-dependent constant.

Cauchy across the four sector sums costs four, while the coefficient energies partition exactly. There is no second factor of four. Restricting the row sum to the requested finite rows is permissible because squared norms are nonnegative. Applying the sharp sieve with arguments X,K yields `finite_squarefree_quadratic_energy` and its factor-four constant.

The reverse inequality with factor 262144 belongs elsewhere in the analytic sharp-sieve proof. It is not needed in this conjugate-transpose adapter and was not silently dropped. The actual local row adapters checked here are the star identity at `Eisenstein/ConstantTermSupport.lean:288–295`, its finite quadratic-row reduction in `InitialBound.lean:77–100`, argument multiplicativity at `SquareParts.lean:142–150`, and the norm bound at `DivisorBlocks.lean:147–152`. Their foundational finite-field character facts remain inherited.

## 4. The divisor estimate and downstream use

I read the divisor-subpower proof at `FiniteOperator.lean:290–411`. Its starting inequality is divisorCard(I)<=product_P(e_P+1), obtained from normalized-factor submultisets. For epsilon>0 choose a finite norm cutoff above which n^epsilon>=2. With b=2^epsilon>1 and c=1+1/(b-1), Bernoulli gives e+1<=c*b^e. Every prime ideal has norm>=2. The finitely many primes below the cutoff therefore cost at most one c each; for larger primes, e+1<=2^e<=norm(P)^(epsilon*e). Norm multiplicativity gives a uniform constant times norm(I)^epsilon. Counting all small ideals rather than only prime ideals merely enlarges this constant.

This body uses no zero-free strip, prime number theorem or QRH input. Its underlying finite ideal balls, factorization, cancellation and norm identities were not exhaustively revalidated. It is an existence bound depending on epsilon and the fixed field, not an explicit practical constant or uniform estimate as epsilon tends to zero.

`Descent/Quadratic.lean:178–197,214–229` also permits a fixed factor B in the column argument. Actual primary-generator and row multiplicativity extract a row-dependent factor of norm<=1. No squarefreeness of B or the complete product B*phi(p), no norm cap on B, and no nonzeroness of B are needed for this contraction.

The consumer at `Descent/HybridReduction.lean:45–83` inserts the actual coefficient

    a(p)=sum_{c in cset(p.1)} beta(c,p.1,p.2)
              *sum_{P in Pset}coef(p.2,P)
                   *inverseCubicKernel(P,c*(mBad*p.1)).

A separate finite Cauchy estimate uses the supplied cset cardinality and |beta|<=1. The cubic expression remains inside its squared norm. This is a legitimate application of the arbitrary-coefficient quadratic theorem; it does not deduce a mixed fourth moment from an unrelated second moment or remove the cubic energy obligation.

## 5. Sharp-sieve assembly: checked scope

I independently compared the author's upper analytic assembly with the indicated source bodies. The finite argument above relies on `sieveNorm_sharp`; reading its wrappers alone would not establish the analytic inequality. Within the additional ranges inspected, the following account is accurate.

* Quadratic `HasSieveExponent` (despite its location in `CubicSieve/FirstCoreCutoff.lean`) has shape C(MN)^loss*(M+N^alpha). The initial exponent two and the reverse inequality retain their actual constants, including 262144 for the latter.
* In the selected annular estimate, the scalar-majorant loss 259*eta gains one divisor loss, becoming 260*eta. The large-gcd contribution is still present; its 3*eta power is enlarged to 260*eta because MN>=1. The threshold assumption controls the full three-term shape by 3M. It is not applied outside its threshold range.
* The annular-to-ball assembly uses seven scales 1,2,...,64 and free/divided coefficient families. Their energies partition. The low term uses the OLD exponent and its reverse inequality, costing 6*eta; it does not invoke the exponent under construction.
* The final choice eta=min(1,rho/600) pays the 260*eta and 6*eta estimates. Small N and N^2<=M are separately covered by the initial bound. Finite derivative orders are chosen for each requested loss, without claiming their constants are uniform in the order.
* The threshold-to-full step enlarges M to max(M,N^beta) and uses epsilon/3 to pay the product enlargement bounded by (MN)^3. The finite dyadic shell count is paid by a further small power; shell coefficient energies partition exactly.
* The bootstrap alpha_n=1+1/(n+1), alpha_(n+1)=2-1/alpha_n, starts at two. For each positive desired loss it chooses a finite n, then absorbs N^(alpha_n-1). It does not pass an uncontrolled sequence of constants to a limit.

At this inspected level the implication structure is not circular: the improvement uses the old exponent plus explicit analytic inputs. No spectral beta cap occurs in the inspected finite reductions or upper assemblies. This is not a transitive no-circularity proof for every lower dependency.

## 6. Remaining proof cut and next useful audit

The following inputs remain substantive, not certified merely because their consumers were checked:

1. **Masked Poisson.** `AnnularLifting.lean:483–544` assembles the scalar small-gcd cost, including its division by six, and the large-gcd bound with outer factor sixteen. `CubicSieve/ArithmeticBins.lean:438` reduces the small part to `masked_poisson_complete` and the active-gcd/Poisson-difference identity. I inspected that adapter, not the entire lower masked-Poisson proof. The six is the norm of the actual scalar multiplier on the annular block.
2. **Selected scalar majorant.** `PoissonConstants.lean:562` supplies the essential 259*eta estimate. The contract and initial constant selection were checked, including a constant of the form 262144*H^64*Cshape selected before the variable scales, q and G. Its hypotheses include 4<=C, B<=C<=C1, 1<=q<=X, norm(G)=Bq, and selectedK>=1. The whole constituent Fourier, derivative, principal-difference and scalar-envelope chain has not been validated by this review.
3. **High square parts and initial sieve.** The high-kernel reduction at `HighKernelGeometry.lean:136–182` applies the old exponent only to admissible descendant scales M/norm(A)^2>=1 and uses the stated inverse-square sum and count bounds. The underlying operator decomposition and ideal-count estimates, initial quadratic bound and reciprocity are retained foundations.
4. **Actual arithmetic and finite operator facts.** Local adapters to actual sextic/quadratic rows were read, but full finite-field character constructions, ideal normalization/factorization, primary-generator algebra and finite operator theory remain inherited.

The next useful analytic review should descend into items 1 and 2 rather than repeat the product-fiber argument. The present result establishes neither a complete sharp-sieve proof audit nor the correctness of the global QRH provider. No finite spectral certificate, compiled compatibility, expanded axiom closure or runtime claim follows from it.

## Independent source scope and pins

Paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`. The ranges record the bounded material read for this comparison, not full-file validation. The eighteen author pins were checked separately; this table also records additional local adapters read independently.

| File | Read scope (lines) | SHA-256 |
|---|---|---|
| `Descent/Quadratic.lean` | 1–232 | `1A7449EA20381B280C7920C47C49BBC3B5C7478E911F98D23E6CAAB529741A16` |
| `Descent/SieveComposition.lean` | 1–136 | `2B271CDDF6328B32252A44FB9FEF0F945E56FD85BA1EC11ED00F00DFA9FC4BEA` |
| `Descent/Fibers.lean` | 1–140 | `004F1691D9029E4E73B1FE3F162CBAFF019C34B7583F1D825DDD9A99E138B454` |
| `Descent/HybridReduction.lean` | 1–123 | `BB6BC1D1C10F933D551BED6775D41756C56F6AA4C8410DB38A9E7D72625AF5E4` |
| `QuadraticSieve/ProductColumns.lean` | 74–168; 432–507; 509–712 (alternative statements) | `B3CBB538BB0A8A18F2F0853BCF0A45E3EDC3E619A9310BB6E798DEDD9CF08C84` |
| `QuadraticSieve/CoprimeBilinearBound.lean` | 522–579; 590–619 | `FCB07617E92E671559105F156013B13ECCDC2B1F9E72AE05203680462A353D10` |
| `QuadraticSieve/UnrestrictedCharacters.lean` | 200–300 | `8F1B25CE87886B991793D6300694B0740554936ABD855DF4802235BB4FA80B42` |
| `QuadraticSieve/FiniteOperator.lean` | 290–411 | `4A8A56A5AC5A218C00616F40749B33A1942DC65F579BB6DF216F039EC2BA32BF` |
| `QuadraticSieve/SquareParts.lean` | 120–165 | `5EB514F253D6CDD739B1C405B59305A4F69ACDF3C5C8BAF7A62A79727E6FC357` |
| `QuadraticSieve/DivisorBlocks.lean` | 140–157; 302–325 | `41458D0EB675CCBDCC9F9FAD95AFEE7AF76ED46C16FD719DC658921EFDCF837D` |
| `Eisenstein/ConstantTermSupport.lean` | 270–313 | `F0DCFD87EB6C4368D22D3634771ED10B04FBE421B8FBBBF24EB20BE97633B426` |
| `QuadraticSieve/InitialBound.lean` | 1–128 | `5D3A030862AAE4997A9D8E13D51FBDBDEE1C41EC1AEC4D23BE49D8B183F7ABC4` |
| `Arithmetic/IdealMobius.lean` | 76–90; 230–250 | `EBE57D9158EB08FB55394555D08DAFDDB8A135BF15C74CFD5B77E7E7D0784B79` |
| `Eisenstein/SeedDefects.lean` | 185–212 | `A60BCC07E52B038B206FA3C2C16ABDC35F149F71B9276D131A2B6BECA9363F10` |
| `MeanSquare/TransformedColumns.lean` | 575–615 (alternative contract/initial reduction) | `71975BD8C26BC773D93DB1E82AEDFFD8A0F5ECB9518BE2782D81402957F6E75E` |
| `QuadraticSieve/LogarithmicLoss.lean` | 83–229; 392–477 | `1ACE302D012B37AC436117CC8513F94954774AA2FF7F35992E7B10F339FB4234` |
| `QuadraticSieve/SelectedExponents.lean` | 403–655 | `08CB24AAB4C0C42BC96CF1D845C2AC269699178FD2447199DE6232B4465788B2` |
| `QuadraticSieve/PoissonComparison.lean` | 1–170 | `428339EF45AACFAB07DE6594CE4BCC58945746C0B326DC1098910396A9F74925` |
| `CubicSieve/FirstCoreCutoff.lean` | 499–548 | `F7C16F712BC622AE9C048678A4D776EC78C45F6502CFFAF7CD7B36BB20156FB1` |
| `QuadraticSieve/AnnularLifting.lean` | 483–544 | `C46E96E87880A8C9D26C7BC2FE04BBA03E768869632D26C4325502794B72E7B2` |
| `CubicSieve/ArithmeticBins.lean` | 438–508 | `99CDCE95094560A32F5E7601A4DA24554B47883C8F5683DC43CC23BCAD661A2A` |
| `QuadraticSieve/PoissonConstants.lean` | 562–653 (contract/initial selection) | `E0914B906B537C1D987169FAC2943E49E47F62579F719E485A46C20117ACCFF2` |
| `QuadraticSieve/HighKernelGeometry.lean` | 136–182 | `289AE0174FB5214B20F8CBC957A137D95216591D4D7F2433B69E953AA486D070` |
