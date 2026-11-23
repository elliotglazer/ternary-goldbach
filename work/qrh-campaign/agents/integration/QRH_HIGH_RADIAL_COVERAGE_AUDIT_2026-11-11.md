# QRH high-radial coverage: actual gate and source reassembly

Date: 2026-11-11. Status: bounded source/paper audit, awaiting independent review. No Lean build, declaration, source change, special-function evaluation or spectral computation was performed. This is not a verification of the full QRH proof or its transitive axioms.

## 1. Result and exact cut

No missing region or uncovered discarded term was found between `original_physical_tail_rapid`, `actual_high_mass_tail`, and the immediate finite-energy decomposition. The split is an exact partition of **dyadic window labels**, not a disjoint partition of physical points. All high labels are combined into one nonnegative weight bounded by one. Equality at the radial cutoff belongs to the retained labels. The source cap and live filters remove only termwise-zero contributions.

The new part beyond the preceding global-tail audit is the actual source coverage: the annular gate supplies the rapid theorem's radial hypothesis; the finite caller supplies its size hypotheses uniformly in every finite frequency set; and a separate genuine summability theorem supports passage to all nonzero frequencies. Zero frequency is added by a different estimate. No limit over prime pools is taken here.

Source base `B` below means `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, at repository commit `4eaee87548250b2682affda7d05d947c05554bae`. A declaration written `Inversion/F.lean:n` is at `B/Inversion/F.lean`, line n. The source hash table binds the complete files, not just the displayed declarations.

Prior accepted cut: `integration/QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `F3DAB6983C136728A4AE0A9467C44397A41F7CA4F476FDB3C16BAA5F5464B0EE`; independent review `moebius/REVIEW_QRH_GLOBAL_TAIL_ANALYTIC_AUDIT_2026-11-11.md`, SHA256 `468EA90C5E52C933700F6E59F1DDB28358B6876D86D6B009103A92E0E6C768CA`. Those paths are relative to `work/qrh-campaign/agents/`. Its radial/Schwartz and lattice estimates are reused, not silently expanded into a full provider proof.

## 2. Exact finite partition, including boundaries

`Moments/SectorLocalization.lean:60–140` builds the dyadic annulus as a difference of cutoffs. Its weights are real, nonnegative, at most one, and supported on the **open** annulus `(2^k/4,2^k)`. For every positive norm only the two adjacent scales can contribute, and their sum telescopes to one. This includes exact dyadic boundaries. `Moments/DyadicCount.lean:13–44,84–92` restricts that sum to the finite closed-box index range `ceil(log₂ a) ... floor(log₂(4b))`; omitted indices have zero weight.

`InitialDyadicAssembly.weight_partition:31` takes the product of the four sums. The four coordinates are common-ideal norm, divisor-ideal norm, overlap-ideal norm, and squared embedded frequency norm (`sourceNorms:50`). Each lies in a positive closed box. Thus the finite four-dimensional partition is exactly one, including endpoints where an individual annulus vanishes. `physicalBlock_partition:79` and `physicalBlock_window_partition:102` distribute this finite sum over the point/ray sums; a `windowSource` restriction only deletes zero cutoff terms.

For a window k set `B=exponent Z k₀`, `theta=exponent Z k₁`, `H=exponent Z k₃`. The radial center is

`R_k = m + H - theta - 2*(D-B)` (`InitialProfile.lean:326`).

`InitialDyadicAssemblyRetained.lean:13–27` defines retained labels by `R_k <= L` and tail labels by `L < R_k`. Their finite sums add to the full window sum. In the actual caller `L=4*eta+tau`. The overlap-coordinate exponent is present in the window but cancels from this radial-center expression through the correlated whole-column estimates; it is not an omitted source coordinate.

`InitialDyadicAssemblyTail.windowMass:16` sums the products of real dyadic weights over any chosen label set. Lines 23–42 establish `0 <= mass <= 1` on the source box. Lines 58–88 identify the sum of the corresponding window blocks with a single physical block weighted by that mass. This avoids a tail-window cardinality loss. A point may contribute to retained and tail windows simultaneously; their masses sum to one.

## 3. Why every removed physical term is zero

`InitialRetainedSupport.live_cutoffs:18` extracts nonzero actual W factors from a nonzero `physicalTerm`. With support bounded above by b, `live_whole_columns:30` gives `C*v*n1 <= b*Z^D` and `C*v*n2 <= b*Z^D`. All five ideal norms are at least one; the divisor norm is at most the common norm. Consequently `live_ideal_caps:51` bounds each ideal coordinate by `b*Z^D`.

`InitialDyadicAssemblySourceCaps.actual_live_caps:31` combines these bounds with any finite-source frequency cap T. The four outer coordinates lie in `[1,bZ^D]^3 × [1,T]`. `InitialDyadicAssemblyLive.physicalBlock_cap_filter:24` therefore removes only points for which **every weighted ray term is zero**. This remains valid when a proposed box is empty: a live term would itself contradict emptiness. `actual_physical_partition:64` then partitions the capped block exactly.

`InitialDyadicAssemblyTail.exists_source_frequency_cap:168` chooses `T=1+sum(x in S) sourceNorms(x,3)`. This is positive also for the empty set. It depends on S; this is harmless only because the subsequent estimates are uniform in T.

`actual_physical_retained_tail:180` is the precise identity used later:

`original block = sum of retained window blocks on capped S + one block on capped S weighted by tail mass`.

For the latter block, `InitialDyadicTailBound.lean:45–120` performs another exact filter: retain x iff some ray rho has `wt(x)*physicalTerm(x,rho) != 0`. Outside that predicate every summand is zero (`physicalBlock_filter_of_live:126`). Inside it, the actual W factors and tail mass are nonzero. This is neither cancellation-based filtering nor replacement of a small term by zero.

## 4. Actual radial lower bound and all rapid hypotheses

On a live tail point, `tail_mass_live_bounds:111` supplies a label with `4*eta+tau < R_k`, `C >= Z^B/4`, divisor norm `d <= Z^theta`, and squared frequency norm `q >= Z^H/4`. Positivity comes from valid nonzero ideals/frequency. The whole-column bounds above imply

`radial(x) = Z^m*q/(d*v^2*n1*n2) >= Z^R_k/(64*b^2)`.

This is `InitialHighFrequencyTailAnnulus.actual_annulus_radial_lower:10`: two common-norm quarter factors and one frequency quarter factor give 64. The bound uses both correlated whole columns, not five unrelated maxima. With `64*b^2 <= Z^eta`, `Z>=1`, `eta>=0`, and `R_k >= 4*eta+tau`, the right side is at least `Z^tau`. `actual_annulus_high_gate:37` proves this conservative implication; there is no need to sharpen its cutoff. `InitialDyadicTailGates.live_mass_radial_gate:58` transfers it through the exact norm-coordinate identities.

`actual_high_mass_tail:15` fixes `(Lcap,saving,tau)` with `tau>0`, then chooses a finite set of Schwartz seminorm indices and C>0 **before** arithmetic types, prime data, finite pool, finite source, source box, W, Phi, weights and scales. Its other assumptions are explicit: valid prime ideals, pairwise coprimality, distinct ideals, odd residue characteristic, primary-generator congruence, norm-bounded character and disjoint slot lists with coefficients of norm at most one. The congruence is used by the live-support extraction even though the underlying rapid statement needs fewer hypotheses.

It invokes `original_physical_tail_rapid:15` with `L=max(1,bZ^D)`. From `Lcap>=0`, `bZ^D<=Z^Lcap` and `Z>1`, one has `1<=L<=Z^Lcap`. The five ideal bounds, two whole-column bounds, `-m<=Lcap`, `m-D<=Lcap`, and the actual radial gate now match the theorem. `pointSource_supports:24` and `sourceKey_norm_coordinate:42` supply the exact finite support and norm carriers. Finally `|wt|<=|w|<=Gamma` follows from mass<=1. The output is

`||tail block|| <= C*Gamma*B1*B2*(finite Schwartz seminorm maximum of Phi)*Z^(-saving)`.

This covers the designated high-window contribution. It does not assert that every point with radial argument >=Z^tau lies only in the tail; such points may legitimately remain in the retained estimate.

## 5. Actual finite caller: constants and exponents

`InitialFiniteEnergy.finite_physical_bound:19` selects the retained estimate and the tail estimate at lines 64–67, using `Lcap=2*cap+2`, `saving=1`, and the same tau. Its fixed assumptions include cap>=0, positive gap/eps/pi/eta/tau/loss, eta<=1, and eta,tau<=gap/50. Here pi denotes the source's positive loss parameter, not the circular constant.

For fixed W1,W2,Phi and the other theorem parameters, degree and Btree are chosen before q; for each nonzero q, C and Z0 are chosen before Z, prime pool, finite source, frequency cap, clipping phases and slot data. The actual arithmetic/slot hypotheses remain those of the theorem; this audit does not delete them. In particular the two parent margins and assigned/remaining product constraints are passed to the retained estimate.

Write `bbar=max(1,b0)`. For sufficiently large Z, `bbar<=Z` and `64*bbar^2<=Z^eta`. From the assigned-center identity and parent inequality the source derives `D<=cap`. Together with `0<=m<=cap` and `D>=-cap`, this gives

`bbar*Z^D <= Z^(D+1) <= Z^(2cap+2)`, `-m<=2cap+2`, and `m-D<=2cap+2`.

The clipped weights have support <=bbar and norm<=B0. After selecting the finite-source T, the exact identity in §3 is applied. The retained term is bounded uniformly in that T by `InitialRetainedSum.retained_sum_bound:18`; the tail is bounded by `tailC*Z^-1`. Since the phase-height factor is >=1 and `m+15eta+pi+eps+loss>0`, the tail is absorbed into the same final bound:

`(Cr+tailC)*Z^(m+15eta+pi+eps+loss) * product_i (1+||theta_i||)^momentOrder(4*degree)`.

There is no extra factor counting high windows. The retained side does pay its explicit `Z^loss`: `retained_exponents_eventually:29` bounds all four retained exponents independently of T (the radial inequality bounds H), and `retained_card_subpower:90` applies the logarithmic finite-window count. This dependence is essential; a bound whose constant depended on T would not support §6.

## 6. Coverage of the original finite and infinite frequency expressions

`InitialPhysicalReassembly.finiteSource:104` includes exactly `G subset pool`, `E subset G`, `V subset pool\G`, and each frequency in an arbitrary finite set F. `mem_finiteSource:115` characterizes the carrier; `sourceOfCode_injective` prevents multiplicity loss in the image. `pointSource` adds the full ordered rectangle of remaining left/right prime subsets. These left/right sets are not required to be disjoint. Exact Mobius reindexing in `InitialPhysicalMeasure.original_ray_common_insertion:304` handles the original disjoint pair condition instead.

`rectangle_restore_common:52` adds the extra rectangular terms only when the actual coprime mask makes them zero. `finite_physical_reassembly:141` then identifies the original finite frequency expression with precisely the physical block accepted above, with weight one, W1=conjugate W and W2=W. This is full finite-source coverage, not a representative collection of frequencies.

The rapid theorem itself is finite. The infinite passage is supplied separately by `InitialPhysicalLimit.physicalFrequency_hasSum:49`. It takes finite sums of the genuine `initialPhysicalMode_summable` theorem (`InitialRayAttachment.lean:298`), then `nonzero_frequency_norm_le:92` applies the bound for **every** finite set after filtering out zero. `norm_tsum_of_finite_bound` is used only after constructing Summable for that zero-deleted function. There is no default-tsum or unproved exchange of infinite sums.

One lower layer was checked: `QuadraticSieve/PrimePools.secondPairRadialMode_summable:472` uses positive scale `Y/(||e||^2 ||n||^2)`, nonzero prime products, the established norm-summable radial lattice kernel, and the bounded finite Gauss/row factor. Its comparison is an actual summable majorant. `InitialRayAttachment` multiplies by the fixed normalization/overlap coefficients and rewrites the normalized modes. The original-input identity still imports the Poisson identity and its exact normalized-mode identification; these foundations were not reproved in this audit.

`InitialTotalEnergy.original_input_bound:20` uses that all-finite-set bound for nonzero frequencies and adds `InitialZeroModeBudget.physical_marked_zero_bound:15`. The latter is a separate `Cz*Z^(m+loss)` estimate, absorbed into the final exponent and height factor. `original_input_zero_nonzero:76` supplies the exact zero-plus-nonzero identity. Both clipping phases have equal norms after conjugation, explaining the single-phase exponent `2*momentOrder(4*degree)` in the total-energy conclusion.

## 7. What remains, and what this audit does not establish

* The complementary retained labels, including the equality boundary, require `InitialRetainedWindow.retained_window_bound:19`: its canonical state, clipping, support domains and energy/tree estimates remain substantive inputs. The current audit checks their placement and T-uniform consumption, not the full retained theorem.
* Zero frequency is not covered by rapid decay. Its marked/normalized zero-mode analysis remains separate.
* The exact original-input Poisson identity, finite Gauss/row arithmetic and the underlying radial Fourier/lattice facts remain source-level analytic foundations. The previous global-tail audit reconstructed the radial/lattice cut; no build or transitive axiom validation was performed here.
* The finite source and prime pool are arbitrary subject to the theorem's support and arithmetic hypotheses. The infinite frequency statement is for each fixed finite prime pool. No infinite-prime-pool theorem or missing limit is inferred.
* Source bodies establish a coherent conditional implication at this cut. They do not independently validate every supplied canonical slot/moment hypothesis, the full QRH provider, or the unchanged final Goldbach roots.

No new mathematical adapter was needed: the source already contains the necessary finite reassembly and summability passage. The useful correction to the earlier frontier is that the actual consumer does supply that passage; it must remain explicitly distinguished from `original_physical_tail_rapid` itself.

## 8. Whole-file source pins

Paths below are relative to B. Line spans above identify the inspected mathematical bodies; the hashes bind their complete containing files.

| Source | SHA256 |
|---|---|
| `Inversion/InitialHighFrequencyTailRapid.lean` | `53FDA6A2E82B6C38E4595C3148BDEAB49235F36F685D8A0960F59BCF01473AED` |
| `Inversion/InitialDyadicTailBound.lean` | `A2AF36AE04D612F40CC4FC0ED7E2761C2F31604CB0DAB18F40C246AC061C3795` |
| `Inversion/InitialDyadicTailGates.lean` | `C52D01D0D3098FE1DE0CB11491BD6220F144EB75D5A77F896024FE7B877998D8` |
| `Inversion/InitialHighFrequencyTailAnnulus.lean` | `F6655F20790F789043052A10B0F11B41B07FF86280CB79355EB35F8AE4DFF9D7` |
| `Inversion/InitialProfile.lean` | `83B1C5FEC03CCE64C50DE747EA3F3F518A1569633B35592A67D89E79D57ECA19` |
| `Inversion/InitialDyadicAssembly.lean` | `ADCB9F1CE81EE71DD5C870C0656D7F58B9E10DC07FDED1AB73831C7B2D0F607F` |
| `Inversion/InitialDyadicAssemblyTail.lean` | `803B67774E526D6089F223DB95C774428B2830963242029E150C4A8F2CC11C69` |
| `Inversion/InitialDyadicAssemblyRetained.lean` | `2A332AF126B91FA1B2427016F4E2F62A35BAEADA3D8813CCDE421D65DC1FD84D` |
| `Inversion/InitialDyadicAssemblyWindows.lean` | `42C53BDDBEF765738AEA4FC7B1FC7744D969310902E9E2406B6A892BC25FED67` |
| `Inversion/InitialDyadicAssemblyLive.lean` | `60FD41CD2EB70E136532879F5DAF2ADC37BC60011AEA002850F37EE997C4DACC` |
| `Inversion/InitialDyadicAssemblySourceCaps.lean` | `AA2DB5E2FDDD5110C794DC8852BF3766089B807DFDEA2F4FCA2CAE2D1799F610` |
| `Inversion/InitialRetainedSupport.lean` | `C4D70957B3F7478D4441F86F7AB607036C63976682838B392450779A4DAE625D` |
| `Inversion/InitialEnergyCallerSource.lean` | `2DDF8A8D9CBD5CBBF54C96D888EB5770AF7244D073CC3DC6B383AC08CBA53365` |
| `Inversion/InitialFiniteEnergy.lean` | `A93012D7C56AAFEF323F21058B632584D99C60E4032033ECD5EF3DBE525F6981` |
| `Inversion/InitialRetainedSum.lean` | `1333F109E0BDBCE15EDF180CC34387B4328B01C1B6D495C9EDC39E8E1C281489` |
| `Inversion/InitialRetainedWindow.lean` | `432681AE431B9AE27040DCD2187710225213F2424B5F96B4DDF1449AD0B6FAB0` |
| `Inversion/InitialPhysicalReassembly.lean` | `2B3024A6AB5EE3D35BECCF45FFE078B4C520A1C94198657E41DDE1FA1FAAB973` |
| `Inversion/InitialPhysicalMeasure.lean` | `4E34DE8B8777EBB75998F7B484643D4DA6D63F222C352C531655836D0D8B0751` |
| `Inversion/InitialPhysicalLimit.lean` | `E134A6C0CC9C484B4495535FBAA298B7F4926DE068A058BDD8E16ED93C1F7241` |
| `Inversion/InitialRayAttachment.lean` | `24DBF037655CB31F79DF0CAC21FF529255A43F5A5C93DBE78054D558E5601613` |
| `Inversion/InitialTotalEnergy.lean` | `15B1B715C4449310DE64E31FA4852233EE85E7B57C1D03F44ED3F78CEE5616F8` |
| `Inversion/InitialZeroModeBudget.lean` | `54EF5B0F8B3BBF3C5D8CF7E68411F6B539A2D05A89DDB34D84F744F0C68E4637` |
| `Moments/DyadicCount.lean` | `1A6DDE7DAABA53251D8A333BF222831D49A2CB6FDF6D42FB378A54C3D1915EF8` |
| `Moments/SectorLocalization.lean` | `181462EC0585529C9D72C6CBC714668C9BB5F9BA0067F4868DEF1088C7ADFC6F` |
| `QuadraticSieve/PrimePools.lean` | `5C7D9F908A6A5EA19F52E9FE2E514170FB986E5F10298CC041B945139132A11F` |
