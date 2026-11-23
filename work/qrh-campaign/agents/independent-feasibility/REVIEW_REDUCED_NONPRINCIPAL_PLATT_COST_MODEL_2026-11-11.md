# Review of the reduced nonprincipal Platt cost model

2026-11-11. Verdict: PASS at bounded paper, source-interface and exact metadata scope, with the two inventory qualifications in section 4. The report describes a defensible candidate operation schedule. It does not supply a complete spectral certificate, a globally admissible parameter selector, or a runtime estimate.

## 1. Frozen inputs and independent work

Paths below are relative to `work/qrh-campaign/agents/`.

| Input | SHA256 |
|---|---|
| zero-sum/REDUCED_NONPRINCIPAL_PLATT_COST_MODEL_2026-11-11.md | B3718D22BE11EBE5503EB2124E0B690D49B428E0000D5CD763317367ADB60AFC |
| zero-sum/nonprincipal_platt_schedule_metadata_20261111.py | F68362D0F18AAD39594598A99E9B5250C8815EDDA2515C37B579DB51EC5C52E0 |
| zero-sum/nonprincipal_platt_schedule_metadata_20261111.json | 6F661E61A212D3F65C24625E6A211DCC0494853BDD3D875162E8521E306F296F |
| zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md | 53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54 |
| zero-sum/FAMILY_GAUSSIAN_FOURIER_PROOF_PLAN_2026-11-11.md | 5FED76F0F59A6422977D968DD7F2018FEDAE0A175DE1ECD43D956EFDEDF44F41 |
| major-constants/JOINT_CHARACTER_FOURIER_BATCH_PLAN_2026-11-11.md | 3D41376E00A58D5EBC8403151807694163F0E59923869DCAAAB08F51A6A3625D |

I read the full author note and metadata code, inspected the relevant completion and transform interfaces, and checked the primary algorithm descriptions. My separate metadata implementation uses Euler totients followed by divisor subtraction to obtain primitive-character counts, rather than the author's local multiplicative formula. It independently constructs unit-group axis lengths and the stated radix-two/Bluestein circuit counts. It neither imports nor executes the author implementation.

The owned script `review_nonprincipal_platt_metadata_20261111.py` has SHA256 `829F4FC31D8E5F8E7FC8C2CB8E30FB2CDC79591AE6347188FE984A8B3D857BDE`; its receipt has SHA256 `7D2183B5737D118DD3C62AC52F2CC25F3B96CAE6F0B65182D59C257A378A94A3`. One metadata-only execution passed all 61 compared fields, the adaptive P=24 seed total, the isolated alpha-error inequality and the eightfold refinement identity. No character values, function values, zeros, FFTs or Lean builds were computed. The script's wall time is not a spectral-cost measurement.

## 2. Mathematical sharing and normalization

The shifted Hurwitz expansion is sound for the specified real alpha segment. For M>=1, every shifted argument is at least M. The normalized derivative is (-1)^k(s)_k zeta(s+k,M+alpha)/k!. The identity must be continued from the absolutely convergent half-plane; no critical-line termwise differentiation is needed. The P-th derivative is absolutely convergent for P>=1. Its first-term-plus-integral majorant gives exactly the stated real Taylor remainder, including the P-1/2 denominator. With |t|<=V, the five D/P choices give (V+24)/(2D)<2/3. Multiplication by phi(c)/sqrt(c)<633 yields the asserted isolated error below 2^-82. This bound does not include seed radii or arithmetic.

The same exact height, anchor, coefficient order and precision identify reusable lattice data. Conductors then have different rational alpha displacements and contractions. Thus seed generation can genuinely be shared across conductors, while the P*phi(c) contractions remain. The factor c^-s and the normalization of the positive character transform are necessary. The M=1 head simplifies after scaling to a^-s. The expansion never evaluates the individual Hurwitz function at s=1; the nonprincipal common-pole cancellation does not license a totalized principal or individual finite-part identity.

The character circuit acts on the CRT product of cyclic unit groups. A single cyclic transform of length phi(c) would generally change the characters. The stated axis formula counts two transforms for each Bluestein input, a cached kernel transform outside that repeated count, point products and chirps. Primitive filtering after the full group transform is valid; replacing its dimension by the primitive count is not justified by filtering alone. In the small-conductor route, filtering before the subsequent time transforms is valid. The source completion and the conductor/parity scales in the displayed theta identity match the pinned Gaussian interface. The time inverse factor omega*L differs from the character normalization. No imprimitive functional equation is silently used for primitive output certification.

The Gaussian tail ratio bounds successive positive majorant terms once the ratio is below one. The observation cH<=135000000 is valid for this target domain; it does not bound cV after Turing extensions or interpolation guards. The small-conductor cost remains conditional on an actual frequency, tilt, truncation and precision selection.

## 3. Reproduced inventory and refined-grid interpretation

The reduced nonprincipal domain has 149999 nonempty conductor levels and 5543640187 primitive labels. Its large-conductor part has 5525163079 primitive labels and 75730502011007 coarse output slots. I independently reproduced 114223068442718 residue-height inputs, 5723455868055742 character butterflies and 976028467193580 extra products. The adaptive shared lattice contains 17223585528 P=24 seed-coefficient slots, not that many simultaneous live values and not that many elementary arithmetic operations.

The nominal grid includes ceil(64H/5)+1 samples. It therefore includes a terminal point at or beyond H. Ordinary refinement by eight gives 605805339946503 distinct large-conductor output locations and 530074837935496 new locations. These are interpolation outputs, not new full character transforms at every location. The formula subtracts seven copies of each channel's already counted initial endpoint.

Platt's section 7 distinguishes the 5/64 initial grid, routine eightfold interpolation and later 32/128/512 refinements. Its remaining-function percentage comes after these refinements and cannot estimate unresolved seed-grid work. The inspected pinned implementation reads lattice data and caches Bluestein kernels; that inspection does not authenticate the historical executable. Sources: [Platt's paper](https://arxiv.org/pdf/1305.3087), [pinned implementation](https://raw.githubusercontent.com/djplatt/code/1f19fcbefa33d2fe5949ddbcd4d3df75deca6819/l-func/int-l-func5.11.cpp).

The polyphase proposal is a finite convolution acceleration. With guard samples and only interior outputs retained, padding at least M+2m can avoid wrap into those outputs. A later checker must specify the kernel index placement and cropped outputs; it must not assert that this length computes every output of an unrestricted linear convolution. The displayed input/kernel radius product expansion is valid without independent-error assumptions. Its analytic Fourier and omitted-sample tails remain additional obligations.

## 4. Two qualifications to retain with the frozen artifact

The JSON contains `alpha_length=16`, `alpha_cells=2048` and related length-16 comparison fields. These are unselected legacy inventory, not the P=24 adaptive schedule justified by the report's new truncation bound. The author confirmed this interpretation. A consumer should select the explicitly named P=24 fields and parameter table, rather than treating those old top-level fields as a certified execution manifest.

The height-cohort table tests H(c)>=t. It is not the full ceil-grid active set, since the latter includes a last node beyond H and may later include guards and Turing work. The author's aggregate grid counts use the correct ceil formula. A production implementation must not truncate its schedule from the illustrative cohort rows. The author confirmed this distinction. Neither qualification requires changing frozen numerical totals.

## 5. Costs still missing from an end-to-end comparison

The following omissions are explicit in the author report and remain material:

- The shared lattice producer must enclose all actual Hurwitz coefficients. Its EM head, corrections, elementary functions, analytic remainder and precision escalation belong in C_lat. Seed-slot counts alone do not price it.
- Unit-group manifests, primitive labels, character/root-number phases, chirp setup, actual residue indexing and transform rounding require proofs and data. Caching is valid only for equal inputs and retained precision.
- The complete sign interpolator needs admissible widths, guards and tail parameters for every range, including small heights and negative guard samples. It interpolates the actual scaled completed function. A phase-equivalent sign proxy does not supply its amplitude or Fourier tails.
- The actual sets requiring finer interpolation, new off-grid values or higher precision are unknown. A more accurate transform cannot repair inaccurate shared inputs. Failed generation work counts even when it leaves no accepted certificate.
- Count acceptance needs central-zero treatment, actual multiplicities, canonical phase integrals, auxiliary intervals, endpoint conventions and integer saturation for every character orbit. Inverse-character reuse supplies negative ordinates; it does not halve the required positive channels. Sign brackets alone do not guarantee termination in the presence of multiple critical zeros.
- Standard-axioms checking must prove the retained arithmetic DAG and error inequalities. Compact serialization is not a native-array kernel computation theorem. Seed theorem sharing can avoid repeated proofs, but contractions, transforms, selected signs and count checks remain. Neither this report nor the historical implementation measures the required Lean or ordinary-rule MM0 work.

## 6. Decision supported by this review

The reduced-domain category counts and the shared-lattice architecture are defensible comparisons. They expose repeated work that a per-character direct sum or independently generated per-conductor EM head would pay. The quoted ratios around 70 and 940 compare different operation inventories; they are not runtime or proof-checking speedups. The broad comparator is the project's declared original domain, not the entire historical verification.

The next useful cost packet is a complete shared seed producer plus a globally admissible interpolation/auxiliary parameter policy, followed by a separately authorized bounded full sign/count example. Current evidence supports studying that architecture. It does not yet rank its total standard-axioms proof cost against strip exclusion or other finite-family replacements. The reduced-domain consumer refactor, all spectral correctness theorems, and their formal implementation remain required.
