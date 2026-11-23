import Gap
import TernaryGoldbach.Statement

/-!
Internal assembly for the finite part of the 10^20 route.

This is a conditional reduction, not a proof of Schoenfeld's estimate, finite
binary Goldbach, Zinoviev's theorem, or ternary Goldbach. The outstanding
theta estimate and finite certificate occur explicitly as arguments.
-/

namespace GrhGoldbach

/-- Derive the needed prime gap from the explicit theta estimate. The large
case uses `(n - B, n - 4]`; Bertrand handles the small lower endpoint. -/
theorem exists_prime_remainder_of_theta_bound
    (hTheta : ∀ x : ℝ, 2300000000 < x → x ≤ 10 ^ 20 →
      |Chebyshev.theta x - x| <
        (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x - 2) * Real.log x)
    {n : ℕ} (hlo : 1615000000000 + 3 < n) (hhi : n ≤ 10 ^ 20) :
    ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ 4 ≤ n - p ∧ n - p ≤ 1615000000000 := by
  by_cases hsmall : n ≤ 2000000000000
  · exact exists_prime_small_remainder hlo hsmall
  · have hB : 1615000000000 ≤ n := by omega
    have h4 : 4 ≤ n := by omega
    have ha : (2300000000 : ℝ) < (n - 1615000000000 : ℕ) := by
      exact_mod_cast (show 2300000000 < n - 1615000000000 by omega)
    have hb : (2300000000 : ℝ) < (n - 4 : ℕ) := by
      exact_mod_cast (show 2300000000 < n - 4 by omega)
    have ha' : ((n - 1615000000000 : ℕ) : ℝ) ≤ 10 ^ 20 := by
      exact_mod_cast (show n - 1615000000000 ≤ 10 ^ 20 by omega)
    have hb' : ((n - 4 : ℕ) : ℝ) ≤ 10 ^ 20 := by
      exact_mod_cast (show n - 4 ≤ 10 ^ 20 by omega)
    obtain ⟨p, hp, hp₁, hp₂⟩ := exists_prime_of_theta_error
      ((hTheta _ ha ha').trans (schoenfeld_expression_lt ha.le ha'))
      ((hTheta _ hb hb').trans (schoenfeld_expression_lt hb.le hb'))
      (by rw [Nat.cast_sub hB, Nat.cast_sub h4]; push_cast; ring_nf; exact le_refl _)
    exact ⟨p, hp, by omega, by omega, by omega⟩

/-- Internal finite-range reduction. Both substantial inputs remain explicit. -/
theorem ternary_goldbach_up_to_of_theta_bound
    (hTheta : ∀ x : ℝ, 2300000000 < x → x ≤ 10 ^ 20 →
      |Chebyshev.theta x - x| <
        (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x - 2) * Real.log x)
    (hBinary : TernaryGoldbach.BinaryGoldbachUpTo 1615000000000) :
    TernaryGoldbach.TernaryGoldbachUpTo (10 ^ 20) := by
  intro n hn h5 hhi
  by_cases hsmall : n ≤ 1615000000000 + 3
  · have heven : Even (n - 3) := Nat.Odd.sub_odd hn (by decide)
    obtain ⟨p, q, hp, hq, hpq⟩ := hBinary (n - 3) heven
      (by obtain ⟨k, hk⟩ := hn; omega) (by omega)
    exact ⟨3, p, q, Nat.prime_three, hp, hq, by omega⟩
  · obtain ⟨p, hp, hp2, h4, hB⟩ :=
      exists_prime_remainder_of_theta_bound hTheta (by omega) hhi
    have hpn : p ≤ n := by omega
    obtain ⟨q, r, hq, hr, hqr⟩ := hBinary (n - p)
      (Nat.Odd.sub_odd hn (hp.odd_of_ne_two hp2)) h4 hB
    exact ⟨p, q, r, hp, hq, hr, by omega⟩

end GrhGoldbach
