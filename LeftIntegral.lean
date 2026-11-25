module

public import LeftWeight
public import TernaryGoldbach.Explicit.ExplicitBoundGen

@[expose] public section


open Real Complex MeasureTheory Filter TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def leftCoeff (D : ℝ) := (2/Real.log 2+4.8)*(2*(D+37)+2.6)

private theorem left_linear {D : ℝ} (hD : 0 ≤ D+37) (y : ℝ) :
    (2/Real.log 2+4.8)*(D+37+2.6*|y|) ≤ leftCoeff D * ‖leftPoint y‖ := by
  have hl := Real.log_pos (by norm_num : (1:ℝ)<2)
  have hr : (1/2:ℝ) ≤ ‖leftPoint y‖ := by
    have h := Complex.abs_re_le_norm (leftPoint y)
    norm_num [leftPoint] at h ⊢
    exact h
  have hi : |y| ≤ ‖leftPoint y‖ := by simpa [leftPoint] using Complex.abs_im_le_norm (leftPoint y)
  dsimp [leftCoeff]; rw [mul_assoc]
  apply mul_le_mul_of_nonneg_left _ (by positivity)
  nlinarith only [mul_le_mul_of_nonneg_right hr hD,hi]

private theorem left_norm_integral {F : ℝ → ℂ} {D N : ℝ} (hD : 0≤D) (hn : 1≤N) (δ : ℝ)
    (hf : ∀ y, ‖F y‖ ≤ (leftCoeff D*‖leftPoint y‖)*
      (‖mellin (cancelledWeight N δ) (leftPoint y)‖*N^(-(1/2):ℝ))) :
    ‖∫ y : ℝ, F y‖ ≤
      leftCoeff D * Real.sqrt (2*π)*(Real.sqrt ‖twistRate δ‖+Real.sqrt N)*
      N^(-(1/2):ℝ)*(2/gapAngle (twistRate δ)) := by
  have hz : 0<(twistRate δ).re := by simp [twistRate]
  have hd : 0<gapAngle (twistRate δ) := sub_pos.mpr (Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl hz))
  have hl := Real.log_pos (by norm_num : (1:ℝ)<2)
  have hc : 0≤leftCoeff D := by unfold leftCoeff; positivity
  let K := leftCoeff D*Real.sqrt (2*π)*(Real.sqrt ‖twistRate δ‖+Real.sqrt N)*N^(-(1/2):ℝ)
  have hpt (y : ℝ) : ‖F y‖ ≤ K*Real.exp (-(gapAngle (twistRate δ)*|y|)) := by
    apply (hf y).trans
    have hm := mul_le_mul_of_nonneg_left (left_mellin_weight hn δ y) hc
    have hpow := Real.rpow_nonneg (show 0≤N by linarith) (-(1/2):ℝ)
    convert mul_le_mul_of_nonneg_right hm hpow using 1 <;> (try dsimp only [K]) <;> ring
  have h := norm_integral_le_of_norm_le ((integrable_exp_neg_abs hd).const_mul K) (Eventually.of_forall hpt)
  rwa [integral_const_mul, integral_exp_neg_mul_abs hd] at h

theorem cancelled_left_integral {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) {N : ℝ} (hn : 1≤N) (δ : ℝ) :
    ‖∫ y : ℝ, hIntG χ (cancelledWeight N δ) N (leftPoint y)‖ ≤
      leftCoeff (DN q)*Real.sqrt (2*π)*(Real.sqrt ‖twistRate δ‖+Real.sqrt N)*
      N^(-(1/2):ℝ)*(2/gapAngle (twistRate δ)) := by
  apply left_norm_integral (DN_nonneg q) hn δ
  intro y
  have hLb := LB_le_linear (N := q) y
  have hl := Real.log_pos (by norm_num : (1:ℝ)<2)
  have hld := norm_logDeriv_L_left hp hχ y
  have hcoef : 0 ≤ 2/Real.log 2+4.8 := by positivity
  have hld' : ‖logDeriv χ.LFunction (leftPoint y)‖ ≤ leftCoeff (DN q)*‖leftPoint y‖ := by
    apply hld.trans
    calc _ = (2/Real.log 2+4.8)*Real.log (BT q y/0.355) := by ring
         _ ≤ _ := mul_le_mul_of_nonneg_left hLb hcoef
         _ ≤ _ := left_linear (by linarith [DN_nonneg q]) y
  rw [hIntG,norm_mul,norm_mul,norm_cpow_x (show 0<N by linarith)]
  have hre : (leftPoint y).re= -(1/2:ℝ) := by norm_num [leftPoint]
  rw [hre]
  exact mul_le_mul_of_nonneg_right hld' (mul_nonneg (norm_nonneg _) (Real.rpow_nonneg (show 0≤N by linarith) _))


theorem cancelled_zeta_left_integral {N : ℝ} (hn : 1 ≤ N) (δ : ℝ) :
    ‖∫ y : ℝ, hZeta (cancelledWeight N δ) N (leftPoint y)‖ ≤
      leftCoeff 3*Real.sqrt (2*π)*(Real.sqrt ‖twistRate δ‖+Real.sqrt N)*
      N^(-(1/2):ℝ)*(2/gapAngle (twistRate δ)) := by
  apply left_norm_integral (D := 3) (by norm_num) hn δ
  intro y
  set c₁ := 2 / Real.log 2 + 4.8 with hc₁
  have hl2 := Real.log_pos (by norm_num : (1:ℝ) < 2)
  have hc₁0 : 0 ≤ c₁ := by positivity
  let s := leftPoint y
  have hsre : s.re = -1/2 := by simp [s,leftPoint]
  have hs1 : s ≠ 1 := by intro h; rw [h] at hsre; simp at hsre; norm_num at hsre
  have hz : riemannZeta s ≠ 0 :=
    zeta_ne_zero_of_zetaF hs1 (zetaF_ne_zero_strip (by rw [hsre]; norm_num) (by rw [hsre]; norm_num))
  have hld : logDeriv riemannZeta s = logDeriv zetaF s - 1 / (s - 1) := by
    rw [logDeriv_zetaF_eq hs1 hz]; ring
  have hL := norm_logDeriv_leftD ldatum_zeta y
  have hLB := log_Bz_le y
  have hL' : ‖logDeriv zetaF s‖ ≤ c₁ * (39 + 2.6 * |y|) := by
    refine hL.trans ?_
    have e : Real.log (Bz y / 0.355) / Real.log 2 / (1 / 2) + 4.8 * Real.log (Bz y / 0.355) =
        c₁ * Real.log (Bz y / 0.355) := by rw [hc₁]; ring
    rw [e]; exact mul_le_mul_of_nonneg_left (by linarith) hc₁0
  have hinv : ‖1 / (s - 1)‖ ≤ 2 / 3 := by
    rw [norm_div, norm_one, div_le_iff₀ (norm_pos_iff.2 (sub_ne_zero.2 hs1))]
    have := Complex.abs_re_le_norm (s - 1)
    rw [Complex.sub_re, hsre] at this
    norm_num at this ⊢; linarith
  have hc₁1 : 2 / 3 ≤ c₁ := by
    have : 0 ≤ 2 / Real.log 2 := by positivity
    rw [hc₁]; linarith
  have hld' : ‖logDeriv riemannZeta s‖ ≤ c₁ * (3 + 37 + 2.6 * |y|) := by
    rw [hld]; refine (norm_sub_le _ _).trans ?_; nlinarith
  change ‖hZeta _ N s‖ ≤ _
  rw [hZeta,norm_mul,norm_mul,norm_cpow_x (show 0<N by linarith),hsre]
  rw [show (-1/2:ℝ) = -(1/2) by ring]
  exact mul_le_mul_of_nonneg_right (hld'.trans (left_linear (by norm_num : (0:ℝ)≤3+37) y))
    (mul_nonneg (norm_nonneg (mellin (cancelledWeight N δ) s)) (Real.rpow_nonneg (show 0≤N by linarith) (-(1/2):ℝ)))

#print axioms cancelled_zeta_left_integral

#print axioms cancelled_left_integral
end GoldbachEnergy
