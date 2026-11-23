# Independent review of seeded Gaussian source energy

2026-11-11. Reviewer: coordinator, independently of the author. Verdict: PASS for the bounded conditional source argument described here. No correction to the frozen author report is required. This does not validate the complete QRH provider, prove the supplied child-energy inequalities, or close the saved exceptional estimate's analytic dependencies.

The reviewed [author report](../qrh-campaign/agents/independent-feasibility/QRH_SEEDED_GAUSSIAN_SOURCE_ENERGY_AUDIT_2026-11-11.md) has SHA256 `9CD95D94917B765A1B0A3F9901A81BDD8617901C50B3A6B99063B3E23553A4BB`. All 39 source-table hashes and all five supporting-report hashes match. Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`, baseline `4eaee87548250b2682affda7d05d947c05554bae`. The original author report is unchanged.

I read the report, inspected the actual target bodies and the supporting calculations listed below, reconstructed the normalization and loss accounting, and checked the explicit lower dependencies. This review uses source, algebra and exact rational checks. No Lean build, source edit, declaration, numerical analytic evaluation or spectral scan was performed.

## 1. Exact conclusions and quantifiers

`Moments/SecondFrozenLiveSource.lean:34` is a conditional transfer from actual live child energies. Its two premises quantify over the real child inputs, all required real heights, supported squarefree divisors, nonzero frozen allocation coefficients and active second children. They are not implied by Ready. The auxiliary character family is selected from actual common-label data before Q, m, the physical scales and the two energy bounds. The constant and eventual threshold precede the varying source and seed.

Writing V for source volume, H for source radius and P for profile cost, its conclusion is exactly

`norm(partEnergy false)/V <= C*Z^(2*delta+epsilon)*P*Norm(eta.modulus)*H*sqrt(E1*E2)*heightEnvelope(t)^(J1+J2)*profileMoment(J1)*profileMoment(J2)/Norm(seed)`.

The source retains nonnegative E1,E2, nonnegative H, a nonzero squarefree seed, the radius caps and the hypotheses needed to transport nonexceptional rows. It does not assert that some nonzero block must exist. Zero blocks contribute zero.

`Moments/SecondSourceRemainder.lean:71` has a different quantifier order for Q. J, the finite control sets and the three constants precede Q, while Kc and the eventual threshold may depend on Q. Q must be neither zero nor top and must satisfy the stated ideal inclusion into `(72)`. All four lower scale bounds `Z^r<=X1,X2,Y1,Y2` remain explicit. No product-only replacement is valid here.

## 2. Conditional retained-energy mechanism

I checked `CommonLiveFrozen:58` and `CommonLiveHeight:20`. The common source estimate uses the actual radial divisor theorem at delta/2 and the squared allocation count at delta/2. A live coefficient gets its normalized support cost; a zero coefficient contributes zero. The result is linear in E, with denominator `Norm(C)*Norm(L)`. Multiplication by positive raw volume gives the height envelope with the correct normalization.

In `SecondSupportedChildren:26,54,71`, a divisor larger than `H/Norm(D)` makes every right coefficient zero. The finite witness argument uses actual divisibility and the source norm cap. For such divisors the right energy is exactly zero, and only a coarse valid left envelope is needed. On the remaining divisors, the paired square-root budgets leave a single factor `1/Norm(L)`. The separately invoked harmonic theorem pays Z^delta. `SecondSquarefreeBlock:65` supplies coarse bounds off the squarefree locus solely to meet a lower theorem's domain; those terms then vanish because their Mobius coefficient is zero.

The bilinear mechanism is not an estimate obtained from unrelated densities. `Cauchy:49,99` uses one density supplied by the previously reviewed whole-product separation theorem. It proves the finite sums of integrals are integrable before interchanging them. The finite row Cauchy estimate controls the product of the two square-root row energies against that same density.

`RestrictedEnergy:63,82` preserves the right argument `-z` and inverse ray character. It supplies the reflection and ray-independence hypotheses using the exact Q and m restrictions. `SecondNonexceptional:16` retains the factor 256 from the finite ray/divisor estimate. `SecondIdealBlockBound:62` applies this to the actual primary generators and sector elements, with the original coprime indicator.

I also checked `RestrictedWindow:39,108`, `SecondMaskedWindow:60`, and `SecondRadicalBlock:61`. The window estimate applies a finite weighted integral inequality to the square root of a nonnegative lattice weight. Its column representation and integrability are explicit lower inputs. The height shift is `t+2*pi*(w-theta)`, and the all-real-height bound is required. A genuine HasSum result then relates the finite estimates to the restricted energy. The conjugate window uses the negative frequency. These are conditional uses of the named Fourier and weighted-integral theorems, not a new proof of those foundations.

## 3. Physical normalization and finite aggregation

`SecondFrozenSupported:78`, `SecondFrozenPhysical:78` and `SecondFrozenChosen:95` transport those estimates to the actual physical block and canonical radial input. The division by volume is performed once. Both physical normalization factors are nonnegative, and the ratio denominator is positive.

At `SecondFrozenRatioCost:110`, both child bounds contain the same nonnegative factor E. The identity `sqrt((E1*E)*(E2*E))=E*sqrt(E1*E2)` spends that factor once. Neither the common child envelope nor the small-ratio penalty is squared again.

I reconstructed the scalar cancellation in `SecondNonexceptionalScalar:21` and `SecondRetainedRatioScalar:43`. A nonzero physical block supplies an actual nonzero summand. Its first dyadic weight bounds the effective scale, while its column windows bound the two residual scales by `4H/Norm(C)` and `4H/Norm(D)`. Thus their geometric mean is at most `4H/sqrt(Norm(C)*Norm(D))`.

For every r>0 and 0<=a<=1,

`r/(1+r)*max(1,1/r)^a <= 1`.

When r<=1, the power is at most 1/r. When r>1, it equals one. Taking a=1/6 therefore introduces no extra ratio loss. The common-frequency and subset factors cancel as stated in the author report.

`SecondBlockHarmonicMass:34` injects actual active label/subset pairs into the harmonic partition. At :106, half the epsilon loss pays the label mass and half pays the number of source blocks. `SecondNonexceptionalAggregate:22` enlarges from live to active labels only through nonnegative weights. Its :64 theorem and the actual application in `SecondFrozenLiveSource:110` leave `Z^epsilon/Norm(seed)`. The result has the claimed exponent `2*delta+epsilon`.

## 4. Exact remainder and diagonal

`SecondLocalization:26,61` consumes the actual Poisson identity with the positive kernel scale `Kphys/(Norm(I)*Norm(J))`. The source applies its summable lattice split before making the finite source sums. In `SecondSourceRemainder:121`, the retained exceptional/nonexceptional identity gives the exact complex equality

`G - P_nonexceptional = (Kphys*radialFourier(W,0))*Z0 + P_exceptional + T_discarded`.

Only then does the proof take norms and divide by V>0. There is no extra factor three. Each summand retains its own normalization.

The diagonal proof was inspected below the source adapter. In `SecondDiagonal:14`, nonzero multiplicative-character values imply coprime residue representatives. The zero-frequency congruence then forces mutual divisibility of the two moduli. Distinct ideals have zero contribution. On the same ideal, the correlation is bounded by the residue cardinality. This cancels the two square-root norm denominators, leaving the sum of squared coefficient norms.

`SecondDiagonal:97,157` counts seed-divisible ideals through an injective quotient map. The norm-ball estimate is used only after showing its radius is at least one; an empty set is handled directly. Actual primary-generator uniqueness prevents uncharged repetitions in the column indexing.

`SourceSecondZeroEnergy:97` controls tuple multiplicity with divisor loss `epsilon/(2*(N+2))`. Each grouped coefficient costs `Y^(epsilon/2)` and its square costs `Y^epsilon`. The source's normalized theorem at :154 leaves `V^epsilon`, rather than `V^(1+epsilon)`. Its subunit support case is exactly zero. I checked the actual profile substitution at :192 and `SecondSourceDiagonal:20`, including the equal plain scale products, seminorm factors and the surviving `1/Norm(seed)`.

## 5. Exceptional branch and the next analytic dependencies

The actual exceptional-row adapter in `SecondExceptionalFixedQChosenBlock:85` preserves both reflected inducing conditions and both expanded-conductor bounds. It derives the lower support from the same source coefficients, treats the zero-block case separately, and passes all four individual plain-scale bounds unchanged.

The scalar inequality used in `SecondExceptionalCommonSaving:9` is valid. For u,v>=0 and m=min(u,v),

`max(r-m,0)+(u+v)/3 >= 2*max(r,0)/3`.

For r<=0 all terms on the left are nonnegative. For 0<r<=m, u+v>=2r. For r>m, subtracting 2r/3 leaves `(r-m+u+v-2m)/3>=0`. The additional factor `(Norm(C)*Norm(D))^theta` is bounded by `Z^(2B*theta)` before combination with this saving.

`SecondExceptionalFixedQSource:84` uses the radical harmonic weight, not the retained branch's square-root pair weight. Its finite aggregation adds delta and preserves the inverse seed norm. `SecondExceptionalSourceCaps:14` pays five B powers for eta, puncture, two source-radius factors and frequency radius; a fixed constant is absorbed into one further power. The uniform source theorem therefore has exponent

`2*epsilon+2*delta+2*(5B+1)*theta-2*max(r,0)/3`.

The author's saved exceptional theorem remains an analytic boundary. I additionally inspected its immediate body at `FiniteProfileExceptionalFixedQSaved:78`. It combines a dyadic estimate at decay one with a separate physical-saving estimate, using a nonzero-block split and a positive `1+rK` denominator. This conditional assembly has no defect, but neither lower estimate is proved by that assembly. The next distinct targets are `CenteredMomentFiniteProfileExceptionalFixedQ.actual_dyadic_exceptional_block` and `CenteredMomentFiniteProfileExceptionalPhysical.original_budget_physical_saving_full`. The latter is the version with a finite seminorm set and Profiles argument. The similarly named theorem with a Tests argument is not an interchangeable source interface.

## 6. Discarded tail

I checked the chain `SourceInputTailUniform:37,71,97,130,159`, `SupportedTailAggregate:42`, `SecondTail:15,46`, `SectorLocalization:437,471`, and `Tail:116,156` against the radial lattice summability and tail statements at `Poisson/RadialFourier:533,544`.

The actual kernel has positive lower reference `exp(-2HN)/Tsec`, obtained from the column norm cap and `V^2/Kphys<=Tsec`. The latter also establishes Tsec>0. The correlation contributes the product of the two column norms. The outside square-root normalizer is coarsely bounded by Kphys using integral norms at least one. No seed saving is asserted.

The pair aggregation squares the coefficient absolute mass. That mass is bounded by a fixed support constant times plainControl times V. The two column norm caps contribute another V^2. After division by V, the resulting power is V^3. The inverse reference-kernel factor costs at most a fixed constant times `Z^(2B)`. Together these cost five B powers.

Choosing a natural A with `(xi/4)*A >= 5B+saving` gives the requested `Z^(-saving)`. A exists even for a negative requested saving. The finite seminorm set and constant may depend on A. The eventual cutoff depends on fixed HN and xi, not the varying source. The subtype restriction uses a genuine summable norm majorant before its tail comparison. Consequently the final discarded term has no `1/Norm(seed)`.

## 7. Verification and limits

In addition to the general algebra above, 77 exact rational edge-case checks passed: 45 for the exceptional scalar inequality, 27 for the natural tail-order allocation, and five for the ratio penalty at exponent 1/6. These finite checks corroborate the formulas; they do not replace the general argument or prove any analytic estimate.

The 39 original source pins and five support pins are inherited from the unchanged author table. Three additional files were inspected to identify the next interfaces; they are not accepted as completely proved analytic dependencies:

| Source | SHA256 |
|---|---|
| `Moments/FiniteProfileExceptionalFixedQDyadic.lean` | `7002D30BFB80C8260B1BAF8E27D97D1B07CD182D47352C964F6695471247B24D` |
| `Moments/FiniteProfileExceptionalPhysicalSaving.lean` | `FC1ADE59A5727993749A11915501114E2003B741D2D6D6C90ECB61F99E58B8E5` |
| `Moments/SecondExceptionalPhysicalSaving.lean` | `D56F3F9E231FDA9EA297ACA883E2581C402F314B715178D076F9DA22FC305684` |

The verdict accepts the bounded conditional transfer and remainder accounting. The child energies, actual radial divisor estimate, exceptional analytic estimates, specified Fourier/Poisson identities, harmonic/counting inputs and compatible library validation remain dependencies. This review neither proves their complete closure nor adds them as allowed premises to the final Goldbach theorem. It changes no finite spectral requirement and does not remove PlattGRH from Lean.

`DRAFT_ANCHORS: 0 created`

`UNREGISTERED_SORRIES: 0 introduced`

`DRAFT_IMPORT_VIOLATIONS: 0 introduced`

`SEALED_THIS_TURN: 0`
