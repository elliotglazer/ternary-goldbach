# Independent review of positive-band production

2026-11-11. PASS for the bounded assembly and normalization reviewed below. The reviewer is the coordinator, independent of the author. No Lean command, source edit, analytic evaluation or spectral computation was performed.

The [author report](../qrh-campaign/agents/independent-feasibility/QRH_POSITIVE_BAND_PRODUCTION_AUDIT_2026-11-11.md) has SHA256 `295C51C596813AF877A02EA4B445FAF79CD853604A4F04B20A90E13D75C351A4`. I read it in full and independently matched its 46 source pins. The source root is `work/openai-math/lean/OAI/NumberTheory/DirichletL`, commit `4eaee87548250b2682affda7d05d947c05554bae`. File hashes identify sources; they do not certify all declarations in those files.

## Exact conditional input

I inspected `Energy/CanonicalLowColumn.lean:122–334`, including the actual application body. Its output profile set and height degree precede the character and modulus divisor; its bound and scale threshold follow those fixed data and precede the dynamic scale and source data. The auxiliary character family follows the selected ray character. The theorem consumes actual child `ZeroAt` and `PositiveAt` bounds at lines 150–152 and the main/error admission packet at lines 181–192. It therefore cannot supply its own child estimates.

`Moments/FirstSecondInputGates.lean:23–34` defines `Ready` by nonzero puncture, positive scales and geometric caps. No target energy inequality is hidden in that structure. This establishes only the meaning of the input; it does not prove the eventual admission construction.

The low-column regime retains kappa >= 1/6, beta >= 51/100 and 2 beta - 1 <= kappa. The natural caller at `Energy/NaturalLowStage.lean:37–62` requires kappa >= 3/4. The support, width, height, modulus and positive-loss hypotheses remain as stated in the source. Neither result is uniform over arbitrary new fixed slot families or support intervals.

## Reference factor and physical pairing

I read `Moments/FirstCommonReferencePower.lean:18–82`. With positive b,V,C,q,Z, its actual normalized power satisfies

`q*(V/C)^2*Z^allowance * normalizedPower = C^(eps-1)*V*E*(b^N*V/C)^alpha`.

The cancellation uses positive real powers and the nonzero conductor norm. The subsequent bound still consumes `common_energy_power_budget`; that input is not established by the identity. `CanonicalLowColumn:268–334` applies the child bound, this reference identity and the homogeneous four-power bound, then uses nonnegative factors to replace source mass and split height. It keeps the advertised sum over all four powers. I checked this assembly, not the analytic derivation of every homogeneous or amplified estimate.

`Moments/FirstReferenceEnergy.lean:33–80` demands both left and right column bounds for the stated squarefree divisors, every ray character and every real frequency. `Moments/FirstReferenceBlock.lean:25–105` applies both bounds, expands the paired window budget and uses the actual reference-window comparison. The latter remains an explicit lower input. `Moments/FirstDivisorCommonBound.lean:159–206` separately pays the supported harmonic mass; finite summation alone does not establish that mass estimate.

In `Energy/FirstPhysicalNormalization.lean:14–77`, the square-root pair is at most H when both coefficients are at most the same nonnegative H. Summing the four-by-four pairs costs 16H. It does not square H or double its scale exponent. The exact identity

`K*q*Z^(Mdecl-(logb Z K+logb Z q)+ell) = Z^(Mdecl+ell)`

holds for Z>1 and K,q>0. Thus the parent conductor factor in `sourceFactor` is paid, rather than discarded. Lines 208–256 combine these estimates into the declared physical bound with exponent `Mdecl+ell+eps` and the retained inverse seed norm.

## Absolute block mass and loss allocation

I read `Moments/FirstReferenceSource.lean:27–114` and `Moments/FirstReferenceEnergy.lean:69–133`. `physicalMass_eq_sum` is a finite sum of norms of the actual original blocks. Its nonnegativity does not assert a positive lower bound for an energy or probe.

The total small exponent is allocated coherently: half to the single-block estimate and half to block summation. Inside the latter, half goes to dyadic counting and half to inactive radical mass. These are distinct lower estimates. The zero source-radius branch uses `physicalMass_zero` after deriving that both profiles vanish at zero from their positive lower support endpoints; it avoids an invalid division by that radius.

`Energy/CanonicalLowPhysical.lean:109–165` explicitly requires each of the four Gaussian-plus-column losses, including `epsSrc*(A+1)+primeLoss`, to be at most ell. This review does not convert that input into an independently verified parameter-selection theorem.

## Return to the band

I read `Energy/ZeroComparison.lean:22–111`, `Energy/FixedRadialReduction.lean:22–56`, and `Energy/PositiveLowBandSource.lean:24–98`. The comparison scale is `1/(2*max 1 b)` and makes the comparison row exactly zero via the strict-subunit row theorem. The other scale preserves the source product and volume. This is an exact zero comparison, not a limit with an omitted error.

The radial reduction retains separate diagonal and tail terms, with positive diagonal-control multiplier. Its source comparison and first physical-reduction theorems remain lower inputs at this cut. The low-band assembly uses the old positive band for width <= rho and physical mass for width > rho. Equality is covered. It requires `epsDiag <= e` and `-saving <= e`; the error terms are not dropped.

I also inspected `Energy/NaturalLowStage.lean:37–125`. It transports the existing child estimates, merges profile sets and height degrees, and inserts the physical estimate. The condition `Mparent-amplification/2 <= Mchild` alone does not prove strict descent. The separately reviewed calling schedule must supply the induction. This audit neither repeats nor replaces that schedule.

## Remaining scope and updated handoff

No correction was found in these conditional assembly and normalization steps. Lower child-energy production, admissions, homogeneous estimates, reference windows, source comparisons, dyadic and harmonic estimates retain their own proof obligations and any separately recorded reviews. The deeper finite ray/Cauchy derivation described by the author is not newly certified by the coordinator's narrower review here.

The author's frozen recommendation to inspect `Moments/Smooth.whole_product_pair_separation` has since been followed in a separate [consumer-join report](../qrh-campaign/agents/independent-feasibility/QRH_WHOLE_PRODUCT_PAIR_SEPARATION_AUDIT_2026-11-11.md). It must be reconciled with its independent review before being counted as accepted. The already reviewed radial envelope is a supporting input, not automatic coverage of that consumer. The newly identified live-allocation bound is likewise a distinct report.

This is bounded paper/source evidence, not a compiled theorem, complete source-dependency audit or transitive axiom check. No final Goldbach premise, spectral profile or frozen anchor changes.

The author's 46 matching source pins are the source manifest for this review; the ranges above specify what I inspected independently.
