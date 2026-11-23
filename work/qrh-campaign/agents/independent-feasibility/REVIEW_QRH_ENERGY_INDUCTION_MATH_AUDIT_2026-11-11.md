# Independent review of the QRH energy induction

Status: **PASS within the stated bounded source/math-review scope; no local defect found. Global QRH provider not validated.** Frozen independent review, 2026-11-11.

## Scope and result

I read the current research checkpoint and the actual source at openai-math commit `4eaee87548250b2682affda7d05d947c05554bae`. The independent emphasis is terminal reach, parameter losses, quantifier order, stage coverage, radial transport, and existence of states in the detector application. The analytic-successor producer review is a separate contribution by major_constants, independently assessed in section 6. The checkpoint read for context hashes to `D58AA410234EA48384F934CDDCE5200227638411676AC4E476F1D2DFC9F6CD25`.

Within this inspected part, I found no local mathematical gap. This does not establish the entire claimed global QRH theorem, validate the underlying imported analytic estimates, or certify that this checkout elaborates with the intended axiom closure. No Lean build, source modification, special-function evaluation, or spectral computation was performed.

Line numbers below refer to the exact files hashed at the end; paths are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`.

## 1. The assertion retains an actual energy and the correct uniformity

`Energy/State.lean:15–54` defines `NaturalState`, its width, mask, and actual `plainEnergy`. The latter is not defined as zero: the `plainEnergy_eq_zero` name identifies a zero-slot energy. Retained rows are nonzero and nonexceptional, a substantive restriction subsequently matched to the detector's exceptional-row split.

`Energy/Bands.lean:20–53` quantifies ZeroAt and PositiveAt over actual states and profiles, positive lengths bounded by powers of Z, and, in the positive case, finite slot data with a capacity inequality. The right side retains diagonalControl, profile seminorms, polynomial dependence on frequencies/height, and the exponent state.width+loss. These factors are not silently discarded.

`Energy/CappedWidthInduction.lean:49–61` has the order

    exists degree, finite seminorm set;
    for every character eta0 and admissible ideal Q;
    exists positive Czero,Cpositive;
    eventually in Z, both energy inequalities.

The degree and seminorm set are uniform in eta0 and Q; constants and eventual thresholds may depend on them. All may depend on the fixed input family and parameters. There is no uniform numerical threshold over an infinite character family. `Detector/FinalAssemblyCertifiedBands.lean:39–79` consumes exactly this order, choosing the source ideal and retaining per-character constants and thresholds. The finite unions of seminorm sets, sums of degrees, and finite intersections of eventual filters in packing do not reverse these quantifiers.

## 2. Terminal reach is finite and the declared losses are paid

Write sigma=min(1,epsilon/16000), n=ceil(2 Mcap/sigma)+1, B=finalSourceCap, and

    r=min(sigma/100,epsilon/[10^6(n+Mcap+10B+30)]).
    width(k)=r/16+k sigma/2;
    loss(k)=r+64kr;
    stageLoss(k)=epsilon/1000+loss(k).

These are the actual definitions in `Energy/WidthSchedule.lean:12–19`, `Moments/FirstSecondLossParameters.lean:10–16`, and `Energy/StageReserveSchedule.lean:11`. For the stated positive epsilon and nonnegative caps, sigma and r are positive. The ceiling-plus-one gives Mcap<n sigma/2, hence the capped width min(Mcap,width(n)) is exactly Mcap (`CappedWidthInduction:31`). This is a finite induction, not a limit in the number of stages.

`WidthSchedule:21–59` proves loss(n)<=epsilon/1000, and monotonicity gives this for k<=n. Adding the initial allowance gives stageLoss(k)<=epsilon/500 (`StageReserveSchedule:19–23`). `CappedWidthInduction:94–130` weakens that to the requested epsilon at the terminal stage. It also restores the original lower profile support and restricts the terminal length max(1,L) to L. Thus the final assertion has the advertised Mcap, L, and epsilon.

There is no circular numerical definition of the reserve: n depends only on Mcap and epsilon; `Energy/WidthRanges.lean:12–18` first constructs the finite geometric range and B from n, then defines the reserve and mesh using B. The source lengths can be extremely large and the mesh extremely small; positivity and finiteness suffice for this asymptotic assertion. No practical threshold or feasible computation follows.

For k<n, the parent band drops by sigma/2 into the old band (`CappedRequests:61–63`). Its enlarged source request and doubled length fit the previous-stage range (`CappedRequests:13–59`). Support shrinks in the previous stage to a/max(1,b), exactly the source requested by the successor; the terminal support returns to a. `StageMargins:10–38` allocates physical=old stageLoss+62r, reflected=physical+r, and new stageLoss=reflected+r. These are actual separate reserves, not multiple uses of a single r.

## 3. Successor ordering, branch coverage, and radial restriction

`Energy/CertifiedExistence.lean:19–38` applies a floor at k=0 and `actual_successor` only with k<n and an already obtained stage k certificate. In `CappedAnalyticSuccessor:30–176`, the logical order is previous zero/positive bounds -> new low bounds -> new high and new zero bounds -> packing. `NaturalHighStage` and `NaturalZeroStage` return implications from the previous bounds and low bounds, later supplied at the same sufficiently large Z; they do not presuppose the resulting new full certificate.

I read `CappedLowStage`, `NaturalHighStage`, `NaturalZeroStage`, `CappedSuccessorPacking`, and the transport bodies. The packing invokes `PositiveHighSourceBound.positive_from_stages:135–151`, whose cases are exhaustive: state.width<=old cap uses the previous bound; otherwise length1+length2+sum(slot widths)<=5 state.width/6 uses the low bound; its complement uses the high bound. Equalities are covered by the first two cases, while high hypotheses accept the resulting weak inequalities. There is no unhandled intermediate band.

`Energy/BandMonotonicity.lean:13–95` transports to smaller mask/radial/length/width domains, narrower profile support, larger loss/constants/degrees/seminorm controls. The underlying state, profile, and energy expressions are preserved. `CappedRadialTransport:18–44` therefore legitimately restricts a certificate at max(2,radial) to radial. The unused positive-radial binder in `CertifiedExistence.terminal_certificate:40` is not a missing cost: the proof first proves the stronger-domain statement at max(2,radial). Positivity remains an application hypothesis, but restriction itself needs only radial<=max(2,radial).

The floor wrapper `WidthFloor.actual_joint_floor:29–85` combines `exists_zero_floor` and `exists_positive_bottom`, enlarging controls without changing energies. I checked the combination, not the complete analytic derivation of these imported floor estimates.

## 4. Detector application is not made vacuous by the state restrictions

`Detector/FinalAssemblyUnconditional.lean:15–35` specializes the terminal certificate with alpha=Fin D.N, source modulus, conjugate W, slot support [1,2], profile support [1/4,9/4], mask cap 0, length 1, width cap 2, kappa=3/4+2 Delta, and epsilon=D.t/4. Its hypotheses on the zero supremum are derived in the contradiction branch beta>7/8; this wrapper does not simply assume beta<=7/8. The deeper construction of the contradiction parameters and final contradiction is outside this review.

`Moments/DetectorEnergyInitialState.lean:24–51` constructs the actual initial state, with row width 1, character width delta, puncture 1, and the given radial profile. Its finite-label modulus estimate (`:77–94`) supplies admissibility eventually for each fixed character and every d>=1/200. The application does not require one threshold working simultaneously for every character. `source_initial_states:116` packages the actual states; `source_keep_iff:96` and `source_energy_split_state:109` identify the nonexceptional part and retain a separate exceptional contribution. This rules out an empty-admissible-state explanation of the wrapper, but does not independently prove the separate exceptional estimate.

`Moments/DetectorPlainMomentParameters.lean:89–154` verifies the actual widths <=2, the marked/unmarked capacity inequalities, and delta+stageError<=D.t. `FinalAssemblyCertifiedBands:80–145` retains polynomial height factors and eventually-large-Z statements when constructing source moments. I found no uniformity mismatch between the capped energy assertion and this consumer.

## 5. Remaining mathematical and validation cut

This bounded review supplies source-level evidence for the finite induction, its parameter bookkeeping, and its actual use. The remaining cut is substantive, not a request for a larger source-name inventory:

- The analytic floor estimates consumed at WidthFloor, including their character/slot uniformity and actual normalization.
- The physical amplification/source-transform estimates beneath the low, high, and zero producers. The companion report audits selected bodies further; any explicitly uninspected analytic kernels remain outside this combined verdict.
- The independently estimated exceptional/source-moment pieces and the final contradiction from chosen moments to nonvanishing. Reading their wrapper signatures is not a proof of these bodies.
- Elaboration and axiom closure of the intended pinned provider, plus the separate integration into the target Goldbach development. Nothing here removes the existing PlattGRH declaration from that development or supplies finite spectral certificates.

In particular, an asymptotic eventually-Z energy theorem does not by itself give a numerical onset for a prime estimate. Its role in this source is an asymptotic contradiction proving nonvanishing. That route must be audited as such, rather than treating its uncomputed thresholds as an explicit Goldbach threshold.

## 6. Companion report review

I read the complete `major-constants/QRH_ENERGY_INDUCTION_MATH_AUDIT_2026-11-11.md`, SHA256 `C04D05F95C1747652F28576AC41372702F586F5D85E2849F12CD3E4D28A8D695`, and independently matched all 35 source hashes in its table. Its qualified conclusion is supported: no defect found in the inspected induction and exponent accounting, with the global provider explicitly unvalidated. No author correction is required.

I independently read the source definitions of `FirstGaussianProfileWeights.losses`, `FirstAmplifiedFourCoefficients.lossVector`, and `FirstSourceParameters.eventually_actual_four_fit`. They give the four costs and the separate external cost stated in the report. Substitution of d=theta=rAmp=r/4, delta<=r/4, es<=r/8, es*A<=r/8, 2B*emask<=r and kappa*mesh<=r gives:

- paid <= old loss+59r/24;
- full inherited cost <= old loss+83r/24;
- exceptional <=3sigma/2+(5B/2+49/24)r;
- diagonal <=2sigma+r;
- decaying <=-1+7r/8.

Ten exact Fraction comparisons independently checked these coefficients and their slack against the stated columnLoss=next stageLoss-9r/4. In particular 83/24<64-9/4, 5B/2+49/24<=(n+Mcap+10B+30)/4, 3/32000+1/4000000<1/1000, and 1/8000+1/1000000<1/1000. The source pays es*A with the declared A; replacing A by Mcap would be unjustified but is not what it does.

I also read `Moments/AmplifiedChildWidth.lean:90–187`: the nominal identity leaves u-max(u,0)<=0, the main/error formulas retain distinct -2sigma and -sigma terms, and the error case requires n in {0,5,6}. This corroborates the report's algebraic origin of the gain, without independently reproving the physical block decomposition or its valuation completeness. `Energy/PaidRemoval.lean:19–77` actually calls the old-band remaining-energy estimate and retains removal loss plus excess/6+kappa*mesh. `Moments/PrimeHeight.lean:68–94` explicitly calls the global prime-polynomial bound; this is a genuine analytic boundary, not a completed proof merely because the caller is present.

The report's section 6 correctly leaves detector nonvacuity to this review. Sections 1 and 4 above now supply the bounded consumer check: actual admissible state construction and the matching eventual quantifiers. They do not supply the still-separate exceptional-row estimate or final contradiction.

The best next substantive audit is `Moments/PrimeGlobal.lean:28`, `CenteredMomentPrimeGlobal.ray_prime_global_squared`: verify its actual smoothed polynomial, uniform conductor/scale and frequency bounds, and beta-dependent input without assuming the desired beta conclusion. The physical normalization/decomposition and floor/recovery boundaries listed in the companion's section 7 remain equally real proof obligations. This is a finite list of unreviewed arguments, not evidence that any of them is false.

## Exact inspected source pins

SHA256 values below cover the principal files used by this independent review. Reading additional helper bodies is described above; no claim of a transitive source or axiom audit is made.

| Relative path | SHA256 |
|---|---|
| `Energy/CertifiedExistence.lean` | `498BEA492166111FC95D17B7F2C379D26BF6D03013299B8D410793EA0B438066` |
| `Energy/CappedAnalyticSuccessor.lean` | `4EC231F505ED8D60B0CC096951EA1F259E96E1B4C4709DEDA62FE0E69351E772` |
| `Energy/CappedWidthInduction.lean` | `4D9ED300268C73C78C65E7102D538EEF72613A450099C35131E12BA2B50C4325` |
| `Energy/CappedRadialTransport.lean` | `75DE077BD37F5309AB213DF1126DD42A40DA14D1040B8C90A233ED0A007535B7` |
| `Energy/WidthSchedule.lean` | `B1DA2BF9CA130FF9C6B0F8A37E2CD86B449D0DEAECF0F7A4576EB92A38440B5D` |
| `Energy/StageReserveSchedule.lean` | `47938137986F9B4B6A7518E35C6E5278C6AFC57792247CCA4B009A1CBF25FB5F` |
| `Energy/WidthRanges.lean` | `9AB32ADCD244A3F1662DF6BDCC1263B94AFBE2819FC435097743B01B40F43A4D` |
| `Energy/WidthInduction.lean` | `542B83F2BC09379C2FF7B8CDE66D6EF952E33B6258A3DB8261D369ECFCDB3ED0` |
| `Energy/Profiles.lean` | `6EA630061B5547531B53727A8BF498EB4F51FF8AF84465B06BEE8CE84EE0814E` |
| `Energy/Bands.lean` | `42FD3FE963D8DEEF1CC5772979B41A8273E80940641E9F24475FF33397A09C2E` |
| `Energy/BandMonotonicity.lean` | `69378E8479851A178A8CCD6C725864C0E664127BA0EAAC2DE45371A709A51782` |
| `Energy/CappedRequests.lean` | `EF6AA491D02FDC8EBE74EA11C32BA26F2210F49B0085C169CFF53295BF0A9AD7` |
| `Energy/CappedSuccessorPacking.lean` | `4E86170A65369400526C0EFF0105B3B4F7579AC9E52954F971FA462B6D8C37D9` |
| `Energy/CappedLowStage.lean` | `65DDBCCF257ECEC57A727C4DBB010D7B7875597A24600CCF4637812B424AA906` |
| `Energy/NaturalHighStage.lean` | `9A8E0F9C45BBEA861336F632D48A526A47694C0A71A860FE88B65E420ED492AB` |
| `Energy/NaturalZeroStage.lean` | `7745F22169E40515D27022D4A88DA9E4BB94A47A50F876FBD2740F9014CD865E` |
| `Energy/StageMargins.lean` | `A04333E56CFF9EDCF5DD7AFCC6F5D11E2685B4493DFD27C9A40CD6759D1F8F9D` |
| `Energy/StageMonotonicity.lean` | `4AF86FC79C5E493495B887C2734B2360104AC9EBD4B4B4E1835685A861BC101C` |
| `Energy/State.lean` | `B5118D2F6F04ED495A6317317B74A7D60BA1B32F2050AEB7EE7E9E4783D67222` |
| `Energy/WidthFloor.lean` | `CAF4B5BEE946E7E441A8E26046696BC1D75976CDD76F87E1ED10A173E6C3E6CA` |
| `Energy/PositiveHighSourceBound.lean` | `65A6FCB3AF24641CE25E95AEFBCED10D200E583A6F36904F0674DF505B264119` |
| `Energy/SourceCapSchedule.lean` | `3D30757FC7863BE516B33915C6F7AB670BBE822C5218C45BCE104F135D9D6726` |
| `Moments/FirstSecondLossParameters.lean` | `9C9C480F031FDC6A495BD6CE8169FD9FD1183C0E1E58F5B7955D0A43D1BCB663` |
| `Moments/DetectorEnergyInitialState.lean` | `74CAF55C289510B71DA89998948DF2457FC07567216E9C18E524F31656F812F2` |
| `Moments/DetectorPlainMomentParameters.lean` | `6CF9BABBC319A9A47C030BC507C945C62E93EF74AD39D976BC4A39FEBE2707FF` |
| `Detector/FinalAssemblyUnconditional.lean` | `70D01B604FD5CC3522A4503543D9A5E422F9105C19E88985C5CD7C28C5958BA2` |
| `Detector/FinalAssemblyCertifiedBands.lean` | `BFA8FC2524634A7F7CCF893C944BBBDA6F0BD3A3DC666C13821CE06CF13F960F` |
| `Energy/NaturalLowStage.lean` | `E831B3EFB8C8EBE45767CFFF4188BFB0DD9C01C3E033A1D943AC2D5F9C2A37D4` |
| `Energy/FirstGaussianProfileWeights.lean` | `E6F0FF771F7B29F85F1A570DE31B441D87D78920B46EF74508CD54429DC70192` |
| `Moments/FirstAmplifiedFourCoefficients.lean` | `8BAF4B3C85B109797581667070238E0107AE1068423749F4AD930AB470035FB4` |
| `Energy/FirstSourceParameters.lean` | `4837B7D97B1D51C1F4319EBE5DEFC30A141FD63F11CE2B26CCFD048A86EE8C75` |
| `Moments/AmplifiedChildWidth.lean` | `6F304FF331BA073E0138C3D42DF5A37374B936721ED9C2AC63F6420B3E6E388A` |
| `Energy/PaidRemoval.lean` | `E82461C13865D99700722DB9E2D2863B0C203E5BF05DFAB89EFC59BE275CDAAE` |
| `Moments/PrimeHeight.lean` | `A1EC164AF7FF7B0D757E3B6DBBD43DCF9CD394DBE50783C35FE970DD84F64B12` |
