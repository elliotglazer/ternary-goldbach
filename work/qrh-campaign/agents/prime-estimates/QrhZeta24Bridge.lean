import TernaryGoldbach.Explicit.Xi
import OAI.NumberTheory.DirichletL.RowCompletion.ZeroFreeRegion

open Complex

namespace TernaryGoldbach.Explicit

/-- The smaller provider bounds zeros in the open critical strip from above. -/
theorem zeta_zero_re_le_twenty_three_twenty_fourths {s : ℂ}
    (hs : riemannZeta s = 0) (h1 : s.re < 1) : s.re ≤ 23 / 24 := by
  have hs1 : s ≠ 1 := by
    intro heq
    rw [heq] at h1
    norm_num at h1
  by_contra h
  exact OAI.ShortDraft.riemannZeta_ne_zero_of_re_gt s (lt_of_not_ge h) hs1 hs

/-- Reflection yields the closed [1/24,23/24] strip for nontrivial zeros. -/
theorem zeta_zero_qrh24_strip {s : ℂ} (hs : riemannZeta s = 0)
    (h0 : 0 < s.re) (h1 : s.re < 1) :
    1 / 24 ≤ s.re ∧ s.re ≤ 23 / 24 := by
  have hξ : xiF s = 0 := (xiF_eq_zero_iff h0 h1).2 hs
  have href : xiF (1 - s) = 0 := by rw [xiF_one_sub]; exact hξ
  have href0 : 0 < (1 - s).re := by
    simp only [Complex.sub_re, Complex.one_re]
    linarith
  have href1 : (1 - s).re < 1 := by
    simp only [Complex.sub_re, Complex.one_re]
    linarith
  have hs' : riemannZeta (1 - s) = 0 :=
    (xiF_eq_zero_iff href0 href1).1 href
  have hUpper := zeta_zero_re_le_twenty_three_twenty_fourths hs h1
  have hLower := zeta_zero_re_le_twenty_three_twenty_fourths hs' href1
  simp only [Complex.sub_re, Complex.one_re] at hLower
  exact ⟨by linarith, hUpper⟩

end TernaryGoldbach.Explicit
