# Inverse total energy: bounded analytic source audit

Date: 2026-11-11. Scope: the proof below `InverseInitialTotalEnergy.original_input_bound` and its use in `InverseMarkedReferencePaddedEnergy.padded_source_energy`. Source root: `work/openai-math/lean/OAI/NumberTheory/DirichletL`. This follows the previously reviewed `QRH_CERTIFIED_MOMENT_TRANSFER_MATH_AUDIT_2026-11-11.md`; it does not modify that report or extend its verdict to the whole QRH provider.

**Verdict: conditional local-source PASS.** The inspected bodies supply a genuine finite physical estimate, a separately normalized zero-mode bound, and a summable infinite-frequency limit. The padding step preserves the actual marked source polynomial and pays its assigned-tuple factor. I found no default-`tsum`, omitted-zero-mode, normalization, or local quantifier gap in these steps. The canonical rank energy, physical reference inequality, rapid-tail estimate, and part of the logarithmic Fourier transfer remain named analytic leaves, not independently established by this audit. No Lean compilation, axiom audit, numerical evaluation, or spectral certification was performed.

## 1. Actual energy and quantitative input

`CubicSieve/ChildTransfer.lean:164` defines `inputConjugateRow` using `supportConjugateSum`, whose definition at `GaussSum/RayCharacters.lean:293` is the finite sum over subsets of the prime pool of

\[
 \mu(P_A)\,C_A\,\overline{\operatorname{finiteSquarefreeRow}(A,u)}.
\]

`CubicSieve/RayCoefficients.lean:108` defines the coefficient as the multiplicative character of the prime product, an actual coprimality mask, the two fixed finite rows, and the supplied test coefficient. At the inputs `c=d=1`, these fixed rows simplify to one. `Inversion/InitialRayAttachment.lean:131` supplies the actual test

\[
 H(A)=\operatorname{primeMark}(A)\,V(P_A/Z^D).
\]

Thus the target of `InitialTotalEnergy.lean:20` is the norm of the complex Schwartz-weighted sum of squared norms of this row, with amplitude normalization `Z^(-D/2)` and radial argument `||emb(u)||^2/Z^m`. It is not an assumed energy oracle. The theorem permits complex Schwartz `Phi`; its outer norm is essential. Positivity of a specially chosen radial majorant is used only in the subsequent finite-row transfer.

The input includes positive gap, epsilon, pi, eta, tau and loss, `eta<=1`, `eta,tau<=gap/50`, nonnegative cap, at most K slots, pairwise disjoint prime lists, bounded coefficients, an actual periodic multiplicative character, live assigned windows, and a complete finite outside-squarefree pool above `Btree*Z^(cap+1)`. Writing E for the sum of all slot exponents and G for the assigned sum, the decisive real constraints are

\[
0\le m\le\mathrm{cap},\quad D\ge-\mathrm{cap},\quad D=r+E-2G,
\]
\[
r+2E\le m-2\mathrm{gap},\quad 2r+8E\le3m-2\mathrm{gap},
\quad r+E+7\eta\le\mathrm{cap}.
\]

All slot exponents are nonnegative. These imply `D<=cap`; they do not imply or require `D>=0`. Product bounds for the assigned window endpoints and remaining prime-height parameters are separate hypotheses. They are consumed in the retained-window geometry.

The degree and pool multiplier are chosen before q. The positive constant and lower Z threshold may depend on q but are chosen before Z, pool size, lists, finite frequency sets, assignment data, and the modulation theta. The final bound is

\[
C Z^{m+15\eta+\pi+\epsilon+\mathrm{loss}}
 (1+|\theta|)^{2\operatorname{momentOrder}(4\mathrm{degree})}.
\]

## 2. Exact physical normalization and zero mode

`InitialRayAttachment.lean:182` (`initial_product_kernel`) retains all scaling factors: `Z^-D`, `Z^m/||n||`, the divisor factor `1/||e||^2`, and the radial Fourier argument

\[
 K\|h\|^2,\qquad K=Z^m/(\|e\|^2\|n\|^2)>0.
\]

Here n is the active prime product and e the divisor generator. In these formulas `||n||` means `||eisEmbedding n||`, the Euclidean complex norm; its square is the corresponding ideal absolute norm. The same convention applies to e and h. `initial_pair_rays` keeps the conjugate minus column and plus column evaluated at **negative** frequency. `normalized_overlap_mode` and `initial_input_physical` at lines 224 and 249 identify that expression with `initialPhysicalMode` and the original squared row. In particular the amplitude square gives `|Z^(-D/2)|^2=Z^-D`; it is not inserted a second time after Poisson summation. The underlying finite second-Poisson identity is `ChildTransfer.lean:540`.

`InitialZeroModePhysical.lean:22,31,56` handles frequency zero separately. The active Gauss factor vanishes unless the two disjoint active supports agree. Disjointness then forces both to be empty. Summing the remaining terms gives exactly `Z^-D * truncatedSecondZero`, with the divisor Möbius weight still present. The proof does not replace this density by a sum of absolute divisor weights.

A useful independent reconstruction is the coefficient-mass argument in `InitialZeroMode.lean:16`. Put X=Z^D>0 and suppose the window has norm at most B and vanishes above b>0. The prime-mark subpower bound at exponent epsilon/2 and the support count imply

\[
\#\{A:W(P_A/X)\ne0\}\le128bX,
\quad |C_A|\le C_m(bX)^{\epsilon/2}B,
\]
\[
\sum_A|C_A|^2\le128b(C_m b^{\epsilon/2}B)^2 X^{1+\epsilon}.
\]

When bX<1 the live support is empty because prime-product norms are at least one; the source splits this case rather than applying an invalid cardinal bound. `Descent/MarkBounds.lean:23` derives the mark bound from the squarefree divisor subpower estimate, using distinct prime ideals to identify the support cardinality.

The density estimate `QuadraticSieve/TruncatedSecondTransfer.lean:233` bounds `truncatedSecondZero` by `Y*|paperRadialFourier(Phi,0)|` times this mass for Y>0. Its density is nonnegative and at most one. Consequently `InitialZeroMode.lean:87` gives

\[
 \left|X^{-1}\operatorname{truncatedSecondZero}\right|
 \le C YX^\epsilon.
\]

`InitialZeroModeBudget.lean:15` chooses `epsilon=loss/(L+1)` with L>=0, takes X=Z^D and Y=Z^m, and assumes Z>=1 and D<=L. Then `D*epsilon<=loss`, including negative D, so the zero mode is at most `C Z^(m+loss)`. This explains both the normalization and why no positive lower bound on D is needed.

## 3. Finite nonzero modes: retained part and tail

`InitialFiniteEnergy.lean:19` treats arbitrary finite physical source sets with nonzero frequency and the stated divisor/overlap inclusions, and arbitrary weights of norm at most one. Its constant is independent of the cardinality and largest frequency of that finite set.

The retained estimate has two distinct ingredients. `InitialRetainedPhysical.lean:20` calls `actual_physical_reference_bound` and two `canonical_marked_energy_exists` estimates for the two fresh test functions. The source then transfers the rank energies to the actual children using `InitialCanonicalEnergy.initial_child_from_rank`. It retains the two ray twists, row-negation closure, label weights and both child norm relations. The exponent accounting is explicitly

\[
m+11\eta+\pi+(\epsilon+4\eta)=m+15\eta+\pi+\epsilon.
\]

`InitialRetainedWindow.lean` builds the actual windows and checks the required clipping geometry. The zero physical block is a trivial branch; a nonzero block supplies the live-data conditions used for the other branch. `InitialDyadicAssemblyRetained.lean:29,90` bounds all four retained dyadic exponents independently of the temporary frequency cap, then bounds the number of retained windows by `A Z^loss`. `InitialRetainedSum.lean:18` uses the finite triangle inequality, giving the extra loss in the final exponent. Merely counting all dyadic windows below the frequency cap would not have given this uniform conclusion; that is not what the source does.

For the complementary windows, `InitialDyadicTailBound.lean:15` filters to genuinely live physical terms and uses `original_physical_tail_rapid`. In `InitialFiniteEnergy` the chosen tail parameters are `Lcap=2*cap+2` and saving 1. The already derived bounds `0<=m<=cap` and `-cap<=D<=cap` meet its scale conditions. Auxiliary eventual inequalities absorb fixed support sizes. This yields `C_tail Z^-1`; since the target exponent is nonnegative and the height factors are at least one, it is absorbed into the same final bound. The constants of retained and tail estimates are added; no assumed cancellation is used.

## 4. Infinite-frequency passage is a genuine convergent limit

`InitialPhysicalLimit.lean:20` defines a frequency function by finite sums over overlap/divisor indices. `physicalFrequency_finite:26` identifies its finite sum with the finite physical block. The set used for that block is `finiteSource` for exactly the supplied finite frequency set.

Summability is supplied before the limit. `InitialRayAttachment.initialPhysicalMode_summable:298` reduces each mode to `QuadraticSieve/PrimePools.secondPairRadialMode_summable:472`. There, the active Gauss factor is bounded by a fixed canonical Gauss norm (the finite sextic row has norm at most one), while the positive K above makes `paperRadialFourier_lattice_summable_norm` applicable. The finite overlap/divisor sums preserve summability, yielding `physicalFrequency_hasSum:49`.

`original_input_zero_nonzero:76` then splits the actual sum into the zero mode and the sum over nonzero frequencies using this `HasSum`; it does not use Lean's default value for a nonsummable series. `nonzero_frequency_norm_le:92` filters zero from every arbitrary finite test set and invokes `InitialHighFrequencyTailInfinite.norm_tsum_of_finite_bound:21`. The latter is precisely closed-ball passage to the limit: `le_of_tendsto hf.hasSum.norm` applied to the uniform finite-sum bound.

The pool, Z and all source data are fixed during this limiting step. A uniform rate of convergence across all pools is unnecessary: the bound itself is already uniform, and summability is required separately for each fixed datum. Conversely, having a bound only on one chosen truncation would not suffice. The source quantifies over every finite nonzero-frequency set.

Finally `InitialTotalEnergy` adds the zero and nonzero norm bounds and uses `conj(clippedSource W c theta)=clippedSource(conj W) c (-theta)` for the two physical inputs. This supplies the squared height factor without losing the theta sign.

## 5. Marked source transfer and padding

The route from this infinite radial energy to the actual finite marked source is not a change of definitions. `InitialResidualTupleEnergy.lean:24` uses the exact logarithmic Fourier integral identity `original_tuples_excluded_fourier`, with the actual character, excluded ideals, tuple columns and a fresh window equal to one on the live original support. It changes the puncture generator only after proving equality of their principal ideals. Its pointwise integral is then bounded by `InitialTotalFourier.original_fourier_energy_bound`. This last Fourier-energy estimate and the excluded-tuple Fourier identity are explicit deeper leaves of the present audit.

`InitialResidualUniformEnergy.lean:24` constructs one uniform fresh window, then chooses a sufficiently large **finite** complete pool after the tuple data. This is allowed because the energy bound is uniform in every sufficiently large Dpool. There is no unproved infinite-pool limit. The cover obligation for all live tuple columns is furnished by `InitialResidualPool.exists_original_complete_pool:14`.

`Dictionary/InverseMarkedReferenceSourceEnergy.lean:33` applies this to a radial Schwartz majorant with nonnegative real part and equal to one on [0,1], and to the conjugated source function/character with the corresponding sign change of modulation. The exact finite-row comparison is `InitialInputRadial.lean:29`: it first proves summability, uses equality to one on the finite row ball, takes the real part of the infinite energy, applies `sum_le_tsum` to its nonnegative real terms, and finally uses `Re z<=|z|`. It does not require the majorant to be real everywhere. The assigned-tuple aggregation explicitly pays

\[
 A_K=(2^K\operatorname{assignedConstant}(K,2))^2
\]

through `InverseMarkedReferenceMass.original_energy_with_assigned_count:66`. This factor is independent of U and absorbed into the allowed constant. Prime support/disjointness, live assigned windows, admissibility and excluded-prime support are still hypotheses or constructions, not dropped by a generic energy label.

For the final padding, write E for all slot exponents and G for any assigned subset. `InitialMarkedReserve.lean:7,20` selects

\[
\rho=\min(\epsilon_m/4,1/4),\quad g=\rho/4,
\quad\eta=\tau=\rho/400,
\quad\pi=\epsilon=\mathrm{loss}=\rho/16.
\]

With `r>=0`, `r-eta<=rr<=r`, `r+2E<1`, and `2r+8E<3`, put `m=1+rho`, cap=2 and `D=rr+E-2G`. Since `0<=G<=E<1/2`, D>=-E-eta>-2. The two strict original capacities imply the required non-strict padded inequalities with gap g, and `rr+E+7eta<=2`. Rows with squared norm at most U also satisfy the larger bound `U^(1+rho)` for U>=1.

The exponent paid in `padded_source_energy:15` is

\[
\rho+15\eta+\pi+\epsilon+\mathrm{loss}
=49\rho/40\le49\epsilon_m/160<\epsilon_m.
\]

The eventual bound `2^K<=U^eta` supplies the product-of-window-endpoints allowance uniformly for every assignment. Padding therefore creates a fixed reserve even when the original strict capacities are arbitrarily close to their endpoints; it does not select a threshold depending on an unrecorded distance to the endpoint.

## 6. Remaining cut and limits of acceptance

The following proofs must be audited or otherwise justified before upgrading this result to a full provider validation:

- `Descent/CanonicalRankExistence.lean:32`, `canonical_marked_energy_exists`, and the underlying rank-energy proof: this is the substantive child energy supplied to the retained part.
- `Inversion/InitialEnergyCallerReference.lean:23`, `actual_physical_reference_bound`, and its separation/physical comparison; `InitialCanonicalEnergy.lean:48` is the normalization transfer used by the caller.
- `Inversion/InitialHighFrequencyTailRapid.lean:14`, `original_physical_tail_rapid`, including its decay constants and full scale hypotheses. The present audit checks their use, not the entire decay proof.
- The underlying second-Poisson bridge and radial Fourier lattice summability at `CubicSieve/ChildTransfer.lean:540` and `Poisson/RadialFourier.lean:533`. I inspected the explicit mode reduction and positive-scale application, not every earlier Fourier theorem.
- The squarefree divisor subpower estimate below `Descent/MarkBounds.lean:23`; the support count and mark estimate are analytic/arithmetic inputs to the reconstructed zero-mode calculation.
- `Inversion/InitialTotalFourier.lean:21` and `InitialExcludedFourier.lean:21`: logarithmic Fourier energy/inversion between the original polynomial and the normalized input. The actual identity and pool/normalization matching were inspected in the caller; integrability estimates internal to these two proofs remain outside this cut.

No local vacuity was used to conclude an energy bound. Empty or unsupported individual batches can of course give zero, but the statements cover all admissible live data, and the source's finite complete-pool construction is explicit. This does not by itself prove the later contradiction data exist or certify the terminal band; those are separate provider obligations.

## Source pins

The following SHA-256 values bind this audit to the inspected files. Paths are relative to the source root above. Source line numbers identify declaration starts, not a successful elaboration record.

| Source | SHA-256 |
|---|---|
| `CubicSieve/ChildTransfer.lean` | `8312D6CA7409662A55C69D3CBA179EBB047E352E55CFFCF5CFF7C62096310AE2` |
| `CubicSieve/RayCoefficients.lean` | `7661899BF8E3F925540E7B251995B5AEC8DF88AD6E75A8DC10A0FF4DA65C5D8F` |
| `GaussSum/RayCharacters.lean` | `06D3516D75D4B624E65E0DA897B8EBA49D0DA492B7956DFC5011FA66CC3BE77D` |
| `Inversion/InitialTotalEnergy.lean` | `15B1B715C4449310DE64E31FA4852233EE85E7B57C1D03F44ED3F78CEE5616F8` |
| `Inversion/InitialFiniteEnergy.lean` | `A93012D7C56AAFEF323F21058B632584D99C60E4032033ECD5EF3DBE525F6981` |
| `Inversion/InitialPhysicalLimit.lean` | `E134A6C0CC9C484B4495535FBAA298B7F4926DE068A058BDD8E16ED93C1F7241` |
| `Inversion/InitialHighFrequencyTailInfinite.lean` | `DC799D17448ADB67FBDA35D045CF12B0E7D07366206BED350BD6D52FB533EEC8` |
| `Inversion/InitialRayAttachment.lean` | `24DBF037655CB31F79DF0CAC21FF529255A43F5A5C93DBE78054D558E5601613` |
| `QuadraticSieve/PrimePools.lean` | `5C7D9F908A6A5EA19F52E9FE2E514170FB986E5F10298CC041B945139132A11F` |
| `Inversion/InitialZeroModePhysical.lean` | `FF709042F545ED380D504D0D9E61EE03BC75AF2CC0074F99C3365157002A54DE` |
| `Inversion/InitialZeroMode.lean` | `BAB8F68D97EA25D5BB2C2C798408B02149E8CBCEB75EF674CEE2C1CA5B22921D` |
| `Inversion/InitialZeroModeBudget.lean` | `54EF5B0F8B3BBF3C5D8CF7E68411F6B539A2D05A89DDB34D84F744F0C68E4637` |
| `QuadraticSieve/TruncatedSecondTransfer.lean` | `946E8749B8833DE99853879BD0D8D8912F7D6781076E5357239578BA32F5629F` |
| `Descent/MarkBounds.lean` | `9AD626F163F8932608344057102081870DCB010E6B9EEB8C71C71CADCF9BBD2E` |
| `Inversion/InitialRetainedSum.lean` | `1333F109E0BDBCE15EDF180CC34387B4328B01C1B6D495C9EDC39E8E1C281489` |
| `Inversion/InitialDyadicAssemblyRetained.lean` | `2A332AF126B91FA1B2427016F4E2F62A35BAEADA3D8813CCDE421D65DC1FD84D` |
| `Inversion/InitialRetainedWindow.lean` | `432681AE431B9AE27040DCD2187710225213F2424B5F96B4DDF1449AD0B6FAB0` |
| `Inversion/InitialRetainedPhysical.lean` | `6825D15988244817C90F2C106494AB62C64E2967D20A1BB7DB0FD10927097E18` |
| `Inversion/InitialDyadicTailBound.lean` | `A2AF36AE04D612F40CC4FC0ED7E2761C2F31604CB0DAB18F40C246AC061C3795` |
| `Inversion/InitialHighFrequencyTailRapid.lean` | `53FDA6A2E82B6C38E4595C3148BDEAB49235F36F685D8A0960F59BCF01473AED` |
| `Inversion/InitialCanonicalEnergy.lean` | `7FBEF1B68A8F8A85B78E21F1884FF3E9290171EED71E0647A044B9B2A8FC0CCD` |
| `Inversion/InitialEnergyCallerReference.lean` | `F9A70CBD23132AB32AD726C4CBF4C9E5C5C3545DFAAE06B7EFF343C06D01FBB9` |
| `Descent/CanonicalRankExistence.lean` | `7B299DCB2DE3C671BC9C84E5E5D2F3D0CF2D3192D30CADF1A2041867EFD21427` |
| `Inversion/InitialMarkedReserve.lean` | `E7D3537999024AED5699992EE7FBA17702527714B44C87CB635984E4547A6055` |
| `Dictionary/InverseMarkedReferencePaddedEnergy.lean` | `AF3C645DF35997C69F960CFE313241A7F9931B48C130BBB8E854973F0E05ED26` |
| `Dictionary/InverseMarkedReferenceSourceEnergy.lean` | `BD28C13F2C3FB93EBADD64C958BED2FD9AEA8F466DB7C7EC231CCFED5345D159` |
| `Dictionary/InverseMarkedReferenceMass.lean` | `2A5E8A48820D32198EEC154EE9FB6B195DED813E566D57FFAA4AFD4EC4925610` |
| `Inversion/InitialResidualUniformEnergy.lean` | `598BECA7B45B91BCD522B0BAC65FEF736749D6F5B0345FE1749CE6E947BC5FCF` |
| `Inversion/InitialResidualTupleEnergy.lean` | `443C2F7F23BC040396E382A310E683D3E50AF430BD7D10AD33A7F6784CB2B4B3` |
| `Inversion/InitialResidualPool.lean` | `B7B753B2BF4E83E9FEB811B830848BEC14A190FA63839D762999622C28F75071` |
| `Inversion/InitialTotalFourier.lean` | `4BF56C66A5A7E4501927F1A4234F7E82F328491CE1014CE1A9FF014C22ACA39E` |
| `Inversion/InitialExcludedFourier.lean` | `4DF92E397D3C1EE5FFF45E73D0FAD14222E35E516576D65A0A02176F6427A6E5` |
| `Inversion/InitialInputRadial.lean` | `4F4F2D99F5F9CCD356586DECE1B231FFA8B9B89FAB955DE1011EBFADB71EC77E` |
| `Inversion/InitialOverlapHeight.lean` | `4771B24D7373EFC16D5F4AB5C65BC155823BADE57A61DC1BBE25E869A67B19B5` |
| `Poisson/RadialFourier.lean` | `86D5DEB861723EBF182C8A8489EFD29320F97049F4CCB471684C827F931C8E58` |

Context snapshot `work/qrh-blueprint/RESEARCH_CHECKPOINT_2026-11-11.md`: `D7671F6C2531E9F210D38B19CB9560EB3923F223BA67EF6F31ECD181BD23EA47`.

Context snapshot `work/qrh-campaign/agents/zero-sum/QRH_CERTIFIED_MOMENT_TRANSFER_MATH_AUDIT_2026-11-11.md`: `3F5E25D0EC07E868F6DCAC85ADCFFF7D73D50E42A35F40F3BE8E33167F85E6C5`.

