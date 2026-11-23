# Pointwise etaPlus error from the Fourier tail

This is a source-derived mathematical proof, not a compiled Lean theorem. For every H>0 and t>0,

    |hH H t - hBase t| ≤ sqrt(368 / (3π H³)).

Consequently, for t>0,

    |etaPlus t - etaO t| ≤ .00221 t exp(-t²/2).

Here etaPlus uses H=200 and etaO is the untruncated hBase smoothing. The estimate extends to t=0 after unfolding the factor t.

The exact weighted Plancherel identity needed is

    ∫ (2πξ)^4 |ghat(ξ)|² dξ = ∫ |gL''(u)|² du ≤ 368.

Both derivative Fourier identities and the second-derivative energy bound occur in MajorArcs/HHFourier2.lean, in the proof of tail_fourier_gC_le' beginning at line217. Extracting this identity does not need stronger regularity assumptions.

Cauchy-Schwarz yields

    ∫_{|2πξ|>H} |ghat(ξ)| dξ
      ≤ sqrt(368) (∫_{|2πξ|>H}(2πξ)^(-4) dξ)^(1/2)
      = sqrt(368/(3πH³)).

The normalization is exact: substituting y=2πξ gives

    ∫_{|2πξ|>H}(2πξ)^(-4)dξ
      = (1/(2π))·2∫_H^∞ y^(-4)dy = 1/(3πH³).

This tail bound plus boundedness of ghat on a finite central interval proves integrability of ghat. Existing source gives continuity and integrability of gC. Thus Mathlib.Analysis.Fourier.Inversion, theorem Continuous.fourierInv_fourier_eq (or its pointwise Integrable variant), identifies the full inverse transform with gC. At u=log t the latter equals hBase t because gL(u)=hBase(exp u).

MajorArcs/HHFourier.lean:272, hH_eq_fourier, identifies hH with the inverse transform truncated at |2πξ|≤H. Subtract full and truncated inversion, take the norm, and use the tail L1 estimate. The oscillatory multiplier has norm1, so the result is uniform in t>0.

For H=200 the decimal .00221 is certified by π>3.14 and the rational inequality

    368 < (.00221)^2 · 3 · 3.14 · 200³.

This last inequality can be checked by norm_num. Multiplication by t exp(-t²/2), which is nonnegative for t≥0, gives the etaPlus estimate. The proof does not require a zero-free rectangle or any assumption about L-functions.

Remaining Lean work: extract the weighted second-derivative identity; establish Fourier integrability and the inverse-tail pointwise estimate; evaluate the power tail integral and rational constant. These are source-faithful supporting lemmas, not assumptions to add to the final theorem.
