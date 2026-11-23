# Live child admission below the amplified energy theorem

Date: 2026-11-11. Author: independent-feasibility. Status: bounded source and mathematical reconstruction, submitted for independent review. No Lean compilation, declaration changes, analytic evaluation, or provider-validation claim.

## 1. Selected boundary and result

The new boundary is `Energy/FirstLiveAdmission.eventually_main_packet` and `eventually_error_packet`, including the two-seed version actually consumed by `CanonicalLowSource`. The substantive lower producers are `FirstSecondCommonGates.eventually_common_ready`, `FirstSecondActiveErrorGates.eventually_active_error_ready`, `AmplificationChildSourceCaps.polynomial_caps`, and `FirstAmplifiedRadiusLower.active_row_reciprocals`.

No mathematical defect was found in this bounded chain. A nonzero retained first block supplies a lower bound on the amplified radii. Actual allocation geometry supplies volume and support caps. A live error coefficient supplies the additional bound on its enlarged puncture. These facts produce the eleven geometric fields of `Ready`. They do not prove the analytic child-energy estimate.

This is new work below the admission hypotheses. `CanonicalAmplifiedUniform` combines the main and error estimates. `CanonicalAnnularPower:96–329` continues to assume main `Ready` and a zero-or-`Ready` alternative for each error input. Those wrappers were used to locate the boundary, not counted as a new analytic estimate.

The earlier energy-induction audit C04D05F95C1747652F28576AC41372702F586F5D85E2849F12CD3E4D28A8D695 already covered child-width descent and paid removal. The canonical-rank audit 2767A7CC08CC13239EFDBC5242D47505FC44028016251407B21A542CDC98FF4B covered rank progress. The live-allocation audit 67B64EAE035944821BEA870E7B62972464B2E233DBF2BBF6569A17F9162A5C54 covered the raw-reduction support estimate and allocation-count payment. This report reuses that finite support calculation and does not repeat the allocation-count or radial estimates. Its independent review is 38A1C08D554CBCC09631164ECB604255C4BCFD44D691E89E524AF25B4953E74F.

All Lean paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL`. The final table pins bytes, not an assertion that every declaration in those files has been audited.

## 2. What admission says, and which hypotheses survive

`Moments/FirstSecondInputGates:23–34` defines `Ready s R K Z ξ B` by:

1. `R ≠ 0` and `0 < K`;
2. `volume s ≤ Z^B`;
3. `0 ≤ sourceRadius s ≤ Z^B`;
4. both the character modulus norm and `N(R)` at most `Z^B`;
5. `0 < nominal s K ≤ Z^B`, where `nominal = volume²/K`;
6. `0 < frequencyRadius (nominal s K) Z ξ ≤ Z^B`.

The frequency radius is the nominal scale times `Z^(ξ/2)`. No energy inequality, nonvanishing theorem, zero-free statement, or induction conclusion is a field of `Ready`.

The main/error packet theorems retain a fixed finite-slot cap `N`, endpoint bounds `b,b₁,b₂ ≥ 1`, positive lower support bounds `l,a`, and nonnegative parent exponents `A,P`. Their eventual threshold precedes the finite index type, input, allocation, character, frequencies, block and row data. After that threshold they require:

- `card ι ≤ N`, `Endpoints b b₁ b₂ s`, and `l ≤ s.lower`;
- plain profiles supported above `a > 0`, hence both vanish at zero;
- `κ ≥ 1/6`, all slot scales at least one, and the affine parent capacity at most `A`;
- parent character norm at most `Z^A`, nonzero puncture `R` with norm at most `Z^P`;
- genuine common labels `C,D` for the outer source coefficient and a supplied `FixedPair` with `τ` equal to one of its two characters;
- positive original `K,Csec`, `0 ≤ ξ ≤ 1`, nonnegative reserve and `σ`, a retained dyad, the nominal upper comparison, and a nonzero actual first block;
- an actual allocation `B` with nonzero frozen coefficient.

For errors there are additional supplied prime-pool membership, coprimality with every active slot, an actual second allocation, and the stated radical conductor bound. The public error packet has `σ ≤ 1` and `k ∈ {1,6,7}`. Its body names the latter `_hk`: the geometric argument works for any natural `k` once its other hypotheses are supplied. This does not remove the three-index restriction from the subsequent analytic error theorem.

The admission theorems themselves do not need `ZeroAt` or `PositiveAt`. The consuming amplified theorem still requires both at `Mcap`, with its original support, modulus and loss parameters. In particular, this audit neither weakens `Mwidth − σ/2 ≤ Mcap` nor removes `κ ≥ 1/6`, `beta ≥ .51`, `2*beta − 1 ≤ κ`, `ξ ≤ σ/4`, the source losses, or the paid-removal inputs from that consumer.

## 3. Nonzero retained rows imply inverse radius at most one

`FirstPhysicalDyadicRows:17–80` defines `activeRows` by filtering the actual finite row set with the row dyadic weight. Its exact `block_activeRows` identity removes only rows with zero weight. The proof includes the zero-lattice-point case in the log-window identity, so `log 0` conventions do not produce an extra row.

If the block is nonzero, this active set cannot be empty, as `FirstLiveAdmission:38–51` proves by substituting the empty finite sum. For any active row `h`, the actual ideal norm satisfies

`1 ≤ normValue h < dyadicScale(n₁)`.

The first inequality uses `h ≠ 0` and the integral ideal norm. Therefore `H₀ = dyadicScale(n₁) > 1`. Nonzero block does not mean that each summand is positive; the argument only uses finite support and nonzero terms.

Write `K₀ = log_Z(firstNominalScale)`, and set

`δ = frequencyLoss Z (32*Csec) ξ = ξ/2 + log_Z(128*Csec)`.

For `Z > 1` and `Csec > 0`, the identity in `FirstAmplifiedRadiusLower:15–18` is exactly

`Z^(K₀+δ) = 128*Csec*Z^K₀*Z^(ξ/2)`.

Retained-row support gives `H₀ ≤ 4*Tsec*Z^(ξ/2)`, while `Tsec ≤ Csec*Z^K₀`. Thus `H₀ ≤ Z^(K₀+δ)`. The source has a factor 32 of slack here; it is not an omitted normalization.

The two actual common radii in `AmplifiedRetainedRadius:150–154` are

`Km = Z^(K₀ + max(d-c,0) + 2σ + δ + reserve)`

and

`Ke = Z^(K₀ + max(d-c-2*errorRemoval+errorMoving,0) + σ + δ + reserve)`.

Their added terms are nonnegative under the packet hypotheses. Hence both exceed or equal `H₀ > 1`, and both inverses are at most one. This proves the choice `D = 0` in the later polynomial cap. No bound on the parent `K⁻¹` is substituted for the child inverse scale, and no assumption that `δ ≥ 0` is needed in this particular lower-radius argument.

The left/right choice only interchanges `c` and `d`. `FirstRightAdmission:33–45` identifies the right radius with the source radius for swapped `C,D` and `swapSubset C D E`, using equality of the nominal scales and subset generator. It introduces no new loss.

## 4. Actual child geometry and the live puncture mechanism

Let `V = volume s`, `NC = N(C)`, and `G = b^(2N)*b₁*b₂ ≥ 1`.

### Common child

`AmplificationChildSourceCaps:41–74` gives the exact identity

`volume(child) = V/rawReduction(B)`.

For a nonzero frozen coefficient, actual support implies `NC ≤ b^N*rawReduction(B)`. Consequently

`volume(child) ≤ b^N*V/NC ≤ b^N*V`.

The source radius is the child volume multiplied by the product of upper slot endpoints and its two plain endpoints. There are at most `N` remaining slots. Thus both its volume and source radius are at most `G*V`, and its radius is nonnegative. These bounds refer to the actual child `Input`, not arbitrary independently chosen smaller parameters.

### Active error child

`FirstAnnularActiveInput:14–30` filters slot ideals whose window value is zero, preserves the volume and endpoints, and supplies an exact equality of the corresponding actual Gaussian energy. The error input is a child of this active input. It is not silently identified with the unfiltered twice-child.

For an extraction by `Q^k` coprime to every active slot, `AmplificationAllocationCost:15–38` shows that the extracted component of every slot is the unit ideal. The two plain extracted ideals multiply to `Q^k`. `AmplificationAllocationScale:16–70` and `AmplificationChildInput:115–158` therefore yield the exact second volume reduction by `N(Q)^k`. This depends on actual allocations and coprimality; it is not a claim about arbitrary pools or arbitrary divisor tuples.

With `d = errorInput` and `H = V/(NC*N(Q)^k)`, `FirstSecondActiveErrorGates.error_caps:29–65` proves

`H > 0`, `volume d ≤ G*H`, and `0 ≤ sourceRadius d ≤ G*H`.

The proof does not require the second frozen coefficient to be nonzero. The first frozen coefficient remains a hypothesis because it was needed for the first reduction.

The new puncture is `Re = (R*C)*Q^k`. Its norm cannot be bounded by simply dropping the power `k`. Instead, in the live branch choose an ideal `I` with the actual aggregated coefficient of `d` nonzero. `SupportedZeroEnergy:73–79` extracts a nonzero tuple term from the finite coefficient sum. This implication is valid despite possible cancellation. `OriginalCommonHarmonic:37–51` then gives

`I ≠ 0` and `N(I) ≤ sourceRadius d`.

The plain profiles vanishing at zero are necessary here. Combining this with `N(I) ≥ 1` gives

`NC*N(Q)^k ≤ G*V`,

and exact multiplicativity gives

`N(Re) ≤ N(R)*G*V`.

This is the live-source support payment in `FirstSecondActiveErrorGates:101–118`. It is independent of an energy bound or a width estimate. If every coefficient is zero, `normalized_zero` instead proves the exact actual normalized source equals zero. `FirstLiveAdmission:313–319` returns that alternative before asking for live admission. It does not assert a live witness for every second allocation.

The norm upper-support proof uses the genuine product coefficients. `SourceZeroEnergy:53–87` reduces it through the existing tuple reindexing to `originalCoefficient_product_bound`; that lower producer remains a named boundary of this report. The finite witness extraction and its consumption have been inspected. No positivity assumption on complex coefficients is hidden in this step.

## 5. Polynomial caps, conductor bounds, and the final budget

For any fixed `G ≥ 1` and `ε > 0`, eventually both `G ≤ Z^ε` and `G² ≤ Z^ε`. The second inequality is imposed directly. It would be incorrect to obtain only `G² ≤ Z^(2ε)` and keep the displayed final exponent.

`AmplificationChildSourceCaps.polynomial_caps:263–290` uses `X,H ≤ G*V`, `V ≤ Z^A`, and `K⁻¹ ≤ Z^D`. It proves

`X,H ≤ Z^(A+ε)`,

`X²/K ≤ Z^(2A+D+ε)`,

`frequencyRadius(X²/K,Z,ξ) ≤ Z^(2A+D+ε+ξ/2)`.

The nominal and frequency scales are positive because `X,K,Z` are positive. For the error child, `NC*N(Q)^k ≥ 1` permits `H ≤ V` before applying this lemma. The live puncture argument separately yields `N(Re) ≤ Z^(A+P+ε)`.

The parent volume bound comes from `InputParentCapacity:44–88`. Precisely,

`log_Z V + (6κ−1)*sum_i log_Z(P_i) ≤ A`.

Since `κ ≥ 1/6` and `P_i ≥ 1`, the added term is nonnegative and `V ≤ Z^A`. Bounds on individual `X₁,X₂` below one cause no issue, because the original capacity uses `length(Z,X) = log_Z(max(1,X))`, which bounds the raw logarithm above.

The conductor calculation in `FirstSourceConductorCaps:20–122` is also separate from energy. Both fixed-pair modulus norms are at most

`fixedPresentationCost * N(η) * NC²`.

The two norm factors are bounded using ideal divisibility into `C`. For the supplied radical-family error character, the extra prime factor is at most `N(p)`, not `N(p)^k`: in `radicalBound` it is either one or a single `N(p)`. This uses the stated radical conductor hypothesis and the ray-character modulus bound, not an assertion that every character has that conductor.

The uniform eventual conductor theorem absorbs the larger of its fixed presentation constants once into `Z^ε`. At `ε = 1`, the parent bounds `N(η) ≤ Z^A`, `NC ≤ Z^(A+1)` give

`N(τ) ≤ Z^(3A+3)`.

Prime-pool membership supplies `N(p) ≤ Z^(σ/3)`, so

`N(υ) ≤ Z^(3A+3+σ/3)`.

This upper norm fact needs only annular-pool membership. Producing a nonempty pool of the required size is a separate analytic input.

Substitute `D = 0`, `ε = 1` into the generic Ready exponents. The main exponent is the maximum of

`A+1`, `2A+1+ξ/2`, `P+A+1`, and `3A+3`.

The live error exponent is the maximum of

`A+1`, `2A+1+ξ/2`, `A+P+1`, and `3A+3+σ/3`.

For `A,P ≥ 0`, `ξ ≤ 1`, and, in the error case, `σ ≤ 1`, every entry is at most `readyBudget A P = 4A+P+10`. The respective budget-minus-entry differences are

`3A+P+9`, `2A+P+9−ξ/2`, `3A+9`, `A+P+7`

and, for the final error entry, `A+P+7−σ/3`. All are nonnegative on the exact stated domains. `ready_mono` transports every bound to this common budget without changing the nonzero/positive fields.

## 6. Lower support, two seeds, and the actual consumer

The lower-support output is stronger than Ready but is not an energy estimate. `SecondInputCapacitySource:24–44` proves

`lowerFactor(N,l,a)*volume(child) ≤ N(I)`

for any nonzero child coefficient, where `lowerFactor = min(1,l)^N * a² > 0`. The product of actual slot lower endpoints dominates `min(1,l)^N` because the number of live slots is at most `N` and the base is at most one. `SourceLowerSupport:22–97` handles both branches of the rectangle difference: a nonzero difference has at least one nonzero product, and both products have the same plain scale product. It does not require that both rectangle terms survive. The same reasoning applies after the second extraction.

The actual low-source consumer uses two seeds. `seed0` produces the original common labels and nonzero first block; the later mask `innerL` belongs to the admitted child. `FirstTwoSeedAdmission:32–78` reuses the seed-independent main Ready fact and proves lower support for the new `innerL`. Its error theorem at lines 80–183 performs the dead/live split on the coefficient with `innerL`, and passes that same `innerL` into `eventually_active_error_ready`. It does not substitute the outer seed into the live witness.

`CanonicalLowSource:180–319` intersects the source, main, error, prime-separation and old-column thresholds, then supplies these inputs explicitly. Its `K ≥ 1` and parent logarithmic capacity produce the needed `N(η) ≤ Z^A`. Its matched scales give `P_i = Z^(w_i) ≥ 1`. Its profile support gives the plain lower endpoints. The main packet is specialized to `Csec = 1`, left side, and the actual nonzero retained block.

For errors, the consumer filters to active slots and invokes `original_slot_coprime`. That theorem at `FirstAmplificationChoice:562–576` compares active slot norms at most `b*Z^eta` with amplifier prime norms at least `Z^(σ/6)`, under the strict separation `b*Z^eta < Z^(σ/6)`. The prime cannot equal or divide such a slot prime. The consumer then supplies `errorIndex i + 1 ∈ {1,6,7}`, the actual radical-family bound, and the new child seed to the two-seed error packet. It passes either coefficient-zero or Ready to the low-column theorem.

The paired right-side admission uses the same nonzero original block. It does not need a new nonzero block with artificially conjugated data. The inspected `FirstRightAdmission` code uses the swapped radius identity and the same conductor cap valid for `F.right`. This report does not extend that observation to a full audit of `CanonicalHighSource`.

## 7. Quantifiers, remaining boundary, and conclusion

The geometric thresholds depend on fixed `N,b,b₁,b₂` and the chosen absorption exponent. The conductor threshold depends on fixed presentation constants and that exponent. They precede all character, frequency, allocation and coefficient data. The scalar radius lower bound is pointwise for every admitted block. No compactness over an unbounded family is assumed.

This audit establishes the source-level mechanism for geometric child admission and its low-source consumption. It preserves the distinction between three nonzero conditions: the original first block, the first frozen allocation coefficient, and the live error's aggregated coefficient. Only the last is discharged by a dead/live split.

The following are still boundaries of this report:

- the underlying tuple/profile reindexing and `originalCoefficient_product_bound` below `SourceZeroEnergy`, beyond the checked finite witness and support consumption;
- construction of `FixedPair` via `exists_canonical_masked_pair`, the character/ray presentation identities, and the lower arithmetic facts about extraction and ideal norms;
- prime-pool existence and the complete amplifier-family production. Membership bounds and the slot-separation implication were checked, not an independent prime-existence theorem;
- the actual analytic Gaussian source estimate beneath `FirstSeededGaussianPower.actual_subsets_seeded_gaussian_power`. The located chain is `SecondFrozenReferenceSeededPowerDescent` to `SecondFrozenSeededPowerDescent`, `SecondFrozenUniformSubset`, and `SecondFrozenLiveDescent`. The last combines `SecondFrozenLiveSource.original_nonexceptional_energy` with `SecondSourceRemainder.original_source_remainder`. These two producers are the next precise energy-estimate boundary. This report inspected the connecting bodies to locate them but does not validate their retained, exceptional, diagonal or rapid-tail estimates;
- the retained `ZeroAt`, `PositiveAt`, width drop, paid-removal and final induction premises, with their previously recorded evidence and unresolved lower inputs.

Admission does not supply a new global QRH proof, a compiled provider, or an explicit finite threshold. The new result is a checked bounded mathematical explanation of why the specific child inputs meet the geometric hypotheses of the next analytic theorem, including the live error puncture payment and the actual two-seed consumer.

## 8. Exact source manifest

SHA256 values below are hashes of the original bytes. File-wide hashes identify the versions; the sections above delimit the reviewed spans.

| Source | SHA256 |
|---|---|
| `Energy/FirstLiveAdmission.lean` | `CEDFD5CF5BCE31554DF8EC36C39F0600292AD3A035ED577DCC86D7495DF571EE` |
| `Energy/FirstTwoSeedAdmission.lean` | `D00290CF747D5C274238984C579CAEB34AA429F9B3CD24B3857D0FB988CD95C9` |
| `Energy/FirstRightAdmission.lean` | `706F79DFD58857F550E10E642EE3AF8189DAFCF632FA2E0C3011DE5932F17669` |
| `Energy/InputParentCapacity.lean` | `7162B7392D194068014742044483253EBAFEBDDAF929BC5C98BD3693C8EC84DC` |
| `Energy/CanonicalAnnularPower.lean` | `49F426FECB2FBB789FEACC7B557CA753BE6C31545C134DC4B7FC9093097AD3BB` |
| `Energy/CanonicalAmplifiedUniform.lean` | `8E06F918FA7619BB7BD6F92D9B61568A9328BF9C861C8099BE3C6106C4413F84` |
| `Energy/CanonicalLowSource.lean` | `2A9B310C35B674BF831B57B0FFB57CADD0A027B8AB0B2C4DDE58D0BD30618B55` |
| `Moments/FirstSecondInputGates.lean` | `FFAF9D81081BD5F5C1AA04CEF450CB7C2D645A6C5CFD5F444C0559D2418B9A5C` |
| `Moments/FirstSecondCommonGates.lean` | `F6CE748EFF1EB24103E44F1BAD64794B95D8ECE7FF9C403914C9670E04F7834D` |
| `Moments/FirstSecondActiveErrorGates.lean` | `2C96E20420BCD4EDB2C339E28728FC7343B543E0AB19488B0B833A29B4649C0D` |
| `Moments/AmplificationChildSourceCaps.lean` | `2E8C744EBA824E73580216150557A7AC8525C405823997675D2F6918C18DBF8B` |
| `Moments/FirstAmplifiedRadiusLower.lean` | `6576FABC70EE84259206F9122E242F971C38EA9EE91E9CDF732F2F32AFCA9E24` |
| `Moments/FirstPhysicalDyadicRows.lean` | `86B78D4D17020ACA488B0ACC31A5FF18165E01F6A4ACE1465475AE9B40A07DEE` |
| `Moments/FirstSourceConductorCaps.lean` | `95D59D1FEFB99E2FBEBFB6D576A96390C4630FDA4D9957B06E08D48AC12465D8` |
| `Moments/AmplificationChildInput.lean` | `EF430B59F9C352E98CC2B7DE3C0B3045D93E3A4F3110B723268730EDB9976EC0` |
| `Moments/AmplificationAllocationCost.lean` | `EEE8A8736120863688D955590EE2A00B6D52F7D511A4C645D8C9AEFC12ED905B` |
| `Moments/AmplificationAllocationScale.lean` | `3F01D53F16F51F55F83E57F4A95B9EB3B04DDE9D9C520839D586895FCB13E698` |
| `Moments/FirstAnnularActiveInput.lean` | `8ED59503133D0287A26073D2D10AB17465A01A9596939ECEA4D0ED09000A9A8E` |
| `Moments/OriginalCommonHarmonic.lean` | `C1018E1857DE93E4F819F98D2E1431B68D9AEE12FDBD38E4C001B3F7A804D5A2` |
| `Moments/SecondInputCapacitySource.lean` | `BACE9DF1D58098A0DA1EADC48DABB3945C14F48DE11E2F2EF114272CFDD6A304` |
| `Moments/FirstPhysicalSourceSupport.lean` | `55FD4F5C4BDD3A42F9EF62BC4CCD59B1AB890D73275B61D31621DADAEB2E2C50` |
| `Moments/SourceLowerSupport.lean` | `E4452BE1B6350F6D4F9CF82312E60EEC42E5221439EDC776D0325D1BC9EE0828` |
| `Moments/SourceZeroEnergy.lean` | `15CA6317FB9DFC40BB84411249DB4DD8B26CDE25C3DC9941A6E3E910F947B3F9` |
| `Moments/SupportedZeroEnergy.lean` | `FCDA641AF4E8129F8F69D18D61CFF25CDDF11B7258031245B09CA1679EFE4BB2` |
| `Moments/FirstPhysicalSourceFixedFamily.lean` | `4BF15039FC0DEB2D20C3530070254B0D79B539217A87B73789EE5A84548D4F4C` |
| `Moments/AmplifiedRetainedRadius.lean` | `A9C8762DDB37E7BC0C2EB852046A977674D01E8FFA2D5C0B4195DC8285D8DE07` |
| `Moments/SectorLocalization.lean` | `181462EC0585529C9D72C6CBC714668C9BB5F9BA0067F4868DEF1088C7ADFC6F` |
| `Moments/FirstAmplificationChoice.lean` | `FBC5A67B226BB91D4CBBB48D0F069B51D06DBDEE3F49618D2974927519A69B21` |
| `Moments/SecondFrozenLiveDescent.lean` | `B5D336B74DC94A6E8E4026F75D81D80D45777ED9A65A72A836E8D12D89C50BF6` |
| `Moments/FirstSeededGaussianPower.lean` | `100006984F2392564914ACA67F03A7F41535D00E2CD2EB076FCA4EEDEEC556C5` |
| `Moments/SecondFrozenReferenceSeededPowerDescent.lean` | `53499EE2C352E28938CBD20202AF2AD971E60D2445FA5A97B59661618BE48009` |
| `Moments/SecondFrozenSeededPowerDescent.lean` | `E930360E2BDE1516893A69127A587CE0DE31EBF357984653BA1C090E7D1A39BE` |
| `Moments/SecondFrozenUniformSubset.lean` | `E59717D1C6B90CA90297AFCA4C2FF7E46439045FC932F18EFE8D3B4C0287710D` |
