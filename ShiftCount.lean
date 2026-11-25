module

public import LocalLeak
public import Mathlib.Algebra.Order.Floor.Semiring
public import Mathlib.Order.Interval.Finset.Nat

@[expose] public section


open scoped ArithmeticFunction.vonMangoldt

namespace GrhGoldbach.LocalLeak

theorem card_le_width_add_one {S : Finset ℕ} {l u : ℝ}
    (hl : 0 ≤ l) (hlu : l ≤ u)
    (hS : ∀ n ∈ S, l < (n : ℝ) ∧ (n : ℝ) ≤ u) :
    (S.card : ℝ) ≤ u - l + 1 := by
  have hsub : S ⊆ Finset.Ioc ⌊l⌋₊ ⌊u⌋₊ := by
    intro n hn
    obtain ⟨hnl, hnu⟩ := hS n hn
    exact Finset.mem_Ioc.mpr ⟨(Nat.floor_lt hl).mpr hnl, (Nat.le_floor_iff (hl.trans hlu)).mpr hnu⟩
  have hcard := Finset.card_le_card hsub
  rw [Nat.card_Ioc] at hcard
  have hcast : (S.card : ℝ) ≤ ((⌊u⌋₊ - ⌊l⌋₊ : ℕ) : ℝ) := by exact_mod_cast hcard
  rw [Nat.cast_sub (Nat.floor_mono hlu)] at hcast
  linarith only [hcast, Nat.floor_le (hl.trans hlu), Nat.lt_floor_add_one l]

/-- A uniform bound on the von Mangoldt mass in any finite part of a Gaussian
shift. The additional integer in the cardinality bound is retained. -/
theorem shifted_sum_le {S : Finset ℕ} {x a w δ z : ℝ}
    (hx : 0 < x) (hlog : Real.log x ≤ 63) (ha : a ≤ 0) (hw : 0 ≤ w) (hd : 0 ≤ δ)
    (hS : ∀ n ∈ S, (n : ℝ) ∈ Set.Ioc (x * Real.exp (a - w - δ * z))
                                       (x * Real.exp (a - δ * z))) :
    ∑ n ∈ S, Λ n ≤ 63 * (x * w + 1) * Real.exp (2 * δ * |z|) := by
  have hl : 0 < x * Real.exp (a - w - δ * z) := mul_pos hx (Real.exp_pos _)
  have hlu : x * Real.exp (a - w - δ * z) ≤ x * Real.exp (a - δ * z) :=
    mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr (by linarith only [hw])) hx.le
  have hc := card_le_width_add_one hl.le hlu hS
  have hwidth := shifted_width_le (z := z) hx.le ha hw hd
  have hmass := Finset.sum_le_sum (s := S) (f := fun n => Λ n)
    (g := fun _ => 63 * Real.exp (δ * |z|)) fun n hn => by
      obtain ⟨hlower, hupper⟩ := hS n hn
      have hnR : 0 < (n : ℝ) := hl.trans hlower
      exact mangoldt_le_for_shift (by exact_mod_cast hnR) hx ha hd hlog hupper
  simp only [Finset.sum_const, nsmul_eq_mul] at hmass
  have hcnt : (S.card : ℝ) ≤ x * w * Real.exp (δ * |z|) + 1 := by
    linarith only [hc, hwidth]
  have he : 1 ≤ Real.exp (δ * |z|) := Real.one_le_exp (mul_nonneg hd (abs_nonneg _))
  have hfactor : (S.card : ℝ) ≤ (x * w + 1) * Real.exp (δ * |z|) := by
    linarith only [hcnt, he]
  calc
    _ ≤ (S.card : ℝ) * (63 * Real.exp (δ * |z|)) := hmass
    _ ≤ ((x * w + 1) * Real.exp (δ * |z|)) * (63 * Real.exp (δ * |z|)) :=
      mul_le_mul_of_nonneg_right hfactor (by positivity)
    _ = _ := by rw [show 2 * δ * |z| = δ * |z| + δ * |z| by ring, Real.exp_add]; ring

/-- Von Mangoldt mass outside the hard interval in a finite shift is
bounded by a sum of two exponential moments, uniformly in the shift. -/
theorem shifted_outside_sum_le {S : Finset ℕ} {x w δ K z : ℝ}
    (hx : 0 < x) (hlog : Real.log x ≤ 63) (hw : 0 ≤ w) (hd : 0 ≤ δ) (hK : 2 * δ ≤ K)
    (hS : ∀ n ∈ S, (n : ℝ) ∈ Set.Ioc (x * Real.exp (-(K * δ) - w - δ * z))
                                       (x * Real.exp (-(K * δ) - δ * z)))
    (hout : ∀ n ∈ S, (n : ℝ) ∉ Set.Ioc (x * Real.exp (-(K * δ) - w - K * δ)) x) :
    ∑ n ∈ S, Λ n ≤ 63 * (x * w + 1) * (Real.exp (-(K - 2 * δ) * K) *
      (Real.exp (K * z) + Real.exp (-K * z))) := by
  by_cases hz : |z| ≤ K
  · have hempty : S = ∅ := Finset.eq_empty_iff_forall_notMem.mpr fun n hn =>
      hout n hn (buffered_window_subset hx.le hd hz (hS n hn))
    rw [hempty, Finset.sum_empty]
    positivity
  · have ha : -(K * δ) ≤ 0 := neg_nonpos.mpr (mul_nonneg (by linarith only [hK, hd]) hd)
    exact (shifted_sum_le hx hlog ha hw hd hS).trans
      (mul_le_mul_of_nonneg_left (outside_chernoff hK (le_of_lt (lt_of_not_ge hz))) (by positivity))

end GrhGoldbach.LocalLeak

#print axioms GrhGoldbach.LocalLeak.card_le_width_add_one
#print axioms GrhGoldbach.LocalLeak.shifted_sum_le
#print axioms GrhGoldbach.LocalLeak.shifted_outside_sum_le
