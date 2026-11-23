import RawInverseRoot
import RawPowerIdentity

/-!
The checked integer inverse-square-root certificate initializes the actual
complex raw-head power at height zero. Candidate production remains separate.
-/

namespace RawHead

/-- The real grid center certified by adjacent integer squares approximates
the literal raw-head integer power at height zero. The generic scale permits
the producer's `S = 2 ^ 98` initialization without changing the source object. -/
theorem integerPower_zero_initialization_error {x S : ℕ} {m : ℤ}
    (hx : 0 < x) (hS : 0 < S)
    (hlo : m * m * (x : ℤ) ≤ (S : ℤ) * (S : ℤ))
    (hhi : (S : ℤ) * (S : ℤ) < (m + 1) * (m + 1) * (x : ℤ)) :
    ‖(((m : ℝ) / (S : ℝ) : ℝ) : ℂ) - integerPower (x : ℝ) 0‖ <
      1 / (S : ℝ) := by
  have hxR : (0 : ℝ) < (x : ℝ) := by exact_mod_cast hx
  have hbounds := inverse_sqrt_sub_div_bounds hx hS hlo hhi
  rw [norm_sub_rev, integerPower_zero_eq_inv_sqrt hxR,
    ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg hbounds.1]
  exact hbounds.2

end RawHead
