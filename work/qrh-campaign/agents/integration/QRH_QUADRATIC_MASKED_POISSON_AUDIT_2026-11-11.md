# Quadratic masked Poisson: active gcd, centered terms and analytic bounds

2026-11-11. Bounded source/mathematical audit of the provider at commit `4eaee87548250b2682affda7d05d947c05554bae`. Below, source paths are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/` (B). No Lean build, source alteration, analytic evaluation or axiom-closure check was performed. The conclusion is a checked source implication at the stated cut, not validation of the full QRH provider.

No mathematical defect was found in the active-gcd identification or the assembly of the four masked-Poisson contributions. The error is not merely named and assumed small: the source rewrites it as three actual tails. Nor are the source and dual principal densities declared equal: their nonzero difference is bounded by an actual quadratic sieve operator. The important remaining lower analytic cut is the original/dual middle-block estimate and its all-frequency summability, together with the underlying quadratic character Poisson identities. These are distinguished from the previously audited original trace-normalized radial Poisson identity.

## 1. Exact output and quantifier order

`CubicSieve/ArithmeticBins.lean:438–469`, `HasSieveExponent.annular_small_gcd_complete`, fixes an existing witness `hexp : HasSieveExponent alpha`, alpha>=1/2, deltaLoss>0 and natural l,A. It chooses finite Schwartz-seminorm sets sD,sS,sT and positive CD,CS,CT,CP before epsilon>0, M,N,X,K,T, coefficients, gcd ideal D and ray c. Under M,K>=1, T>=4, `CoefficientOnShell N X a`, D!=0 and norm(D)<=X/2, it proves

    ||6 * annularRayGcdBlock M N K D c a||
      <= poissonComparisonMajorant ... (commonMaskIdeal D)
           K (X/norm(D)) M T (activeGcdCoefficient N a D c) annularSieveCutoff.

The ambient indexing bound N and the active quotient scale X/norm(D) are different. There is no coefficient normalization, lower energy bound, nonempty-family hypothesis or uniformity over number fields. Zero/empty coefficients give zero without division by energy. The cutoff is the actual fixed Schwartz cutoff, with its proved value zero at zero.

`CubicSieve/FirstCoreCutoff.lean:501` defines HasSieveExponent by the actual squared operator norm: for every positive loss there exists C>0 bounding sieveNorm(M,N) by C(MN)^loss(M+N^alpha), for M,N>=1. This old exponent witness remains an explicit input. This audit does not infer it from the conclusion or replace it with the sharp exponent being bootstrapped. `QuadraticSieve/PoissonComparison.lean:333–380` supplies the generic masked theorem with the same order of constants; its additional domain is squarefree G containing both fixed bad primes, injective admissible columns of norm in [N/2,N], one common ray, and each column coprime to G.

## 2. Actual gcd restriction and quadratic Poisson normalization

`ArithmeticBins:393–436` defines active columns as I/D on `gcdRaySupport`, retaining coefficient a(I). The support requires divisibility by D, ray c, and a(I)!=0. Restricting the original finite double sum is exact: discarded coefficients vanish or fail the original gcd/ray predicate. `QuadraticSieve/CommonMasks.lean:607–647` proves quotient injectivity by cancellation of nonzero D, admissibility, common quotient ray and the rescaled norm shell. Squarefreeness of I gives coprimality of D and I/D; admissibility excludes the bad primes. Thus I/D is coprime to commonMaskIdeal(D), the squarefree union of those bad primes and primeSupport(D).

The shell lower endpoint is strict on nonzero coefficients: X/2<norm(I). With norm(D)<=X/2, every active I differs from D, including the boundary case norm(D)=X/2. Hence I/D!=1. Moreover X/norm(D)>=2, so the generic N>=1 gate is satisfied. `originalHigh_gcd_eq_maskedPoissonDifference` at `ArithmeticBins:400` consumes precisely these facts, not an unrestricted claim about every gcd block.

`QuadraticSieve/SquareParts.lean:227–271` defines originalPairSource using the actual quadratic rows and radial weight on supported ideals. Its low part has norm(squarefreePart(L))<=K; its high part has strict >K. Genuine source norm-summability follows by injecting chosen ideal generators into the Schwartz lattice sum (`:203–225`), then row norms<=1. Indicators preserve summability, and high=source-low follows by `tsum_sub`. The cutoff concerns the squarefree part, not norm(L) itself.

`SquareParts:280–382,474–478` then factors the common gcd mask and applies `canonical_same_ray_pair_poisson`. Its prefactor is M/(6*||n||), n=gen(I/D)*gen(J/D); each mask-divisor term has mu(q)*chi(gen q)/norm(q), and radial argument M*||h||^2/(norm(q)*||n||^2). The six is the actual unit-orbit conversion. CommonMasks:447–484 uses this identity, removes the dual zero term using the nontrivial residual pair, and converts to the retained ideal sum plus tail. If a contributing pair were diagonal, gcd(I,I)=D would force I=D, already excluded. Thus no principal unit-pair zero mode is silently removed in the active branch.

This quadratic pair/character identity is not the original first/second-pass radial Poisson theorem audited previously. Its immediate character input is `Eisenstein/ConstantTermSupport.lean:356`, `canonical_same_ray_pair_poisson`. The present audit checks its consumption and normalization, not all lower Gauss/reciprocity proofs.

## 3. The four contributions, with the density difference retained

Write V(x)=W(x^2), Vhat(x)=paperRadialFourier(W)(x^2), d(G)=number of ideal divisors, and L_K=columnDyadicLength(K). These are actual Schwartz functions (`GaussSum/ReflectionBrackets.lean:273–304`), not formal notation for arbitrary functions. Their radial transforms at zero agree by `quadratic_principal_zero_modes_equal` (`:267`), whose input is the half-line Fourier identity (`Mellin/InverseContour.lean:481`). This is a particular zero-mode equality, not an assertion that all transforms coincide.

`PoissonComparison:156–199` defines Delta=maskedDualFamily−maskedPrincipalSourceSum(V)/6 and proves the exact identity

    6 Delta = sum_{q|G} mu(q) centeredRetainedDual(q)
              + 6 maskedDualTailFamily − centeredMaskedSource
              + paperRadialFourier(V)(0) sqrt(M)
                  actualPrincipalDifference(cols,densityColumn(a),G,K).

Each dual center subtracts the unrestricted density at M/norm(q); the source center subtracts its masked density. `QuadraticSieve/CuspCoercivity.lean:137` and `CubicSieve/PrincipalDensity.lean:518–550,637–660` identify their difference exactly. The densityColumn factor is the column prime-pool density, with modulus<=1. Its coefficient energy is therefore at most sum|a|^2. No claim that the displayed principal difference vanishes is used.

Triangle inequality gives four nonnegative terms (`PoissonComparison:201`). The selected majorant (`:317–331`) pays d(G)(L_K+1) for centered dual, 6 for the tail, L_K+1 for centered source, and the separate principal operator term. The transform/divisor twists have norm<=1; F=norm(q)>=1 justifies comparing the dual majorant to F=1. All factors of six survive this assembly.

## 4. Retained/source truncations are bounded analytic errors

`QuadraticSieve/RetainedDualBounds.lean:186–232` proves `dualPrincipalIdeal_truncated_all_conductors`. It explicitly punctures z=0, proves summability and unit invariance, and applies the six-unit sum identity. This also covers I=J=1 in the generic theorem; it does not misuse a nonprincipal-only lattice formula. The result is (principalTruncation+middleTruncation+truncationError)/6.

Although `Poisson/PrincipalTruncation.lean:239` defines truncationError as a residual, `:244–324` rewrites it into: small-divisor nonzero dual tail; middle-divisor frequencies outside the retained disk; large-divisor source tail. The bound is

    2^|S| C seminorm(W) * [(Y/X)^A + (1+Z/X)^(-A)
      + (X/Y)/(min(1,X/Z)^2 * (1+X*lengthScale/Z)^A)].

It consumes the actual masked five-piece Poisson identity and the separately proved small/large/middle tail estimates. `MaskedPrincipalBounds:487–525` chooses order l+3, Y=X0/T, Z=T*X0, lengthScale=T^4, X in [X0/2,2X0], T>=4. The scalar reduction gives a constant times T^-l; support_card_bound replaces 2^|primeSupport(G)| by supportConstant(epsilon)*norm(G)^epsilon. This constant is chosen before the prime set and W.

For retained dual rows, X0=N*sqrt(F/(M*norm(row))) and the actual pair scale lies in [X0/2,X0]. The physical prefactor is at most 2M/(FN). `RetainedDualBounds:239–309` combines this with the 128B and 128N ideal-cardinality estimates and finite Cauchy. `:346–396` splits the centered sum into negative large-principal and W(0)*small-principal corrections, plus middle and error. Both principal corrections are paid; Vhat(0) is not assumed zero. `:467` partitions all retained squarefree rows into finitely many dyadic bins, handles empty bins by zero, and pays L_K+1 at B<=2K.

For the source, `PrincipalDensity:208–235` has the same exact split, but W here is V and V(0)=0 removes the small-principal term. `:238–279` bounds the error at X=X0=sqrt(M/norm(row)) using primeSupport(G*I*J), giving the displayed 16384BN factor and supportConstant(epsilon)*(norm(G)N^2)^epsilon/T^l. `:297–345` bounds the remaining large-principal and middle terms; `:396–450` gives the same complete dyadic-row partition. This is why both sD and sS occur and cannot be replaced by one unexplained residual estimate.

## 5. Middle terms: actual finite frequency sum and its lower cut

`Eisenstein/CuspIntegration.lean:673–779` expands the source middle into actual product-divisor terms and a finite nonzero frequency disk. `QuadraticSieve/MiddleWindows.lean:584–626` dominates this by the full nonzero-frequency sum with a proved Summable premise. The latter is built from two dyadic divisor pools (`:309`) and `original_middle_window:98`. The window theorem compares to `actual_original_middle_all_frequencies` and applies the hexp-dependent `original_middle_block` when D1*D2<=2U*sqrt(M/B). If that inequality fails, the support predicate is impossible and the window is exactly zero. Thus the cutoff is not assumed for a nonempty unsupported window.

The dual path is `QuadraticSieve/DualMiddleExpansion.lean:226–282`, `dual_product_divisor_middle`, `MiddleWindows:432` and `dual_middle_window:138`. Its scale is M/F+(2U)*sqrt(M/F)*B^(alpha−1/2), with the corresponding divisor gate D1*D2<=2U*N*sqrt(F/(MB)). Again genuine all-frequency summability precedes finite-to-infinite domination. Neither path interprets a nonsummable tsum as zero.

Retained dual rows need not avoid the fixed bad primes. `Eisenstein/SeedDefects.lean:360–505` partitions squarefree rows into their four bad-prime sectors. In a nonempty sector Q=norm(bad part)>=1, the good rows remain injective and admissible, B becomes B/Q, M becomes M*Q, coefficients get quadratic-row twists of norm<=1, and the exact identity has prefactor 1/Q. Alpha>=1/2 makes the rescaled majorant no larger. An empty sector contributes zero. Summing costs four, not an assumed admissibility of all squarefree rows.

This audit stops at the substantive all-frequency/block producers `actual_original_middle_all_frequencies`, `actual_dual_middle_all_frequencies`, `HasSieveExponent.original_middle_block`, and `HasSieveExponent.dual_middle_block` in `Poisson/LatticeEnvelopes.lean:215,277,408,436`, rather than claiming their names prove the lower oscillatory estimates. The window support, dyadic recombination, nonzero-frequency restriction, sector conversion and resulting majorant have been reconstructed here. That file is pinned as the precise lower frontier, not as a fully audited file.

## 6. Tail and principal operator: two independent bounds

`QuadraticSieve/DyadicColumns.lean:124–180` defines the discarded dual tail by strict norm(squarefreePart(L))>K on nonzero ideals. That norm is <=norm(L). Injectivity of idealGenerator and actual `paperRadialFourier_lattice_summable_norm` give summability; the tail is bounded by the full lattice tail at tK. The result is C seminorm(W)/(min(1,t)^2(1+tK)^A). `CubicSieve/ScaleCaps.lean:352–420` sums mask divisors using t>=M/(norm(G)N^2), norm(q)>=1 and prefactor<=2M/N. `:422–489` pays the finite pair Cauchy/cardinality cost 128N, hence **256M*d(G)** times the tail expression and coefficient energy. The generic final identity supplies its additional factor6.

`QuadraticSieve/PrincipalDifference.lean:114–177` expresses the principal difference as a double divisor sum of coprime Gram forms, with bounded character twists. `CubicSieve/CrossFactorization.lean:633–700` bounds each by the actual operator norm using |mainWeight|<=1/sqrt(K) and `ideal_coprime_gram_operator_bound`; two divisor sums cost d(G)^2. Injective restriction identifies the matrix norm bound with sieveNorm(K,N). `MaskedPrincipalBounds:256` applies **hexp.reverse**, so the scale is N+K^alpha, not K+N^alpha. Its fixed reversal cost is inside CP. After multiplying by sqrt(M), this gives

    d(G)^2 supportConstant(epsilon) N^epsilon CP (KN)^deltaLoss
      * [sqrt(M/K)N + sqrt(M)K^(alpha−1/2)] * sum|a|^2.

The lower coprime Gram inequality and the finite normalized-pair boundary expansion remain arithmetic/operator foundations; no positivity of the complex principal difference is claimed.

## 7. Status and remaining obligations

The checked join covers the small-gcd, one-ray annular block, all four terms, exact quotient domain, profiles, unit-column edge, and genuine sum convergence interfaces. It does not cover large gcds, hyperbolic reassembly, the full exponent bootstrap, or numerical constants after specializing T,K. The existing quadratic scalar-majorant audit is the separate bound on that specialization, not evidence for the analytic bounds just traced. The product-column audit likewise consumes the eventual sharp sieve and cannot be substituted for hexp here.

Remaining lower proof audits are: (i) quadratic same-ray character Poisson and its finite Gauss/reciprocity/unit transport; (ii) the actual source/dual all-frequency and middle-block estimates; (iii) lower large/small principal divisor bounds and coprime Gram operator inequality; (iv) the masked five-piece Poisson/tail foundations, Schwartz seminorm control and ideal support/cardinality lemmas at their established source interfaces. Prior radial-Poisson and global radial-tail reviews support shared Fourier/lattice facts at their own scopes, not blanket validation of these quadratic adapters. No new final hypothesis, spectral certificate, kernel-validity claim or root change follows from this note.

## Source and supporting-report pins

The following SHA-256 values bind the files read. Ranges above identify the consumed mathematical bodies; a file pin does not imply every declaration in that file was audited.

| Source relative to B | SHA-256 |
|---|---|
| CubicSieve/ArithmeticBins.lean | 99CDCE95094560A32F5E7601A4DA24554B47883C8F5683DC43CC23BCAD661A2A |
| CubicSieve/FirstCoreCutoff.lean | F7C16F712BC622AE9C048678A4D776EC78C45F6502CFFAF7CD7B36BB20156FB1 |
| QuadraticSieve/PoissonComparison.lean | 428339EF45AACFAB07DE6594CE4BCC58945746C0B326DC1098910396A9F74925 |
| QuadraticSieve/CommonMasks.lean | 92D248E33F8E722D0EEFE7DFC3AE1534B6515BB4C0A0C1D32515E35920CE0B9A |
| QuadraticSieve/SquareParts.lean | 5EB514F253D6CDD739B1C405B59305A4F69ACDF3C5C8BAF7A62A79727E6FC357 |
| Eisenstein/ConstantTermSupport.lean | F0DCFD87EB6C4368D22D3634771ED10B04FBE421B8FBBBF24EB20BE97633B426 |
| QuadraticSieve/CuspCoercivity.lean | 311DD70E96A1AC47135A20490A215560E5E66E9AE69DB17849EA735ABCA1CCF6 |
| CubicSieve/PrincipalDensity.lean | DD2371ED32B9AFAE8385FC400CD8A46A147B520FE4A006888E05D73385EC7781 |
| GaussSum/ReflectionBrackets.lean | D340337267ACE775D60C578B6E6D12E78CE8C1313B019AFE93E10ADD63AC1D4F |
| Mellin/InverseContour.lean | 07583B9AD1732A76889CA43FA78BDD98E902E0B41612F68D6CFB5ED4C5166D20 |
| QuadraticSieve/RetainedDualBounds.lean | ACD0726AFE215CE68AA43C1D089D28D78571D98042D1232073C085143EBBAB33 |
| Poisson/PrincipalTruncation.lean | BCD43D485A71D92684B79A876BFFCFE8E31B0F11D60DF75B4A02F1AABFD1D273 |
| QuadraticSieve/MaskedPrincipalBounds.lean | 06FB5D3004455032D16A914D3CB16381E862EC4DBDAB3FBCA6DA037FA7DCA868 |
| QuadraticSieve/DyadicColumns.lean | 06DD20DAD9FB49BFC615256402AA6664FAFB5125CB6AC11C701118057A47F87C |
| CubicSieve/ScaleCaps.lean | BA02CBBC2401A9025D4EDC570C4146F5496B2166E08F64A9AECD1B16A0588164 |
| Eisenstein/CuspIntegration.lean | A2465D4A05196AAB0A183BFE5523324C04E80E733D583EAE72CD3DA40D4D3EB5 |
| QuadraticSieve/MiddleWindows.lean | 8D234890AC8D5CFE5C6A9E76D53A9264E8E241928138FB5924CC6FFD5FFAE8A3 |
| QuadraticSieve/DualMiddleExpansion.lean | CBFBF47693FCD5395C9A80D6D86F817669897021E549C335BED8AB20AFED3041 |
| Eisenstein/SeedDefects.lean | A60BCC07E52B038B206FA3C2C16ABDC35F149F71B9276D131A2B6BECA9363F10 |
| QuadraticSieve/PrincipalDifference.lean | DB43BA4F8848D4B6792952A9A5E42FB4B35F05DF2E878067C9892F65953ED64B |
| CubicSieve/CrossFactorization.lean | FBF22E8AF7E34C1AB76CDAB3101CAACF1ED7BA1A766CE476D9F0B34841399933 |
| Poisson/LatticeEnvelopes.lean | BF911A0AA1CB1468B57F4DC48ACBEC400EA06C5AD504C95F3B050E577825FC29 |

Supporting notes below are relative to work/qrh-campaign/agents. They retain their own limited review scopes.

| Report | SHA-256 |
|---|---|
| integration/QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md | DE7237156824F7503A51F36A9E4A777F57647F2FC98F82D624D000E5D5C12AFA |
| moebius/REVIEW_QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md | 9516B5144F691A5D5203C93D737B943E69EFE4A0E4BA4F399A164F833AF75407 |
| independent-feasibility/QRH_QUADRATIC_SCALAR_MAJORANT_AUDIT_2026-11-11.md | 8E0B2679F9122C0F97C42A85896EAA867CFB5FB905E83482F8E38C3977168279 |
| audit/REVIEW_QRH_QUADRATIC_SCALAR_MAJORANT_AUDIT_2026-11-11.md | 8046E570600491B3F4F4894D357428F73BF674768994B306023FF6A6077473A9 |
| major-constants/QRH_QUADRATIC_PRODUCT_COLUMN_AUDIT_2026-11-11.md | 9E4A104441FA0B154132CF3F1AAE9E560EBD34EC368BB77484EAB38F3EEF758B |
| independent-feasibility/REVIEW_QRH_QUADRATIC_PRODUCT_COLUMN_AUDIT_2026-11-11.md | 31B94E3645296163679C9B7D820AE0E0D3EFEC7BDEBC48F743382CFA5EDCFFE9 |
