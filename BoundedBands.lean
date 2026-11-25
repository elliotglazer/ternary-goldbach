module

public import BoundedMajor
public import MinorNumerics
public import TotientSquare

@[expose] public section


open Real TernaryGoldbach
noncomputable section
namespace GoldbachEnergy

theorem log_floor_two_e19 {N : ℝ} (hn : 2*10^19 ≤ N) : 44.442 ≤ Real.log N := by
  have cert := lower_log_certificate 44 (442/1000) (2*10^19) (by norm_num) (by norm_num)
    (by norm_num [expPoly])
  apply le_trans _ (Real.log_le_log (by norm_num : (0:ℝ) < 2*10^19) hn)
  norm_num at cert ⊢
  linarith

theorem split_log_bounds : 46.051 ≤ Real.log (10^20:ℝ) ∧ Real.log (10^20:ℝ) ≤ 46.052 := by
  have lo := lower_log_certificate 46 (51/1000) (10^20) (by norm_num) (by norm_num)
    (by norm_num [expPoly])
  have hi := upper_log_certificate 46 (52/1000) (10^20) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num [expPoly])
  norm_num at lo hi ⊢
  exact ⟨by linarith,by linarith⟩

/-- A minor-arc rational approximant can still fall in the range of the uniform
major-arc estimate. In that case it already satisfies the minor budget. -/
theorem minor_of_major_geometry {N : ℝ} (hn : 2*10^19 ≤ N) (hl : Real.log N ≤ 56)
    (q : ℕ) (hq : 0 < q) (hq' : (q:ℝ) ≤ modulusCutoff N)
    {δ : ℝ} (hd : |δ| ≤ 2*Real.log N/q.totient) :
    ∃ g u : ZeroTiling, twistedBudget N q δ g u + minorPrincipalBudget N q δ ≤ 0.315*N/Real.log N := by
  obtain ⟨g,u,h⟩ := major_budget_bounded hn hl q hq hq' δ hd
  refine ⟨g,u,?_⟩
  have hL := log_two_e19 hn
  have h0 : 0 < N := by linarith
  have hL0 : 0 < Real.log N := by linarith
  have hp := min_le_left (minorConstant N*N/Real.log N) ((N/q.totient)/‖twistRate δ‖)
  have hc : minorConstant N ≤ 0.096 := by unfold minorConstant; split <;> norm_num
  change _ + min _ _ ≤ _
  apply (add_le_add h hp).trans
  rw [← add_div,le_div_iff₀ hL0]
  rw [div_mul_cancel₀ _ hL0.ne']
  nlinarith only [mul_le_mul_of_nonneg_right hc h0.le,h0]

#print axioms log_floor_two_e19
#print axioms split_log_bounds
#print axioms minor_of_major_geometry
end GoldbachEnergy
