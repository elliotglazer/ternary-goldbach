module

public import LeakBound

@[expose] public section


open Set Finset
open GrhGoldbach.GaussianSource
open scoped ArithmeticFunction.vonMangoldt

namespace GrhGoldbach.LocalLeak

/-- The finite integral endpoints and the endpoints on the naturals agree. -/
theorem mem_floored_interval {l u : ℝ} (hl : 0 ≤ l) (hu : 0 ≤ u) (n : ℕ) :
    n ∈ Finset.Ioc ⌊l⌋₊ ⌊u⌋₊ ↔ (n : ℝ) ∈ Ioc l u := by
  rw [Finset.mem_Ioc, Set.mem_Ioc, Nat.floor_lt hl, Nat.le_floor_iff hu]

theorem diff_sum_le_exterior {f : ℕ → ℝ} (hzero : f 0 = 0)
    (hnonneg : ∀ n, 0 ≤ f n) {l u : ℝ} (hl : 0 ≤ l) (hu : 0 ≤ u) :
    (∑' n, f n) - ∑ n ∈ Finset.Ioc ⌊l⌋₊ ⌊u⌋₊, f n ≤
      ∑' n : ℕ, if 0 < n ∧ (n : ℝ) ∉ Ioc l u then f n else 0 := by
  classical
  by_cases h : Summable f
  · have H := h.sum_add_tsum_compl (s := Finset.Ioc ⌊l⌋₊ ⌊u⌋₊)
    rw [_root_.tsum_subtype] at H
    have H' : ∀ n : ℕ, ((↑(Finset.Ioc ⌊l⌋₊ ⌊u⌋₊) : Set ℕ)ᶜ).indicator f n =
        (if 0 < n ∧ (n : ℝ) ∉ Ioc l u then f n else 0) := by
      intro n
      rcases Nat.eq_zero_or_pos n with rfl | hn
      · simp [hzero, Set.indicator, Set.mem_compl_iff]
      · simp only [Set.indicator, Set.mem_compl_iff, Finset.mem_coe, mem_floored_interval hl hu, hn, true_and]
    simp_rw [H'] at H
    linarith only [H]
  · rw [tsum_eq_zero_of_not_summable h]
    have hs := Finset.sum_nonneg (s := Finset.Ioc ⌊l⌋₊ ⌊u⌋₊) (f := f) fun n _ => hnonneg n
    have ht : 0 ≤ ∑' n : ℕ, if 0 < n ∧ (n : ℝ) ∉ Ioc l u then f n else 0 :=
      tsum_nonneg fun n => by split_ifs <;> first | exact hnonneg n | exact le_refl _
    linarith only [hs, ht]

/-- The part of the localized smoothed sum lost by restricting to the hard
interval, in the form consumed by prime extraction. -/
theorem gaussian_leak_difference_0511 {x : ℝ} (hlo : 10 ^ 15 ≤ x) (hhi : x ≤ 10 ^ 27) :
    let v := Real.sqrt x
    let f := fun n : ℕ => Λ n * gsm (-(4.5 * (2.8 / v))) (-(4.5 * (2.8 / v)) - 101 / v)
                                      (2.8 / v) (n / x)
    (∑' n, f n) - ∑ n ∈ Finset.Ioc ⌊x * Real.exp (-(126.2 / v))⌋₊ ⌊x⌋₊, f n ≤ 0.511 * v := by
  dsimp only
  have hx : 0 < x := lt_of_lt_of_le (by norm_num) hlo
  have hs : 0 < Real.sqrt x := Real.sqrt_pos.mpr hx
  have hw : 0 ≤ 101 / Real.sqrt x := by positivity
  have he := gaussian_leak_0511 hlo hhi
  dsimp only at he
  rw [show -(4.5 * (2.8 / Real.sqrt x)) - 101 / Real.sqrt x - 4.5 * (2.8 / Real.sqrt x) =
    -(126.2 / Real.sqrt x) by ring] at he
  refine le_trans (diff_sum_le_exterior ?_ ?_ (by positivity) hx.le) he
  · simp
  · intro n
    apply mul_nonneg ArithmeticFunction.vonMangoldt_nonneg
    apply intervalIntegral.integral_nonneg
    · exact div_le_div_of_nonneg_right (by linarith only [hw]) (by positivity)
    · exact fun z _ => gpdf_nonneg z

end GrhGoldbach.LocalLeak

#print axioms GrhGoldbach.LocalLeak.gaussian_leak_difference_0511
