# Retained-source push and live-key count

Date: 2026-11-11. Scope: source and paper audit only. No Lean declaration, build, function evaluation, or source modification was performed.

The three requested transfers are sound at the bounded scope checked here. The retained-source estimate pays actual multiplicity through a squarefree-divisor fiber bound. The global estimate preserves outer multiplicity through a dependent-pair source. The live-key estimate counts occupied dyadic boxes after an exact partition of the original sum. These are different operations; the proof does not replace a many-to-one source map by an injection.

This finding is conditional on the imported arithmetic row identities and smoothed second-Poisson identity identified below. It does not certify the four child moment inputs, terminal energy induction, or the full QRH provider.

## 1. Exact targets and source semantics

All source paths below are relative to work/openai-math/lean/OAI/NumberTheory/DirichletL. The hash table freezes the files read; a file hash does not mean every declaration in that file was audited.

Descent/FirstActualSecondEnergy.lean:46, first_retained_actual_second_energy, chooses a positive constant after an arbitrary positive exponent epsilon and before all actual data. These data include the index type, prime generators, finite pool, cube, common set, multiplicative twists, labels, coefficients, scale, height, selector and window. Its conclusion is

\[
 E_{\rm retained}\leq \Gamma K_\epsilon Y^\epsilon
 E_{\rm canonical\ second}.
\]

The hypotheses include nonzero maximal prime generators, distinct prime ideals, pairwise coprimality, the excluded bad prime, residue characteristic different from two, the stated primary-generator condition, norm bounds on both multiplicative twists, squarefree nonzero label ideals, \(Y>0\), \(X>0\), and \(\|a(x)\|\leq\Gamma\) on the actual retained source, with \(\Gamma\geq0\). They are used, not inferred from a generic source name.

The coefficient loss is linear in Gamma. The energy sums \(\|w(x)\|\|P(x)\|^2\); this theorem does not square its coefficient bound. A later application whose coefficient itself is a product must supply the appropriate product bound.

The canonical second energy is the definition at FirstActualSecondEnergy:16. It retains both ray labels, every \(D\subseteq F\), \(\|\mathrm{crossCoeff}\|\), the absolute selector weight, every core label and its absolute outer coefficient, the factor \(32\cdot512\), and the real part of the actual fresh second-Poisson expression. Positivity is proved at line 26 through its physical-row identity.

Descent/FirstOriginalProfileUniform.lean:85, first_global_retained_push_uniform, makes the same constant choice before both index types and all outer data. Its right side is the sum of these canonical second energies over the finite outer set, multiplied by \(\Gamma K_\epsilon Y^\epsilon\). It does not remove that outer sum.

## 2. Physical support and the paid fiber

FirstRetainedFamily:12 defines the retained source by a union over label ideals \(f\), with the image of each nonzero child-frequency ball under \(h\mapsto(f,h)\). The membership and sum lemmas at lines 18 and 25 retain the label coordinate. The union fibers are disjoint because their first coordinates differ; the within-fiber map is injective.

Write \(e\) for the actual cube dilation label and \(g_f\) for the chosen ideal generator. The physical row map is

\[
 (f,h)\longmapsto y=h\,g_f^2 e.
\]

Mellin/ReflectedKernel.lean:558 defines precisely this map. FirstCanonicalEnergy:39 uses the actual multiplier identity to prove that a retained row maps into the nonzero child-frequency ball with multiplier one. In particular \(y\ne0\) and \(\|\operatorname{eisEmbedding}y\|^2\leq Y\). The squared Euclidean embedding norm is the element's algebraic norm here; it is not an additional squaring of the ideal norm.

Arithmetic/SquarefreeDivisors.lean:140 proves the needed fiber bound. On the fiber above a nonzero \(y\), projection to \(f\) is injective: for fixed \(f\), the equation \(h g_f^2 e=y\) forces \(g_f^2e\ne0\), and cancellation recovers \(h\). Moreover \(f\) divides the principal ideal of \(y\). Since \(f\) is squarefree, the fiber injects into the squarefree divisors of that ideal. No uniform bound on all label ideals is silently substituted.

Lines 78–138 bound these divisors by \(2^{\#\operatorname{primeSupport}(I)}\) and then by \(C_\epsilon N(I)^\epsilon\). The second step splits primes at a fixed norm threshold chosen from epsilon. There are finitely many small prime ideals; each large prime pays its factor two from its norm to the epsilon power. Their squarefree product divides \(I\), so its norm is at most \(N(I)\). Thus the constant depends on epsilon, not on the ideal, pool, dilation or label set.

The finite weighted pushforward at ReflectedKernel:488 is an exact grouping by fibers followed by

\[
 \sum_{x:f(x)=y}\|w(x)\|
 \leq \Gamma\,\#\{x:f(x)=y\}.
\]

SquarefreeDivisors:192 applies this with the preceding row map and \(N(y)\leq Y\). Consequently

\[
 \sum_{x\in S}\|w(x)\|\,\|P(f(x))\|^2
 \leq \Gamma C_\epsilon Y^\epsilon
       \sum_{y\in T}\|P(y)\|^2 .
\]

This is a finite identity and inequality. There is no infinite sum convention or unproved injectivity of the entire map in this step. An empty source or fiber is covered by the same argument.

## 3. Actual column, core and second-Poisson transport

FirstCanonicalEnergy:17–37 defines the retained coefficient as the original coefficient times the actual cube outer factor and cube base factor. Their norm bounds give \(\|w\|\leq\|a\|\). FirstOldEnergy:15 similarly retains the ray cross coefficient and selector while bounding the remaining masks by one.

FirstCommonChild:72 identifies the original column with the support-ray factor, the before-dilation factor, and the actual dilated core row at \(h g_f^2e\). Both exterior factors have norm at most one. The row uses the negative height \(-t\), the window \(u\mapsto\omega(\exp u)\), and the logarithmic column at \(\operatorname{primeProductNorm}(D)X\). The sign follows FirstCommonChild:56; it is not a freely changed Fourier convention. FirstFreshEnergy:12 applies the fiber inequality to this exact identity. FirstOldEnergy:39 then interchanges only finite sums over the source, ray labels and subsets.

CubicSieve/IntegratedTransfer.lean:151 applies finite weighted Cauchy to dilatedCoreRow_eq_input_family, followed by firstCoreOuter_mass. This yields

\[
 \|\mathrm{dilatedCoreRow}\|^2
 \leq(32\cdot512)\sum_{\rm core}
        \|\mathrm{firstCoreOuter}\|
        \|\mathrm{firstCoreInputRow}\|^2.
\]

The core mass is paid explicitly, rather than absorbed into an unspecified constant independent of the index set. At IntegratedTransfer:135, firstCoreOuter_mass bounds each outer factor by its coreRayCoefficient times the twist norm, uses that norm at most one, and sums coreRayCoefficient_mass over the product index. The underlying core-ray mass calculation and the exact decomposition remain named lower dependencies of this audit.

The next enlargement is justified by an actual compactly supported majorant. RowMajorants:184–214 proves that its real part is nonnegative, it equals one for \(|s|\leq1\), and it vanishes for \(s>2\). On input \(s=\|\operatorname{eisEmbedding}z\|^2/Y\), \(Y>0\), the weighted row has finite support in rowMajorantBall \(Y\), defined with radius parameter \(\lceil2Y\rceil\). Thus its summability holds even for an arbitrary row function \(P\).

RowMajorants:220 extends the finite row sum to this nonnegative physical energy. Line 247 then uses firstCoreInputRow_smoothed_second_poisson. FirstPriorityEnergy:16 records the resulting equality

\[
 \Re(\mathrm{firstFreshSecondPoisson})
 =\sum_{z\in\mathrm{rowMajorantBall}(Y)}
   \Re\!\left(\mathrm{rowMajorant}
          (\|\operatorname{eisEmbedding}z\|^2/Y)\right)
   \|\mathrm{firstCoreInputRow}(-t,z)\|^2.
\]

This proves nonnegativity and explains the occurrence of the real part on the spectral side. It does not assert that each complex summand there is positive. The fresh second expression includes its full modes; deleting zero modes or later large-frequency tails would need the separate two-pass estimates.

For height integration, IntegratedTransfer supplies continuity, a height-independent finite bound on each row, and integrability after multiplication by an integrable scalar density. RowMajorants:269 uses the finite majorant support. The pointwise push itself does not need an unproved Fubini step. The foundational smoothed Poisson equality, including its normalization, is retained as a lower cut rather than inferred from summability alone.

## 4. Global outer multiplicity

FirstGlobalPush:13 defines a dependent-pair source over the outer finite set. Two distinct outer labels remain distinct even when their local \(f,h\) data agree. FirstOriginalProfileUniform:85 expands this source with Finset.sum_sigma, applies the same uniform local estimate at each outer label, and factors out the common nonnegative \(\Gamma K_\epsilon Y^\epsilon\).

There is no additional outer-cardinality factor because the complete outer sum remains on the right. There is also no merging of two outer labels into one source term. The same constant works because its existential choice precedes both index types and all local data. It is independent of the actual height, window and selector, whose dependence remains in the energies.

## 5. Live keys partition terms before counting boxes

FirstOriginalProfileLivePartition:15–24 defines a joint key consisting of a six-coordinate SourceIndex and two further natural-number dyadic indices. The live keys are the image of the filtered pairs \((x,j)\), with \(x\) an actual original retained source and \(j\) an actual common index, for which the actual source summand is nonzero.

The sum_live_joint_cells and joint_cell_eq_refined proofs, culminating at line 78, partition the full sum exactly. Every nonzero summand belongs to its unique key; zero summands can be omitted. All source pairs with that key still occur in the corresponding cell sum. The map from source pairs to keys need not be injective.

FirstOriginalProfileLiveCount:14 bounds the image by a box once all eight indices are at most \(B_0\). The box cardinality is \((B_0+1)^8\). Line 39 converts positive norm caps into index caps using monotonicity of the natural floor of \(\log_2\). Thus this is a count of occupied boxes, not a count of source pairs.

The norm caps are obtained from actual nonvanishing. FirstLiveCaps:39 uses the two original \(W\)-factors in firstNormProfile. Their arguments are products of four quantities at least one. A nonzero profile forces both arguments into the upper support of \(W\); a factor of either product is therefore at most \(L\). No positivity or lower amplitude of \(W\) is required.

FirstLiveNorms:18 carries this through the actual divisor and cube labels. The six source norms are bounded by

\[
 (L,L,L,LB^2,B^2,Y),
\]

and the two additional quantities are bounded by \(L\) and \(B^2\). Here \(B\) bounds each input cube norm, the whole support norm is at most \(B^2\), and the quotient divisor and active support keep their actual divisibility relations. The frequency bound uses the nonzero physical multiplier and norm divisibility; it does not assume that multiplier is a unit. The resulting common cap is

\[
 R=\max\{Y,L,LB^2,B^2\}.
\]

FirstOriginalProfileLiveSupport:43 handles the height twist. A nonzero normTwistedSource value forces the underlying \(W\) value to be nonzero, so the same support implication holds uniformly in the twist parameter theta. Arbitrary coefficients, cutoffs and selectors may kill additional terms but cannot create a nonzero original profile outside this support.

## 6. Explicit small-power budget and quantifier order

FirstLiveCountBudget:13–115 proves the scalar estimate independently of the arithmetic data. Set

\[
 L=bZ^r,\quad B=Z^{\ell+\eta},\quad
 Y=Z^{2F+15\eta+\tau}.
\]

The assumptions are \(b,L_{\rm cap}\geq0\), \(Z\geq2\),
\(r,\ell\leq L_{\rm cap}\), \(0\leq F\leq L_{\rm cap}\), and
\(0\leq\eta,\tau\leq1\). No lower bound on \(r\) or \(\ell\) is added. They imply

\[
 1\leq R\leq \max(1,b)Z^{3L_{\rm cap}+16}.
\]

The lower bound follows from \(Y\geq1\). Put \(b_0=\max(1,b)\), \(A=3L_{\rm cap}+16\), and

\[
 c_0=1+\frac{\log b_0}{\log2}+\frac A{\log2}.
\]

Then

\[
 (\lfloor\log_2 R\rfloor+1)^8
 \leq c_0^8(1+\log Z)^8
 \leq c_0^8(1+8/\epsilon)^8 Z^\epsilon .
\]

The last step uses \(\delta=\epsilon/8>0\),
\(\log Z\leq Z^\delta/\delta\), and \(1\leq Z^\delta\). This reconstructs an admissible explicit positive constant; the source packages it existentially.

At line 117, original_live_joint_small_power selects this constant after only \(b,L_{\rm cap},\epsilon\), before the type, prime system, pool, cube collection, label set, coefficient function, cutoff, multiplicative twist, mark, \(W\), Schwartz function, all scales and theta. Its extra actual-source assumptions are the cube norm cap, nonzero label ideals and the upper-support implication for \(W\), together with the displayed prime-system conditions.

Squarefreeness of labels is essential to the earlier retained push but is not a hidden premise of this live-key bound. The distinction prevents one theorem's hypotheses from being silently transferred to the other.

## 7. Remaining boundary and audit verdict

The finite support maps, fiber multiplicities, coefficient bounds, Cauchy application, compact-majorant enlargement, global dependent-pair sum, live partition and scalar small-power absorption were reconstructed from their bodies. No missing cardinality factor, height-dependent constant, default infinite-sum argument, or unjustified injection was found.

The audit stops at the underlying arithmetic identities rayIdealRow_cube_labels at CubicSieve/KernelEnergy:352 and dilatedCoreRow_eq_input_family at CubicSieve/ChildTransfer:626; the local Gauss/CRT and cube-label proofs supporting their norm bounds; and coreRayCoefficient_mass below the checked outer-mass reduction. IntegratedTransfer:404 reduces the smoothed first-core identity to inputConjugateRow_smoothed_second_poisson; its masked_pair_second_poisson foundation at CubicSieve/SecondPoisson:83 remains a lower cut. The finite ideal divisor encoding and ideal norm multiplicativity are used as source lemmas. The child moment hypotheses and later spectral-tail estimates are not conclusions of these transfers.

Consequently this is a conditional local-source PASS, not a claim that the entire analytic provider or QRH implication has been verified.

## Source pins

SHA-256 hashes below freeze the relevant source version. Paths have the common source prefix stated in section 1.

| Source file | SHA-256 |
| --- | --- |
| Descent/FirstActualSecondEnergy.lean | 0CD117E9B837C9287C271D0A7F953980E9D4A832174B4B09D7BA050AC174CF27 |
| Descent/FirstOriginalProfileUniform.lean | 290D551BA435B4EDA0CE5A7DDFACE6E89D2EB9E2F2991D83BDA2628C81648B01 |
| Descent/FirstRetainedFamily.lean | 72A993A98654FA3E92FC307E124542DBD6223C94587724E11A858793765F09C5 |
| Descent/FirstGlobalPush.lean | 2640DF1898DB74A03804570260A33768F72F9586E131014F9239BDF4AE202604 |
| Descent/FirstCanonicalEnergy.lean | A2ABE6F0FF28941AAEC2F14189798DEA03D2C175FC397D726D94E722204573B6 |
| Descent/FirstFamilyToSecond.lean | F415508B44453E9B01903919611B10B1A8C659E66C7C2CA83E36ADD262252FA4 |
| Descent/FirstOldEnergy.lean | 79A6D4B4E4628077E595F55A20058B838EC473DA54D7283671AACC014B760ECE |
| Descent/FirstFreshEnergy.lean | C833B3B2F50BB3088216504C7CBB83E0530FFFEE1E99A0705BF8E57DA1E136B9 |
| Descent/FirstCommonChild.lean | D7FA423778D3248EBE8020CE7F50C45F04758861D4B20A566304DAC71EDDDAFA |
| Descent/FirstToSecond.lean | ECE2B2CA8D769332C840A9B0AEAE0CBCACBC718D585087EDCF02144F37515DE5 |
| Descent/FirstPriorityEnergy.lean | 4D80D37CA5A42522C3CF89C89E9A861A484BF42B11A6B5B7CF61883605921FFA |
| Descent/FirstOriginalProfileLivePartition.lean | DC3FF1AD682A124FD3D7C29CD8FE9D2178A3933B91C923FB33B77FEFD9806841 |
| Descent/FirstOriginalProfileLiveCount.lean | 4C270FA553FF9907BF618E8D4AA05B743F1C55D410873045BE74C6E9213494DF |
| Descent/FirstLiveCaps.lean | F166377A91A6CD22F8321CC024C9BF9D6FA06B83B1EFCAC26BF1783F8EA52FAE |
| Descent/FirstLiveNorms.lean | B55E24E9284D143398613EC84634F20D130B50F71A08AE00E78D6F1FB7B82D79 |
| Descent/FirstOriginalProfileLiveSupport.lean | C868F65BA6C4E51694B8B0F1FBF048BBB18D751A7E92E4FF15AB59E73450C405 |
| Descent/FirstLiveCountBudget.lean | 2469D397686044D2962C1940CD1D45210447D98ECE00A721FDFA4CAB4C9561C8 |
| Arithmetic/SquarefreeDivisors.lean | 7EC9C941095748C47D3B2D871D10F48C6840BEC6B1A0EC242BC931C7688FA3AB |
| Mellin/ReflectedKernel.lean | 7BE20D70C76E58BB08CB2909EDD09B96A0B1E7ED92BEEABEEAC0928F0B131D52 |
| CubicSieve/RowMajorants.lean | 591B439E64B09A6FE881A8FB648424E44AF67C9DD43FF3F38B5599836ADC88B6 |
| CubicSieve/IntegratedTransfer.lean | 4139A54D28C9F875721396961818736A8DF75FDD8598428448B78AFD98795499 |
| CubicSieve/KernelEnergy.lean | C884D02BE56E92D79EDD4C6F6821359880483CE57C247EEF49E30298F56DD6D0 |
| CubicSieve/ChildTransfer.lean | 8312D6CA7409662A55C69D3CBA179EBB047E352E55CFFCF5CFF7C62096310AE2 |
| CubicSieve/SecondPoisson.lean | 53007B41EE56A39DD8DA4877EB3890D90C1D6F353727683001FA018D7FDCCF39 |
