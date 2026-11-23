# Independent review: actual child admission

Date: 2026-11-11. Reviewer: major-constants.

Verdict: PASS within the bounded source/mathematical scope below. No correction requested. I read the frozen author report in full, compared its substantive claims with the source bodies, and independently verified all 33 source hashes.

Author report: `independent-feasibility/QRH_LIVE_CHILD_ADMISSION_AUDIT_2026-11-11.md`, SHA256 `C8FDBA5516B0A0FD675DDFA3CE4ABB001E6113400C4D9FD3FC94E926FF76DBD4`. The author report is unchanged.

The source baseline is `work/openai-math` commit `4eaee87548250b2682affda7d05d947c05554bae`. Paths below are relative to `lean/OAI/NumberTheory/DirichletL/`. This is a bounded mathematical reading of source bodies, not a compilation, axiom audit, or validation of the global QRH provider. No Lean files were changed, no builds or numerical analytic evaluations were run.

## 1. The selected cut

The newly checked step is the construction of the `Ready` premises in `Energy/FirstLiveAdmission.eventually_main_packet` (176–253) and `eventually_error_packet` (255–358). The outer annular/amplified estimates previously retained these premises. The current review does not reinterpret their retained parent `ZeroAt`/`PositiveAt` estimates as proved by admission.

`Moments/FirstSecondInputGates.lean:23–34` defines `Ready`: nonzero puncture, positive radius, polynomial bounds for volume, source radius, conductor, puncture, nominal scale, and frequency radius. It is a geometric predicate, not an energy inequality. The nominal scale is exactly `volume^2/K`; the frequency radius is that quantity times `Z^(xi/2)`.

I independently read the actual packet bodies, common and active-error gate producers, the decisive allocation/volume identities, finite coefficient support proofs, inverse-radius argument, conductor caps, and the two-seed consumer join. The earlier whole-product Fourier separation and allocation-energy reviews remain separate accepted inputs; this report does not repeat their analytic claims.

## 2. Actual allocation geometry

Write `V=volume s`, `G=b^(2N)*b1*b2`, with `b,b1,b2>=1` and at most `N` prime slots. `AmplificationChildSourceCaps.lean:41–74` proves

`volume(child)=V/rawReduction <= b^N*V/Norm(C)`

when the actual frozen coefficient is nonzero. The equality uses the actual allocation product and complementary live/frozen slots. The inequality uses the support of every frozen window; it is not valid for an arbitrary ideal tuple lacking these hypotheses. `radius_bound` (133–139) adds another factor `b^N*b1*b2`, giving the common envelope `G*V/Norm(C)`.

For the second extraction by `Q^k`, coprimality with every active prime slot forces its extracted slot factors to be one. I checked `AmplificationAllocationCost.lean:15–36`: the actual allocation has a witness in the finite tuple pool, support extraction at primes dividing `Q` is trivial on a coprime slot, and the two plain factors consequently multiply to `Q^k`. `AmplificationAllocationScale.lean:16–22,46–71` and `AmplificationChildInput.lean:119–163` then give the exact identity

`volume(second child)=volume(first child)/Norm(Q)^k`.

In `FirstSecondActiveErrorGates.lean:20–65`, the second child is built from `activeInput(first child)`, not an unrelated replacement pool. `FirstAnnularActiveInput.lean:14–31` filters precisely zero-window slots, preserves volume, and identifies the original data with its active version; actual normalized Gauss energy is preserved through the existing active-energy identity. No nonemptiness of these pools is asserted or needed to form the input.

Thus, with `D=Norm(C)*Norm(Q)^k>0`, the error child has positive volume, nonnegative source radius, and both are at most `G*V/D`. This conclusion needs the nonzero first frozen coefficient and the active-slot coprimality hypothesis. Those hypotheses are preserved in the packets and their caller.

## 3. The live-coefficient puncture bound

The substantive error admission step is `FirstSecondActiveErrorGates.lean:104–119`. A nonzero aggregate column coefficient supplies an ideal `I` and then a nonzero tuple summand. This is the elementary finite implication in `SupportedZeroEnergy.lean:73–78`; it does not infer that every summand is nonzero and does not assume positive coefficients.

`OriginalCommonHarmonic.lean:37–51` and `AmplificationChildSourceCaps.lean:100–109` yield

`I != 0`, hence `1 <= Norm(I) <= sourceRadius(error child) <= G*V/D`.

Consequently `D <= G*V`. Multiplying by `Norm(R)` and using `Norm(R)<=Z^P`, `V<=Z^A`, and `G<=Z^epsilon` gives

`Norm((R*C)*Q^k) <= Z^(A+P+epsilon)`.

This avoids paying a separate factor proportional to `k*log_Z Norm(Q)` in the puncture exponent. It is not a claim that the enlarged puncture divides the surviving column ideal. The proof uses the child's scale, integrality of the positive ideal norm, and the actual coefficient's support.

I checked the support proof beneath the wrapper: `SourceZeroEnergy.lean:53–87`, `SourceMass.lean:168–235,466–480`. A nonzero signed rectangle implies that at least one of its two products of windows is nonzero. Both branches have the same scale product `X1*X2=Y1*Y2`, so either gives the stated upper norm bound. The tuple-product norm is then bounded coordinatewise. Signed cancellation causes no gap.

The complementary case is explicit: `FirstLiveAdmission.lean:313–317` returns all coefficients zero and `normalizedGaussSource=0`, using `FirstSecondInputGates.normalized_zero` (36–39). It does not force a `Ready` assertion for an arbitrarily large dead puncture. Empty pools and zero windows are therefore allowed without a false live-state assertion.

## 4. Other caps and the eventual threshold

`AmplificationChildSourceCaps.polynomial_caps` (263–290) uses `G^2<=Z^epsilon`, not merely `G<=Z^epsilon`. Given positive child volume `X`, `X,H<=G*V`, `V<=Z^A`, and `K^-1<=Z^D`, it proves

`X,H <= Z^(A+epsilon)`,

`X^2/K <= Z^(2A+D+epsilon)`,

`frequencyRadius <= Z^(2A+D+epsilon+xi/2)`.

`eventual_geometry` (257–261) supplies both required powers uniformly over the subsequently quantified inputs. `FirstSecondCommonGates.lean:18–74` retains the independently available common puncture bound `Z^(P+Ccap)`; the error version uses the live puncture argument above. None of these inequalities needs an analytic estimate for an L-function or a desired zero-free region.

The packet specialization is `epsilon=1`, `D=0`, common extraction cap `Ccap=A+1`, main conductor exponent `3A+3`, and error conductor exponent `3A+3+sigma/3`. For `A,P>=0`, `xi<=1`, and, on the error side, `sigma<=1`, each entry in the relevant maximum is at most

`readyBudget(A,P)=4A+P+10`.

The main maximum has entries `A+1`, `2A+1+xi/2`, `P+A+1`, `3A+3`; the error maximum replaces the last by `3A+3+sigma/3`. The generous common cap is valid at boundary values as well. `ready_mono` enlarges only those exponents, retaining all positivity facts.

The threshold is chosen before the source input, its pools and cardinality, characters, row set, dyadic indices, allocations, auxiliary prime and its exponent. It depends on the fixed support/cardinality parameters. This is eventual uniformity in the stated bounded class, not an explicit effective threshold or an unconditional assertion that every arbitrary state satisfies the packet hypotheses.

## 5. Why the radii have reciprocal at most one

`FirstPhysicalDyadicRows.lean:17–40,61–80` identifies the actual block with its restriction to active rows. A nonzero block therefore forces an active row. Such a row is nonzero, has integral norm at least one, and has norm strictly below the dyadic row scale; that scale is strictly greater than one.

`FirstAmplifiedRadiusLower.lean:15–77` combines this with retained-row scale `<=4*Tsec*Z^(xi/2)` and the section bound `Tsec<=Csec*Z^K0`. The exact identity is

`Z^(K0+frequencyLoss Z (32*Csec) xi)=128*Csec*Z^K0*Z^(xi/2)`.

Both main and error radius exponents add a nonnegative maximum, nonnegative multiples of `sigma`, and nonnegative reserve. They therefore dominate that base scale. Each radius is greater than one on a live block, giving reciprocal at most one. No claim about the sign of the expression inside the error maximum is needed. The zero block is not used to establish a fictitious lower scale.

Parent capacity also remains explicit: `InputParentCapacity.lean:44–88` uses `kappa>=1/6` and slot scales at least one to convert the affine capacity into `V<=Z^A`. Small positive plain scales are handled by `length=max(0,log_Z X)`, so the argument does not silently require each plain scale to exceed one.

## 6. Conductor and seed fidelity at the consumer

`FirstSourceConductorCaps.lean:25–119` bounds both fixed characters by a fixed presentation constant times `Norm(eta.modulus)*Norm(C)^2`. The two extra generator norms are each bounded by `Norm(C)` using their actual divisibilities. The error character adds at most one factor `Norm(Q)` through `radicalBound`; the displayed exponent `k` does not create `Norm(Q)^k` in this conductor bound. Fixed presentation constants are absorbed by one eventual power. The output is conditional on the exact supplied fixed-pair and radical-modulus contracts.

The source packet distinguishes the outer seed, which produces the original common labels and the nonzero block, from the inner seed in the admitted child. `FirstTwoSeedAdmission.lean:67–78` reuses the seed-independent main `Ready` assertion and independently supplies the inner lower-support bound. Its error proof (126–183) tests liveness with `innerL`, while `actual_common_gates` is applied to `seed0`. The final error-ready and lower-support calls retain `innerL`. There is no replacement of one seed by another.

The positive lower-support factor is exactly `(min 1 l)^N*a^2`. I checked `SecondInputCapacitySource.lean:24–47` and `SourceLowerSupport.lean:21–96`: deleting slots only improves the minimum-factor bound, and either nonzero rectangle branch gives the same lower product norm. Again no coefficient positivity is used.

`CanonicalLowSource.lean:174–319` actually consumes these packets at `Csec=1`. The caller proves active-slot coprimality from its separated prime-pool event, keeps the explicit radical bound for the auxiliary character, and maps `errorIndex+1` to the admitted exponents `1,6,7`. The main radius and error radius use the same frequency-loss expression after reducing `32*1`. In the error dead case it passes the all-zero coefficient conclusion; otherwise it passes `Ready`. The parent energy estimates remain separate arguments to the low-column estimate.

I checked the small right-radius identities in `FirstRightAdmission.lean:33–45` and the right-main transport (85–101): the common subset generator and nominal scale are transported under the exact swap. This does not constitute a renewed audit of every right/high-source consumer.

## 7. Scope and remaining inputs

No defect was found in the independently read finite/geometric admission mechanism. Its benefit is to discharge the actual child size gates on live packets, not to produce the child analytic energy estimate itself. The Gaussian source estimate, parent band bounds, and main/error source-control production below `CanonicalMainUniform`/`CanonicalErrorUniform` remain separate analytic inputs unless covered by another explicitly pinned audit.

The report relies on the stated fixed-pair/modulus construction, radical character contracts, norm multiplicativity and nonzero-norm facts, finite ideal support-extraction facts, and existing active-energy identity. It does not recursively revalidate the underlying ideal arithmetic or the analytic Gauss summability used by that identity. No unconditional existence of a nonzero packet, no numerical spectral conclusion, and no global provider validation follows from this bounded review.

The author's named next Gaussian cut is accurate: `FirstSeededGaussianPower.actual_subsets_seeded_gaussian_power` calls `SecondFrozenReferenceSeededPowerDescent`, then `SecondFrozenSeededPowerDescent`, `SecondFrozenUniformSubset`, and `SecondFrozenLiveDescent.original_source_descent`. The last calls `SecondFrozenLiveSource.original_nonexceptional_energy` at lines 107–109 and `SecondSourceRemainder.original_source_remainder` at lines 110–113. I independently checked these call locations, not their complete analytic proofs. Retained, exceptional, diagonal and rapid-tail production remains outside this verdict.

This review advances one small inherited cut: the original tuple coefficient's upper-support argument is reconstructed in section 3 through the actual `SourceMass` body. This is a finite support improvement only, not validation of the separate Gaussian estimates. No discrepancy with the frozen author's narrower scope was found.

## 8. Source pins

All 33 author-manifest hashes matched the original bytes. They are reproduced below for version binding, followed by the additional files read for this review. File-wide pins do not claim file-wide proof coverage; the ranges and explicit remaining cuts above control that scope.

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
| `Moments/SourceMass.lean` | `51DD4C18335E9BA2236B87DAFA929C26995FE60FF6224FDACC3270676CEFF7A8` |
| `Energy/CanonicalMainGaussian.lean` | `99CB8DA085CFD761DA322DF9B1D15E900EC873B7F614811CEB5C04827E70620A` |
| `Energy/CanonicalErrorGaussian.lean` | `181C23822ED2DC69FEB0FD334A7DEB32719E87ABA2C26C29442E984785033D97` |
| `Energy/CanonicalMainUniform.lean` | `1C8CDFFB49CEAEA9BB4465573530590BB9D18285B5FE0EA2EB5F4ACAD13EF041` |
| `Energy/CanonicalErrorUniform.lean` | `D83195BAEDFB3B17AA312B7CC4D9F923E1965B94C745BC95D066D6F70ABC4A56` |
