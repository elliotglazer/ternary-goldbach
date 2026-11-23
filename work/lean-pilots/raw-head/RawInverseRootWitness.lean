import RawInverseRootProducer

/-!
Supplied adjacent-square witnesses identify the canonical inverse-root
initializer exactly. This generic uniqueness argument does not evaluate a
concrete `Nat.sqrt`, change the initializer, or claim a measured speedup.
-/

namespace RawHead

/-- For a positive input, the adjacent-square certificate determines exactly
the numerator computed by `inverseRootCandidate`. Positivity of the scale is
needed by the analytic error theorem, but not by this integer identity. -/
theorem inverseRootCandidate_eq_of_square_bounds {x S m : ℕ}
    (hx : 0 < x)
    (hlo : m * m * x ≤ S * S)
    (hhi : S * S < (m + 1) * (m + 1) * x) :
    inverseRootCandidate x S = m := by
  unfold inverseRootCandidate
  symm
  apply Nat.eq_sqrt.mpr
  exact ⟨(Nat.le_div_iff_mul_le hx).mpr hlo,
    (Nat.div_lt_iff_lt_mul hx).mpr hhi⟩

end RawHead
