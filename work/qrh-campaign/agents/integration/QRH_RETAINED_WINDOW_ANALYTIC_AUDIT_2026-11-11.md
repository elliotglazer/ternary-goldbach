# Actual retained-window estimate: source and mathematical audit

Date: 2026-11-11. Scope: bounded proof-body audit, not a Lean build, axiom audit, or validation of the whole QRH provider. No numerical evaluation, Lean declaration, source edit, or change to final premises. The source root below is `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, commit `4eaee87548250b2682affda7d05d947c05554bae`. The final table pins the files actually inspected.

## 1. Result and exact target

No local defect was found in the retained-window join inspected here. The source file is **InitialRetainedWindow.lean**, not RetainedWindow.lean. Its `retained_window_bound:21` bounds the actual finite `physicalBlock` on `pointSource Finset.univ (windowSource ...)`, with source weights pulled back by `erasePoint`, the assigned element, and the remaining-slot prime mark. It concludes

`||physicalBlock|| <= C Z^(m+15 eta+piLoss+eps) (1+|theta1|)^momentOrder(4 degree) (1+|theta2|)^momentOrder(4 degree)`.

Here `piLoss` denotes the source's arbitrary positive real binder `π`, **not** the circular constant. This is an absolute upper bound, not a saving relative to `Z^m` by itself. Small losses are chosen later. The Schwartz profile may vanish, the finite source may be empty, and the physical block may be zero; no nonvacuity of every input is asserted or needed.

The new work in this cut is the actual window-to-canonical-state geometry, opposite-energy/fiber-mass comparison, common integral, clipping and normalization ledger. The earlier canonical-rank, short-energy, two-pass, and retained-push audits remain the lower analytic inputs listed in §8. The original trace-normalized Poisson identity is a separate boundary; it is not reproved here.

## 2. Constants and meaningful hypotheses

Fix smooth positive-compact-support profiles W1,W2, a Schwartz radial profile Phi, a dilation cap bcap>=1, four positive compact window intervals, nonnegative cap and U, positive gap, eps and piLoss, and slot bound K. The theorem first chooses `degree`, `Btree>=1`, and `Tclip>=0`. **Only then**, for every nonzero natural q, it chooses C>0 and Z0>1. All subsequent choices are uniform: Z>=Z0, the integer pool size Dpool>=Btree Z^(cap+1), slot type, lists, coefficients, assigned elements, character, finite source, window functions, real window exponents, clipping modulations and source weights. C and Z0 may depend on q; degree/Btree/Tclip do not.

The pool is the actual `outsideSquarefreeIdeals (reflectionExcludedPrimes q) Dpool`, with actual nonzero, primary, distinct coprime prime generators. Remaining slot lists are pairwise disjoint; their prime norms have bounds Hslot>=1 and their coefficients have norm<=1. Their product bound is `prod Hslot <= Z^(assignedCenter(remaining)+eta)`. The base character has norm<=1 and factors through the fixed conductor attached to q. Assigned elements are nonzero and their actual smooth weights are nonzero, with product of support upper endpoints <=Z^eta. These are used to bound their product's norm; one cannot replace them by mere labels.

Every finite source element has divisor contained in common and nonzero frequency. The four window supports satisfy hi_i<=Z^eta and lo_1>=Z^(-eta). Other conditions are eta>=0, eta<=gap/50, tau<=gap/50; the single-window theorem does not separately require tau>0. Its decisive state hypotheses are, writing Zall for the sum of all slot exponents and G for the assigned sum,

`D=r+Zall-2G`, `r+2Zall<=m-2gap`, `2r+8Zall<=3m-2gap`,

`r+Zall+7eta<=cap`, `B-theta+2eta<=U`, and `radialCenter=m+H-theta-2(D-B)<=4eta+tau`.

Also `Tclip<=3eta log Z`, and 1<=c1,c2<=bcap. These last conditions give a uniform nonnegative clipping shift, not an unproved compactness assertion depending on the source.

## 3. Actual windows, filtering, and full puncture

`InitialEnergyCallerFixedWindows.exists_actual_initial_windows:30` constructs one fresh positive-support Schwartz cutoff and six compact logarithmic cutoffs before any source data or clipping modulation. It uses fixed window geometry and the bounds on log-support of W1,W2 (`log_source_support:16`). The conclusion is `BlockSupport`: the fresh column weights equal one wherever the corresponding original clipped factor is nonzero, and the six logarithmic cutoffs equal one on the resulting active coordinates. This is exact support replacement, not approximation.

`InitialEnergyCallerSourceMask.physicalBlock_coprimeSource:22` deletes only terms with overlap/common ideals not coprime. Each such term's actual `outerCoefficient` is zero. On the remaining source, divisor inclusion then makes the child label squarefree. This filter is necessary to invoke admissible canonical labels; it does not assume the original source was already coprime.

The proof splits on whether the filtered physical block is zero. The zero branch is immediate. Otherwise `InitialEnergyCallerEmpty.physical_nonzero_clipping:62` shows that fresh columns are nonempty: if empty, every original clipped term vanishes by `BlockSupport` (`physicalBlock_zero_of_fresh_empty:19`). Positive compact support and `log(bfresh)<=3eta log Z` therefore give

`delta=max(0,D-B-v)-(D-B-v)` with `0<=delta<=3eta`.

This is a consequence of actual nonzero contribution, not an extra universal bound on D-B-v.

`InitialEnergyCallerWindowGeometry.retained_source_windows:16` translates the four nonzero cutoff factors into norm inequalities. In particular, the quotient ideal t has

`Norm(t)<= (hi_0/lo_1) Z^(B-theta) <= Z^(B-theta+2eta)`.

It is nonzero; hence nonempty quotient support also implies `B-theta>=-2eta`. The assigned product j is nonzero and has `Norm((j))<=Z^(G+eta)`. `InitialCanonicalStateSource.retained_full_puncture:60` combines the exact ideal identity `(j*primaryGenerator(t))=t*(j)` with multiplicativity to obtain

`Q=log_Z Norm((j*primaryGenerator(t)))>=0`, `Q<=B-theta+G+3eta`,

`||embedding(j*primaryGenerator(t))||^2=Z^Q`.

Thus the canonical input uses the **full** puncture norm, not a radical norm substituted into an equality. Nonzero norms and Z>1 justify logarithms and powers (`InitialCanonicalState:19–54`).

Set `N=max(0,D-B-v)`, `V=theta+v+2eta`, `M=theta+H+2eta`, and `zrem=Zall-G+eta`. The actual child label and row bounds give V,M>=0 and finite domains `idealRange(Z^V)` and `nonzeroChildFrequencyBall 1 (Z^M)` (`InitialCanonicalDomains:21–55`, `InitialCanonicalStateSource:21–55`). Rows are closed under negation; the original nonzero frequency and nonzero divisor keep them off zero.

`InitialCanonicalStateWindow.actual_window_state:19` gives N+V,M<=r+Zall+7eta and the two exact canonical margins

`gap <= N+V-M-Q-zrem`, `gap <= 4(N+V)-3M-6zrem`.

The proof uses `enlarged_initial_margins:63` with c1=c2=2gap. Before enlarging the remaining mark exponent by eta, its reserve is 3gap/2. The first inequality spends eta, the second spends 6eta; eta<=gap/50 leaves at least gap in both. The retained radial condition supplies the row cap in this argument. The assigned register identity supplies Zall-G for the remaining marks. No independent bound on an arbitrary prospective child is assumed.

## 4. Two canonical energies and the 4eta cost

`InitialRetainedPhysical.retained_physical_bound:20` chooses two fresh reference profiles, applies `Descent/CanonicalRankExistence.canonical_marked_energy_exists:32` to each with Mcap=Fcap=cap and margin=gap, and combines their degrees by addition and pool multipliers by addition. For fixed q it combines constants by C1+C2 and thresholds by max. This supplies moments for every real logarithmic twist s, both `secondRayMinus` and `secondRayPlus`, every retained quotient t and every pair of assigned mark subsets. Choosing a profile after its degree or a single twist would not satisfy this interface.

`CanonicalRankMoments:19` is the actual normalized finite column-energy definition. Its nonnegative ideal weight is `secondLabelWeight K`, large enough for `card(idealDivisors f)^(|J1|+|J2|+1)` by `InitialCanonicalState.assigned_label_weight_le:87`; f!=0 ensures the base cardinality is at least one. Restricting rows and weights is legitimate because every summand is nonnegative.

`InitialCanonicalEnergy.initial_child_from_rank:48` makes the normalization change explicit. Canonical moments are at exponent N+(theta+v+2eta); the requested energy is normalized at F=N+(theta+v). Their equality introduces Z^(2eta). The canonical upper bound itself has the enlarged exponent F+2eta+eps. Together these give `C Z^(F+eps+4eta)`, not `C Z^(F+eps+2eta)`. `normalization_change:18` is proved from the common unnormalized energy, using Z>0; no inequality direction is hidden.

`InitialEnergyCallerUniform.initial_raw_uniform:26` transports the reference estimate from scale Z^N to the original Z^(D-B-v). It first handles empty fresh columns exactly; otherwise the clipping factor lies in [1,b] and `canonical_clipped_uniform` applies. `initial_height_bound:14` converts each signed left or right twist's `(1+|s|)^(2J)` to the joint weight `tripleHeight(4J)*coordinateHeight(4J)`. The left twist is negative and the right positive; both are retained.

## 5. Source fibers, signs, and the common integral

This step is not an arbitrary-source cardinality bound. `InitialEnergyCallerAssignedPair.original_assigned_pair:24` expands the marks into actual assigned sources. `InitialEnergyCallerSupport.actual_sector_energy:18` maps sector sources injectively to arithmetic tuples, then uses `initial_energy_projection` to pay the possible child fiber by powers of ideal-divisor counts. `actual_sector_signed_pair:57` applies finite Cauchy to absolute values with coefficient norm bound. That projection's lower arithmetic fiber theorem is an explicit boundary of this audit.

`InitialEnergyCallerAssignedCanonical.original_assigned_canonical_pair:19` converts both energies to normalized canonical energies and handles the second child's negative row through `energy_neg_rows`. Sign-closed rows are essential. It gives, for each allocation and ray,

`|sum allocatedMode| <= |rayCoeff| Z^F (sum_t d(t)^(|J1|+|J2|)) sqrt(B1)sqrt(B2)`.

With B1=B2=E>=0 the square roots multiply to E. `InitialEnergyCallerMass.assigned_quotient_mass:28` bounds the divisor sum by C Z^(R+piLoss), uniformly in every finite assigned source. It applies `normalized_mass_bound` with epsilon=piLoss/(U+1) and R<=U; Z>=1 makes `R epsilon<=piLoss` sufficient, including negative R. No claim is made that every quotient ideal occurs, or that the source-to-child map is injective.

`InitialEnergyCallerAllSlots:22,47` expands **all** pairs of subsets and pays at most 4^K. `InitialEnergyCallerUnits:27,39` partitions exactly into six unit sectors and pays six. `InitialEnergyCallerRays:22` pays the finite sum of absolute ray coefficients, enlarged by one for positivity. These constants precede every finite pool/source and all window exponents.

`InitialEnergyCallerIntegral.actual_common_integral_bound:23` then bounds the integral by `C Z^(F+R+piLoss) A` times the weighted L1 norm of the actual family density. It explicitly invokes `familyDensity_weighted_integrable`; the norm-of-integral inequality is not being used to manufacture a convergence claim. `InitialEnergyCallerPhysical:23` uses the exact `physicalBlock_rectangular_common_measure` and `initial_physical_family_common_measure`. The latter provides the profile identity, integrability and weighted bound uniformly in the scale parameters, with polynomial cost in theta1,theta2. Their lower common-measure/Fourier construction is retained as a boundary rather than inferred from Poisson alone.

## 6. Physical normalization and final exponent

The source's `prefactorCenter` is `m-2D+B-theta` (`InitialProfile:325`). In the physical comparison it appears as `Z^(prefactorCenter+3eta)`. Let F=D-B+theta+delta and R=B-theta+2eta. Then `InitialEnergyCallerClipping.initial_scalar_identity:30` is the exact identity

`prefactorCenter+3eta+F+R+piLoss+(F+e) = m+5eta+2delta+piLoss+e`.

The two F terms have different origins: undoing the column normalization and the supplied canonical-energy upper bound. With delta<=3eta, this is at most m+11eta+piLoss+e. Substituting e=eps+4eta from §4 gives the stated m+15eta+piLoss+eps. The proof retains the common scalar A linearly; it does not square the moment bound or omit either normalization. Constants combine as the profile constant times C1+C2, after the separate reference-profile transport.

The physicalBlock already uses the actual physical normalization inherited from its source definition. This proof is an estimate of that object; it does not apply a second Z^-D normalization or claim the underlying unnormalized source energy has this same exponent.

## 7. How the reviewed short/long/push bounds supply the rank input

The dependency direction is canonical rank induction -> canonical moments -> initial retained physical/window bound. The second-pass retained push used inside the rank induction is a different theorem; it does not assume the initial retained-window conclusion currently being proved.

`CanonicalRankExistenceInduction:23,43` inducts over rank with a hypothesis for every positive-compact-support Schwartz profile. `CanonicalRankExistenceSuccessor:15` obtains four profiles from `CanonicalCompleteRankNormalized.actual_complete_normalized_rank_step:16` before choosing their four induction degrees and q-dependent constants. It combines those into one larger degree, pool bound and threshold. The actual four moment hypotheses are then supplied at rank n, not n+1.

The complete step's short term is `Cs (1+|theta|)^shortDegree Z^(N+V-cstar/256)`. Its long term is `Cb(1+A)(1+|theta|)^dl Z^(N+V+lossFinal+2L epsFirst+eps)`. `CanonicalCompleteRank:16` supplies the progressing long bins from actual live-bin children for each of the two signs and both profiles. The already reviewed long/push chain retains the source multiplicities, the finite key count and the child-energy hypotheses; it does not make them disappear into a constant.

The rank schedule is `M_n=3(n-1)cutoff/4`, `F_n=L-15n eta`, `c_n=cstar/2+7n eta`, `e_n=62n eta`. Long children use the cutoff/2 reduction, so their row cap is M-3cutoff/4; their total cap grows by 15eta and their margin loses 7eta. These fit rank n exactly from rank n+1. With tau=eta, piLoss=8eta, the selected mass exponents and first-pass epsilon, the successor uses loss=e_n+58eta and lossFinal=e_n+60eta, and the remaining first-pass loss fits e_n+62eta. The short saving is dominated by the nonnegative allowed rank loss. Rank zero is vacuous because M>=0 contradicts its negative row cap, but all nonempty higher-rank cases pass through the substantive step. The top depth is chosen before eta, avoiding a depth/eta fixed point.

This paragraph checks the consuming formulas and quantifier order against the source; it does not reprove the lower short spectral estimate or the two-pass analysis. The previously reviewed source reports are pinned below so their bounded scope cannot be mistaken for a whole-provider claim.

## 8. Immediate aggregation and remaining boundary

`InitialRetainedSum.retained_sum_bound:18` specializes the windows to [1/4,1], U=cap+3 and positive eta,tau, adds uniform eventual thresholds for Z^eta>=4 and Tclip<=3eta log Z, and pays the retained-window count `A Z^loss`. Its result is the same bound with exponent m+15eta+piLoss+eps+loss. Source-dependent physical cutoff T is quantified **after** these constants. Every retained window is included; equality in the radial threshold remains retained. This does not turn the finite window estimate into an infinite-source theorem. The separate genuine summability/Poisson passage and zero mode remain as recorded in the previous audits.

Remaining lower inputs not fully re-audited here: the arithmetic child-fiber projection and divisor-mass theorem; the exact canonical row/negative-row identities and bounded mode coefficient; `canonical_clipped_uniform`; the common-measure identity, weighted integrability and uniform profile estimates; the deeper short spectral, two-pass, retained-push and rank-geometry foundations identified in their own reviews. The full provider still needs source compatibility, successful elaboration and permitted transitive axioms checked separately. No new analytic premise has been added to a final theorem.

## 9. Frozen source and supporting-report pins

Source hashes below bind the inspected bodies, not every theorem in those files. Supporting reports are cited at their existing bounded scope; their status text is historical where a later review is listed.

| Source path relative to provider root | SHA256 |
|---|---|
| Inversion/InitialRetainedWindow.lean | 432681AE431B9AE27040DCD2187710225213F2424B5F96B4DDF1449AD0B6FAB0 |
| Inversion/InitialRetainedPhysical.lean | 6825D15988244817C90F2C106494AB62C64E2967D20A1BB7DB0FD10927097E18 |
| Inversion/InitialRetainedSum.lean | 1333F109E0BDBCE15EDF180CC34387B4328B01C1B6D495C9EDC39E8E1C281489 |
| Inversion/InitialCanonicalEnergy.lean | 7FBEF1B68A8F8A85B78E21F1884FF3E9290171EED71E0647A044B9B2A8FC0CCD |
| Inversion/InitialCanonicalState.lean | 05E241CA152DAD3BA77B2E425500BFF041F81AE0342002AF7AC9D34780F20EAD |
| Inversion/InitialCanonicalStateSource.lean | 25C150A58E32BAFC695848D0A934686D654C1BCACDAE2E62BB06B4B7B56CEEC8 |
| Inversion/InitialCanonicalStateWindow.lean | D162077647D50739AAC1CCFCABA34797D645C72048BD20F2F0138A36A30ED834 |
| Inversion/InitialCanonicalDomains.lean | 1220C9D893675F568277F319C1CBF4E84DEF6FC3FA4F14B746BEBEAB39EF1B0E |
| Inversion/InitialEnergyCallerFixedWindows.lean | 4C5878EBE5F01C0EB32393543A081E476886AE69D9A92EA294435D5F5674A7DE |
| Inversion/InitialEnergyCallerEmpty.lean | 4A1C6189128FC36E75BAF81CE6076C1DE3F3BEE2A9B8922FF725D9813E7D68D4 |
| Inversion/InitialEnergyCallerReference.lean | F9A70CBD23132AB32AD726C4CBF4C9E5C5C3545DFAAE06B7EFF343C06D01FBB9 |
| Inversion/InitialEnergyCallerPhysical.lean | 464705C0A397A23479F97570B8C3398AD4EA85461761CF2B76CE2A4A2FF6EE80 |
| Inversion/InitialEnergyCallerIntegral.lean | AE5F78C274C6051DBFEE961F6F7067D34E39E6458F2464E61C13C9F2F8FE26C9 |
| Inversion/InitialEnergyCallerUniform.lean | 6B6DA0C18C076DDE09860D3A641BF8EC4100EC1202E1AD8F8C29CFB9676E88CE |
| Inversion/InitialEnergyCallerClipping.lean | 407EF2BF3BFF836593EB22260CD4E92A326E5F25932750AB15C361E7B32552F3 |
| Inversion/InitialEnergyCallerRays.lean | 7697106A1F316EB5730860511D67900D1E9571E482A4C48D8AEAECE000A5DC6A |
| Inversion/InitialEnergyCallerUnits.lean | 77ACDB3FBAAE99640C7D4E39E5990D1E3A01F276ED602B2D0C4F920819C5FC12 |
| Inversion/InitialEnergyCallerAllSlots.lean | 1B11F097734B03A34CF52C7FB21B2F40969BCA3C3D1BCC9CF8BBDEBA914F130D |
| Inversion/InitialEnergyCallerMass.lean | DDA4126813E9E9033299C94B782D29DB7EC09224F497A576B2707514ACC9F045 |
| Inversion/InitialEnergyCallerBranch.lean | 9E7F5CB692792BD364BA502DF5700DE4E250B01DD03594BFD6E924A6C196F815 |
| Inversion/InitialEnergyCallerAssignedCanonical.lean | A11ACD1ACDD9CBE01DAF8C52E154D32719B65CA2D5D167A62CC9976EDDD3F111 |
| Inversion/InitialEnergyCallerAssignedPair.lean | E7B451D0A09079FBE5758BE1B3D600DD6FC4D8A7AB52510EFA409E6FCADAB46E |
| Inversion/InitialEnergyCallerSupport.lean | FA0D03E9C370B9E7B8418715532E65C23C8B03FA7C4653F2B12EE77FE2738F14 |
| Inversion/InitialEnergyCallerWindowGeometry.lean | 626B0EDDCABD3F404BBD79A3BD08C4FE7098B671D14408D3FEA390983D3C1A2A |
| Inversion/InitialEnergyCallerSourceMask.lean | 17C21A5B83F318D4F5C1190D8FB721A21544FB5FA70554E9ADF17C71013B1E83 |
| Inversion/InitialProfile.lean | 83B1C5FEC03CCE64C50DE747EA3F3F518A1569633B35592A67D89E79D57ECA19 |
| Descent/CanonicalRankExistence.lean | 7B299DCB2DE3C671BC9C84E5E5D2F3D0CF2D3192D30CADF1A2041867EFD21427 |
| Descent/CanonicalRankExistenceInduction.lean | EAF8639E1BA4D9E8A89DC4FD6F1FB9471CFF5F7BDE7D646D255D0EFCAE374934 |
| Descent/CanonicalRankExistenceSuccessor.lean | D2843F8CBBD084E83E1682DD8FB9160F593F807C8C461E37BF54AA6A4D736745 |
| Descent/CanonicalRankMoments.lean | 7311954BBB54718ACEC29DC50699F7D447AA5B27A9C660E1AE88B4EFD415F964 |
| Descent/CanonicalCompleteRankNormalized.lean | 72AB6C4781B92B236F40893B69C6D2FEC4B1BF6DD7A2731950FE1BAE1F61CB6E |
| Descent/CanonicalCompleteRank.lean | ECFDC826302CAE631A60B05E36EC845BEF79B63B7D0B4F812D131073D99B4389 |

Supporting packets (paths relative to work/qrh-campaign/agents/):

| Packet | SHA256 |
|---|---|
| major-constants/QRH_CANONICAL_RANK_ANALYTIC_AUDIT_2026-11-11.md | 2767A7CC08CC13239EFDBC5242D47505FC44028016251407B21A542CDC98FF4B |
| independent-feasibility/REVIEW_QRH_CANONICAL_RANK_ANALYTIC_AUDIT_2026-11-11.md | 0DA96714C7A742CEA9E987C8693A947A85387FBD13A84871034040EA0B590187 |
| major-constants/QRH_SHORT_ENERGY_ANALYTIC_AUDIT_2026-11-11.md | F45A59471E8A762710AF1F25CD74576E87C9061E4AE592A9B8682ABC6FCF1420 |
| independent-feasibility/REVIEW_QRH_SHORT_ENERGY_ANALYTIC_AUDIT_2026-11-11.md | 839163B2D5C05257B60B5ADFCDE8F508959ECB155B89B676FDD07527A1E0C6D7 |
| zero-sum/QRH_TWO_PASS_ANALYTIC_AUDIT_2026-11-11.md | 15A32FFB650E713609A2DB97F2C7BCE8ACA4B7881EDC04DDA57B2778A271A8F5 |
| audit/REVIEW_QRH_TWO_PASS_ANALYTIC_AUDIT_2026-11-11.md | B78EA45214EFC76A38E66EA69665E01AF0D7E4AE14B5BA15AD633D3B12C81DB8 |
| zero-sum/QRH_RETAINED_PUSH_LIVE_KEYS_AUDIT_2026-11-11.md | F119DA8C851BDDE45D41D72D372E1BF9BA281FECAB913BF1A66274A7D5E30C35 |
| audit/REVIEW_QRH_RETAINED_PUSH_LIVE_KEYS_AUDIT_2026-11-11.md | 13D35BEEC86E141A6F4A1A758B43D60D0834BF5F7F055C8333BD46C03EC1DB6D |
| integration/QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md | DE7237156824F7503A51F36A9E4A777F57647F2FC98F82D624D000E5D5C12AFA |
| integration/QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md | D8188C5E8AA59E979BEC024567255CF28845215117F2426C70C31D93F60EBA4D |
| moebius/REVIEW_QRH_HIGH_RADIAL_COVERAGE_AUDIT_2026-11-11.md | 0EC988BEE4AF8EF9A3FB17273AD0DACEF1D642F55F527D608ACF92C9D26D077B |
| moebius/REVIEW_QRH_ORIGINAL_POISSON_ANALYTIC_AUDIT_2026-11-11.md | 9516B5144F691A5D5203C93D737B943E69EFE4A0E4BA4F399A164F833AF75407 |
