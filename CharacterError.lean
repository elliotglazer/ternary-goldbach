module

public import ResidueBudget
public import LeftIntegral
public import TwistedWeights
public import ZetaCount

@[expose] public section


open Real Complex MeasureTheory Filter TernaryGoldbach TernaryGoldbach.Explicit
open scoped Topology
noncomputable section
namespace GoldbachEnergy

def contourBudget (D N δ : ℝ) : ℝ :=
  leftCoeff D*Real.sqrt (2*π)*(Real.sqrt ‖twistRate δ‖+Real.sqrt N)*N^(-(1/2):ℝ)*
    (2/gapAngle (twistRate δ))

def charBudget (q : ℕ) (D N δ : ℝ) (g u : ZeroTiling) : ℝ :=
  residueBudget q N δ g u + contourBudget D N δ/(2*π) + 7

private theorem close_contour {X I₀ : ℂ} {V R : ℝ}
    (h : ‖-X-(1/(2*π):ℂ)*I₀‖ ≤ R) (hi : ‖I₀‖ ≤ V) : ‖X‖ ≤ R+V/(2*π) := by
  let A := (1/(2*π):ℂ)*I₀
  have ha : ‖A‖ ≤ V/(2*π) := by
    dsimp only [A]; rw [norm_mul,norm_div,norm_one,norm_mul,Complex.norm_ofNat,Complex.norm_real,
      Real.norm_eq_abs,abs_of_pos Real.pi_pos,div_mul_eq_mul_div,one_mul]
    exact div_le_div_of_nonneg_right hi (by positivity)
  change ‖-X-A‖ ≤ R at h
  calc ‖X‖ = ‖-X-A+A‖ := by rw [sub_add_cancel,norm_neg]
       _ ≤ _ := (norm_add_le _ _).trans (add_le_add h ha)

theorem nonprincipal_wave_error {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1)
    (grh : ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℝ} (hn : 1 ≤ N) (β : ℝ) (g u : ZeroTiling) :
    ‖Schar χ (fun n => (amp N n:ℂ)) β‖ ≤ charBudget q (DN q) N (N*β) g u := by
  let δ := N*β
  obtain ⟨T,_,hl⟩ := cancelled_character_formula hp hχ hn δ
  have hb := le_of_tendsto' ((continuous_norm.tendsto _).comp hl)
    (fun k => rectangle_residues hp hχ grh hn δ (T k) g u)
  have h := close_contour hb (cancelled_left_integral hp hχ hn δ)
  rw [Schar_sub_unit χ (by linarith : 0<N) β] at h
  let X := Schar χ (fun n => (amp N n:ℂ)) β
  let U := Schar χ (fun n => (amp 1 n:ℂ)) 0
  change ‖X-U‖ ≤ _ at h
  have hu := unit_character_bound χ
  change ‖U‖ ≤ 6 at hu
  have ht := norm_add_le (X-U) U
  rw [sub_add_cancel] at ht
  change ‖X‖ ≤ _
  unfold charBudget contourBudget
  linarith only [ht,h,hu]

theorem principal_wave_error (rh : RiemannHypothesis) {N : ℝ} (hn : 1≤N) (β : ℝ)
    (g u : ZeroTiling) :
    ‖Schar (1 : DirichletCharacter ℂ 1) (fun n => (amp N n:ℂ)) β-principalWave N 1 β‖ ≤
      charBudget 1 3 N (N*β) g u := by
  let δ := N*β
  obtain ⟨T,_,hl⟩ := cancelled_zeta_formula hn β
  have hb := le_of_tendsto' ((continuous_norm.tendsto _).comp hl)
    (fun k => rectangle_residues_of_count (zeta_count (T k))
      (fun _ hs => zeta_critical_or_zero rh hs) hn δ g u)
  let X := Schar (1 : DirichletCharacter ℂ 1) (fun n => (amp N n:ℂ)) β
  let U := Schar (1 : DirichletCharacter ℂ 1) (fun n => (amp 1 n:ℂ)) 0
  let P := principalWave N 1 β
  rw [Schar_sub_unit _ (by linarith : 0<N) β] at hb
  change ‖P-1-(X-U)-_‖ ≤ _ at hb
  rw [show P-1-(X-U) = -((X-P)-(U-1)) by ring] at hb
  have h := close_contour hb (cancelled_zeta_left_integral hn δ)
  have hu := unit_character_bound (1 : DirichletCharacter ℂ 1)
  change ‖U‖ ≤ 6 at hu
  have hU : ‖U-1‖ ≤ 7 := by have h' := norm_sub_le U 1; rw [norm_one] at h'; linarith
  have ht := norm_add_le ((X-P)-(U-1)) (U-1)
  rw [sub_add_cancel] at ht
  change ‖X-P‖ ≤ _
  unfold charBudget contourBudget
  linarith only [ht,h,hU]

#print axioms nonprincipal_wave_error
#print axioms principal_wave_error
end GoldbachEnergy
