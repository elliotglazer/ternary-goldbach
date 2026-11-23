import TernaryGoldbach.Explicit.Xi
import OAI.NumberTheory.DirichletL.Nonvanishing

open Complex

namespace TernaryGoldbach.Explicit

/-- The proven QRH nonvanishing theorem bounds every zeta zero from above. -/
theorem zeta_zero_re_le_seven_eighths {s : ℂ} (hs : riemannZeta s = 0) :
    s.re ≤ 7 / 8 := by
  by_contra h
  exact OAI.riemannZeta_ne_zero_of_seven_eighths_lt_re (lt_of_not_ge h) hs

/-- Reflection through the functional equation bounds every nontrivial zero from below. -/
theorem zeta_zero_qrh_strip {s : ℂ} (hs : riemannZeta s = 0)
    (h0 : 0 < s.re) (h1 : s.re < 1) :
    1 / 8 ≤ s.re ∧ s.re ≤ 7 / 8 := by
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
  have hUpper := zeta_zero_re_le_seven_eighths hs
  have hLower := zeta_zero_re_le_seven_eighths hs'
  simp only [Complex.sub_re, Complex.one_re] at hLower
  exact ⟨by linarith, hUpper⟩

end TernaryGoldbach.Explicit

