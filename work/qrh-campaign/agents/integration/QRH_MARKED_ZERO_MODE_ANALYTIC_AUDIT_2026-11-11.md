# QRH marked zero mode: actual arithmetic and normalization

Date: 2026-11-11. Status: bounded source/paper audit, frozen for independent review. No Lean build, declaration, source edit, analytic evaluation or numerical experiment. This report does not validate the full provider or its transitive axioms.

## 1. Result and scope

No mathematical gap was found in the inspected zero-mode chain. It uses exact vanishing of nonempty off-diagonal rows, a signed Möbius density identity, uniform marked coefficient mass, and the normalization `X^-1`. It does not use high-frequency decay, zero-free strips, RH, a prime number theorem or cancellation in an estimated absolute divisor sum.

The audited conclusion is `InverseInitialZeroMode.physical_marked_zero_bound`: for fixed `loss>0`, `L>=0`, `b>0`, `B>=0` and Schwartz Phi there exists C>0 before all prime families, finite pools, characters, element parameters, slots/lists/coefficients, W and scales, such that the actual finite physical zero-frequency sum is at most `C*Z^(m+loss)` whenever `Z>=1` and `D<=L`. W needs only `|W|<=B` and `W(x)!=0 -> x<=b`. Its arguments in this application are positive. The prime, disjointness and norm assumptions are retained explicitly below.

Source base B is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, repository commit `4eaee87548250b2682affda7d05d947c05554bae`. Paths in the source map are relative to B. The complete containing files are hash-bound at the end.

This fills the zero-mode input left separate by `integration/QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md` (SHA256 `D8188C5E8AA59E979BEC024567255CF28845215117F2426C70C31D93F60EBA4D`), reviewed in `moebius/REVIEW_QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md` (SHA256 `0EC988BEE4AF8EF9A3FB17273AD0DACEF1D642F55F527D608ACF92C9D26D077B`). These report paths are relative to `work/qrh-campaign/agents/`. No frozen report is amended.

## 2. Actual physical zero, not an abstract diagonal surrogate

`Inversion/InitialRayAttachment.lean:131,212,224` defines `initialTest`, `initialPhysicalMode`, and proves `normalized_overlap_mode`. The physical mode contains the actual finite ray sum, the common coefficient, the Möbius factor and the physical kernel. The normalized identity writes it as

`Z^-D * overlapPairWeight * (Z^m / |n|) * (mu(E)/|e|^2) * radialPhi(Z^m*|h|^2/(|e|^2*|n|^2)) * activeGaussRowFactor(T,U,e,h)`.

Here n is the product over active support, e generates the divisor ideal, and `radialPhi=paperRadialFourier Phi`. `initial_product_kernel:182` checks the exact kernel scales via the active-support norm and the ideal-generator norm identity. `initial_overlap_weight:137` expands the actual common/masked coefficients. `initial_pair_rays:153` uses `CubicSieve/RayCoefficients.second_gauss_ray_expansion:146`, preserving the conjugation and the second frequency `-h`. Thus substituting h=0 does not drop or estimate any ray coefficient.

`Inversion/InitialZeroModePhysical.physical_zero_off_diagonal:22` applies `CubicSieve/FixedProfiles.activeGaussRowFactor_zero_of_ne:379`. The active support is `(T\U) union (U\T)`. If U!=T it is nonempty. The active Gauss row has a factor `conj(row(0))`, and the finite product character row is zero there. `GaussSum/SexticRadialPoisson.lean:789–803` proves this directly from the quotient-field character's zero criterion: zero lies in every prime ideal. No estimate on the magnitude or nonvanishing of the Gauss constant is needed for this vanishing.

The original outer sum only includes disjoint U,T. Therefore its only surviving equal pair is `U=T=empty`. The unequal cases vanish term by term, not after cancellation. For the empty pair, `activeGaussRowFactor_empty:391` is exactly one. `physical_zero_empty:31` gives

`Z^-D * Z^m * radialPhi(0) * |c_G|^2 * conj(H_G)*H_G * mu(E)/Norm(E)`,

where `H_G=initialTest(mark,W,Z,D,G)` and `c_G=secondInputCoefficient(...,constant 1,G)`. The empty active product has norm one; all divisor generators are nonzero products of nonzero primes. The later positive-scale normalization does not rely on division by zero.

`physical_zero_sum:56` performs the full finite U,T,E sums and identifies the actual physical zero sum with

`Z^-D * truncatedSecondZero(pool,Psi,j,1,1,H,Phi,Z^m,K)`, with `K(G,E)={0}`.

No finite or infinite frequency remainder is hidden in this identity. No limiting operation occurs in the zero-mode proof.

## 3. Signed divisor density and coefficient semantics

`CubicSieve/FrequencyCutoffs.truncatedSecondZero:155` retains the signed divisor sum. `QuadraticSieve/TruncatedSecondTransfer.truncatedSecondZero_eq_density:184` identifies it with

`Y * radialPhi(0) * sum_G |secondInputCoefficient(...,H,G)|^2 * density(G)`,

where `density(G)=prod_{i in G}(1-1/Norm(P_i))`. The hypothesis is that zero belongs to every K(G,E); choosing singleton zero supplies it exactly. Other entries of K have no effect on this zero component.

`GaussSum/ActiveConductor.primeSubset_moebius_norm_sum:178` expands the finite product. `GaussSum/SecondPoissonScale.prime_product_moebius:369` proves `mu(prod_{i in E} P_i)=(-1)^|E|` by induction using distinct maximal primes, coprimality, and multiplicativity of Möbius on coprime factors. Norm multiplicativity then gives the reciprocal product. This order of operations matters: taking absolute values before the divisor sum would discard the density saving.

`primeDensity_nonneg_le_one:191` proves each factor is in [0,1] because every nonzero ideal norm is at least one. Hence `secondDiagonalMass_nonneg_le:218` puts the density-weighted mass between zero and the unweighted coefficient square mass. `truncatedSecondZero_norm_le:233` follows with the factor `|Y|*|radialPhi(0)|`. No positivity or reality of `radialPhi(0)` is assumed.

The coefficient is not a free envelope: `CubicSieve/RayCoefficients.secondInputCoefficient:108` is literally

`Psi(product p_i) * coprimeMask(G,element) * row(G,c)^4 * row(G,d) * H(G)`.

The coprime mask is zero or one. `GaussSum/SecondPoissonScale.finiteSquarefreeRow_self_pair:191` proves `conj(row)*row=mask` directly from the multiplicative characters in the quotient fields. `PrimeRows/IdealGenerators.finiteSquarefreeRow_norm_le_one:526`, `CubicSieve/ConjugateProfiles.secondInputCoefficient_norm_le:504` and `CubicSieve/SupportNorms.secondInputCoefficient_norm_le_test:127` then give `|coefficient|<=|H(G)|` under the genuine assumption `|Psi(x)|<=1` for all x. The element parameter named m in those general coefficient lemmas is distinct from the real scale exponent m used here.

## 4. Uniform marked mass, including empty and small-scale cases

`Descent/Marks.lean:15–19` defines each slot as a sum over listed primes in G, and the mark as the product of those slot sums. `primeMark_norm_le_divisor_count:76` bounds it by `2^|G|`: the intersection lists are pairwise disjoint, their total cardinality is at most |G|, and each intersection-cardinality is at most its power of two. This holds for arbitrarily many slots. Empty slots/lists and the empty slot family are handled by ordinary empty sums/products; no lower bound on the number of available choices is assumed.

`Descent/MarkBounds.finite_primeMark_small_power:21` identifies |G| with the number of distinct prime factors of the product ideal and invokes `Arithmetic/SquarefreeDivisors.prime_support_subsets_bound:83` at exponent eps/2. The latter chooses, **before the ideal**, a norm threshold above which `2<=Norm(P)^(eps/2)`. The globally finite set of small-norm ideals contributes a constant. The product of the remaining distinct prime factors divides the original ideal, so its norm is at most the original norm. Consequently

`|mark(G)| <= Cmark * Norm(G)^(eps/2)`

with Cmark independent of the pool, number of slots, lists and norm-bounded coefficients. This is a qualitative small-power constant, not an effective runtime or numerical bound asserted here.

`Inversion/InitialZeroMode.marked_coefficient_mass:16` restricts to exactly the live set `T={G subset pool : W(Norm(G)/X)!=0}`. Outside T the coefficient is zero. Inside T, `Norm(G)<=bX`. If bX<1 the set is empty since a nonzero ideal product has norm>=1. Otherwise

`|T| <= 128*bX`, and `|coefficient(G)| <= Cmark*(bX)^(eps/2)*B`.

The count is uniform in the pool. `QuadraticSieve/PrincipalDifference.boundedPrimeSupports_card:636` injects prime subsets into their ideal products; `GaussSum/RayCharacters.family_product_injective:588` proves injectivity by prime divisibility and distinctness. `Mellin/InverseContour.finite_ideal_count_real:306` then counts all nonzero ideals of norm<=bX. This is not a bound on elements with arbitrary choices of associates.

The count was followed further: `Hecke/FiniteEulerFactors.idealsUpTo_card_le:430` injects ideals by a chosen generator whose span recovers the ideal (`PrimeRows/NormFiberExtraction.lean:57–69`). Its integer-coordinate norm is `a^2-ab+b^2`. `Arithmetic/LatticeCount.lean:23–88` bounds both coordinate squares by 2N, puts the points in a box of radius `floor(sqrt(2N))+1`, and obtains `64*(N+1)`. Taking N=floor(bX) and bX>=1 gives 128bX. The actual coordinate/PID/norm identifications remain foundational inputs, not assumed counting asymptotics.

Squaring the coefficient bound and multiplying by this count yields

`sum_G |coefficient(G)|^2 <= [128*b*(Cmark*b^(eps/2)*B)^2]*X^(1+eps)`.

The source adds one to the bracket to guarantee Cmass>0. This is valid for every X>0, including X<1 and B=0; it does not require W to be smooth or to have a positive lower support endpoint.

## 5. Normalization, scale loss and actual consumption

`marked_normalized_zero:87` combines §§3–4 for positive X,Y:

`|X^-1 * truncatedSecondZero| <= Czero*Y*X^eps`,

with `Czero=Cmass*|radialPhi(0)|+1`. Thus the original `X^(1+eps)` mass loses exactly one power under the source's normalization. No additional X, square root or ray-cardinality factor is omitted.

`Inversion/InitialZeroModeBudget.physical_marked_zero_bound:15` sets `eps=loss/(L+1)>0`, `X=Z^D>0`, `Y=Z^m>0`, uses `Z^-D=(Z^D)^-1`, and obtains `Czero*Z^(m+D*eps)`. Since D<=L and L>=0,

`D*eps <= L*loss/(L+1) <= loss`.

This requires no lower bound on D and no restriction on real m. Negative D is covered by the small-scale case in §4, rather than by reversing a power inequality. Z=1 is allowed. The final C depends only on loss,L,b,B,Phi; it precedes the prime types/families, pool, Psi, j, slots/lists/coefficients, W, Z,D,m. It may depend on Phi through its actual Fourier value at zero; no claim of a Phi-uniform numerical constant is made.

The full source hypotheses remain: nonzero generators of maximal prime ideals, pairwise coprimality, distinct ideals, good primes away from lambda, odd residue characteristic and the primary congruence required by the actual ray identity; norm-bounded Psi; pairwise disjoint slot lists and coefficients of norm<=1. Leading underscore names on some binders do not erase their uses in the proof or permit dropping them.

`Inversion/InitialTotalEnergy.lean:70,104–126` instantiates L=cap, b=max(1,b0), B=B0, marks on `all\assigned`, j the assigned element, and W the actual clipped source. It supplies list disjointness by restriction, the same coefficient bound, and the clipped support/norm estimates. D<=cap follows from the assigned-center identity and parent margin. Czero is chosen even before the later q-dependent finite-energy constant. Finally the zero bound `Czero*Z^(m+loss)` is absorbed into `Z^(m+15eta+pi+eps+loss)` times a phase-height factor>=1. The constant becomes `Cfinite+Czero`.

## 6. Exact remaining lower frontier

The inspected branch supplies the zero contribution conditional on the actual arithmetic definitions and identities, without a new spectral or asymptotic premise. It does not by itself prove the entire source-to-Goldbach chain.

* The physical/ray attachment imports the actual Gauss conversion and finite character expansion identities. `CubicSieve/FirstPassage.mobius_second_gauss_restore:442` was read through its algebraic recombination: it uses `active_productGauss_eq_mobius_converted`, `activeConvertedGauss_eq_columnBlocks`, and `convertedColumnBlock_restore`. Their deeper Gauss/conversion/reciprocity proofs were not audited here. `GaussSum/RayCharacters.lean:123,137` reduces its expansions to the fixed quotient/ray character expansions; those lower proofs likewise remain separate.
* The quotient-field multiplicative-character laws, ideal unique factorization/norm multiplicativity, finite bounded-norm ideal sets, the PID generator construction and Eisenstein coordinate norm identities are foundational inputs. Their consuming arithmetic bodies were checked; a whole transitive source or axiom audit was not performed.
* The value `paperRadialFourier Phi 0` is carried exactly into a qualitative constant. No numerical computation of that transform is needed. Identifying the entire original input with its physical mode sum still uses the original Poisson/source identity previously separated in the coverage audit.
* The retained nonzero-frequency energy branch and its moment/tree inputs remain distinct. This zero-mode result does not supply them, nor any infinite-prime-pool limit.

No additional elementary adapter was needed. The notable mechanisms are retaining the Möbius signs until the density product, the source-independent small-power mark bound, and proving the X<1 live-set alternative before using the normalization.

## 7. Whole-file source pins

The following paths are relative to B; line references above identify the inspected bodies.

| Source | SHA256 |
|---|---|
| `Inversion/InitialZeroModeBudget.lean` | `54EF5B0F8B3BBF3C5D8CF7E68411F6B539A2D05A89DDB34D84F744F0C68E4637` |
| `Inversion/InitialZeroModePhysical.lean` | `FF709042F545ED380D504D0D9E61EE03BC75AF2CC0074F99C3365157002A54DE` |
| `Inversion/InitialZeroMode.lean` | `BAB8F68D97EA25D5BB2C2C798408B02149E8CBCEB75EF674CEE2C1CA5B22921D` |
| `Inversion/InitialRayAttachment.lean` | `24DBF037655CB31F79DF0CAC21FF529255A43F5A5C93DBE78054D558E5601613` |
| `Inversion/InitialTotalEnergy.lean` | `15B1B715C4449310DE64E31FA4852233EE85E7B57C1D03F44ED3F78CEE5616F8` |
| `CubicSieve/FrequencyCutoffs.lean` | `C95D42537008177423EF31FA3D849CDB0DBEC93A76923EB27F16719A5A5C4A12` |
| `CubicSieve/FixedProfiles.lean` | `DB3408190882A334DFF6889FB5268FC925CC8A52DC15F8B0100448D8E4F47376` |
| `CubicSieve/SupportNorms.lean` | `5E93D50ED608F55C6A77B2E7284C3CEDBC658A1A9F66F91C27D2CF90B535616C` |
| `CubicSieve/RayCoefficients.lean` | `7661899BF8E3F925540E7B251995B5AEC8DF88AD6E75A8DC10A0FF4DA65C5D8F` |
| `CubicSieve/ConjugateProfiles.lean` | `B44328A089F0D2BD29BFFA76FE503EF25F2CF050DBEF9338994C03833091847C` |
| `CubicSieve/FirstPassage.lean` | `567DAF8EF52B38FFE4396AEE1379127D44B9C68CEA0E07526741649871F38A0D` |
| `QuadraticSieve/TruncatedSecondTransfer.lean` | `946E8749B8833DE99853879BD0D8D8912F7D6781076E5357239578BA32F5629F` |
| `QuadraticSieve/PrincipalDifference.lean` | `DB43BA4F8848D4B6792952A9A5E42FB4B35F05DF2E878067C9892F65953ED64B` |
| `QuadraticSieve/CoefficientCancellation.lean` | `EB0C36E8DA5C04048719CD0C1D0806BD987F19D88FA3B6389EE63A5C8E74A3F0` |
| `GaussSum/ActiveConductor.lean` | `6D162A236C09692CA2FD918947412C0AE89A1D0D7D621DDCEC72AB0BBC399DC6` |
| `GaussSum/SecondPoissonScale.lean` | `60105F7CBAACC19CEC0704164673538A6924E7201F224C321580179FF88FD31A` |
| `GaussSum/SexticRadialPoisson.lean` | `8DB6F0F3B850868F18706630A4F8F1DA42A345D2F0D32949B8D4CC6CB0F5D21C` |
| `GaussSum/RayCharacters.lean` | `06D3516D75D4B624E65E0DA897B8EBA49D0DA492B7956DFC5011FA66CC3BE77D` |
| `GaussSum/RamifiedTracePhase.lean` | `8F8DC82676BAE195CFFC3EDC794106F8506FDE88BB6E828325BC481DAB4F855A` |
| `Descent/Marks.lean` | `5EB91FD55EC8FA2088E61FCC2B7E9BE1A5BCCE7503DF8DAE64E7F877CBAC191B` |
| `Descent/MarkBounds.lean` | `9AD626F163F8932608344057102081870DCB010E6B9EEB8C71C71CADCF9BBD2E` |
| `Arithmetic/SquarefreeDivisors.lean` | `7EC9C941095748C47D3B2D871D10F48C6840BEC6B1A0EC242BC931C7688FA3AB` |
| `Arithmetic/LatticeCount.lean` | `AD7A616017D5EFD2D01A5F38C49C86EAF2F081A0E74CFA17196E5A8010BFD69F` |
| `PrimeRows/IdealGenerators.lean` | `FFD100322A61D78A44F28CE7EDEA6E7CC756D7055C5710B42809B1B2AA016949` |
| `PrimeRows/NormFiberExtraction.lean` | `60D8BA6CAE8F7A5797C6DAE1B72049279673BF18527ED9CC37FCCB5AA741F35B` |
| `Mellin/InverseContour.lean` | `07583B9AD1732A76889CA43FA78BDD98E902E0B41612F68D6CFB5ED4C5166D20` |
| `Hecke/FiniteEulerFactors.lean` | `4F65030622460B1636D6F66C43FB8175E8EF3244502BDBA48C3AAFACB2452716` |
