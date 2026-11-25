module

public import CharacterComparison
public import CharacterFormula

@[expose] public section


open ArithmeticFunction Real TernaryGoldbach TernaryGoldbach.Explicit
open scoped ArithmeticFunction
noncomputable section
namespace GoldbachEnergy

theorem norm_amp_sum {N : ℝ} (h : 0<N) : Summable fun n => ‖(amp N n:ℂ)‖ := by
  have hp (n : ℕ) : 0 ≤ amp N n := mul_nonneg vonMangoldt_nonneg (Real.exp_pos _).le
  simpa only [Complex.norm_real,Real.norm_eq_abs,abs_of_nonneg (hp _)] using amp_summable N h

theorem unit_character_bound {q : ℕ} (χ : DirichletCharacter ℂ q) :
    ‖Schar χ (fun n => (amp 1 n:ℂ)) 0‖ ≤ 6 := by
  have h := norm_Schar_le χ (norm_amp_sum zero_lt_one) 0
  have hnn (n : ℕ) : 0 ≤ amp 1 n := mul_nonneg vonMangoldt_nonneg (Real.exp_pos _).le
  have h6 := norm_wave_one 0
  simp only [wave,mul_zero,e_zero,mul_one,← Complex.ofReal_tsum,Complex.norm_real,Real.norm_eq_abs,
    abs_of_nonneg (tsum_nonneg hnn)] at h6
  apply h.trans; simpa only [Complex.norm_real,Real.norm_eq_abs,abs_of_nonneg (hnn _)] using h6

theorem Schar_sub_unit {q : ℕ} (χ : DirichletCharacter ℂ q) {N : ℝ} (hn : 0<N) (β : ℝ) :
    SsumG χ (cancelledWeight N (N*β)) N =
      Schar χ (fun n => (amp N n:ℂ)) β - Schar χ (fun n => (amp 1 n:ℂ)) 0 := by
  have h1 := summable_Schar χ (norm_amp_sum hn) β
  have h2 := summable_Schar χ (norm_amp_sum zero_lt_one) 0
  unfold Schar SsumG
  rw [← h1.tsum_sub h2]
  apply tsum_congr
  intro n
  have hz : (N:ℂ) ≠ 0 := by exact_mod_cast hn.ne'
  have ht : (Λ n:ℂ)*cancelledWeight N (N*β) (n/N) =
      (amp N n:ℂ)*e (n*β)-(amp 1 n:ℂ) := by
    unfold cancelledWeight amp e; push_cast; rw [mul_sub]
    simp only [mul_assoc,div_one,← Complex.exp_add]
    congr 2 <;> congr 1 <;> field_simp [hz] <;> ring
  simp only [mul_zero,e_zero,mul_one]
  linear_combination (norm := ring) χ (n : ZMod q) * ht

#print axioms Schar_sub_unit
#print axioms unit_character_bound
end GoldbachEnergy
