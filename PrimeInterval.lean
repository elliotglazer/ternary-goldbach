module

public import WeightedBound
public import LocalLowZeros
public import LeakOutside
public import Transfer
public import TernaryGoldbach.Statement

@[expose] public section


open scoped Real
namespace TernaryGoldbach.Explicit

/-- Every x in the analytic range admits a prime in the interval needed
for the binary-Goldbach transfer at 4·10^15. -/
theorem exists_prime_in_sqrt_interval (hRH : RiemannHypothesis) {x : ℝ}
    (hx : 1e15 ≤ x) (hX : x ≤ 1e27) :
    ∃ p : ℕ, p.Prime ∧ x - 126.2 * √x < p ∧ (p : ℝ) ≤ x := by
  apply localized_prime_of_low_and_leak hx hX (rhBelow_of_full_rh hRH _)
  · intro T
    have h := localized_low_zeros_lt hRH hx hX T
    dsimp only at h
    rwa [show -(12.6/√x) - 101/√x = -(113.6/√x) by ring] at h
  · have hx' : 10^15 ≤ x := by norm_num at hx ⊢; exact hx
    have hX' : x ≤ 10^27 := by norm_num at hX ⊢; exact hX
    have h := GrhGoldbach.LocalLeak.gaussian_leak_difference_0511 hx' hX'
    dsimp only at h ⊢
    rw [show -(4.5*(2.8/√x)) - 101/√x = -(113.6/√x) by ring,
      show -(4.5*(2.8/√x)) = -(12.6/√x) by ring] at h
    exact h

#print axioms exists_prime_in_sqrt_interval

theorem exists_prime_in_local_interval (hRH : RiemannHypothesis) {x : ℝ}
    (hx : 1e15 ≤ x) (hX : x ≤ 1e27) :
    ∃ p : ℕ, p.Prime ∧ x - 4000000000000000 + 4 < p ∧ (p : ℝ) ≤ x := by
  obtain ⟨p,hp,hl,hu⟩ := exists_prime_in_sqrt_interval hRH hx hX
  have hs := (GrhGoldbach.LocalAssembly.sqrt_range (by norm_num at hx ⊢; exact hx)
    (by norm_num at hX ⊢; exact hX)).2
  exact ⟨p,hp,by linarith only [hs,hl],hu⟩
#print axioms exists_prime_in_local_interval

/-- The finite-range input for the project's large-number theorem under
ordinary RH and its remaining explicit binary-Goldbach certificate. -/
theorem ternary_goldbach_up_to_1e27_of_rh (hRH : RiemannHypothesis)
    (hbinary : TernaryGoldbach.BinaryGoldbachUpTo 4000000000000000) :
    TernaryGoldbach.TernaryGoldbachUpTo (10^27) :=
  GrhGoldbach.LocalAssembly.ternary_of_interval_and_binary (exists_prime_in_local_interval hRH) hbinary

#print axioms ternary_goldbach_up_to_1e27_of_rh
end TernaryGoldbach.Explicit
