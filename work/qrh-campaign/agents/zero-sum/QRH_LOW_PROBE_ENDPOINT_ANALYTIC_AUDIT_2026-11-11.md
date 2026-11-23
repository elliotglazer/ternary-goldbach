# Actual low-probe endpoint: bounded analytic audit

Date: 2026-11-11. Verdict: PASS for the conditional source assembly and scale/mass estimates described below. This is not a build, axiom audit, or validation of all reflected-energy and Gram foundations. No Lean edits or analytic evaluations were made.

## 1. Distinct coverage and actual target

The accepted final-contradiction report consumes `Detector/FinalAssemblySource.normalizedProbe_low`; the ray-normalizer report separately checks its eventual nonzero denominator. Existing `Energy/CanonicalLowPhysical` audits concern a different induction layer. This report follows the detector's numerator estimate and its immediate Gaussian, scale and compensation mechanisms.

The target is `Detector/FinalAssemblySource.lean:35`, through `LowNormalized.lean:13`. Fix a nonzero ideal M, a subgroup H containing global units, finite source exclusions S, K slot exponents ell_i>0 that are injective and sum to 1/6, and nonnegative nonzero smooth compactly supported slot weights W_i supported in (a,b), a>0. Fix nonzero, real-valued, nonnegative Schwartz weights W0,W1 supported in positive compact intervals. For each actual character eta and every loss>0 the source produces a constant and eventual bound

\[
 |\operatorname{normalizedProbe}_\eta(Z)|\le C_\eta Z^{3/16+\mathrm{loss}}.
\]

The normalizer is exactly sourceResidueConstant(W0,W1,product(S)) times the principalScalar at total slot mass and exponent 1/6. Its nonvanishing is an eventual **conclusion**, retained together with the estimate. Constants and thresholds may depend on eta and the fixed data. No character-uniform top bound is inferred from the theorem's `forall eta, exists C` order.

Source paths below are relative to `work/openai-math/lean/OAI/NumberTheory/DirichletL/`.

## 2. Actual subset decomposition, not a replacement probe

`GaussianSubset.lean:13–35` uses J for the unselected slots and its complement for `SelectedSlot J`. Write

\[
 d=\sum_{i\in J}\ell_i,\qquad e=\sum_{i\notin J}\ell_i,
 \qquad d,e\ge0,\quad d+e\le1/6.
\]

For a tuple of canonical supported prime generators, let L be the `elementNorm` of the product over J. Here `elementNorm(n)` is the absolute ideal norm of the principal ideal (n), not its Euclidean square root. Every entry is nonzero, L>=1, and L is multiplicative. For constants c0=(min(1,a))^K>0 and B=(max(1,b))^K,

\[
 c_0Z^d\le L\le BZ^d.
\]

The compensated subset weight, selected slot factors and their log phases remain in the exact formulas. In particular selected phases use `logPhase(-t, log(elementNorm(p_i)/Y_i))`. `GaussianCommon.lean:11` identifies the actual compensated physical probe with the finite sum over all subsets J of a dyadic sum of `lowCommonDyad` integrals. The base of each density is R=Z times the product of selected scales, hence R=Z^(1+e). Replacing it by Z would lose the selected-scale dependence.

The physical row tsum is made finite first: `GaussianPhysicalTuple.lean:14` constructs one common finite row set for the finitely many tuples, using compact physical weights and positive scales. The body at line 27 then applies the actual Gaussian row identity. `GaussianTuple.lean:106` explicitly supplies corrected-Gaussian dyadic summability before interchanging that tsum with a finite tuple sum. Thus the assembly is not justified by default tsums. The deeper corrected Gaussian reassembly and separation identities remain named foundations in section 8.

## 3. Inverse-row normalization and the retained energy input

Let q=elementNorm(calibrationForSet(S).generator)>0, X0=Z^(17/48), Y0=Z^(23/48), and

\[
 Q=\operatorname{lowPhysicalScale}(X_0/L,Y_0/L)=qZ^{5/6}/L^2.
\]

`LowPhysicalInverseBound.lean:13` uses the **actual** selected inverse row, finite numerator rows and ray residue classes. It does not replace the row by a freely chosen vector. The numerator row cutoff is bounded by a fixed constant times Z^(5/6-2d), using the lower bound on L. `LowNominalEnergy.lean:13` supplies

\[
 E_\sigma=\sum_{z\in R_{\rm num}}|\operatorname{row}_\sigma(z)|^2
 \le C(1+|t|)^n Z^{5/6-2d+507\epsilon}.
\]

Its central dyad parameter U lies in [Z^(1+e-epsilon/2),Z^(1+e+epsilon/2)]. The nominal conversion sets ell0=e+epsilon/2 and shift=log_Z(U)-1-ell0; it keeps |shift|<=epsilon and the capacity ell0<=1/6-d+epsilon.

`LowSelectedBound.lean:27` is read at its adapter level: it supplies the actual period, calibration mask and bad-prime divisibility, filters primes against that period, preserves disjoint selected lists, sums the true ray characters and all six unit rows, and pays the fixed correction energy. The substantive underlying theorem is `Reflection/LowOriginalEnergy.low_original_completed_energy`; its reflected analytic proof is **not closed by this report**.

The subsequent scale cancellation is fully checked. `LowInverseNormalize.lean:19` gives

\[
 \frac{\sqrt{E_\sigma}}{\sqrt Q}
 \le\sqrt{CB^2/q}\,(1+|t|)^n Z^{507\epsilon/2}.
\]

Indeed E_sigma/Q is bounded by (CB^2/q)(1+|t|)^n Z^(507epsilon), since
Z^(5/6-2d+alpha)(Z^d)^2/Z^(5/6)=Z^alpha. Taking square roots and using sqrt((1+|t|)^n)<=(1+|t|)^n is legitimate. Summing the finite ray residue classes and retaining 1/(2 pi) proves the normalized inverse-mass bound. No main power of Z is silently removed by a normalization convention.

## 4. Gram factor and compensated mass

`LowTupleGram.lean:35` applies the actual separated Gram estimate after the exact tuple-to-low-polynomial identity. It bounds each unselected tuple by its weight norm times

\[
 \frac{1}{2\pi\sqrt Q}\,operatorname{Gram}(X_0/L,Y_0/L,\epsilon)
          \sum_\sigma\sqrt{E_\sigma}.
\]

`LowGramIntegrated.lean:30` integrates the pointwise Gram bound using compact Mellin decay: the weighted Mellin factor is <=C/(1+v^2), whose integral is pi. The generic norm-integral inequality by itself is not a proof of Bochner measurability or of the original Fourier identity; the meaningful actual separated representation and lower Gram theorem remain inputs.

The Gram scale is explicitly reconstructed in `LowGramScale.lean:13` and `LowSourceScales.lean:38,62`. Eventually q<=Z^(1/8) and L<=Z^(11/48): the latter follows from L<=B Z^(1/6) and fixed B<=Z^(1/16). Put P=Y0/(qX0). Then P>=1, while L Y0/(q^2 X0^2)<=1. The three terms in the Gram square are therefore bounded by three times P^(1/6), and (Y0/L)^epsilon<=Y0^epsilon. Since 17/48+(1/8)/6=3/8,

\[
 \operatorname{Gram}(X_0/L,Y_0/L,\epsilon)
 \le\sqrt{3q/L}\,Z^{3/16+23\epsilon/96}.
\]

Combining this with the inverse-mass bound costs (507/2+23/96)epsilon=24359epsilon/96<254epsilon. It leaves the factor L^(-1/2) multiplying the unselected compensation weight, rather than a tuple-count loss.

`LowUnselectedMass.lean:37` proves the exact norm identity

\[
 |w_J(p)|L^{-1/2}
   =\prod_{i\in J}\operatorname{elementNorm}(p_i)^{-2}
                         |W_i(\operatorname{elementNorm}(p_i)/Y_i)|.
\]

The compensation supplied L^(-3/2); the Gram factor supplies the remaining L^(-1/2). The sign (-1)^|J| is harmless only after its norm is taken. The canonical-slot/prime-ideal equivalence is used for the inverse-square sum, so there is no omitted unit multiplicity. Each finite slot sum is dominated by the convergent supported-ideal norm sum of exponent -2. The finite product formula then gives one constant depending on K and the fixed weight bound, independent of the actual pools, subset and scales. `LowCentralTuple.lean:18` concludes the genuine central tuple estimate C(1+|t|)^n Z^(3/16+254epsilon).

## 5. Central and remote dyads, including the boundary cases

`LowGaussianDyad.lean:36,57` multiplies the central tuple bound by the actual Gaussian density and integrates against its weighted Schwartz norm. `LowGaussianCentral.lean:23` compares central dyads with

\[
 CZ^{3/16+254\epsilon}(2^j)^\epsilon
     \operatorname{gaussianJointMoment}(V,n,2^j/R),\quad R=Z^{1+e}.
\]

The positive moment sum is genuinely summable and at most C'R^epsilon. `GaussianDensityBudget.lean:57` obtains this from polynomial decay of order N>epsilon and the dyadic kernel sum. Thus the central total is at most CC' Z^(3/16+256epsilon), because (1+e)epsilon<=7epsilon/6<2epsilon. Inserting (2^j)^epsilon>=1 is in the correct direction.

The remote predicate is 2^j/R<=A^(-1) or A<=2^j/R, where A=Z^(epsilon/2). Both equality boundaries are assigned to the remote part; the complement satisfies the closed central range used above. No dyad is lost.

`LowRemoteMass.lean:63` retains the actual coefficient norms and proves the scale-mass bound

\[
 \operatorname{mass}\le q(128\max(1,b))^K Z.
\]

It uses the finite ideal-count bound for each canonical prime slot, yielding at most (128 max(1,b))^K Z^(1/6) tuples, and a per-tuple physical scale <=qZ^(5/6). The compensation and remaining weight factors have norm <=1; L>=1 justifies discarding its denominator in this crude remote estimate.

`LowGaussianRemote.lean:60` applies the actual remote polynomial tail estimate, with N chosen so epsilon*N/2>=13/3. The remaining power is

\[
 Z R^2/A^N=Z^{1+2(1+e)-\epsilon N/2}\le Z^{-1},
\]

using e<=1/6. The physical scales X0/L,Y0/L are eventually >=1 before applying that theorem. Both the summability and the tail bound are returned; a formal unproved decay phrase is not substituted for them.

`LowGaussianSum.lean:12` adds the two nonnegative norm series, obtains absolute summability of the complete complex dyadic series, and applies the norm-tsum inequality. Its total bound is Ccentral Z^(3/16+256epsilon)+Cremote Z^(-1), absorbed at Z>1. The Gaussian log-window and remote decay producers remain lower analytic dependencies; this audit checks their complete consumption and exact exponents.

## 6. Actual pools, weight rescaling and denominator

`LowCommonBound.lean:23` takes the finite sum over every subset J; it sums their constants and intersects their eventual thresholds before allowing arbitrary actual prime pools and bounded slot weights. `RayPoolDisjoint.lean:12,24` proves eventual disjointness of the actual pools from injectivity of the exponents: for ell_i<ell_j, b Z^ell_i<a Z^ell_j eventually. Pool norm bounds respect their floor-defined endpoints. This is not an assumption of random or independent primes.

The generic numerator estimate accepts norm-bounded complex slot weights. `LowWindowBound.lean:21` rescales by D=max(1,B), proves the exact probe homogeneity D^K, and applies the unit-weight theorem with epsilon=min(loss/512,1/2). It only needs 256epsilon<=loss; the unused slack is not spent elsewhere. Constants may depend on K and B.

`LowNormalized.lean:13` asks the numerator and the already reviewed inverse-normalizer theorem each for loss/2. Their actual product is bounded by

\[
 (C_pZ^{3/16+\mathrm{loss}/2})(C_nZ^{\mathrm{loss}/2})
      =C_pC_nZ^{3/16+\mathrm{loss}}.
\]

The eventual normalizer-nonzero claim is retained alongside this inequality. W1's upper support endpoint may be enlarged to max(b1,a1+1) to satisfy a strict interval-width hypothesis; its function and denominator are unchanged. Schwartz seminorms provide actual finite pointwise bounds. The positivity/nonzero assumptions on W0,W1 and the slot weights are used by the normalizer theorem, not replaced by the numerator's weaker absolute bounds. Finally `FinalAssemblySource.lean:27,35` converts the eventual norm bound to Big-O with positive Z; no totalized division at an eventually zero denominator is used.

## 7. Quantifiers and conditional verdict

At the central and combined-dyad stages, degree, constants and an eventual threshold are chosen before the dynamic pools, subsets, central scales, bounded weights and real frequency t. The finite subset maxima/sums preserve this order. Dependence on the fixed character, fixed exclusion/calibration data, support functions, epsilon and slot family remains allowed. No threshold uniform over arbitrary growing K, modulus or moving windows is claimed.

The normalized numerator estimate is an actual source function bound. It does not by itself prove that the probe is nonzero, nor the high comparison error to the signal. Those are separate obligations. No desired QRH conclusion or final detector contradiction was invoked in the checked scale, compensation and summability assembly.

## 8. Exact remaining lower boundary

The substantive lower inputs not independently proved to their foundations here are:

- `Reflection/LowOriginalEnergy.lean:18`, `InverseReflectedPhase.low_original_completed_energy`, and its completed-row estimates. The actual period/mask/list/six-unit adapter in `LowSelectedBound` was inspected; the entire reflected-energy mechanism was not.
- `Detector/GramBound.lean:13`, `ProbeGramCommon.actual_additive_gram_bound`, as consumed through `LowGramApplied`, `LowGramIntegrated` and `LowTupleGram`. The Mellin-weight integration and all source scales were checked; the underlying additive Gram inequality remains a cut.
- The actual low-polynomial/Fourier identity and corrected Gaussian reconstruction beneath `GaussianTuple`/`GaussianSlots`, including their meaningful integrability statements; compact physical-row reduction and the explicit summability supplied at the inspected reassembly were checked.
- Gaussian log-window moment and remote-polynomial decay, finite ideal counting and canonical-slot/ideal summability foundations. Their prefactors, exponents, norm sums and parameter domains were preserved rather than rederived recursively.
- The actual inverse normalizer is the accepted `QRH_RAY_NORMALIZER_PRODUCTION_AUDIT_2026-11-11.md` dependency (SHA-256 `693FA8013AC733DAE96CAD1C464912CF9F04DF5F09F9ACE6B3E7556F93443270`), not a new result of this report.

This is consequently a bounded PASS of the low endpoint's immediate source production and normalization, with precise lower analytic cuts. It is not full-provider or full-reflected-energy acceptance.

## 9. Inspected source pins

Pins identify inspected source and do not assert compilation or library-version compatibility. Files listed as lower foundations above are not promoted to a full audit merely because their interfaces or adapter bodies were read.

| File | SHA-256 |
|---|---|
| Detector/FinalAssemblySource.lean | `03F9668E3D43A20F5F1EF554C852BFCA64CBF90EC5D4C305114EC166BD1954E9` |
| Detector/LowNormalized.lean | `01619D97B7806B1BF4BB29588A3138F57F09B22553651E1DF064BA00F07B376B` |
| Detector/LowWindowBound.lean | `9DB8A9A92721F27D8F73788BFA2AD2360113D2E501FD76F784D8DBB0A9329F7F` |
| Detector/LowCommonBound.lean | `EB0E0C4E245E53AF09BEF2594922254EE94344D65E966F7761C992DA9AAB11FA` |
| Detector/LowGaussianSum.lean | `A81AC4903173C860BD495712DC2B1E12FD59DE659808A0C237C25E8299968137` |
| Detector/LowGaussianCentral.lean | `C82F52219AF407D78C91176D0813F07640F4FD12432A64DE5B42DB0B3CC2FC81` |
| Detector/LowGaussianRemote.lean | `DBFB763704FB0E2EC92A61CAF44077A48EC871E204DEFD3F70B6592FB7529038` |
| Detector/LowGaussianDyad.lean | `61D5110256E46AC6DF63CF0F7A2F2C184ABC9E2851619763F95F398D7CB198CE` |
| Detector/LowCentralTuple.lean | `222F7C9CE135670CCF1C1F858F19FE9148021449A7468F48BE5D9D0C070CEB84` |
| Detector/LowPhysicalInverseBound.lean | `4814743BC56FAC256AD38A711EF494E7A35FB4E0038EA62A0B15BF77D175F2BD` |
| Detector/LowNominalEnergy.lean | `D5B1CC0999B378E4C5789040C1200A97BECB8A9C7FFB0748BBF63FAB27BCCB78` |
| Detector/LowSelectedBound.lean | `9982ED15252CF87767ACCB18FEF93049C8D393EBF7577174C8DDE668FEA19790` |
| Detector/LowInverseNormalize.lean | `C96194F2803D4CFEBA942E73F48B6230B1796075DD374A40D6E8AD64C120DEB3` |
| Detector/LowUnselectedMass.lean | `F84377828FEAEB15314CA307193DACC69B02247349F22578B408823C208BD26D` |
| Detector/LowTupleGram.lean | `61A27DE1F32F3F6416B1C6D9D847AA5DEF56E1C7A0D26CD36A4A13C3DD3BBFD9` |
| Detector/LowGramIntegrated.lean | `D41F737B1BC35A4F5C0C038C1DEF38A6ECD7FD142C552E214E4B68876079D8F3` |
| Detector/LowGramScale.lean | `EF04C0C8C4AB63ECED450862470AAC6A140C97F476E82BD59E2C9377F3248CB3` |
| Detector/LowSourceScales.lean | `18FE592CF12E5680A6B56B04C739579424A333F05D83BE703E15A091F4B9E602` |
| Detector/LowSlotScales.lean | `315D9B1E86B7C98FA0DA82CC0D8F03F70797B109C691F8357BC0DFDFCB9DC69C` |
| Detector/LowNominalGeometry.lean | `AF712E9EFBE11945084ABD8B6471E6CB267C2BADFB36323D17E93A2114584DAA` |
| Detector/LowRemoteMass.lean | `4684C392D67777D0FA8E32C3C73DA2FE1BCEB5C347E6C4DB49A4A8861721DAE8` |
| Detector/GaussianCommon.lean | `E42CECE41AA213640268C562EE55AD36DE0A3BBFBE0908986A80EC1B4A8A1326` |
| Detector/GaussianSubset.lean | `09410ABFA6996C5990FEF469048FA451588709D24DEC933F429C96A31C5DC19F` |
| Detector/GaussianPhysicalTuple.lean | `6F1112CDD2B232132E1610AFF90D08F8A91BC6EF099BF5D66FDCCFCE1C65B68F` |
| Detector/GaussianTuple.lean | `6671260EE29362021F53B6A5BE5AC4F94E6ABF267E6DE7FE03E95B8B3D7A9160` |
| Detector/GaussianDensityBudget.lean | `228ED0D1483A87569AA82C7C405CED9C6810B455FE0CFE4E673AC9E82EDD4E55` |
| Detector/GaussianPhysicalMass.lean | `4EE7CC16FA0E352DBEC5FD27287761151326A62C413DDB9D5FBE641A605A5BBD` |
| Detector/RayPoolDisjoint.lean | `C6B49479C4A3B507A1C1924BE233597E4F0C56269E6B2B03A36CD0DA27BD692D` |
| PrimeRows/CubeNormalizer.lean | `B6808E221D9A1963FC56ABEF23B9DA5F357F25DFC066612B57ED757BCAA5CA55` |
