# Independent review: unit-group character transform

2026-11-11. Verdict: **PASS as a source-faithful mathematical and implementation plan**, with the implementation and formal proof obligations below. No correction to the frozen note is required. This review does not certify a transform implementation, numerical L-value, contour, finite spectrum, or Lean theorem.

## Reviewed artifact and scope

Producer: `work/qrh-campaign/agents/integration/UNIT_GROUP_CHARACTER_TRANSFORM_PLAN_2026-11-11.md`, SHA256 `DFA02789B3025A997F98E0500B001B3C5A7D983C400EEDC8F7B6DD4ADDAE4866` (independently rehashed).

I read the complete note, checked the actual source definitions and conventions listed below, and compared its coordinates and primitive filters with the accepted manifest and review. No FFT, interval evaluation, family scan, Lean/Lake invocation, or dependency change was performed. All source and producer files were read-only.

The manifest is `zero-sum/FAMILY_CHARACTER_MANIFEST_PROOF_PLAN_2026-11-11.md`, hash `53D6DE424680957E9467FE5CF608578BB356DE08C57979E7494E4F1E387D4D54`; its independent review is `integration/REVIEW_FAMILY_CHARACTER_MANIFEST_2026-11-11.md`, hash `EEE3BAE662500804EAEC0268A8612D0E01ED1C2FAF5D0208D442A97739794664`. Both hashes were rechecked. Their group-coordinate and generator proofs remain inputs to implementing this plan; accepting this plan does not upgrade that earlier paper evidence to compiled declarations.

## Actual source identification and the pole

Pinned Mathlib root: `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages/mathlib/Mathlib`.

| Source | Independently verified SHA256 | Relevant source locations |
| --- | --- | --- |
| `NumberTheory/LSeries/ZMod.lean` | `D756ABE5CB941F1210DC7DDDC90F68F120148BB6A45AC4E6C4282C3070FBC17D` | 85: definition; 97: series identity; 124,135: differentiability |
| `NumberTheory/LSeries/HurwitzZeta.lean` | `5AA1270696F59F95417054D77E156BAB2DCD42F6AFDF7318CF1A2944298818B3` | 74: series; 89,97: source pole subtraction; 104: entire differences |
| `Analysis/Fourier/ZMod.lean` | `012663E2EB3A3F3196C6BCE04CB530D04E29C8DE8C65AFE703F2D707484EFE10` | 87: equivalence; 106,114: forward/inverse formulas |
| `NumberTheory/LSeries/DirichletContinuation.lean` | `ECF79F2A64EF2E7215729EBB2E7D5ADAA03468B18BBDA0040680AA925D4673F1` | 60: actual LFunction; 74: convergence identity; 97: nonprincipal differentiability |
| `NumberTheory/MulChar/Basic.lean` | `1C31A9810F59DB8CDCDEEF50D20EFEAA0C70CF24B5C2448356AD1FF5EC240915` | 609: vanishing nonprincipal character sum |

The actual source definition is a finite sum of Hurwitz values multiplied by `c^(-s)`, not a conditionally convergent Dirichlet series. Removing nonunits and reindexing by a proved coordinate equivalence gives the plan's positive character transform exactly. The additive-circle input represents `a/c`; confusing it with `a`, a root of unity, or an arbitrary real lift would be wrong. The note does not do so.

The common-reference difference is the important source-safe simplification. For a nonzero character label, the coefficient sum is zero. Hence subtracting the same source Hurwitz value at every coordinate leaves the transformed row unchanged, pointwise even at `s=1`. The source explicitly proves every such Hurwitz difference entire. All primitive characters at conductor `c>1` are nonprincipal, so these are exactly the selected rows that can use this construction. Conductor one and the principal row are separate.

The warning about individual finite parts is necessary and correct: source Hurwitz subtraction uses `1/(s-1)/GammaR(s)`. An evaluator using ordinary pole subtraction must identify its *difference* with the source difference, first off the pole and then by continuity/analytic continuation. It cannot identify individual totalized values merely because residues agree. This plan retains that obligation and therefore does not hide a pole-normalization assumption.

## Coordinates, signs, and primitive selection

The product of cyclic coordinates is the actual CRT unit group. The two-primary cases are correct: no coordinate for modulus 2; a sign coordinate for modulus 4; and separate sign and five-power coordinates for higher powers of 2. The odd-prime-power coordinate has order `(p-1)*p^(k-1)`. There is no claim that their product is cyclic.

The last-coordinate-fastest indexing is fully specified. Actual source-character identification still needs the manifest generator/CRT witnesses and its surjectivity proof, rather than a mere equality of cardinalities. The note says this explicitly.

The positive kernel matches the manifest's character labels. The source DFT uses the negative exponent without normalization; its inverse uses the positive exponent divided by the axis length. Thus a positive transform is source DFT at the negated output index, or axis length times source inverse DFT. Applying this on every axis gives either inversion of every character coordinate or multiplication by `phi(c)` for the normalized full inverse. There is no further division by `phi(c)`, and `c^(-s)` is a distinct L-function factor.

The examples `c=40` with dimensions `(2,2,4)` and `c=120` with `(2,2,2,4)` are correct noncyclic tests. Their stated primitive filters each select six rows. The general filters also match the conductor criterion: nonzero label at odd prime level, label not divisible by p at higher odd prime powers, odd five-power label at higher 2-powers, and no primitive rows when the conductor has exactly one factor of 2. The parity formula uses the sign coordinate and odd-prime labels, not the five-power coordinate. The inverse character negates every label; same-sample complex conjugation cannot replace the inverse row at nonreal s.

Extraction selects the actual primitive L-values. It introduces no Gauss sum, conductor multiplicity, or totient weight. Those belong to later character reconstruction/averaging. Parseval is a valid consistency check but cannot detect every label permutation; the plan correctly avoids treating it as row certification.

## Deterministic error propagation

For unit-modulus exact roots, coefficient uncertainties contribute at most their sum to each output. This remains true with correlated errors; no square-root or independence improvement is justified. The common-reference uncertainty must be included unless symbolic cancellation or a direct difference evaluator proves a sharper bound.

The local product bound is correct:

`w*z - what*zhat = w*(z-zhat) + (w-what)*zhat`.

Consequently the error is at most `E + delta*|zhat|` before operation rounding. There is no omitted `delta*E` term with this split, because the factor multiplying the input error is the *exact* unit-modulus w. All radii and midpoint magnitude bounds must of course be certified upper bounds.

The direct-axis recurrence is valid if its rounding allowance includes every operation for that output. It is not automatically the error theorem for an arbitrary FFT circuit. The note explicitly requires propagation through the actual circuit and accounts for convolution/chirp/scaling variants separately. Likewise, multiplying by `p=c^(-s)` gives `P*E + eps_p*|vhat| + eta_final` by the same split; it does not miss a cross term.

Point evaluation at an exact s is the stated scope. Uncertain inputs and whole contour panels need additional analytic enclosures. No finite collection of nonzero point balls by itself proves a zero-free contour or a multiplicity count. These distinctions are preserved.

## Remaining obligations and status

The finite-sum transform theorem and its source adapters are sound on paper, but still require formal declarations and proofs. An executable version additionally needs exact manifest/generator verification, source-correct coefficient balls including the pole case, certified elementary roots and `c^(-s)`, a proved circuit/permutation/scaling refinement, and deterministic rounding propagation. Arbitrary-length axis transforms need their own correct algorithms; a radix-two library is not sufficient for general `p-1` lengths. None of the proposed rejection tests has been run in this packet.

The asymptotic operation counts are conditional algorithmic descriptions, not measured performance or a total family resource estimate. Reuse applies only to common samples at a common modulus. Conductor-specific or character-specific adaptive nodes cannot silently be shared.

No hidden RH, simplicity, finite-spectrum certificate, or new final Goldbach premise is introduced by these identities. Conversely, this plan supplies none of the still-required spectral data. It preserves the existing Hcert and selected character family, and leaves nonvanishing, winding, multiplicity-aware completeness, and all Lean validation separate.
