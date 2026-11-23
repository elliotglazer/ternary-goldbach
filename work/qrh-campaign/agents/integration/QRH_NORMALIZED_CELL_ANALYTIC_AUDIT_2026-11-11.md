# Normalized nonfloor cell: analytic audit

This is a bounded source and paper audit, not a Lean build, axiom audit, or proof of global QRH. No defect was found in the count-to-normalized-cell argument reconstructed below. The substantive remaining inputs are named in section 8. In particular, this result does not certify the raw moment estimates, the prime-row analytic estimates, or their complete transitive dependencies.

The source repository is `work/openai-math`, commit `4eaee87548250b2682affda7d05d947c05554bae`. All Lean paths below are relative to `lean/OAI/NumberTheory/DirichletL/` in that repository. Exact file hashes are recorded at the end. The checkpoint and `work/qrh-blueprint/QRH_PROVIDER_MATH_FRONTIER_2026-11-11.md` were read. The earlier detector-contradiction audit, SHA256 `B28B9982BEAD587411C9FC10F5D61C06A03073E59B3701F85B8B328C6CF48ABC`, and its review `6F5A1D26DAA6B4BCB271694F40BB6D82BE046D879288B4F93E26E980CBFA6505` remain unchanged.

## 1. Exact theorem and quantifier order

The selected declaration is `ProbeFinalAssembly.actual_normalized_nonfloor_cube`, `Detector/FinalAssemblyNormalized.lean:18`. Its conclusion has the form

`exists C>0, forall eta, eventually Z, forall d,v,a,C0,rows,i, ... => normer != 0 and ||cube/normer|| <= C*C0*Norm(eta.modulus)^(2*eps)*Z^(3/16+Delta-saving+nuN)`.

Here `nuN` denotes the source binder `nu`, the normalization loss. It is distinct from the Greek `ν` used in the count loss. All fixed slot data, cutoffs, budgets, `Delta`, and the supplied `CountParameters` precede `C`. The eventual threshold may depend on `eta`; it is uniform in the subsequent cell data, the three height coordinates, and `C0`. The height-moment premise is required throughout the closed cube, not just at sampled heights.

The similarly named `ProbeHighRowFamily.actual_normalized_nonfloor_cube` in `PrimeRows/NonfloorNormalized.lean:17` is a parallel wrapper with existential `cB,kB,cH,kH` before `eta`. It is not the source of the selected fixed-count wrapper. `CountParameters` is supplied to the latter, and `Detector/FinalAssemblyCountParameters.lean:49` constructs such parameters from the two conditional raw-moment counting theorems. A result-shaped structure is therefore not being silently assumed at the public assembly boundary. Its producer proofs still require audit at the stated deeper frontier.

The generic conclusion has a useful saving only when `saving>nuN`. There is no such positivity premise on the generic `saving` binder. In the actual call, `Detector/FinalAssemblyFixedHigh.lean:28–45` takes `saving=D.t`, `nuN=D.t/8`, with `D.t>0`. Thus this cell contributes exponent `3/16+Delta-7*D.t/8`. The later dyadic loss is another `D.t/8`; it is not part of this theorem. The condition controlling that later use is `sigma+nuN+dyadCost<=saving`, `FinalAssemblyHigh.lean:60`.

## 2. Actual nonempty cell and source predicates

The finite rows are `FreeRow`s over the Eisenstein integer source carrier. Each selected row has `u.val!=1`, `rowNorm u>=Z^(1/100)`, nonzero calibrated residue, and `rowNorm u<=Z^(d-margin)`. The same rows lie in `[Z^v,2*Z^v]`. The theorem requires `.51<a<=1`, `i<=n`, current detector maximum at `3*i*Z^tau` at least `a`, and next detector maximum at `3*(i+1)*Z^tau` strictly below `a+2*e`.

These two detector bounds have different uses. The lower bound constructs the supported witness and batch; the upper bound controls the continued row kernel and prime amplitudes. Neither is replaced by a bare assertion that the cell has a label. The calibration nonvanishing and nonfloor conditions are retained through every row restriction.

`SourceExclusions`, `Detector/SourceExclusions.lean:24`, requires every excluded ideal to be prime, inclusion of the fixed bad primes, and the correction-tail predicate. `FirstTail (4*e) S` is a separate analytic premise. The actual prime pools are `ProbeRaySlots.pool`, `Detector/RaySlots.lean:14`: primes in the identity ray class, outside `S`, with `floor(c*Yj)<Norm(P)<=floor(b*Yj)`. Their weights have support in `(c,b)`. The pool membership theorem at line 17 gives the exact endpoint convention.

The slots satisfy `Yj=Z^ell_j`, positive distinct `ell_j`, `sum ell_j=1/6`, and `rmin<=ell_j/d<=Rslot`. `CubeFixedPrimes.lean:68–89` proves these scale inequalities and obtains eventual pairwise disjointness of the prime pools from injectivity of `ell`. The slots cannot be an empty family because their sum is `1/6`.

In `FinalAssemblyClass.lean`, a nonempty amplitude class `rows'` is a filter of the supplied rows. The body constructs an actual `Batch` with `B.rows=rows'` and exact equalities for its source moment data, reverse orientation, slot set, widths, profiles, upper cutoffs, external frequency, mesh, bin width, and detector family. This is the crucial nonvacuity check for `SourceMomentsAt`, defined in `PrimeRows/NonfloorMoments.lean:15`. Its universal premise over matching batches is instantiated with this constructed batch and every nonempty fiber. The argument does not merely postulate an unrelated batch satisfying an empty implication.

The nonempty class also supplies `0<=q<=delta/2`, where `delta=2*a-1>0` and `q` is its actual weighted amplitude mean. Hence division by `delta` in the balanced cutoff is legitimate. Empty amplitude classes contribute zero; they need no witness or mean estimate.

## 3. What the moment premise says, and the two counts

`Hecke/DetectorRawFiber.lean:15–47` makes each fiber nonempty and fixes its supported witness label and dyadic endpoints. It records the actual character coefficients, including the reverse/conjugate choice, positive slot widths bounded by the slot mesh, total width at least `7/37`, and actual physical-amplitude bins. `Moments` at line 62 contains four quantitative conditions, not a Boolean proxy for the desired count:

* `inverse_raw` gives raw moments for logarithmic orders up to two, both the profile and its scaled version, over all real parts in `[0,1]` and heights in the stated interval.
* `inverse_marked` bounds squared polynomial-times-selected-slot products under both capacity restrictions `r+2*width<1` and `2*r+8*width<3`.
* `plain_marked` bounds the two polynomial factors times selected slots under `2*m+6*(3/4+2*Delta)*width<=1`.
* `plain_unmarked` gives the corresponding bound without selected slots, with exponent `max(1,2*m)+epsilon_m`.

The selected source count is `FinalAssemblySourceCount.adaptive_source_count_from_raw_moments:94`. Put `O=logCost+heightCost+momentCost` and `Lc=159*epsilon+epsilon_m+Rslot+7*ν`. It proves

`card(rows') <= K*C0*Z^O*(Z^d)^Rcount`,

where

`Rcount = balancedRowCount(delta,1/2-q/delta)+Delta/4+Lc` if `delta<=5/6`,

and `Rcount=1-delta+78*epsilon+epsilon_m` if `delta>5/6`.

The equality case belongs to the balanced branch. Both moment constants are chosen before the cell. The body combines the two constants using `max(KB,KH)`, intersects their eventual thresholds, and uses the same case split in the moment premise and conclusion.

`PrimeRows/NonfloorCount.lean:14–89` identifies the balanced maximum of short and long exponents with `Endpoint.balancedRowCount` at the adaptive cutoff. The high branch reduces the cutoff to `3/2`. The independently inspected deeper chain is `DetectorFixedAmplitudeCount` / `DetectorHighBatchCount`, then `DetectorCountFromMoments` / `DetectorHighCount`, then the raw branch and no-slot counting bounds. Balanced counting uses all four moment forms as needed. If a selected-slot capacity is exhausted it falls back to the raw or unmarked bound; it does not assume a positive admissible selection always exists. High counting uses the inverse raw/no-slot endpoint and the witness bound `r>=1-76*epsilon`, producing the `78*epsilon` loss. Its lack of `Delta` and `q` in the final count is consistent with that proof.

The source prefactor conversion absorbs the finite character-label count, dyadic/logarithmic factors, bin count, and moment height into `Z^O`. The frequency condition is `2*pi*allowance+3*i*Z^tau<=Z^heightCost`, with `allowance=(Z^d)^(tau/(2*dmax))`. It holds uniformly for `d<=dmax`, `i<=n`, using `tau<heightCost`; no uncharged growing height factor is discarded. This conversion is linear in `C0`, including `C0=0`.

## 4. Prime-slot estimate and physical exponent

`CubePrimeBound.actual_cube_prime_bound:22` combines actual phase-bin bounds with `Detector/CentralPrimeSum.actual_central_prime_sum:13`. For each row it gives

`||sum_P calibratedTupleValue|| <= C*Norm(eta.modulus)^(2*eps)*rowNorm(u)^alpha*Z^loss*product_j Yj^(-4/25+g_j+mesh)`,

where `alpha=a-1/2+12*e+eps*(N+8)`. It also gives actual amplitude bounds and a lower squared-amplitude spike whenever `g_j>0`. The temporary height factor `(3+(3*i+2)*Z^tau)^(2+4*eps)` is absorbed using the strict hypothesis `tau*(2+4*eps)<loss`. Thus `Z^loss` already pays this factor.

The identity `CubeSlotExponent.source_slot_product:25` transforms the product exactly to `Z^(-2/75+q/6+mesh/6)`, using `sum ell_j=1/6` and `q=6*sum ell_j*g_j`. The dyadic factor is also exact up to a fixed constant. `CentralDyadicWeight.dyadic_weighted_rows_card:11` uses `||frequencyWeight(z,u)||=rowNorm(u)^(-17/50)` and an annular bound valid for either sign of `alpha-17/50`. It does not reverse a power inequality when that exponent is negative.

Together with the count, `CentralClassArithmetic.lean:22` and `FinalAssemblyClass.lean:18` yield class exponent

`Eclass = O+d*Rcount+v*(a-1/2+12*e+eps*(N+8)-17/50)+loss-2/75+q/6+mesh/6`.

The cardinality of the finite amplitude alphabet is bounded independently of `Z`. `FinalAssemblyArithmetic.lean` pays `(alphabetBound(mesh)^N+1)` in the constant when summing classes. It does not charge another row count or hide a power of `Z` there.

## 5. Exact margin and all exponent costs

The physical Mellin scale is

`(Z^(17/48))^(4/25)*Z^(a+16*e-33/50)*(Z^(23/48))^(-a-6*e)=Z^P`,

`P=(25/48)*a-181/300+(105/8)*e`.

`NonfloorExponent.central_class_exponent_identity:41` proves

`P+Eclass = mixedSourceExponent(a,v,d,Rcount,q)+realLoss(N,v,e,eps,loss,mesh)+O`.

Here `mixedSourceExponent=sourceExponent(a,v,Rcount,q)+(d-v)*Rcount`. This correction is essential because row norms use `v` while moment counting uses `d`. Under `d-v<=mu`, it costs at most `3*mu/2` in the balanced branch and `mu` in the high branch. The dyadic upper edge `v<=13/16+zeta` costs `2*zeta`. Since `zeta<=3/16`, `v<=1`, and

`realLoss=(105/8)*e+12*v*e+v*eps*(N+8)+loss+mesh/6 <= 26*e+(N+8)*eps+loss+mesh/6`.

`CentralMixedMargins.lean:23–59` gives the balanced margin

`mixedSourceExponent-(3/16+Delta) <= -49/440640-(51/64)*Delta+(13/16)*Lc+2*zeta+3*mu/2`.

The high branch gives `-1/48-delta/16-Delta+(13/16)*(78*epsilon+epsilon_m)+2*zeta+mu`, which is stronger than the budget needed here. The balanced rational endpoint inequality is a genuine nonzero margin. The coordinator and independent reviewer separately expanded its cleared polynomial identity exactly; those scalar checks do not validate the analytic inputs to the inequality.

Consequently `NonfloorExponent.adaptive_mixed_saving:8` applies the exact supplied budget

`(13/16)*Lc+2*zeta+3*mu/2+26*e+(N+8)*eps+loss+mesh/6+O+saving <=49/440640`, with `Lc<=1/32`,

to conclude `P+Eclass<=3/16+Delta-saving`. The source arithmetic bound therefore retains `-P` until integration. No `nuN` normalization loss has been paid at this stage.

## 6. Actual integral, not a formal height-volume estimate

`CubeFiniteIntegral.cubeWeightedRow_integrable:20` first proves each actual finite-row integrand integrable, using the buffered continued kernel under the next-detector bound. The closed cube is measurable. `finiteCentralCubeRows_eq_integral:65` then interchanges only finite sums of already integrable terms. `CubeCommonProfile.cube_sum_eq_common_profile:22` factors the common source Mellin weight out of those sums. Thus line 38's `cube_common_profile_integral` gives the exact factor `(1/(2*pi))^3` times the integral of the cube indicator times that weight times the arithmetic sum.

The source Mellin profile has real parts `a+16*e`, `17/50`, and `1-a-6*e`, lying in `[0,2]`, the singleton `{17/50}`, and `[-1,1]`. `CentralCubeNorm.actual_common_cube_aggregate_norm:104` invokes `MellinBoundary.profile_uniform_moments:477` with moment degree zero on precisely these ranges. Its bound is uniform in the height cube. The body of `profile_uniform_moments` uses the radial Mellin strip-decay theorem, compact-source Mellin strip decay, and an integrable coupled Gaussian/Cauchy majorant. Those strip-decay theorems are explicit deeper inputs to this audit.

After taking norms, the aggregate bound is `C*Z^P*A`, where `A` bounds the arithmetic sum throughout the cube. The factor `(1/(2*pi))^3` is in `C`. Substitution of `A=C'*C0*Norm(eta.modulus)^(2*eps)*Z^(3/16+Delta-saving-P)` cancels `P`. There is no extra `Z^(3*tau)` from cube volume. `FinalAssemblyIntegral.actual_nonfloor_cube_norm:18` implements this cancellation, with the actual height `(3*i+1)*Z^tau` below the permitted `(3*i+2)*Z^tau` and eventually `Z^tau>2`.

## 7. Normalization and nonvacuity

The denominator is exactly `sourceResidueConstant(W0,W1,product S)` times the source `principalScalar` built from the slot masses at `Yj=Z^ell_j`, with parameter `1/6`. `CubeNormalizer.actual_ray_normalizer_inverse:13` proves it is eventually nonzero and its inverse norm is at most `Cn*Z^nuN`, for every prescribed `nuN>0`.

Its proof invokes `power_ray_mass_and_normalizer` for positive actual ray-prime masses and the scalar inverse estimate, and `signed_source_normalizer_ne_zero` for the residue factor. These use the nonnegative, nonzero, smooth source windows and positive support. The normalizer estimate ultimately uses ray-prime asymptotics from the Hecke family on the line `Re(s)=1`; it is not supplied by the desired `7/8` nonvanishing conclusion. Complete validation of that PNT chain remains outside this cut.

The normalized theorem multiplies the unnormalized estimate by this inverse bound and obtains exactly `+nuN` in the exponent. The denominator cannot be silently zero under totalized division. This does not assert that the normalized probe is a nonzero function; that stronger assertion is neither proved nor needed here.

## 8. Bounded verdict and next substantive frontier

The reconstructed chain preserves the actual source carriers, both detector inequalities, the constructed batch, the two count regimes, all visible powers of `Z`, and the eventual nonzero denominator. It yields a positive `7*t/8` cell saving at the selected data. The raw moment premise is still a premise of this theorem. `FinalAssemblyMomentInput.lean:13,34,56` exposes its actual source formulation and the uniform-height absorption used by the outer assembly; this audit does not discharge its producer by rereading the wrapper.

The remaining substantive tasks are the following, with dependencies separated from algebra checked above:

* Prove the supplied `Moments` for the actual source data, including marked selected-slot bounds and uniform real-part/height/logarithmic derivatives. The energy/moment audits already accepted by the project cover only their recorded cuts.
* Validate the fiber-count analytic estimates beneath `DetectorRawBranches`, notably rowwise Sobolev/inverse endpoints, selected physical products, and fiber spikes. The two regime assembly and capacity fallbacks were independently inspected; that is not a complete proof audit of these analytic estimates.
* Validate `CentralPrimeSum.actual_central_prime_sum` and `CubePhaseBins.actual_phase_bins_on_cube`, including field/row comparison and prime-slot estimates. The downstream scale, bin, disjointness, and exponent transport were reconstructed here.
* Validate the buffered continued row kernel and its analytic identity with the original source, plus the two Mellin strip-decay inputs to `profile_uniform_moments`. The finite integral interchange and the use of the resulting global majorant were checked here.
* Validate the full ray-prime mass, principal scalar, and residue nonvanishing chain beneath `CubeNormalizer`. Its immediate positivity/inverse transport was checked; there is no claim that this audit reproved the PNT.

No new public hypothesis is proposed. The most useful next analytic audit is the actual row/prime-slot estimate underlying `CentralPrimeSum` together with the inverse rowwise endpoint needed for counting, followed separately by the raw marked moment producer. Merely checking another normalized wrapper would not reduce that frontier.

## Source pins

The following SHA256 values bind the source files used in this audit. This is a file-content inventory, not evidence of successful elaboration or allowed transitive axioms.

| Source | SHA256 |
|---|---|
| `Detector/FinalAssemblyNormalized.lean` | `423741DFE68336116469CD7DACF116C00A21618947199E799DC1098965992274` |
| `PrimeRows/NonfloorNormalized.lean` | `2219A642F978A3716A1B25DFCDEAC96030EE9EBC4FD15C5994CE7DF9C02B9C26` |
| `Detector/FinalAssemblyIntegral.lean` | `3B5A3D257E20FF7D1AE033E094AD1B0E23E44FBEEA4BF41CB838A5A54C917F16` |
| `Detector/FinalAssemblyArithmetic.lean` | `2783D75EF9637989F7230CD18DDED5A56B31AEBC628DC5DF5DE832FB9148C2CD` |
| `Detector/FinalAssemblyClass.lean` | `B1F5E2ACDAEBF205A9E58DC590AD94EE18184D26CD51C3588ABE2C04BF55278D` |
| `Detector/FinalAssemblySourceCount.lean` | `7E60A888E42377952D9C0353A9CB001689B232655171DCDF755CD1CFA52ED59E` |
| `Detector/FinalAssemblyCountParameters.lean` | `F2183C59E14C429D7C63042D4E4694EA906955C1FB03F94B407474173DED365B` |
| `Detector/FinalAssemblyMomentInput.lean` | `0AD3A3DB4CDEBAD7634684D3D4252A86E5539702641C4E64B9C994D89534CC07` |
| `Detector/FinalAssemblyFixedHigh.lean` | `B3B043756695167550FC3FAD7D088DCE5C4A83234900DF4C5CBB6C229586DD23` |
| `Detector/FinalAssemblyHigh.lean` | `05514C32466FBE9D72C86B52ED5CA91BA38ED42617CC1579CE3D6B67F218E726` |
| `PrimeRows/NonfloorMoments.lean` | `272F2E4E667CA3C459FFB477729F2389C8D71AD0BDAD48128167F8F4513F0AFB` |
| `PrimeRows/NonfloorCount.lean` | `DBA31F83223EFB91818E86C8E8345DF18B25C6FEFB9043C91690D5C906D315F6` |
| `PrimeRows/NonfloorSourceCount.lean` | `6CDB1AD3F59C0FC8E635330914CDA2224FF57296E809E927D25E0900283A48DD` |
| `PrimeRows/NonfloorExponent.lean` | `62B41B044A9EFA0354C02C9CF27BC87557FBC031F9AE47D6EB83BDA849E01B89` |
| `PrimeRows/NonfloorClass.lean` | `EF858E097162C5C2D2BABF52772613F92C84A9E8F24EDFE84CBB93F9BD0F6911` |
| `PrimeRows/CubePrimeBound.lean` | `E57BB4481BD27229DA0B9574BFCBEF97E41C5ABB5683AB22AEF29CEA691F1EC0` |
| `PrimeRows/CubeFixedPrimes.lean` | `DE7711561337803A59341FC5316A4F1BC1BE8EF0DC46C6EF52BE1F678C61F482` |
| `PrimeRows/CubeSlotExponent.lean` | `677CB6ACDF009DC95B7EB42CEEBE409F2D1B80594DA467692B024C00215CF7CA` |
| `Detector/CentralClassArithmetic.lean` | `121CB898D7271ECE736D9AB6DBB2EBF61574938FCA97E9969A890E60481739FE` |
| `Detector/CentralDyadicWeight.lean` | `D0E4D959D87DA65EBDD434D9638964F41666D79EB3BA32EF535987626B090461` |
| `Detector/CentralMixedMargins.lean` | `6B414E0BE1B095BF3471AF675ABC819C4A88C4CD732C052B1C5ED5C10927FCC6` |
| `Detector/CentralExponent.lean` | `C5ADBFEBE62C9A49F191B6DE6497062C1C66790FCA8E6379DD96E6DF069C97B8` |
| `Detector/CentralCubeNorm.lean` | `5C823D228B6086D388A2C42230FD6EFD705127101FF39B02D7D6756B86CCFD40` |
| `PrimeRows/CubeFiniteIntegral.lean` | `DF5AF748F59E843E2F4F35B3212CB2633E10C9F132320C1CD455AA7D8A8E2F2F` |
| `PrimeRows/CubeCommonProfile.lean` | `033D43783FD0FFD30BE9B5F36F640D7185967C0DC88955B943659794B8A94FF0` |
| `Detector/MellinBoundary.lean` | `A991662009CDAA60B3B3F8FA504BF087C559AB27805F1EAD0C61E25F0FC37C84` |
| `PrimeRows/CubeNormalizer.lean` | `B6808E221D9A1963FC56ABEF23B9DA5F357F25DFC066612B57ED757BCAA5CA55` |
| `Detector/SourceExclusions.lean` | `7CE136A63D2478F75C876BC7404717A426B97829132B9C634647009A4CB8D650` |
| `Detector/RaySlots.lean` | `3EF16C5521252DBB348B0EC0B5ECEEEC03889C71A66980AEC020010C4B868EFC` |
| `Hecke/DetectorRawFiber.lean` | `67F7DEAEA66FBF26CA0C697AAFA579AFA58F12C17735F70CF83F4C14AC7A4607` |
| `Hecke/DetectorRowCountEndpoint.lean` | `5C8C7DEA96F71CEB069615D1626CBDED898A277663E10BFC02E50F2D4EEBC2E7` |
