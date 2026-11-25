module

public import LogCertificate
public import GammaBudget
public import LongRay

@[expose] public section


open Real Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def boxBP (Q : ℕ) (Y : ℚ) : ℚ :=
  1400*Q^9*(Q+1)*(Y+22)*(5/4*(Y+11))^10/(355/1000)

theorem bp_box_upper {q Q : ℕ} [NeZero q] (hq : q≤Q) {y : ℝ} {Y : ℚ}
    (hy : |y| ≤ (Y:ℝ)) :
    BP q y/0.355 ≤ (boxBP Q Y:ℝ) := by
  unfold BP boxBP
  rw [show (10:ℝ)=(10:ℕ) by norm_num,Real.rpow_natCast]
  push_cast
  have hQ : (q:ℝ)≤Q := by exact_mod_cast hq
  have hp := abs_nonneg y
  have hY : (0:ℝ) ≤ Y := hp.trans hy
  norm_num only [show (5:ℝ)/4=1.25 by norm_num,show (355:ℝ)/1000=0.355 by norm_num]
  gcongr <;> positivity

theorem small_bp {q : ℕ} [NeZero q] (hq : q≤2200) {y : ℝ} (hy : |y| ≤ 10) :
    Real.log (BP q y/0.355) ≤ 123 := by
  have hc := upper_log_certificate 123 0 (boxBP 2200 10) (by norm_num [boxBP])
    (by norm_num) (by norm_num) (by norm_num [expPoly,boxBP])
  have h := bp_box_upper hq (Y:=10) (by norm_num; exact hy : |y| ≤ ((10:ℚ):ℝ))
  have hq0 : (0:ℝ)<q := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne q)
  exact (Real.log_le_log (by unfold BP; positivity) h).trans (by simpa using hc)

def oneCell : ZeroTiling :=
  ⟨1,2,7,7,8,8,by decide,by norm_num,by norm_num,by norm_num,by norm_num⟩

theorem gamma_small_twist {q : ℕ} [NeZero q] (hq : q≤2200) (z : ℂ)
    (hz : 1≤‖z‖) (harg : |z.arg| ≤ 1/2) : gammaBudget q z oneCell ≤ 1400 := by
  have hs : Real.sqrt (2*π) ≤ 3 := (Real.sqrt_le_left (by norm_num)).mpr (by linarith [Real.pi_lt_four])
  have hz' : 1 ≤ Real.sqrt ‖z‖ := by simpa using Real.sqrt_le_sqrt hz
  have hf : Real.sqrt (2*π)/Real.sqrt ‖z‖ ≤ 3 := by rw [div_le_iff₀ (by linarith)]; linarith
  have hj := jensen_denominator (W:=7) (by constructor <;> norm_num)
  have hw : cellWeight z 0 2 ≤ 3 := by
    unfold cellWeight; apply (min_le_left _ _).trans; simpa using hf
  have hc : centerCount q 2 ≤ 123 := by
    unfold centerCount
    have hden : Real.sqrt (9/4+(2:ℝ)^2) = 5/2 := by
      exact (Real.sqrt_eq_iff_mul_self_eq (by norm_num) (by norm_num)).mpr (by norm_num)
    rw [hden,show (10:ℝ)/(5/2)=4 by norm_num]
    have hl : 1 ≤ Real.log 4 := (Real.le_log_iff_exp_le (by norm_num)).mpr (by linarith [Real.exp_one_lt_three])
    rw [div_le_iff₀ (by linarith)]
    linarith only [small_bp hq (y:=0) (by norm_num),hl]
  have hc0 : 0 ≤ centerCount q 2 := by
    unfold centerCount; apply div_nonneg (log_BP_pos q 0).le
    apply Real.log_nonneg; rw [one_le_div (by positivity)]
    apply (Real.sqrt_le_left (by norm_num)).mpr; norm_num
  have ray (dir : ℝ) (hd : 1 ≤ π/2-dir*z.arg) : rayBound q z dir 2 7 8 ≤ 500 := by
    let d := π/2-dir*z.arg
    have hs' := ray_simple (q:=q) z dir 2 7 8 (by linarith) (by norm_num) (by norm_num) (by norm_num) (by linarith)
    have hk : Real.sqrt (2*π)/Real.sqrt ‖z‖/Real.log (10/Real.sqrt (9/4+((7:ℝ)/2)^2)) ≤ 3.125 := by
      rw [div_le_iff₀ (by linarith)]; linarith
    have hl : Real.log (BP q 8/0.355)+11 ≤ 134 := by linarith only [small_bp hq (y:=8) (by norm_num)]
    have hd' : 1+1/((π/2-dir*z.arg)*7) ≤ 8/7 := by
      have hh := one_div_le_one_div_of_le (by norm_num : (0:ℝ)<7) (show 7≤(π/2-dir*z.arg)*7 by linarith)
      linarith
    apply hs'.trans
    have hpos : 0 ≤ Real.log (BP q 8/0.355)+11 := by linarith [log_BP_pos q 8]
    have hb := mul_le_mul hk hl hpos (by norm_num)
    have hh := mul_le_mul hb hd' (by positivity : 0 ≤ 1+1/((π/2-dir*z.arg)*7)) (by norm_num)
    linarith only [hh]
  have hp := ray 1 (by linarith [(abs_le.mp harg).2,Real.pi_gt_three])
  have hm := ray (-1) (by linarith [(abs_le.mp harg).1,Real.pi_gt_three])
  have hcent := mul_le_mul (max_le hw (by norm_num : (0:ℝ)≤3)) hc hc0 (by norm_num)
  simpa [gammaBudget,oneCell,gridIncrement,clippedWeight] using
    (show max (cellWeight z 0 2) 0*centerCount q 2+rayBound q z 1 2 7 8+rayBound q z (-1) 2 7 8 ≤ 1400 by
      linarith only [hcent,hp,hm])

#print axioms small_bp
#print axioms gamma_small_twist
end GoldbachEnergy
