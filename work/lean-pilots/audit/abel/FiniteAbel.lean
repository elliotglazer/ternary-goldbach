import TernaryGoldbach.Explicit.LGrowth

/-! Internal finite Abel decomposition pilot. -/
noncomputable section
open Complex MeasureTheory Set
open TernaryGoldbach.Explicit

namespace SpectralAbelPilot

private lemma sum_zeroed (g : ℕ → ℂ) (n : ℕ) :
    (∑ k ∈ Finset.Icc 0 n, if k = 0 then 0 else g k) =
      ∑ k ∈ Finset.Icc 1 n, g k := by
  rw [← Finset.insert_Icc_add_one_left_eq_Icc n.zero_le,
    Finset.sum_insert (by simp)]
  simp only [ite_true, zero_add]
  refine Finset.sum_congr rfl fun k hk => ?_
  rw [ite_eq_right (Nat.ne_of_gt (lt_of_lt_of_le Nat.zero_lt_one (Finset.mem_Icc.mp hk).1))]

lemma finite_abel (g : ℕ → ℂ) (N : ℕ) (s : ℂ) (hs : 0 < s.re) :
    (∑ k ∈ Finset.Icc 1 N, g k * (k : ℂ) ^ (-s)) =
      (∑ k ∈ Finset.Icc 1 N, g k) * (N : ℂ) ^ (-s) +
      s * ∫ t in Ioc (1 : ℝ) N,
        (∑ k ∈ Finset.Icc 1 ⌊t⌋₊, g k) * (t : ℂ) ^ (-(s + 1)) := by
  have hs0 : -s ≠ 0 := neg_ne_zero.mpr (Complex.ne_zero_of_re_pos hs)
  have hd (t : ℝ) (ht : 1 ≤ t) :
      deriv (fun x : ℝ => (x : ℂ) ^ (-s)) t = -s * (t : ℂ) ^ (-(s + 1)) := by
    rw [Complex.deriv_ofReal_cpow_const (lt_of_lt_of_le zero_lt_one ht).ne' hs0]
    congr 2
    ring
  have hc : ContinuousOn (fun t : ℝ => -s * (t : ℂ) ^ (-(s + 1))) (Icc 1 N) := by
    intro t ht
    exact ((Complex.continuousAt_ofReal_cpow_const t _
      (Or.inr (lt_of_lt_of_le zero_lt_one ht.1).ne')).const_mul (-s)).continuousWithinAt
  have hi : IntegrableOn (deriv (fun x : ℝ => (x : ℂ) ^ (-s))) (Icc (1 : ℝ) N) := by
    refine hc.integrableOn_Icc.congr_fun (fun t ht => ?_) measurableSet_Icc
    exact (hd t ht.1).symm
  have hab := sum_mul_eq_sub_integral_mul₀'
    (fun k => if k = 0 then (0 : ℂ) else g k) (by simp) N
    (f := fun x : ℝ => (x : ℂ) ^ (-s))
    (fun t ht => differentiableAt_id.ofReal_cpow_const
      (lt_of_lt_of_le zero_lt_one ht.1).ne' hs0) hi
  simp only [Complex.ofReal_natCast] at hab
  have hleft : (∑ k ∈ Finset.Icc 0 N,
      (k : ℂ) ^ (-s) * (if k = 0 then 0 else g k)) =
      ∑ k ∈ Finset.Icc 1 N, g k * (k : ℂ) ^ (-s) := by
    have he : (fun k : ℕ => (k : ℂ) ^ (-s) * (if k = 0 then 0 else g k)) =
        (fun k => if k = 0 then 0 else g k * (k : ℂ) ^ (-s)) := by
      funext k
      split_ifs <;> simp only [mul_zero, mul_comm]
    rw [he, sum_zeroed]
  rw [hleft, sum_zeroed] at hab
  have hint : (∫ t in Ioc (1 : ℝ) N,
      deriv (fun x : ℝ => (x : ℂ) ^ (-s)) t *
        ∑ k ∈ Finset.Icc 0 ⌊t⌋₊, if k = 0 then 0 else g k) =
      -s * ∫ t in Ioc (1 : ℝ) N,
        (∑ k ∈ Finset.Icc 1 ⌊t⌋₊, g k) * (t : ℂ) ^ (-(s + 1)) := by
    rw [← integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioc fun t ht => ?_
    rw [hd t ht.1.le, sum_zeroed]
    ring
  rw [hint] at hab
  calc
    _ = _ := hab
    _ = _ := by ring

theorem LFunction_finite_abel {q : ℕ} [NeZero q]
    {χ : DirichletCharacter ℂ q} (hχ : χ ≠ 1)
    {s : ℂ} (hs : 0 < s.re) {N : ℕ} (hN : 1 ≤ N) :
    χ.LFunction s =
      (∑ k ∈ Finset.Icc 1 N, χ (k : ZMod q) * (k : ℂ) ^ (-s)) -
      psum χ N * (N : ℂ) ^ (-s) +
      s * ∫ t in Ioi (N : ℝ), psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1)) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hi := integrableOn_integrand hχ hs
  have hsplit : Iint χ s =
      (∫ t in Ioc (1 : ℝ) N, psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1))) +
      ∫ t in Ioi (N : ℝ), psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1)) := by
    rw [Iint, ← Ioc_union_Ioi_eq_Ioi hNr, setIntegral_union Ioc_disjoint_Ioi_same
      measurableSet_Ioi]
    · exact hi.mono_set Ioc_subset_Ioi_self
    · exact hi.mono_set (fun t ht => lt_of_le_of_lt hNr ht)
  have hf := finite_abel (fun k => χ (k : ZMod q)) N s hs
  change (∑ k ∈ Finset.Icc 1 N, χ (k : ZMod q) * (k : ℂ) ^ (-s)) =
    psum χ N * (N : ℂ) ^ (-s) +
      s * ∫ t in Ioc (1 : ℝ) N, psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1)) at hf
  rw [LFunction_eq_mul_Iint hχ hs, hsplit, hf]
  ring

end SpectralAbelPilot
