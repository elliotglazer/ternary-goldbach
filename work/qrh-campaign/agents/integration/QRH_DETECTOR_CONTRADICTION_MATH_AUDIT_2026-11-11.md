# Detector moments to the zero contradiction

2026-11-11. Bounded mathematical/source audit of the candidate global seven-eighths proof. The current research checkpoint was read first. No build, evaluator, Lean declaration, dependency change, source edit or broad trust scan was performed. No conclusion here validates the whole QRH proof.

Source root `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, repository commit `4eaee87548250b2682affda7d05d947c05554bae`. Paths below are relative to that root. The source hash table fixes the files used. The candidate public theorem has the correct target, but successful elaboration, allowed transitive axioms, and the deeper analytic estimates remain separate obligations.

## 1. Finding and precise audit boundary

The inspected outer contradiction is mathematically coherent. It does not conclude from a negative zero count. It constructs one positive saving uniform over characters, uses that saving to continue a reciprocal-L signal left of the supremum of real parts of zeros, and contradicts an actual primitive zero strictly above that continuation boundary. The sentinel cannot supply this zero. The chosen-data type is inhabited, the source windows are nonzero, and the normalization denominator is eventually nonzero. These checks exclude vacuity from empty data or division by zero; they do not independently prove that every normalized probe is a nonzero function. A zero probe would still have to satisfy the substantive approximation estimate for the actual signal.

This round reconstructed the supremum/continuation contradiction, the moment-exponent absorption, the final high-bound exponent comparison and finite row partition, and the explicit discharge of the final assembly's parameter/data predicates. It read the capped-induction assembly body and identified its genuine analytic inputs. It did **not** independently prove the low/high/zero-stage analytic estimates, the raw inverse/marked/unmarked moment theorems, the normalized single-cell estimate, the physical-probe transport, or all analytic Fourier/Mellin foundations. Thus this is a checked upper proof segment with a named substantive frontier, not a proof of global QRH or a finding that only compilation remains.

## 2. Actual carrier, zero inclusion and nonvacuous supremum

`Hecke/Family.lean:14-29` works over `K=CyclotomicField 3 Q` and its ring of integers O. A `Character` contains a nonzero ideal modulus, a complex multiplicative character of its quotient, triviality on global units, and a positive integer period belonging to the modulus. It is not a Dirichlet character silently relabelled as a Hecke character.

`Hecke/ZeroSupremum.lean:10-16` defines

`Z = { Re(s) : exists chi, 0<Re(s), (s!=1 or chi.residue!=1), LFunction chi s=0 }`,

`beta = sSup(insert (1/2) Z)`.

Euler nonvanishing for Re(s)>1 supplies the bound beta<=1; the sentinel supplies nonemptiness and beta>=1/2. Every actual admissible zero belongs to Z and has Re(s)<=beta by `zero_re_le_beta:43`. The definition excludes the principal pole but allows a nonprincipal zero at1 if one were to exist; it does not assume zeros lie on a critical line, have positive ordinate, or are simple.

`Hecke/PrimitiveSupremum.beta_eq_primitive_supremum:29` uses finite deletion to replace any zero with real part at least1/2 by a primitive character's zero at the **same point**. Smaller real parts are dominated by the sentinel. `exists_primitive_zero_near_beta:46` then supplies a primitive actual zero above beta-epsilon whenever epsilon>0 and1/2<=beta-epsilon. Its proof uses the strict near-supremum inequality to exclude the sentinel, rather than assuming the supremum is attained.

Finite deletion is substantive. `Hecke/FiniteDeletion:126-159` uses the identity `L_chi=L_psi*factors` on Re(s)>0, pole compatibility from `principal_iff_of_mask:97`, and nonvanishing of the finite Euler factors at `:32`. The two directions are kept distinct: primitive reduction needs the factors nonzero; transferring the primitive zero to the excluded-prime character in the common probe only uses multiplication by a finite factor. This round checked the consuming equations and pole logic, not the entire ideal-Euler/primitive-character construction underlying them.

## 3. Quantifier order in the moment input

`Detector/FinalAssemblyChosenData.lean:13-28` has the following order under the contradiction assumption beta>7/8:

`exists D, exists F:SourceData D, exists counts, exists J>=0, forall eta, exists C>0, forall 0<tau<=1, eventually Z, SourceMomentBound ...`.

D, F, counts and the exponent J are chosen before the character eta and the height parameter tau. C may depend on eta, but not tau. The eventual-Z threshold may depend on both. The final contradiction only needs a uniform saving and continuation boundary, not a common numerical C or starting height for all characters.

The stronger `FineMomentInput` chooses a positive mesh function before D, then quantifies over every sufficiently fine D, every F and counts, and only then chooses J. `chosen_input_of_fine:30` actually constructs D using `ParametersHighDataFine.exists_high_data_fine:10`, F using `FinalAssemblyData.exists_source_data:33`, and counts using `source_count_parameters:46`. It does not infer existence from a universal statement over a possibly empty data type.

The fine construction chooses `t=min(Delta/8,1/100000000)`, then finitely many slots for the positive quantity `min(t,mesh(t))`, then an allowance depending on the resulting N, then the smaller detector parameters. This order avoids a mesh/data circularity. `HighData` explicitly has N>0, positive injective slot lengths with sum1/6, positive rmin, cost, epsilon, e, eps and sigma. Its sigma is `min(t/2,((7/8)*rmin)/4)>0`. F explicitly has nonzero real and complex windows, nonnegative weights, compact support in(1,2), and a nonzero ideal modulus. These conditions rule out choosing an all-zero smoothing function.

## 4. From certified bands to those moments

The selected public path is

`Nonvanishing:19 -> FinalAssemblyUnconditional.dirichlet_nonzero:37 -> FinalAssemblyCertifiedBands.dirichlet_of_certified:150 -> chosen_moments_of_certified:147 -> fine_moments_of_certified:138 -> chosen_input_of_fine -> common_probe_of_chosen_moments:57`.

`FinalAssembly.lean` is a parallel raw-moment route. Its `common_probe_of_raw_moments` still takes RawMomentInput. The selected unconditional wrapper uses certified bands and fine/chosen data instead; no RawMomentInput is silently assumed.

`FinalAssemblyUnconditional.detector_certified_bands:15` constructs the required band using `Energy/CertifiedExistence.terminal_certificate:40`. Its apparent beta-dependent premise is not the desired theorem in disguise. With Delta=beta-7/8,

`kappaPlain(D)=3/4+2*Delta=2*beta-1`.

Thus the required `2*beta-1<=kappaPlain` is equality. The assumptions beta>=.51 and kappaPlain>=.75 follow from the contradiction assumption beta>7/8; stageError=t/4>0 follows from D. The other premises are explicit window support/smoothness, numerical slot endpoints1,2 and integration endpoints1/4,9/4, the supplied positive radial parameter, mask0, width cap2 and range1. The unused fine-mesh hypothesis in this wrapper is harmless: the band theorem is stronger, and fine-mesh control is consumed later by the marked moment bound.

`Energy/CappedWidthInduction.CertifiedBand:51` is not just a Boolean label. It asserts uniform finite derivative/control data, then for every base character and admissible fixed ideal there are positive constants and eventual actual `ZeroAt` and `PositiveAt` bounds. Its terminal conversion uses the exact terminal width=cap and final stage loss<=epsilon. `CertifiedExistence.certified_bands:19` proves it by finite induction: a floor theorem and `CappedAnalyticSuccessor.actual_successor:30`.

The successor body was read. It establishes parent/child widths, contour request bounds, positive reserve and mesh, invokes `actual_capped_low`, `actual_high_stage`, `actual_zero_stage`, and packs those results using the prior band. In each final branch it intersects the prior/low/new eventual events and supplies the old zero/positive bounds to the new stage. The dependencies are on the previous stage k, not on the desired band k+1. This checks the assembly's inductive direction; the cited stage theorems remain analytic audit leaves.

`FinalAssemblyCertifiedBands.plain_inputs:39` instantiates the band at the actual `sourceFixedIdeal F=F.modulus inf span(72)`. Its nonzero/proper-ideal and containment premises are proved by `Moments/NaturalFixedRaySourceFixedIdeal:16-36` and `DetectorEnergyInitialState.source_fixed_gates:100`, not omitted as impossible hypotheses. In particular F's required bad-prime exclusion makes sourceFixedIdeal proper, and intersecting with a character modulus preserves the required non-top property. The positive-radial assertion is used universally; the zero assertion is specialized to the actual radial support bound.

`source_moments:80` combines three genuine source fields: inverse, fine marked-plain, and restricted unmarked-plain. Their nonnegative natural exponents Ji,Jm,Ju are replaced by J=Ji+Jm+Ju, chosen before eta. Constants add to Ci+Cm+Cu. Since height>=0, every power of1+height is bounded by the summed exponent. The body supplies all four components of `SourceMomentsAt`; it does not replace the moment predicate by only one component. Its selected batch/fiber/nonempty hypotheses and width/external-parameter equalities are forwarded to the three source theorems. Their analytic estimates, rather than the elementary sum-of-exponents step, are major unverified leaves of this audit.

## 5. Height absorption and the actual uniform high saving

`chosen_data_height:38` uses D.height_choice after J is known. In the concrete fine constructor one may take

`tau=min(cost/(3200), min(1/800,t/(4*(J+7))))>0`.

This supplies tau<1/400,4tau<cost/200,tau<t,2tau(1+J)<=t, and tau(2+4eps)<t. In particular tau<=1. For Z>=1,

`C*(1+Z^(2tau))^J <= C*2^J*Z^(2tau*J) <= C*2^J*Z^t`.

The slightly stronger budget2tau(1+J)<=t also implies2tau<=t. This is exactly `FinalAssemblyMomentInput.polynomial_height_absorption:41`; no character-dependent J is absorbed into a supposedly uniform tau.

`FinalAssemblyFixedHigh.fixed_high_bound:14` then gives, for every eta, an eventual estimate with positive finite constants

`||F.probe eta Z - signal(excludePrimes eta,H,-11/16,Z)||`

`<= (Ct+C*Cm*Norm(eta.modulus)^(2eps))*Z^(beta-11/16-sigma)`.

Here H is the actual `sourceCorrection eta F.S`. The fixed-high body supplies all scalar premises to `FinalAssemblyHigh.actual_high_probe_from_raw_moments:18` using the fields of D and the inequalities above. Notable inequalities are `13/16+3t<=7/8`, the count budget `159epsilon+9t<=1/32`, and the full central budget at `HighData:41-43`, bounded by49/440640. These constants are not an assumed zero-free estimate; the fine-data constructor arranges them by shrinking positive parameters.

The row-moment application is not vacuous. For each nonempty selected row bin, the body derives j!=0 from membership in the supported nonfloor rows, hence `.51<.51+e*j<=1`. It obtains the lower/upper row norms and conductor range from the actual dyadic geometry. Since i<=n and `(3n+1)<=Z^tau` eventually, every required height `(3i+1)Z^tau` is at mostZ^(2tau). These facts instantiate the full SourceMomentBound. Empty bins are handled separately as zero finite sums, not as evidence that all bins are empty.

The high-bound exponent was checked through `FinalAssemblyHigh` and the full body of `FinalAssemblyCollected.actual_nonfloor_rows_saving:18`. The latter sums the normalized cell estimates over actual dyadic bins and i,j labels, paying a positive dyadic cost. Its normalization is proved nonzero eventually by `actual_ray_normalizer_inverse`; the probe's division is not justified by Lean's totalized division alone. The central term has exponent

`3/16+Delta-saving+nu+dyadCost`.

At the fixed parameters saving=t and nu=dyadCost=t/8. The D.high_saving field `sigma+t/8+t/8<=t` gives

`3/16+(beta-7/8)-t+t/8+t/8 <= beta-11/16-sigma`.

For Z>=1 this is the correct upper-bound direction for real powers. The physical transport error already has the right exponent. The triangle inequality and addition of positive constants yield the displayed final estimate.

The count record itself has balanced and high fields, split at `2a-1<=5/6` and its strict complement. `FinalAssemblyCountParameters.exists_count_parameters:48` constructs it by calling the corresponding adaptive raw-moment counting theorems. It is a proved-data dependency in the source architecture, not a free public parameter; those two counting theorems' substantive estimates have not been re-proved here.

## 6. The exact contradiction, including regularization

Assume beta>7/8. Put Delta=beta-7/8 and omega=Delta/2. `FinalAssemblyChosenData:57-75` obtains the same D,F,tau and sigma for every primitive eta and supplies:

* `J_eta=F.probe eta=O(Z^(3/16+omega))`, from the actual low-probe bound;
* `J_eta-signal(chi,H,-11/16)=O(Z^(beta-11/16-sigma))`, from section5;
* chi is eta with F's finite primes excluded, with the exact ideal-coefficient mask;
* H is analytic on Re(s)>7/8 and `||H(s)-1||<=1/2` there.

`Hecke/CommonProbe.PrimitiveContract:13` permits chi,H,J to depend on eta. It requires omega and sigma fixed before eta. `actual_source_analytic` supplies the mask and H statements, so H cannot be chosen zero.

Set `epsilon=min(Delta-omega,sigma)>0` and `a=beta-epsilon`. By `Supremum:10-42`, a>=7/8+omega>7/8 and a<beta<=1. The two estimates give

`signal=O(Z^(max(3/16+omega,beta-11/16-sigma)))=O(Z^(a-11/16))`.

Because a>7/8>1/2, primitive supremum approximation supplies an actual eta-zero rho with Re(rho)>a. The finite-deletion mask preserves the pole exception and makes rho a zero of L_chi. There is no step assuming the extremal zero is attained or has bounded ordinate.

For c=-11/16 the source defines `signalMellin f c s = mellin f (-(s+c))`. The polynomial bound at infinity, local integrability on positive reals and rapid decay at zero imply this function is analytic for Re(s)>a. `Continuation:45-74` derives those Mellin domain inequalities explicitly; the local/zero-end properties of the actual signal are supplied by `Hecke/Signal:166,231`.

`Hecke/SignalIdentity:26` first identifies the Mellin transform with the amplitude on Re(s)>max(a,1). The identity is proved from the Fourier-inversion line through2, with a punctured approach and analytic identity theorem. It is not inferred from a single equality at2. Euler nonvanishing is used only in Re(s)>1 at this stage.

Write R(s)=s-1 for a principal chi and1 otherwise, and Lreg=the entire pole-removed L in the principal case or the entire nonprincipal L otherwise. `SignalIdentity:64-101` constructs these functions and supplies `Lreg(rho)=R(rho)L_chi(rho)` and R(rho)!=0 from the pole exception. On the initial half-plane the identity is

`Lreg(s)*signalMellin(s) = R(s)*exp((s-5/6)^2)*H(s)`.

`Continuation.product_identity_on_halfPlane:76` continues this product identity throughout the connected open half-plane Re(s)>a. At rho its left side is0. Its right side is nonzero: R(rho)!=0, complex exp never vanishes, and `||H(rho)-1||<=1/2` forbids H(rho)=0. This is the literal contradiction in `nonzero_of_regularized_signal:94-111`, consumed by `SignalIdentity.nonzero_of_probe_bounds:103` and `CommonProbe.beta_le_seven_eighths:27`.

All exceptional points in this consuming argument are covered. Re(rho)>a>7/8 excludes0. A principal rho=1 is excluded by the zero carrier; a nonprincipal rho=1 uses R=1 and the nonprincipal mask identity. No zero simplicity, enumeration, multiplicity weighting or positivity of Im(rho) is required for this location argument.

## 7. Return to the actual Dirichlet L-function

`Hecke/Dirichlet:71` builds the Hecke character via the ideal norm, with unit triviality proved. `LFunction_eq_dirichlet_product:128` identifies its continued L-function with `L_chi(s)*L_baseChangeChi(s)` away from0,1 by analytic continuation of the Euler identity. For7/8<Re(s)<1 both exceptional points are avoided, and nonvanishing of the Hecke product implies nonvanishing of the first factor. For Re(s)>=1, `dirichlet_seven_eighths_of_hecke:158` uses the separate Mathlib `LFunction_ne_zero_of_one_le_re` and the original pole exception. No naive Dirichlet series is used below its absolute convergence line.

The final export at `Nonvanishing:19` therefore has exactly q>0, a complex Dirichlet character,7/8<Re(s), and exclusion of the principal pole. There is no detector, primitivity, moment, height or finite-zero hypothesis in its statement. That is a statement/source fact, not evidence that its proof term has passed the target kernel. The distinct public zeta-at1 theorem is not needed by the selected Goldbach integration, which uses the Dirichlet modulus-one export away from the pole.

## 8. Substantive remaining frontier and next useful audit

The following are the exact deepest obligations used but not independently established in this bounded audit:

| Leaf or group | Role and unresolved content |
|---|---|
| `Detector/FinalAssemblyNormalized.actual_normalized_nonfloor_cube:18` and `PrimeRows/NonfloorTransport.actual_nonfloor_probe_transport:23` | The actual detector/moment saving for one nonempty cell and the decomposition of the physical probe into signal, retained central rows and bounded remainder. The final exponent comparison does not prove these estimates. |
| `Detector/DetectorInverseFields.source_batch_inverse_fields:25`, `DetectorPlainMarkedFineField.source_batch_plain_marked_fine:30`, `DetectorPlainUnmarkedRestrictedField.source_batch_plain_unmarked:44` | Actual inverse and plain moments with uniform exponent/control data. Reading the outer combination does not validate their analytic continuations or energy inequalities. |
| `Energy/CappedLowStage.actual_capped_low`, `NaturalHighStage.actual_high_stage`, `NaturalZeroStage.actual_zero_stage`, and `WidthFloor.actual_joint_floor` | The nontrivial energy induction. This round checked that successor packing consumes stage k and smaller requests correctly, not that each analytic stage estimate is true. |
| `PrimeRows/NonfloorCount` balanced/high adaptive count producers | The real moment-to-row-count bounds at both exponent regimes, including their uniform constants and nonempty-fiber conditions. |
| Actual ray normalizer/low-probe estimates and finite Euler/primitive-character foundations | The positive normalizer, low exponent3/16+omega and source correction bound. SourceData's nonzero window and the explicit nonzero-normalizer conclusion expose these obligations rather than discharge their analytic proofs by definition. |
| `Hecke/Signal.signalMellin_eq_amplitude_on_line:237`, contour/reciprocal bounds, and the continued Hecke/Dirichlet product foundations | Actual Fourier inversion, local integrability, rapid decay and source-function identities used in the reconstructed analytic contradiction. The identity theorem and the contradiction were checked here; their input analysis still needs its own audit and kernel validation. |

The highest-value next bounded source audit is the normalized nonempty-cell theorem together with its immediate raw moment/count estimate, or one complete low/high/zero induction stage with its exact premise chain. It should produce a real inequality derivation rather than another import count. All these leaves currently have candidate source bodies; this report neither found a new missing public assumption nor certified those bodies. No finite spectral assertion or global QRH claim is authorized as an added Goldbach premise.

## 9. Source pins

The table records files read at this cut. Line references identify declarations, and source hashes fix the exact body version. No hash is a proof or a successful build receipt.
| Source relative to OAI/NumberTheory/DirichletL | SHA256 |
|---|---|
| `Nonvanishing.lean` | `16A7F55147E177E972264A2AC61D1639188A2090844A89D1C080CBA8500791CC` |
| `Supremum.lean` | `52A4EA682DC8EB58BE4F774AFECC72F9D6543501A8891B63D2BF3F8D9CFCCA07` |
| `Continuation.lean` | `BAF2CD9ADB5911D766AABD9112EEA36DA4841E8EC04852A369882AE45D253E85` |
| `ParametersCentralBudget.lean` | `93CD4D46B1633620712FDE28749593C79E28D8C3A1FE4E77210D222E50C574E3` |
| `ParametersHighData.lean` | `4BBF9A79F4A7CAA8BA443C1E5F6DBACFD6821D59D993270443B46F2D212B0691` |
| `ParametersHighDataFine.lean` | `C2192E143746349197464D1ECA3AFB8DC7F20538AC6B0F1504A6F09D2D53E243` |
| `Hecke/Family.lean` | `B18557C5C055910287507F1ED2B1F7BB31EDE318CB62A2A10A3140F1995A9408` |
| `Hecke/ZeroSupremum.lean` | `F27256644A64572823B53CAE87483C4726192FF906EE7F64AE30E13F77E57242` |
| `Hecke/PrimitiveSupremum.lean` | `8DC3B1BBD50945D38EDC095181429C1864F409096503163AA63B448496BB9D45` |
| `Hecke/CommonProbe.lean` | `D2FE9C934B4DE31248CFC3B4F0F5B806BBCEF6A6C8769805C74CAA556E0A8097` |
| `Hecke/FiniteDeletion.lean` | `8186CCBFBB6D3BD95E65AD807C852B82204C689664CDDEDAB2407035911AE72C` |
| `Hecke/Dirichlet.lean` | `55D1D7D6CAF40B33973651D25A12DE35DCFF0E3F9BFACF7F84E4997D8014702F` |
| `Hecke/Signal.lean` | `EC7A4403C352DEE276850EA4418122C03DD3A5BC108AC8352FCD866578BE36F6` |
| `Hecke/SignalIdentity.lean` | `2FF1E2AAB2956D512457F121068804D65B34D790AB70520F2836041C44776C2E` |
| `Detector/FinalAssembly.lean` | `1BD9D5C4550057F027CF83B9795B2B5CCAF60E986BC43E8CF0B45D101D7A8F32` |
| `Detector/FinalAssemblyChosenData.lean` | `0D072EFAFE870A968D5D9DCDCC98309BFDDA366637E1D9E812B8BFFC4D26D6BE` |
| `Detector/FinalAssemblyCertifiedBands.lean` | `BFA8FC2524634A7F7CCF893C944BBBDA6F0BD3A3DC666C13821CE06CF13F960F` |
| `Detector/FinalAssemblyUnconditional.lean` | `70D01B604FD5CC3522A4503543D9A5E422F9105C19E88985C5CD7C28C5958BA2` |
| `Detector/FinalAssemblyMomentInput.lean` | `0AD3A3DB4CDEBAD7634684D3D4252A86E5539702641C4E64B9C994D89534CC07` |
| `Detector/FinalAssemblyFixedHigh.lean` | `B3B043756695167550FC3FAD7D088DCE5C4A83234900DF4C5CBB6C229586DD23` |
| `Detector/FinalAssemblyHigh.lean` | `05514C32466FBE9D72C86B52ED5CA91BA38ED42617CC1579CE3D6B67F218E726` |
| `Detector/FinalAssemblyCollected.lean` | `1ECAF8B60EDBE7FE40746AE74701EBDEBC75BC8F3DCE39D95F720D98FEB169C7` |
| `Detector/FinalAssemblyData.lean` | `E4ED7337985E8B5843727F0884472DD98F3C04934FEF839F4E184125CF8C57FA` |
| `Detector/FinalAssemblySource.lean` | `03F9668E3D43A20F5F1EF554C852BFCA64CBF90EC5D4C305114EC166BD1954E9` |
| `Detector/FinalAssemblyCountParameters.lean` | `F2183C59E14C429D7C63042D4E4694EA906955C1FB03F94B407474173DED365B` |
| `Energy/CertifiedExistence.lean` | `498BEA492166111FC95D17B7F2C379D26BF6D03013299B8D410793EA0B438066` |
| `Energy/CappedWidthInduction.lean` | `4D9ED300268C73C78C65E7102D538EEF72613A450099C35131E12BA2B50C4325` |
| `Energy/CappedAnalyticSuccessor.lean` | `4EC231F505ED8D60B0CC096951EA1F259E96E1B4C4709DEDA62FE0E69351E772` |
| `Moments/DetectorPlainMomentParameters.lean` | `6CF9BABBC319A9A47C030BC507C945C62E93EF74AD39D976BC4A39FEBE2707FF` |
| `Moments/DetectorEnergyInitialState.lean` | `74CAF55C289510B71DA89998948DF2457FC07567216E9C18E524F31656F812F2` |
| `Moments/NaturalFixedRaySourceFixedIdeal.lean` | `190E5726DBC032DB6D9C0EA31D9B45E7ABBBD8DDCC2ACB7564C34FEE8EAC26CB` |



