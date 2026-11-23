# Localized zero contribution

`LocalLowZeros.lean` contains the proof candidate for `TernaryGoldbach.Explicit.localized_low_zeros_lt`. For every 10¹⁵ ≤ x ≤ 10²⁷ and every rectangle height T, under full RH, it bounds the sum of Gaussian Mellin norms over zeros u with |Im u| ≤ 2·10¹⁴, each multiplied by its analytic multiplicity. Multiplying the sum by √x gives a strict upper bound of 98.977√x.

- `LocalWeight.lean` gives the nonsingular reciprocal factor, its monotonicity, the three-piece integral and the fixed numerical coefficient. At ordinate zero the reciprocal equals the interval width.
- `ShiftedWeight.lean` accounts for the translation by 13 and both halves of the Weil-window integral. Its finite-sum theorem preserves arbitrary natural multiplicities and derives the strict 98.977√x bound from the two analytic inequalities.
- `LocalMellin.lean` bounds the exact Gaussian Mellin integral on the critical line, using the integral norm for the small ordinates and the endpoint formula for the large ones.
- `DensityBound.lean` bounds the scalar expression from `PsiB_le_PsiG` by 5.5 on the interval used for the low zeros.
- `WeilWeightedRH.lean` applies the full-RH pointwise window in the upstream weighted-zero proof. `LocalLowZeros.lean` bounds the resulting density by 5.5 before applying the integral and scalar estimates.

`check.py` checks `LocalWeight.lean` and prints the axioms of its six public theorems. This stage passed Lean 4.35.0 at trust level zero with only `propext`, `Classical.choice` and `Quot.sound`. `receipt.json` and `LocalWeight.log` record the input hashes, exit code and audit output.

`check.py --extensions` imports the checked first stage. Its three theorems passed at trust level zero with the same three standard axioms. `extensions-receipt.json` and `Extensions.log` record the input hashes and axiom output.

`check.py --density` checked the 5.5 scalar bound independently at trust level zero with the same three standard axioms. `density-receipt.json` and `Density.log` record the run.

The project-specific zero-sum theorem also needs the Goldbach 4.35.0 imports and `../weil/WeilWindowRH.lean`. Its full import closure has not been kernel checked here.
