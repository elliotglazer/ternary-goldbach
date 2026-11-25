module

public import TailHeight
public import GammaBudget

@[expose] public section


open Real Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def tailTiling (z : ℂ) : ZeroTiling :=
  ⟨1,2,7,7,8+‖z‖,8+‖z‖,by decide,by norm_num,by norm_num,
    by refine ⟨by norm_num,by norm_num,?_⟩; linarith [norm_nonneg z],
    by refine ⟨by norm_num,by norm_num,?_⟩; linarith [norm_nonneg z]⟩

theorem gamma_of_log_bounds {q : ℕ} [NeZero q] {L : ℝ} (hL : 0 < L) (z : ℂ)
    (hz : 1 ≤ ‖z‖) (ha : 1/‖z‖ ≤ π/2-|z.arg|)
    (hBP : Real.log (BP q (8+‖z‖)/0.355) ≤ 11*L)
    (hshift : Real.log (BP q (8+‖z‖)/0.355)+11 ≤ 11.2*L) :
    gammaBudget q z (tailTiling z) ≤ 98*L+4.3*L*Real.sqrt ‖z‖ := by
  let s := Real.sqrt ‖z‖
  have hs : 1 ≤ s := by dsimp [s]; simpa using Real.sqrt_le_sqrt hz
  have hs0 : 0<s := by linarith
  have hz0 : 0<‖z‖ := by linarith
  have hL0 : 0<L := by linarith
  have hpi : Real.sqrt (2*π) ≤ 2.51 := (Real.sqrt_le_left (by norm_num)).mpr (by linarith [Real.pi_lt_d6])
  have hj := jensen_denominator (W:=7) (by constructor <;> norm_num)
  let J := Real.log (10/Real.sqrt (9/4+((7:ℝ)/2)^2))
  have hJ : 0.96 ≤ J := hj
  have hJ0 : 0<J := by linarith
  have hK : (Real.sqrt (2*π)/s/J)*(Real.log (BP q (8+‖z‖)/0.355)+11) ≤ 30*L/s := by
    have hx : Real.sqrt (2*π)/J ≤ 2.62 := by rw [div_le_iff₀ hJ0]; linarith
    have hh := mul_le_mul hx (show Real.log (BP q (8+‖z‖)/0.355)+11 ≤ 11.2*L by linarith)
      (show 0 ≤ Real.log (BP q (8+‖z‖)/0.355)+11 by linarith [log_BP_pos q (8+‖z‖)]) (by norm_num)
    rw [show (Real.sqrt (2*π)/s/J)*(Real.log (BP q (8+‖z‖)/0.355)+11) =
      ((Real.sqrt (2*π)/J)*(Real.log (BP q (8+‖z‖)/0.355)+11))/s by ring]
    apply div_le_div_of_nonneg_right _ hs0.le; linarith
  have ray (dir v : ℝ) (hd : 1/‖z‖ ≤ π/2-dir*z.arg) (hv : 1/(π/2-dir*z.arg) ≤ v) :
      rayBound q z dir 2 7 (8+‖z‖) ≤ (30*L/s)*(1+v/7) := by
    let d := π/2-dir*z.arg
    have hd0 : 0<d := (one_div_pos.mpr hz0).trans_le hd
    have hyd : 1 ≤ (8+‖z‖)*d := by
      have hh := (div_le_iff₀ hz0).mp hd
      change 1 ≤ (8+‖z‖)*d; change 1 ≤ d*‖z‖ at hh; nlinarith only [hh,hd0]
    have hraw := ray_simple (q:=q) z dir 2 7 (8+‖z‖) hd0 (by norm_num) (by norm_num) (by norm_num) hyd
    apply hraw.trans
    apply mul_le_mul hK _ (by change 0 ≤ 1+1/(d*7); positivity) (by positivity)
    change 1+1/(d*7) ≤ 1+v/7
    rw [← div_div]; gcongr
  have hbase : 30*L/s ≤ 30*L := by rw [div_le_iff₀ hs0]; nlinarith only [mul_le_mul_of_nonneg_left hs hL0.le]
  have hsquare : s^2=‖z‖ := Real.sq_sqrt (norm_nonneg _)
  have fast (dir : ℝ) (hf : 1 ≤ π/2-dir*z.arg) :
      rayBound q z dir 2 7 (8+‖z‖) ≤ 35*L := by
    have hd := (one_div_le_one_div_of_le zero_lt_one hz)
    have r := ray dir 1 ((by simpa using hd : 1/‖z‖ ≤ 1).trans hf) ((one_div_le_one_div_of_le zero_lt_one hf).trans_eq (by norm_num))
    linarith only [r,hbase,hL]
  have slow (dir : ℝ) (hd : 1/‖z‖ ≤ π/2-dir*z.arg) :
      rayBound q z dir 2 7 (8+‖z‖) ≤ 30*L+4.3*L*s := by
    have hh := one_div_le_one_div_of_le (one_div_pos.mpr hz0) hd
    rw [one_div_one_div] at hh
    have r := ray dir ‖z‖ hd hh
    have hmul : (30*L/s)*(1+‖z‖/7) = 30*L/s+(30/7)*L*s := by
      rw [← hsquare]; field_simp
    rw [hmul] at r
    linarith only [r,hbase,mul_nonneg hL0.le hs0.le]
  have htwo : rayBound q z 1 2 7 (8+‖z‖)+rayBound q z (-1) 2 7 (8+‖z‖) ≤ 65*L+4.3*L*s := by
    rcases le_or_gt 0 z.arg with h|h
    · rw [abs_of_nonneg h] at ha
      linarith only [slow 1 (by simpa using ha),fast (-1) (by linarith [Real.pi_gt_three])]
    · rw [abs_of_neg h] at ha
      linarith only [fast 1 (by linarith [Real.pi_gt_three]),slow (-1) (by simpa using ha)]
  have hc : centerCount q 2 ≤ 11*L := by
    have hzero := (log_BP_mono q (c:=0) (c':=8+‖z‖) (by simp)).trans hBP
    unfold centerCount
    rw [show Real.sqrt (9/4+(2:ℝ)^2) = 5/2 from (Real.sqrt_eq_iff_mul_self_eq (by norm_num) (by norm_num)).mpr (by norm_num),
      show (10:ℝ)/(5/2)=4 by norm_num]
    have hl : 1 ≤ Real.log 4 := (Real.le_log_iff_exp_le (by norm_num)).mpr (by linarith [Real.exp_one_lt_three])
    rw [div_le_iff₀ (by linarith)]; nlinarith only [hzero,mul_le_mul_of_nonneg_left hl hL0.le]
  have hw : cellWeight z 0 2 ≤ 3 := by
    unfold cellWeight; apply (min_le_left _ _).trans
    simp only [mul_zero,neg_zero,Real.exp_zero,mul_one]
    change Real.sqrt (2*π)/s ≤ 3; rw [div_le_iff₀ hs0]; linarith
  have hc0 : 0 ≤ centerCount q 2 := by
    unfold centerCount; apply div_nonneg (log_BP_pos q 0).le
    apply Real.log_nonneg; rw [one_le_div (by positivity)]
    apply (Real.sqrt_le_left (by norm_num)).mpr; norm_num
  have hcent := mul_le_mul (max_le hw (by norm_num : (0:ℝ) ≤ 3)) hc hc0 (by norm_num)
  simpa [gammaBudget,tailTiling,gridIncrement,clippedWeight,s] using
    (show max (cellWeight z 0 2) 0*centerCount q 2+rayBound q z 1 2 7 (8+‖z‖)+rayBound q z (-1) 2 7 (8+‖z‖) ≤ 98*L+4.3*L*s by
      linarith only [hcent,htwo])

theorem tail_gamma {q : ℕ} [NeZero q] {L : ℝ} (hL : 56 ≤ L) (z : ℂ)
    (hz : 1 ≤ ‖z‖) (ha : 1/‖z‖ ≤ π/2-|z.arg|)
    (hBP : Real.log (BP q (8+‖z‖)/0.355) ≤ 11*L) :
    gammaBudget q z (tailTiling z) ≤ 98*L+4.3*L*Real.sqrt ‖z‖ :=
  gamma_of_log_bounds (by linarith) z hz ha hBP (by linarith)

#print axioms gamma_of_log_bounds
#print axioms tail_gamma
end GoldbachEnergy
