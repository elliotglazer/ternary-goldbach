import Gap

/-! The elementary finite reduction below Helfgott's cutoff. -/

namespace GrhGoldbach

/-- Uniform majorant for the weaker log-squared version of Schoenfeld's
theta estimate. Its margin covers the shift by four at the upper endpoint. -/
theorem schoenfeld_log_sq_lt_1e27 {x : ℝ} (hx : 1 ≤ x) (hX : x ≤ 10 ^ 27) :
    (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x) ^ 2 <
      (10000000000000000 - 4 : ℝ) / 2 := by
  have hlog := Real.log_le_log (by linarith only [hx]) hX
  rw [Real.log_pow] at hlog
  norm_num only [Nat.cast_ofNat] at hlog
  have hlog' : Real.log x ≤ 62.2 := by
    linarith only [hlog, log_ten_lt_2303]
  have hs : Real.sqrt x ≤ 32000000000000 := by
    apply Real.sqrt_le_iff.mpr
    exact ⟨by norm_num, hX.trans (by norm_num)⟩
  have hl2 : (Real.log x) ^ 2 ≤ 62.2 ^ 2 := by
    simpa only [pow_two] using
      mul_le_mul hlog' hlog' (Real.log_nonneg hx) (by norm_num)
  have hnum : Real.sqrt x * (Real.log x) ^ 2 ≤ 32000000000000 * 62.2 ^ 2 :=
    mul_le_mul hs hl2 (sq_nonneg _) (by norm_num)
  have hdiv := (div_lt_iff₀ (show 0 < 8 * Real.pi by positivity)).2
    (show Real.sqrt x * (Real.log x) ^ 2 <
        ((10000000000000000 - 4 : ℝ) / 2) * (8 * Real.pi) by
      linarith only [hnum, Real.pi_gt_d4])
  convert hdiv using 1
  ring

/-- Above the threshold of (6.1), its right side is bounded by the one
in the log-squared estimate (6.3). -/
theorem schoenfeld_refined_le_log_sq {x : ℝ} (hx : 1 ≤ x) :
    (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x - 2) * Real.log x ≤
      (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x) ^ 2 := by
  have hl := Real.log_nonneg hx
  have h : (Real.log x - 2) * Real.log x ≤ (Real.log x) ^ 2 := by
    nlinarith only [hl]
  rw [mul_assoc ((1 / (8 * Real.pi)) * Real.sqrt x)]
  exact mul_le_mul_of_nonneg_left h (by positivity)

/-- Find an odd prime summand. The explicit analytic input is the
restriction of Schoenfeld (6.3) to the high endpoints used here. -/
theorem exists_prime_remainder_of_theta_1e27
    (hTheta : ∀ x : ℝ, 2300000000 < x → x ≤ 10 ^ 27 →
      |Chebyshev.theta x - x| < (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x) ^ 2)
    {n : ℕ} (hlo : 10000000000000000 + 3 < n) (hhi : n ≤ 10 ^ 27) :
    ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ 4 ≤ n - p ∧ n - p ≤ 10000000000000000 := by
  by_cases hsmall : n ≤ 15000000000000000
  · obtain ⟨p, hp, h₁, h₂⟩ := Nat.bertrand ((n - 4) / 2) (by omega)
    exact ⟨p, hp, by omega, by omega, by omega⟩
  · have ha : (2300000000 : ℝ) < (n - 10000000000000000 : ℕ) := by
      exact_mod_cast (show 2300000000 < n - 10000000000000000 by omega)
    have hb : (2300000000 : ℝ) < (n - 4 : ℕ) := by
      exact_mod_cast (show 2300000000 < n - 4 by omega)
    have ha' : ((n - 10000000000000000 : ℕ) : ℝ) ≤ 10 ^ 27 := by
      exact_mod_cast (Nat.sub_le n 10000000000000000 |>.trans hhi)
    have hb' : ((n - 4 : ℕ) : ℝ) ≤ 10 ^ 27 := by
      exact_mod_cast (Nat.sub_le n 4 |>.trans hhi)
    have hspan : 2 * ((10000000000000000 - 4 : ℝ) / 2) ≤
        ((n - 4 : ℕ) : ℝ) - ((n - 10000000000000000 : ℕ) : ℝ) := by
      rw [Nat.cast_sub (show 4 ≤ n by omega),
        Nat.cast_sub (show 10000000000000000 ≤ n by omega)]
      push_cast
      linarith
    obtain ⟨p, hp, h₁, h₂⟩ := exists_prime_of_theta_error
      ((hTheta _ ha ha').trans (schoenfeld_log_sq_lt_1e27 (by linarith only [ha]) ha'))
      ((hTheta _ hb hb').trans (schoenfeld_log_sq_lt_1e27 (by linarith only [hb]) hb'))
      hspan
    exact ⟨p, hp, by omega, by omega, by omega⟩

/-- With the quantitative theta and binary Goldbach inputs, every odd n
through Helfgott's cutoff is a sum of three primes. The predicates are
written out to keep this arithmetic module independent of the circle method. -/
theorem ternary_up_to_1e27_of_theta_binary
    (hTheta : ∀ x : ℝ, 2300000000 < x → x ≤ 10 ^ 27 →
      |Chebyshev.theta x - x| < (1 / (8 * Real.pi)) * Real.sqrt x * (Real.log x) ^ 2)
    (hBinary : ∀ m : ℕ, Even m → 4 ≤ m → m ≤ 10000000000000000 →
      ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = m)
    (n : ℕ) (hn : Odd n) (h5 : 5 < n) (hhi : n ≤ 10 ^ 27) :
    ∃ p q r : ℕ, p.Prime ∧ q.Prime ∧ r.Prime ∧ p + q + r = n := by
  by_cases hsmall : n ≤ 10000000000000000 + 3
  · obtain ⟨q, r, hq, hr, heq⟩ := hBinary (n - 3)
      (Nat.Odd.sub_odd hn (by decide))
      (by obtain ⟨k, hk⟩ := hn; omega) (by omega)
    exact ⟨3, q, r, Nat.prime_three, hq, hr, by omega⟩
  · obtain ⟨p, hp, hp2, h4, hB⟩ :=
      exists_prime_remainder_of_theta_1e27 hTheta (by omega) hhi
    obtain ⟨q, r, hq, hr, heq⟩ := hBinary (n - p)
      (Nat.Odd.sub_odd hn (hp.odd_of_ne_two hp2)) h4 hB
    exact ⟨p, q, r, hp, hq, hr, by omega⟩

end GrhGoldbach

#print axioms GrhGoldbach.schoenfeld_log_sq_lt_1e27
#print axioms GrhGoldbach.schoenfeld_refined_le_log_sq
#print axioms GrhGoldbach.ternary_up_to_1e27_of_theta_binary
