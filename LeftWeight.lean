module

public import TrivialZero
public import CharacterFormula

@[expose] public section


open Real Complex
noncomputable section
namespace GoldbachEnergy

def leftPoint (y : ℝ) : ℂ := ((-1/2:ℝ):ℂ) + y*I
def gapAngle (z : ℂ) := π/2-|z.arg|

private theorem left_rate (y : ℝ) {z : ℂ} (hz : z ≠ 0) :
    ‖z^(-leftPoint y)*Complex.Gamma (leftPoint y+1)‖ ≤
    Real.sqrt (2*π)*Real.sqrt ‖z‖*Real.exp (-(gapAngle z*|y|)) := by
  have h₁ : leftPoint y+1=critical y := by apply Complex.ext <;> simp [leftPoint,critical] <;> ring
  have h₂ : -leftPoint y=1+(-critical y) := by rw [← h₁]; ring
  rw [h₁,h₂,Complex.cpow_add _ _ hz,Complex.cpow_one,mul_assoc,mul_comm (z^_) (Complex.Gamma _),norm_mul]
  apply (mul_le_mul_of_nonneg_left (critical_gamma_rate y hz) (norm_nonneg z)).trans_eq
  have hh := Real.sq_sqrt (norm_nonneg z)
  have hs := Real.sqrt_pos.mpr (norm_pos_iff.mpr hz)
  rw [← hh]; simp only [Real.sqrt_sq hs.le]; unfold gapAngle; field_simp <;> ring
  
theorem left_mellin_weight {N : ℝ} (hn : 1≤N) (δ y : ℝ) :
    ‖leftPoint y‖ * ‖mellin (cancelledWeight N δ) (leftPoint y)‖ ≤
      Real.sqrt (2*π)*(Real.sqrt ‖twistRate δ‖+Real.sqrt N)*
      Real.exp (-(gapAngle (twistRate δ)*|y|)) := by
  have hn0 : 0<N := by linarith
  have hz : twistRate δ ≠ 0 := by intro h; have h' := congrArg Complex.re h; simp [twistRate] at h'
  have h := congrArg norm (cancelled_mellin_strip hn δ (s := leftPoint y) (by norm_num [leftPoint]))
  rw [norm_mul,sub_mul] at h
  have hreal := left_rate y (z := (N:ℂ)) (by exact_mod_cast hn0.ne')
  rw [Complex.norm_real,Real.norm_eq_abs,abs_of_pos hn0] at hreal
  have hgap : gapAngle (twistRate δ) ≤ gapAngle (N:ℂ) := by
    unfold gapAngle; simp [Complex.arg_ofReal_of_nonneg hn0.le]
  have hreal' := hreal.trans (mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr
    (neg_le_neg (mul_le_mul_of_nonneg_right hgap (abs_nonneg _)))) (by positivity))
  rw [h]
  exact (norm_sub_le _ _).trans ((add_le_add (left_rate _ hz) hreal').trans_eq (by ring))

#print axioms left_mellin_weight
end GoldbachEnergy
