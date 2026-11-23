# Certified-band transfer to actual detector moments

## Verdict and scope

The inspected transfer is mathematically coherent **conditional on the terminal `CertifiedBand` input and the imported analytic moment estimates identified below**. It uses the actual source polynomials and energy sums. I found no local replacement by an abstract response, no missing source-fixed-ideal gate, and no loss of the required order of quantifiers over the character, height, or `tau`.

This is a bounded source-body audit, not a proof of `DetectorCertifiedBands`, an audit of the complete QRH dependency closure, or a Lean verification. No evaluator, compiler, or numerical scan ran. In particular, `certified_terminal` consumes a certificate at the final index; the name does not mean that it constructs that certificate from the floor theorem. The immediate mathematical audit frontier is the production of the terminal band and the deeper inverse-reference estimates, not the final transport of those estimates to `SourceMomentBound`.

Provider root is `work/openai-math/lean/OAI/NumberTheory/DirichletL`, at repository revision `4eaee87548250b2682affda7d05d947c05554bae`. All source paths below are relative to that root, and their inspected bytes are pinned at the end. The restoration checkpoint read for scope was `work/qrh-blueprint/RESEARCH_CHECKPOINT_2026-11-11.md`, observed SHA256 `D58AA410234EA48384F934CDDCE5200227638411676AC4E476F1D2DFC9F6CD25`. That mutable checkpoint is contextual evidence, not a mathematical premise.

## 1. What the certificate actually bounds

`Energy/State.lean:16–34` defines a `NaturalState`, with a genuine Hecke character, fixed ideal, nonzero puncture, radial weight, row width, and character width. Its constraints include:

- base `Z >= 1`, nonnegative widths, radial scale exactly `Z^rowWidth`;
- actual character-modulus norm at most `Z^characterWidth`;
- nonzero puncture of norm at most `Z^Bmask`;
- a Schwartz radial profile supported above by `bPhi`;
- every retained row nonzero and not `FixedInducingRow` for the stated character, fixed ideal, and mask.

The radial object itself has a positive scale and nonnegative real weight at every lattice point, `Moments/RadialEligibleEnergy.lean:15–28`. The retained set is an arbitrary predicate subject to the state constraints. Thus this is uniform in admissible retained masks and radial profiles, **not** in arbitrary signed weights, exceptional rows, punctures of unlimited norm, or profiles of unlimited support with a single constant.

`Moments/InductionEnergy.lean:16–22` defines the energy literally as the lattice sum of the squared norm of `positiveSlotRow`, multiplied by the real radial weight and the retention indicator. `Energy/State.lean:44–52` makes `plainEnergy` the same formula with no prime slots. `Moments/FiniteProfileExceptionalPair.lean:14–21` makes `Profiles a b` a pair of actual Schwartz functions supported in `[a,b]`; its control is the product of two finite seminorm controls. These are not opaque numerical witnesses. `energy_absolute` at `Moments/InductionEnergy.lean:71` explicitly obtains summability through `bounded_radial_summable` before comparing the sum. This audit did not re-prove the underlying lattice summability theorem, but it did check that the displayed sum is not being justified by the default value of a nonsummable `tsum`.

`Energy/Bands.lean:20–26` defines `ZeroAt`. For every admissible state with the prescribed fixed ideal and width at most `M`, every such profile pair, every real oscillation parameter, and every positive pair of scales at most `Z^L`, it bounds that plain energy by

`C * diagonalControl(radial.profile) * profileControl^2 * (1 + |t|)^degree * Z^(state.width + eps)`.

`PositiveAt`, lines39–57, additionally quantifies over every subset of the finite slot type, ray characters, slot widths, slot real parameters, and slot frequencies. It requires `0 <= width <= Lslot`, `lo <= sigma <= hi`, frequencies bounded in absolute value by a freely chosen nonnegative height, and the capacity inequality

`length(Z,X1) + length(Z,X2) + 6*kappa*sum(widths) <= state.width`.

The left side uses the actual `primePool`, relative-character ideal coefficients, and `HeckePrimeAnnular.annularWeight W`. The right side uses `(1 + |t| + height)^degree`. No additional threshold is chosen after the height, frequencies, state, profile pair, or scales.

`CertifiedBand`, `Energy/CappedWidthInduction.lean:49–61`, puts **degree and finite seminorm set before the base character and fixed ideal**. Positive constants and the eventual threshold can depend on that character and ideal. The support, length, width, and loss depend on the induction stage. The detector specialization at `Detector/FinalAssemblyCertifiedBands.lean:30–37` requires this for every positive radial support bound, with constants and controls allowed to depend on that bound. It does not assert one constant for all radial support bounds.

## 2. Terminal transport and fixed ideals

`certified_terminal`, `Energy/CappedWidthInduction.lean:94` onward, unpacks the assumed final band, uses the terminal width identity, and applies `zeroAt_transport` and `positiveAt_transport`. Those transport bodies at `Energy/BandMonotonicity.lean:36` and65 preserve the actual character, mask, profile functions, and energy. They enlarge only admissibility bounds and the nonnegative right-hand side. In particular, length restriction is transported in the correct direction, and the final stage loss is bounded by the requested `eps`. `certified_floor`, line63, produces index zero only. Neither theorem here supplies the missing progression from index zero to the final index.

The detector's fixed ideal is not a small numerical conductor. It is

`sourceFixedIdeal F = F.modulus inf (72)`,

and `internalQ Q eta = Q inf eta.modulus`. These are ideal intersections. Inclusion in `(72)` says that the ideal is divisible by `(72)` under the usual reversed ideal-divisibility order; it does not bound its absolute norm above by72. See `Moments/NaturalFixedRaySourceFixedIdeal.lean:16–36` and `Moments/NaturalFixedRaySourceInternal.lean:15–23`.

All four gates used by `plain_inputs` are actually supplied:

1. `sourceFixedIdeal F <= F.modulus` by intersection.
2. Its intersection with `eta.modulus` is nonzero, using the nonzero source modulus, `(72)`, and character modulus.
3. It is not the unit ideal. The excluded source set contains the prime ideal generated by `goodLambda`; the source prime product lies inside that proper prime, and so does `sourceFixedIdeal F`. Further intersection cannot become the unit ideal.
4. `internalQ` lies inside `(72)` by transitivity.

`source_fixed_gates`, `Moments/DetectorEnergyInitialState.lean:100–108`, is a proof from these facts. `plain_inputs`, `Detector/FinalAssemblyCertifiedBands.lean:39–78`, specializes the terminal certificate to this ideal for each base character. The positive part retains every `bPhi > 0`. The zero part chooses the independently constructed support bound of the actual `radialMajorant`.

## 3. Actual source, masks, and the marked/plain dictionaries

`SourceData`, `Detector/FinalAssemblyData.lean:14–31`, contains the actual source prime set and a nonzero real-valued Schwartz window, supported in `(1,2)` and bounded between0 and1. Its complex representative `W` equals the real window pointwise. `Hecke/Dyadic.lean:22–49` defines the actual polynomial: ordinary coefficients are `idealCoeff`, inverse coefficients multiply these by ideal Moebius; the polynomial has the factor `D^(-1/2)` and sums `W(norm(I)/D) * (norm(I)/D)^(-sigma + i*t)`. For compactly supported windows at positive scale, line51 proves finite support. The inverse branch is not a replacement by arbitrary coefficients of modulus at most one.

The potentially delicate removal of exceptional rows is genuine, but asymptotic. `Moments/NaturalFixedRaySourceFreeExceptional.lean:16–38` uses the actual numerator valuation theorem to show that an exceptional sixth-free row is supported on prime factors of `internalQ`. Bounded exponents then give a fixed row-norm ceiling, lines40–55. For a fixed source character there are finitely many ray labels; their ceilings are all eventually less than `Z^(1/100)`, lines57–72. Consequently every row admitted by the lower row-norm condition is retained. No unrestricted statement about all small rows is used.

`Moments/DetectorPlainExceptional.lean:33–78` compares the finite detector-row energy with the retained source energy using injectivity of the row embedding, the positive normalization denominator, nonnegative radial weight, and `radialMajorant = 1` on `[0,1]`. The last condition applies because the actual fiber rows have norm at most the radial scale. Lines80–107 supply their retention, and lines122 onward also supply the large-prime coprimality needed for the actual coefficient identity. The equality is therefore not obtained by deleting uncontrolled rows from a positive sum.

For the marked branch, `Moments/DetectorPlainMarkedState.lean:26–39` and41–80 identify each source slot exactly. An external parameter with real part `17/50` becomes the annular parameter `33/50`; its imaginary part changes sign; the window becomes `conj W`. `Moments/DetectorPlainRelativeClass.lean:19–64` proves that each ray character is one on the identity-class prime pool, so the relative coefficient there equals the inverse base-character coefficient. This is a pool-restricted identity, not a claim that those characters agree on every ideal.

`Detector/DetectorPlainMarkedFineField.lean:30` onward applies `PositiveAt` to that source state with row width1, character width `delta = D.t/4`, radial scale `U=Z^d`, actual retained mask, and both polynomial scales `U^m`. The fine condition `D.ell(j) <= mesh/200` and `d >= 1/200` imply `D.ell(j)/d <= mesh`. The capacity assumption on the selected slots is retained. Thus the result is uniform over every permitted selected subset, not only a prechosen subset. It covers `j+k <= 2`, `sigma in [0,1]`, and all `|t| <= height`.

For the unmarked branch, the character-width allowance is deliberately padded to `delta + max(0,2*m-1)`. It changes no character or energy, only the admissible upper bound on the modulus. The total state width is `max(1,2*m)+delta`. `Moments/DetectorPlainUnmarkedState.lean:37–85` gives the state and exact source equality. `Detector/DetectorPlainUnmarkedField.lean:50–83` applies `ZeroAt` at oscillation parameter0, while the desired `sigma,t` remain in the actual Schwartz profiles. `Moments/DetectorPlainProfileControl.lean:13–49` bounds the profile seminorms polynomially in height. The restricted theorem used by the final assembly is `DetectorPlainUnmarkedRestrictedField.lean:44`, which only asks for the source-fixed-ideal zero bounds. It does not silently demand the unrestricted all-ideal hypothesis of the older wrapper.

The exponent checks are explicit in `Moments/DetectorPlainMomentParameters.lean:20–37,51–60,89–101,151–153`: `delta = stageError = D.t/4`, `m <= 23/40`, both state widths at most2, both scales at most `U`, and `delta + stageError <= D.t`. The marked output has exponent `1+D.t`; the unmarked output retains `max(1,2*m)+D.t`. No conversion to exponent1 is made when `2*m > 1`.

## 4. Inverse branch and uniformity

The inverse field does not follow from `CertifiedBand`. It comes from separate imported inverse moment estimates. `Detector/DetectorInverseRawField.lean:23–41` takes a fixed reference-window estimate, then a Fourier profile-transfer theorem. `Dictionary/InverseRawUniform.lean:20–95` preserves the actual inverse source Schwartz function and charges the square of a weighted Fourier L1 norm. It supplies uniformity in the moving scale, clipping parameters, reversal, `sigma in [0,1]`, and derivative orders at most2. The final move to a height bound is monotonicity, not a new character-dependent exponent.

For marked inverse fields, `Detector/DetectorInverseMarkedField.lean:22` onward supplies actual source profile equality, pairwise disjoint live-prime lists, and primes larger than the deleted base modulus before applying the reference estimate. Both capacity inequalities remain required. `Dictionary/InverseMarkedUniform.lean:21–77,89–156` exhibits the actual polynomial Fourier identity and integrability, followed by the finite-energy transfer. The physical-product multiplier is held as the actual row-dependent multiplier; it is not assumed bounded independently and then dropped.

`Detector/DetectorInverseFields.lean:25` combines raw and marked constants. The raw `RawMoment` means the literal inequality in `Hecke/InverseAmplificationRaw.lean:11–16`, for every finite set of nonzero rows in the norm ball, positive polynomial scale, and its stated capacity condition. It is stronger than a single finite detector-fiber estimate and is used with that meaning.

The decisive order of quantifiers is:

| Stage | Uniform choices | Choices that may depend on later data |
|---|---|---|
| Fixed radial terminal certificate | degree, finite seminorm set before base character and ideal | constants and threshold may depend on that character and ideal |
| Each field theorem | height exponent before source character | constant and eventual threshold may depend on source character |
| Within an eventual field bound | threshold already fixed | arbitrary allowed `d`, rows, fiber, selected slots, height, profile parameters |
| `source_moments` | `J = Ji+Jm+Ju` before `eta` | `C_eta = Ci+Cm+Cu` before `tau` |
| Consumer | `0 < tau <= 1` | use height `Z^(2*tau)` in the already uniform field bound |

Finite-label summation and finite intersections of eventual events justify the source-character step. `Hecke/DetectorDyadicGeometry.lean:23–27` gives one threshold for all `d >= 1/200`. No maximum over an infinite family of arbitrary Hecke characters is taken. The source character remains outside the threshold. Similarly, this is polynomial control of unbounded heights, not a constant independent of height.

`source_moments`, `Detector/FinalAssemblyCertifiedBands.lean:80–136`, then merely increases each nonnegative constant and each height exponent, substitutes that height, and fills the four fields of the actual `SourceMomentBound`. The requested restrictions on row norms, detector data, external parameters, selected slots, and derivative order are still visible. The conclusion does not assert the inequalities for arbitrary batches which fail those restrictions.

## 5. Remaining cut and useful next audit

There is no local logical shortcut found in this transfer. That conclusion does not establish the analytic inputs below.

1. **Band production.** `DetectorCertifiedBands` is explicitly the hypothesis of `fine_moments_of_certified`, `chosen_moments_of_certified`, and the final nonvanishing consequences. The missing closure for this audit is a source-faithful producer at the final index with the full uniformity of section1. An index-zero estimate, a width arithmetic inequality, or bounds for a finite sample of states do not suffice.
2. **Inverse analytic estimates.** I inspected the reference wrappers down to `Dictionary/InverseRawInputBound.lean:14–64`, which applies `InverseInitialTotalEnergy.original_input_bound` to no marked slots, and `Dictionary/InverseMarkedReferenceDeletedEnergy.lean:44–113`, which applies `padded_source_energy` after proving the actual deleted-prime coefficient gates. The underlying total-energy and padded-source inequalities are the remaining analytic cut. Their names and presence in the source tree do not constitute an independent mathematical audit.
3. **Other imported analytic facts.** The fixed-support valuation theorem, the lattice summability theorem, and the uniform Fourier-density moment theorem were checked for their exact use and scope, not recursively re-proved here. The actual retained-source and Fourier identities above avoid a new gap at the final transport, but cannot certify those deeper estimates by themselves.

The named deeper inverse declarations are `InverseInitialTotalEnergy.original_input_bound` at `Inversion/InitialTotalEnergy.lean:20` and `DetectorDictionaryInverseMarkedReference.padded_source_energy` at `Dictionary/InverseMarkedReferencePaddedEnergy.lean:15`. Their bodies are deliberately outside this bounded audit; their files are pinned below to make that cut reproducible.

The next productive task is therefore the terminal-band successor mechanism on arbitrary `NaturalState` and actual `PositiveAt`, alongside the original inverse total-energy estimate if not already separately reviewed. Repeating the final `source_moments` assembly would not address that cut. No source declaration, frozen evidence file, or mathematical target was changed.

## Inspected source hashes

The table pins files, not a claim that every declaration in each file was audited. Exact decisive locations are identified above.

| Path relative to provider root | SHA256 |
|---|---|
| Detector/FinalAssemblyCertifiedBands.lean | BFA8FC2524634A7F7CCF893C944BBBDA6F0BD3A3DC666C13821CE06CF13F960F |
| Energy/CappedWidthInduction.lean | 4D9ED300268C73C78C65E7102D538EEF72613A450099C35131E12BA2B50C4325 |
| Energy/Bands.lean | 42FD3FE963D8DEEF1CC5772979B41A8273E80940641E9F24475FF33397A09C2E |
| Energy/State.lean | B5118D2F6F04ED495A6317317B74A7D60BA1B32F2050AEB7EE7E9E4783D67222 |
| Energy/BandMonotonicity.lean | 69378E8479851A178A8CCD6C725864C0E664127BA0EAAC2DE45371A709A51782 |
| Detector/FinalAssemblyData.lean | E4ED7337985E8B5843727F0884472DD98F3C04934FEF839F4E184125CF8C57FA |
| Detector/FinalAssemblyMomentInput.lean | 0AD3A3DB4CDEBAD7634684D3D4252A86E5539702641C4E64B9C994D89534CC07 |
| PrimeRows/NonfloorMoments.lean | 272F2E4E667CA3C459FFB477729F2389C8D71AD0BDAD48128167F8F4513F0AFB |
| Detector/DetectorMomentData.lean | 0FB5B95B1D8AABB0A0D77DEB9C38F5B151EE62D06DDE3D12FBF139AA65CE4E4A |
| Detector/DetectorPlainMarkedFineField.lean | 390B0FD2BF514884D39BBB25FFD0C03DF3FE9ACF658635194DAEC2EC86C3B67F |
| Detector/DetectorPlainUnmarkedRestrictedField.lean | 1DF9F3D50F2E4682C2568C93206A2EE570F54B4D98A7EB3ABBB751968DD2FE4C |
| Detector/DetectorPlainUnmarkedField.lean | BACF0E1A965881AAE9F52FC5F6A0A19E71CD11C77610FA27E53CE895434AE9E5 |
| Detector/DetectorInverseFields.lean | 7C264E1999AE65BBD7A813B35E26ED66A434B50B0176EC45465E74D6AD9A816B |
| Detector/DetectorInverseRawField.lean | B576ABA6A9B559297891F76BC0B3D31FF5E7DE9A75B5E38149CD774FED4820B8 |
| Detector/DetectorInverseMarkedField.lean | 4C52CB073D03585679FB8775B2EE48EB7A5BAB0C3B7B1212ADCD8491596568E3 |
| Moments/NaturalFixedRaySourceFixedIdeal.lean | 190E5726DBC032DB6D9C0EA31D9B45E7ABBBD8DDCC2ACB7564C34FEE8EAC26CB |
| Moments/NaturalFixedRaySourceInternal.lean | 0ADE3F70DE71BA092E670B54568BC84BD17A265AEB1412AB1BA71A9A61DD9CD4 |
| Moments/NaturalFixedRaySourceFreeExceptional.lean | E61699D887E4375EFE50CD0AD7C719857901066F1D11ECA3E82582A966C81514 |
| Moments/DetectorEnergyInitialState.lean | 74CAF55C289510B71DA89998948DF2457FC07567216E9C18E524F31656F812F2 |
| Moments/DetectorPlainExceptional.lean | 2AC61604F132E917464D5AAAC0EB40B10EBBF548D6E8A2CCA0DC3599DC6310C1 |
| Moments/DetectorPlainMarkedState.lean | 8CFF28C211620D98255B4C8FE9C3118BAA10DA9ACDCE9593F1A0C73C263E965D |
| Moments/DetectorPlainUnmarkedState.lean | DA29AB1A1C430E54F11698F3AAE55B3876BDEBE79D1BF252ED8ADA14A6C1C047 |
| Moments/DetectorPlainRelativeClass.lean | 328E28F69B77F5B5E960D14191F35F5E8DA9752B2593DA77E1232F7C34FB3713 |
| Moments/DetectorPlainProfileControl.lean | F6269102E894537DF1CAB668DDCD0AAD26DD47246D68AEC86CAF137B2726A1A5 |
| Moments/DetectorPlainMomentParameters.lean | 6CF9BABBC319A9A47C030BC507C945C62E93EF74AD39D976BC4A39FEBE2707FF |
| Moments/DetectorPlainFiberSource.lean | E49CDF473B10E9EB2CAAEDF90B37380E860CB42372D73995F6D2C8E1674115D8 |
| Moments/DetectorDictionarySource.lean | 2F9894C7CC17A0B329229F826397B6708A0294BBC40726AFA3C35248CD0F3E98 |
| Moments/InductionEnergy.lean | 1BB64BAC9E5E03FBDA5F90A1AB05519A145AFE75AEAC58C0B15EB67C0AB65141 |
| Moments/RadialEligibleEnergy.lean | 8BD68F1DB654D9EE362BEED04310456B2AF47BE17A6A8D23151C916FAB3C829C |
| Moments/FiniteProfileExceptionalPair.lean | F4E6A790FAFC9DCE047FBBC0ACC3FBB01643B288050E79A7EF3E3FF1E406028D |
| Hecke/InverseAmplificationRaw.lean | 8F68B18477343493C5ED8CD5F6F1B1F634C8B59883003FF0E3F3FA11C1CEE2AF |
| Hecke/Dyadic.lean | 15E88379D7386D4D0A873C8D2467EF28AF8ED5FB7392219D634F616B9D36C2A2 |
| Hecke/DetectorDyadicGeometry.lean | 98B41CC892745A4A4796BEE61C8617D2B4F6C7F343BAE375D0749023AB2F46C5 |
| Dictionary/InverseRawReference.lean | 805C7D060071F5C78DD80D502316132AA4AA95CCF6C704BA5F765F546AF13E15 |
| Dictionary/InverseRawInputBound.lean | E46B3996C16226543290848EEE3C650A189DD2CFDFEA27807EF71B6244AC9F01 |
| Dictionary/InverseRawUniform.lean | CB31D97592C4288A1C84EC3FCA84298C11FE69ABF23087CE8EFA9E5736FDDA39 |
| Dictionary/InverseMarkedReferenceFiberEnergy.lean | 722B43BD851931C771E0A170C5218922A106FBC1C67EBD8A3763ED84076F878A |
| Dictionary/InverseMarkedReferenceDeletedEnergy.lean | DE26949474B45877FA18D6424B678428E43E970431C66ECAE04D3D3C9E916AAA |
| Dictionary/InverseMarkedUniform.lean | A47B14E253ECC1D6AB066593843BE8F2509E176696EA7915E1E4E85F43685298 |
| Inversion/InitialTotalEnergy.lean | 15B1B715C4449310DE64E31FA4852233EE85E7B57C1D03F44ED3F78CEE5616F8 |
| Dictionary/InverseMarkedReferencePaddedEnergy.lean | AF3C645DF35997C69F960CFE313241A7F9931B48C130BBB8E854973F0E05ED26 |
