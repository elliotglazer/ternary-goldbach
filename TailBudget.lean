module

public import TailCharacter
public import MinorNumerics

@[expose] public section


open Real Finset
noncomputable section
namespace GoldbachEnergy

def tailCeiling (N : ℝ) (q : ℕ) (δ : ℝ) :=
  let L := Real.log N
  Real.sqrt q*(Real.sqrt N*(103*L+10.8*L*Real.sqrt |δ|)+51*L^2+3150*L*|δ|)

theorem twist_in_tail {N δ : ℝ} (hn : 1≤N) (hl : 56≤Real.log N) (q : ℕ) (hq : 0<q)
    (hp : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N) :
    twistedBudget N q δ (tailTiling (twistRate δ)) (tailTiling 1) ≤ tailCeiling N q δ := by
  let L := Real.log N
  have hL : 56≤L := hl
  have h0 : 0<L := by linarith
  have hq1 : (1:ℝ)≤q := by exact_mod_cast hq
  have hq' : (0:ℝ)<q := by linarith
  have hqN : (q:ℝ)≤N := by nlinarith only [hp,mul_nonneg hq'.le (abs_nonneg (8+‖twistRate δ‖)),hq1]
  have hs : 1 ≤ Real.sqrt q := by simpa using Real.sqrt_le_sqrt hq1
  have hh2 : 1/2≤Real.log 2 := by
    have h := lower_log_certificate 0 (1/2) 2 (by norm_num) (by norm_num) (by norm_num [expPoly]); simpa using h
  let D := Real.log q/Real.log 2*(1+L)
  have hD : D ≤ 3*L^2 := by
    have hh : Real.log q/Real.log 2 ≤ 2*L := by
      rw [div_le_iff₀ (by linarith)]
      nlinarith only [show Real.log q≤L from Real.log_le_log hq' hqN,mul_le_mul_of_nonneg_left hh2 h0.le]
    have hv := mul_le_mul_of_nonneg_right hh (by linarith : 0≤1+L)
    dsimp [D]; nlinarith only [hv,mul_le_mul_of_nonneg_right hL h0.le]
  have h1 := tail_conductor hn hl q hq hp
  have hgamma : 98*L+4.3*L*Real.sqrt ‖twistRate δ‖ ≤ 103*L+10.8*L*Real.sqrt |δ| := by
    nlinarith only [mul_le_mul_of_nonneg_left (sqrt_twist_bound δ) h0.le,h0,
      mul_nonneg h0.le (Real.sqrt_nonneg |δ|)]
  have hz := mul_le_mul_of_nonneg_left (twist_norm_bounds δ).2 h0.le
  let Y := Real.sqrt N*(103*L+10.8*L*Real.sqrt |δ|)+51*L^2+3150*L*|δ|
  have hc : tailCharCeiling N δ+2*(3*L^2) ≤ Y := by
    change Real.sqrt N*(98*L+4.3*L*Real.sqrt ‖twistRate δ‖)+33*L^2+103*L+500*L*‖twistRate δ‖+7+2*(3*L^2) ≤ _
    dsimp only [Y]
    nlinarith only [mul_le_mul_of_nonneg_left hgamma (Real.sqrt_nonneg N),hz,mul_le_mul_of_nonneg_right hL h0.le,hL,abs_nonneg δ,mul_nonneg h0.le (abs_nonneg δ)]
  have hsD := mul_le_mul_of_nonneg_right hs (show 0≤3*L^2 by positivity)
  have hsum := mul_le_mul_of_nonneg_left (add_le_add h1 hD) (Real.sqrt_nonneg q)
  have hh := mul_le_mul_of_nonneg_left hc (Real.sqrt_nonneg q)
  change D+Real.sqrt q*(conductorBudget q N δ (tailTiling (twistRate δ)) (tailTiling 1)+D) ≤ Real.sqrt q*Y
  linarith only [hD,hsD,hsum,hh]

theorem order_in_tail {N : ℝ} (hn : 0<N) (hl : 56≤Real.log N) :
    minorOrder N = 4900*(Real.log N)^4 := by
  have he := Real.exp_le_exp.mpr hl
  rw [Real.exp_log hn, show (56:ℝ)=(56:ℕ)*(1:ℝ) by norm_num,Real.exp_nat_mul] at he
  have hbase : (2.7:ℝ) ≤ Real.exp 1 := by linarith only [Real.exp_one_gt_d9]
  have hx : (10:ℝ)^20 ≤ N := (le_trans (by norm_num : (10:ℝ)^20 ≤ 2.7^56)
    (pow_le_pow_left₀ (by norm_num) hbase 56)).trans he
  simp [minorOrder,not_lt.mpr hx]

#print axioms twist_in_tail
end GoldbachEnergy
