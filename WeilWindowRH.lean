module

/- Copyright 2026 Charlie Reams (upstream Weil-window proof).
   Adapted under Apache License 2.0. -/
public import TernaryGoldbach.Explicit.WeilWindow

@[expose] public section


/-!
# Weil windows under full RH

Adapted from `TernaryGoldbach.Explicit.weil_windowH` at Goldbach revision
23b2d68ca344203d4384e0aff7affa4ec034bef9 (Apache-2.0). Full RH places
every zero of ξ in the rectangle on the critical line. Its window then has
nonnegative real part, so any finite subfamily is bounded by the limiting sum.
-/

open Complex Metric Set Filter Finset
open scoped Real Topology

namespace TernaryGoldbach.Explicit

private theorem re_eq_half_of_rect_zero_of_rh (hRH : RiemannHypothesis)
    {T : ℝ} {u : ℂ} (hu : u ∈ rectZerosXi T) : u.re = 1 / 2 := by
  obtain ⟨h0, h1⟩ := strip_of_mem_rectZerosXi hu
  apply hRH u ((xiF_eq_zero_iff h0 h1).1 (xiF_eq_zero_of_mem_rectZerosXi hu))
  · rintro ⟨n, hn⟩
    rw [hn] at h0
    simp at h0
    linarith [Nat.cast_nonneg (α := ℝ) n]
  · intro heq
    rw [heq] at h1
    simp at h1

/-- Dominance of the full Weil sum over any height truncation under RH. -/
theorem weil_windowH_le_WPhi_of_rh {ℓ : ℝ} (hℓ0 : 0 < ℓ) (hℓ1 : ℓ ≤ 1) {m : ℕ} (hm : 2 ≤ m)
    (h2 : Real.exp (2 * m * ℓ) < 2) {H : ℝ} (hRH : RiemannHypothesis) (hH0 : 0 ≤ H)
    {T₀ : ℝ} (T : ℝ) :
    ∑ u ∈ (zerosRectD zetaF T).filter (fun u => |u.im| ≤ H),
      (multRectD zetaF T u : ℝ) * (WH ℓ m T₀ u).re ≤ WPhi ℓ m T₀ := by
  set S := (zerosRectD zetaF T).filter (fun u => |u.im| ≤ H) with hS
  set Z : ℕ → Finset ℂ := fun k => rectZerosXi (goodT k) with hZ
  have hlim := weil_formula hℓ0 hℓ1 hm h2 T₀
  have hre := (Complex.continuous_re.tendsto _).comp hlim
  have hlimR : Tendsto (fun k : ℕ => (∑ u ∈ Z k, (mult (goodT k) u : ℂ) * WH ℓ m T₀ u).re) atTop
      (𝓝 (WPhi ℓ m T₀)) := by
    have hπ : (0 : ℝ) < 2 * π := by positivity
    have h := hre.div_const (2 * π)
    have hc : (2 : ℂ) * (π : ℂ) = ((2 * π : ℝ) : ℂ) := by push_cast; ring
    have hc' : (1 / (2 * π) : ℂ) = ((1 / (2 * π) : ℝ) : ℂ) := by push_cast; ring
    have e1 : ∀ X : ℂ, (2 * (π : ℂ) * X).re / (2 * π) = X.re := by
      intro X; rw [hc, Complex.re_ofReal_mul]; field_simp
    have e2 : ∀ X Y : ℂ, (2 * (π : ℂ) * X + Y).re / (2 * π) = (X + (1 / (2 * π) : ℂ) * Y).re := by
      intro X Y
      rw [Complex.add_re, Complex.add_re, hc', Complex.re_ofReal_mul, hc, Complex.re_ofReal_mul]
      field_simp
    simp only [Function.comp_def, e1, e2] at h
    exact h
  refine ge_of_tendsto hlimR ?_
  filter_upwards [eventually_ge_atTop (⌈max T H⌉₊ + 1)] with k hk
  set T' := goodT k with hT'
  have hkT : max T H + 1 ≤ (k : ℝ) := by
    have := Nat.le_ceil (max T H)
    have : ((⌈max T H⌉₊ + 1 : ℕ) : ℝ) ≤ k := by exact_mod_cast hk
    push_cast at this; linarith
  have hT'k : (k : ℝ) ≤ T' := (goodT_mem k).1
  have hT'1 : 1 ≤ T' := by linarith [le_max_right T H]
  have hT'3 : H < T' := by linarith [le_max_right T H]
  -- The larger rectangle contains each selected zero with the same multiplicity.
  have hmemS : ∀ u ∈ S, u ∈ zerosRectD zetaF T ∧ |u.im| ≤ H := fun u hu => Finset.mem_filter.1 hu
  have hstrip : ∀ u ∈ S, 0 < u.re ∧ u.re < 1 := fun u hu => by
    obtain ⟨-, h0, h1, -⟩ := zerosRectD_zetaF_strip (hmemS u hu).1; exact ⟨h0, h1⟩
  have himT : ∀ u ∈ S, |u.im| < T := by
    intro u hu
    have h := (hmemS u hu).1
    rw [zerosRectD, Finset.mem_filter] at h
    obtain ⟨-, -, -, h3, h4⟩ := h
    rw [zT_im] at h3; rw [wT_im] at h4
    exact abs_lt.2 ⟨h3, h4⟩
  have hsub : S ⊆ Z k := by
    intro u hu
    exact mem_rectZerosXi_of_mem hT'1 (hmemS u hu).1 (hstrip u hu).1
      (hstrip u hu).2 (by linarith [(hmemS u hu).2])
  have hmul : ∀ u ∈ S, (multRectD zetaF T u : ℝ) = mult T' u := fun u hu => by
    exact_mod_cast multRectD_eq_mult hT'1 (hstrip u hu).1 (hstrip u hu).2 (himT u hu)
      (by linarith [(hmemS u hu).2])
  -- real parts
  have hre_sum : (∑ u ∈ Z k, (mult T' u : ℂ) * WH ℓ m T₀ u).re =
      ∑ u ∈ Z k, (mult T' u : ℝ) * (WH ℓ m T₀ u).re := by
    rw [Complex.re_sum]
    refine Finset.sum_congr rfl fun u _ => ?_
    simp [Complex.mul_re]
  rw [hre_sum, Finset.sum_congr rfl fun u hu => by rw [hmul u hu]]
  exact Finset.sum_le_sum_of_subset_of_nonneg hsub fun u hu _ =>
    mul_nonneg (Nat.cast_nonneg _)
      (WH_re_nonneg_of_line ℓ m T₀ (re_eq_half_of_rect_zero_of_rh hRH hu))

/-- Full RH gives the original Weil-window conclusion at unrestricted heights. -/
theorem weil_windowH_of_rh {ℓ : ℝ} (hℓ0 : 0 < ℓ) (hℓ1 : ℓ ≤ 1) {m : ℕ} (hm : 2 ≤ m)
    (h2 : Real.exp (2 * m * ℓ) < 2) {H : ℝ} (hRH : RiemannHypothesis) (hH0 : 0 ≤ H)
    {T₀ : ℝ} (T : ℝ) :
    ∑ u ∈ (zerosRectD zetaF T).filter (fun u => |u.im| ≤ H),
      (multRectD zetaF T u : ℝ) * (WH ℓ m T₀ u).re ≤ WPhi ℓ m T₀ + OffC ℓ m := by
  apply (weil_windowH_le_WPhi_of_rh hℓ0 hℓ1 hm h2 hRH hH0 T).trans
  exact le_add_of_nonneg_right (by unfold OffC; positivity)

end TernaryGoldbach.Explicit
