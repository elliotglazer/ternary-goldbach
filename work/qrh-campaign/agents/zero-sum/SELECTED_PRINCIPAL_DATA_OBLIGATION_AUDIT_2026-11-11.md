# Principal head data in the selected original-RH comparator

2026-11-11. Bounded source and paper dependency audit. No build, source edit, spectral evaluation or new zero certificate. Prior reports remain unchanged. Paths below are relative to the repository unless a shorter root is stated.

## Conclusion and selected scope

The current combined finite-RH comparator does **not** require a separate certificate of the numerical statements `N(1500)=1069` and `Q_1500<1.668`. Its retained original principal estimates use RH through the closed height `10^8`, analytic zero-window bounds, and their existing explicit-formula and arithmetic inputs. This conclusion follows from the bodies described below, not from absence of the decimal constants in a search.

Those numerical head statements are genuine inputs of the earlier damped shared-strip/global-seven-eighths route. They also enter an optional Johnston/Büthe prime-gap replacement through the reciprocal-head and inverse-square reuse arguments. These are different consumer paths. This audit does not remove their inputs when either alternative is selected.

Here “selected” means the R132900 ordinary finite-RH comparator using the original principal psi/plateau/Mertens path, the reduced nonprincipal plus/base-gap heights, and the shared-RH star bound. It does not mean every historical document with `SELECTED` in its filename. In particular, `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md` selects the earlier damped alternative within its own strategy and remains correct in that context.

The removable cost obligation is separate production/checking of the exact 1500 count and weighted head sum **solely as additional inputs to this comparator**. No percentage or runtime saving follows. A chosen RH certificate algorithm may use that same head packet internally; removing it there requires another completeness argument. The retained `RHBelow 10^8` is not already proved by this audit.

## Positive source trace for the principal estimates

Source paths in this section are relative to `work/ternary-goldbach/TernaryGoldbach/`.

`Explicit/ZetaZeroSums.lean:23` defines `RHBelow H` by actual zeta zeros with `0<Re(rho)<1` and `|Im(rho)|<=H`, requiring `Re(rho)=1/2`. Its `rh_upto_1e8` at line29 currently extracts this from `Fact PlattGRH`. The predicate contains no prescribed list, simplicity, exact count or reciprocal moment. The modulus-one identification remains part of that extraction. Replacing the Fact requires a genuine proof of this predicate; merely checking some signs is insufficient.

The decisive low-zero estimate is `line_sum_le` at line161 and its adjustable-window version `line_sum_leH` at line416. Their inputs include an arbitrary finite subset of the actual `zerosRectD zetaF T`, line location and a height bound. The sum uses `multRectD`, the actual analytic multiplicity. They partition the finite carrier into windows and bound the multiplicity in each window using `BPz2`, `ZLg` and the corresponding analytic Jensen estimates. The pointwise hypothesis is weighted by `max(1,|Im(rho)|)`. Thus this proof does not divide by an unproved minimum positive ordinate and does not need the numerical count or reciprocal sum through1500. Bounds such as `ZLg BPz2 H` are analytic upper bounds, not stored exact spectral counts. `Explicit/ZetaPoly.lean` supplies the zeta growth bound used here.

`Explicit/PsiExplicit.lean:120`, `SsumG_gsm_errH`, applies the zeta explicit formula and splits each actual finite zero carrier into `|Im(rho)|<=H` and its complement. It uses `RHBelow H` and `line_sum_leH` for the low part, the Gaussian high-tail estimate for the complement, and the actual `hZeta` vertical term. The low term `LineB2H`, defined at line110, is a finite sum of analytic logarithmic window bounds with denominators `max(.5,6*m)`. It is not the quantity `Q_1500`. The summability result at line186 and `tsum_gsm_leH` at line199 then pass to the actual infinite sum and the smoothed prime expression. No default value of a non-summable tsum replaces this step.

This supplies the following surviving uses.

| Consumer | Principal data actually used at this boundary |
|---|---|
| `Explicit/PsiPlateau1e8.lean:104,120` | The scalar `ErrGH` bound and `tsum_gsm_leH` with `RHBelow 10^8`, smoothing `delta=7/10^8`, and `K=7`. The upper and lower unsmoothing arguments retain their analytic tails. |
| `Explicit/PsiRanges1e8.lean`, as traced in the reviewed principal-height audit | The 22 original finite psi ranges use `H=10^8` and their analytic/scalar window certificates. No substitution by the damped 1500-head argument occurs. |
| `Prelim/MertensProduct.lean:531`, `E1_win_num` | A separate explicit-formula window invokes `tsum_gsm_leH` with `H=10^8`, followed by variation bounds. |
| `Prelim/EOneBound.lean:156`, `abs_smoothed_E_le` | Explicit use of `rh_upto_1e8` with the integral/variation estimates for the smoothed E1 expression. |
| `MajorArcs/Thm714.lean:485,572` | `errPZ_le` bounds E1 with the analytic `ZLg/BPz2` line-window expression, E2 with the analytic tail, and the origin/vertical pieces separately. `thm_7_1_4_one` supplies principal RH at `10^8`. |
| `MajorArcs/Cor713.lean:774,807` | `err933Z_le` combines the principal E1, E2, origin and vertical bounds. The conductor-one branch of `cor_7_1_3'` supplies RH through `10^8`. |
| `MajorArcs/Prop715.lean:230–364` | The phi1/phi2 and coefficient-energy estimates need principal RH only through500, using their analytic window/tail bounds. This follows by restriction of the retained closed `10^8` predicate. |

The reviewed principal-height audit also follows the unbounded theta/psi and totient consequences into the minor arcs. In particular, changing the major-arc principal error does not remove the existing `PsiLarge`/zero-free-region split at `10^8`, the plateau, Mertens variation, or E1 consumers. This report relies on that prior bounded chain for these downstream paths; it does not claim a fresh recursive audit of every imported theorem.

The current source wrappers still carry `Fact PlattGRH`. The preceding mathematical dependency localization is not a claim that those wrappers have already been refactored or compiled without it.

## The current star count does not import a principal head

The shared star proof has two separate components.

First, `WSTAR_CUTOFF_BASELINE_TRADEOFF` and its reviewed lower-floor successor work with primitive **nonprincipal** characters, `c>1`, the complete closed carrier through

`Hstar(c)=ceil(max(300,(704/343)*(1063200/qt(c))))`.

Their closed-count upper bounds use the canonical theta/count relation with the two character channels, elementary Turing bounds, a Binet phase enclosure, and one-sided averages around the cutoff. They retain real zeros, boundary zeros and actual multiplicities. Their low Gram bound uses a full-strip Jensen window; the high tail uses `count_tail_windowG` with its growing remote-window bound, not a fixed low-window count extended to infinity. These are analytic count estimates for the selected nonprincipal carriers. They are neither `N_zeta(1500)` nor deductions from it.

At shared ordinary RH the factor `y^(2 beta-2)` is exactly `1/y` on those carriers. The root `SHARED_RH_STAR_BUDGET` therefore uses the uninflated bounds `Q_A<2.321e-19` and `Q_B<1.753e-12`. Its remainder includes the separate high tail, origin/vertical and coprime-removal terms. These `Q_A,Q_B` are conductor-weighted statistics and must not be confused with the principal integrated counting moment `Q_1500`.

Second, the principal star term stays separate. `WEIGHTED_PRINCIPAL_WSTAR_BUDGET` uses the actual conductor-one Cor933 estimate, inner and outer removal, and a finite arithmetic weight bound. Its integrated principal/removal radius is `1.902e-6`. The principal source path is the Cor713 row above, not the damped psi head. Principal plus and Prop715 coefficient-energy bounds likewise retain their own paths. No nonprincipal count estimate substitutes for the principal pole treatment.

There is one stale or ambiguous inheritance sentence to avoid in future ledgers. Line104 of `WEIGHTED_PRINCIPAL_WSTAR_BUDGET` says “Principal RH and its head data remain separate certificate obligations.” At the selected original-RH consumer boundary, the specific extra assertions `N(1500)=1069` and `Q_1500<1.668` do not follow as obligations from that sentence. The source derivation requires principal RH and the original analytic/finite inputs just listed. If “head data” means a particular RH producer's internal completeness evidence, that producer must state it separately. This clarification does not alter any frozen report.

## Selected and alternative data ledger

| Data or proof object | Current original-RH/shared-RH comparator | Alternative or qualification |
|---|---|---|
| Actual principal RH through closed height `10^8` | Retained. Both signs and every actual nontrivial zero are covered. | It does not assert simplicity or prescribed numerical counts. |
| Principal RH through500 | Retained by restriction, for Prop715. | No separate spectral run is forced. |
| Principal certificate completeness, true orders, endpoint coverage | Retained wherever needed to establish the RH predicate. | A sign-only list is insufficient. Counts used internally are not eliminated by this audit. |
| Exact positive count `N(1500)=1069` | No separate consumer requirement found in the inspected selected chains. | Explicit input of the damped shared-strip route; may also be used by an RH producer. |
| `Q_1500=sum_(0<gamma<=1500) m*(1/gamma-1/1500)<1.668` | No separate consumer requirement in those chains. | Explicit damped-route input; the raw reciprocal sum is `Q_1500+N(1500)/1500`, not `Q_1500`. |
| An explicit zero-free head such as `0<|gamma|<=14` | Not added by these selected window estimates. | Needed in the optional inverse-square reuse proof if that proof is selected. This audit does not deny other classical analytic nonvanishing facts in imported foundations. |
| Analytic zeta/Dirichlet growth, Jensen/window counts, summability, explicit formula and gamma estimates | Retained. | They are proofs to check/formalize, not certified lists of zeros. |
| Nonprincipal closed finite-RH certificates through the chosen plus/base/star union | Retained. | Current star uses analytic count bounds on smaller subcarriers; no extra principal head is induced. |
| Finite prime/psi tables, arithmetic mass bounds, original binary coverage and other original finite inputs | Retained where consumed. | For example `Prelim/PsiTwoSided.lean:79` still dispatches the small range to `SmallTab.small_table`. Removing zero-head moments does not remove these arithmetic certificates. |
| Shared principal strip through60343058 plus global7/8 and the three 1500-head facts | Not the current comparator's original principal path. | This is the explicit input package of the historical damped `SELECTED_PRINCIPAL_ROUTE`. |
| Johnston/Büthe prime-gap replacement using reciprocal/inverse-square head reuse | Not silently adopted here. | The head-reuse notes explicitly use the 1500 data. Selecting that alternative restores those obligations or requires another proof. |

The historical damped route's use is substantive. It performs finite Abel summation with the exact boundary subtraction `N(1500)` and the integrated moment `Q_1500`, plus symmetry and Gaussian damping. Ordinary RH alone does not supply those numerical statements. Conversely the original window proof is a genuine different bound, so it does not need to reconstruct that Abel input.

## Cost and closure consequence

For the current comparator's cost model, remove a separately mandatory reciprocal-head statistic pass and its fixed numerical count acceptance unless the chosen principal RH producer explicitly needs them. Continue charging all sign evaluation, Turing/argument-principle or other completeness checks, multiplicity/endpoint handling, and any internal head initialization used by that producer. An already-available head packet may remain useful; it need not be discarded.

There is no demonstrated reduction in the number of zeros or the principal height to be certified. There is no basis here for replacing `10^8` by1500, by500, or by the new nonprincipal maximum height. The result is a dependency correction, not a timing measurement or a claim that the remaining formal analytic library is complete.

No full transitive axiom audit, target-version build, all-import proof validation, or final unconditional theorem is asserted. The ledger is bounded by the inspected source bodies and the cited independent consumer audits. Any later route change must carry its own finite-data requirements instead of inheriting the word “head” without an identified consumer.

## Frozen evidence

The following tables pin the source and report bytes used for this conclusion. The source rows named above were inspected at body level. The broader all-consumer and height audits supply the explicitly stated downstream scope; their conclusions are not treated as compiled theorem evidence.

| Source under `work/ternary-goldbach/TernaryGoldbach/` | SHA-256 |
|---|---|
| `Explicit/ZetaZeroSums.lean` | `21C97198134C5CEEDBCD597FA11E05982FE8878FFD24BBB60BCCC8E2032943AA` |
| `Explicit/ZetaPoly.lean` | `53A059C5EA1BBEFBD64FCDBE95D127FC019758E9D308B1BD7E1256B550DAB451` |
| `Explicit/PsiExplicit.lean` | `33A24C9E1606011AAC8930EC978BA027E90A2A66E0888DB18915ACC2FBF85BB1` |
| `Explicit/PsiPlateau1e8.lean` | `F5BEB066695D24085A74706C9FFE3219A2A053E2C1854FC3E209BD0CD78E392C` |
| `MajorArcs/Thm714.lean` | `7BBF8F06B1A0B703A0C00FF1E5E64997792C4E93629CED591FCB6A646301FD3F` |
| `MajorArcs/Cor713.lean` | `11325BE6F77A7A762747542F30E2A9035782765A801C603F14107E84ED5D7433` |
| `MajorArcs/Prop715.lean` | `CD026A3D01FD8578484E43A48888885C2DC3BF696B2F7ACB89BB525E4E064DF0` |
| `Prelim/MertensProduct.lean` | `8182DC2B990DC8D65AC76D3CC55847B26922E2062CD154C14367D5DB97F71A0F` |
| `Prelim/EOneBound.lean` | `ADD1130F3FBBB4EA2AAFB7A7F769FBD565E14DB13B2F6500245E14023106DC65` |
| `Prelim/PsiTwoSided.lean` | `9E2790AC0B3707D4A51B79735711BC9D7470694E8BFE6B96762E38F39F929E3C` |

| Report relative to repository | SHA-256 |
|---|---|
| `work/qrh-campaign/agents/integration/PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `207EEAF68F7FB51351B4C37E991A09664F1B7852CCE29D82C75B2D4B8B776D63` |
| `work/qrh-campaign/agents/moebius/REVIEW_PRINCIPAL_RH_HEIGHT_CONSUMER_AUDIT_2026-11-11.md` | `30736389905515E2AA502E924A299DCBEB4CBE6F9151477838592FA87B4E69D9` |
| `work/qrh-campaign/agents/audit/THREE_AGGREGATE_CONSUMER_SUFFICIENCY_AUDIT_2026-11-11.md` | `78119012C8BA40AFC93AB523B84DD441CD19D3FBC76F12418C41DD081B3C9F28` |
| `work/qrh-campaign/agents/independent-feasibility/ORIGINAL_RH_CONSUMER_DOMAIN_RESEARCH_2026-11-11.md` | `AC14194BAB999170E7444DD0EDAA0285A3758942681AB44E4E2047CF8A87D48C` |
| `work/qrh-blueprint/SHARED_RH_STAR_BUDGET_2026-11-11.md` | `A5457ABF7E67FD98C88F46B8F08DF4F8BD35B44B48A3B734E5F660F94CCAA993` |
| `work/qrh-blueprint/WEIGHTED_PRINCIPAL_WSTAR_BUDGET_2026-11-11.md` | `22A6A16880BE2FA5CB0FF393C533BD60B1AFCD32C751E5A0D64FE7ADAB7C40F7` |
| `work/qrh-campaign/agents/zero-sum/WSTAR_CUTOFF_BASELINE_TRADEOFF_2026-11-11.md` | `55D2E58DA0F13A77ECC3AB097E5CAC45D58EE247178F8A8D5824756A45E1C2AB` |
| `work/qrh-campaign/agents/zero-sum/WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md` | `E1D58C8EC2EDB7FD8F3BF77F1D3833F3E400200D14AD30B396F59FA8CB5EE794` |
| `work/qrh-campaign/agents/moebius/REVIEW_WSTAR_LOWER_FLOORS_AND_SQUAREFREE_PROFILE_2026-11-11.md` | `422940369A04ED695A45EF28F20F154349932CEBC0242EEEE15FF3373D5CE6A4` |
| `work/qrh-blueprint/SELECTED_PRINCIPAL_ROUTE_2026-11-11.md` | `F5276E1C93B959BFC4D86A58BEFAA4666E320454CDC9B2CC2804EEEBE354FEBB` |
| `work/qrh-campaign/agents/zero-sum/RECIPROCAL_HEAD_REUSE_2026-11-11.md` | `8EC98EEAC527630E0D3F558B63A0CE9897189DA389932FC7B0F536510EA9D27F` |
| `work/qrh-campaign/agents/zero-sum/INVERSE_SQUARE_HEAD_REUSE_2026-11-11.md` | `1C4A0493A913D1E57EF6DBF9C8D9DE0F4E8DD4E2F14ED506FD8970CD9D1702F0` |
