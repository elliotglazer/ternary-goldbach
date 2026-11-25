module

public import BoxTiling

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def logBP (q : ℕ) (y : ℝ) := Real.log (BP q y/0.355)

theorem logBP_nonneg (q : ℕ) [NeZero q] (y : ℝ) : 0 ≤ logBP q y :=
  Real.log_nonneg (by rw [le_div_iff₀ (by norm_num),one_mul]; exact (by norm_num : (0.355:ℝ) ≤ 1400).trans (one_le_BP (N:=q) y))

theorem logBP_order {d Q : ℕ} [NeZero d] (hd : d ≤ Q) (y : ℝ) : logBP d y ≤ logBP Q y := by
  have hpos : 0 < BP d y/0.355 := div_pos ((by norm_num : (0:ℝ) < 1400).trans_le (one_le_BP (N:=d) y)) (by norm_num)
  apply Real.log_le_log hpos
  unfold BP
  have h : (d:ℝ) ≤ Q := by exact_mod_cast hd
  gcongr

def boxGammaTop (Q m : ℕ) (h W a b ds df ys yf : ℝ) :=
  coreSum Q m h a b + rayCore (logBP Q ys) ds (m*h) W ys + rayCore (logBP Q yf) df (m*h) W yf

theorem core_order {d Q m : ℕ} [NeZero d] (hd : d ≤ Q) {h : ℝ} (hh : 0 ≤ h) (h9 : m*h ≤ 9) (a b : ℝ) :
    coreSum d m h a b ≤ coreSum Q m h a b := by
  apply sum_le_sum; intro j hj
  apply mul_le_mul_of_nonneg_left _ (le_max_right _ _)
  have hj' : ((j+1:ℕ):ℝ) ≤ m := by exact_mod_cast mem_range.mp hj
  have hw := (mul_le_mul_of_nonneg_right hj' hh).trans h9
  have hi := disk_nonneg (by positivity) hw
  unfold centerCount
  rw [div_eq_mul_inv,div_eq_mul_inv]
  exact mul_le_mul_of_nonneg_right (logBP_order hd 0) hi

/-- The two rays exchange roles when the argument changes sign. Their witness
anchors can be chosen using just the endpoint angles of the box. -/
theorem gamma_on_box {d Q m : ℕ} [NeZero d] (hd : d ≤ Q) (z : ℂ) {h W a b ds df ys yf : ℝ}
    (hm : 0 < m) (hh : 0 < h) (hmh : m*h ≤ 9) (hw : 0 < W ∧ W ≤ 18)
    (hs : m*h+W/2 ≤ ys) (hf : m*h+W/2 ≤ yf) (ha : a ≤ |z.arg|) (hb : |z.arg| ≤ b)
    (hds : 0 < ds ∧ ds ≤ π/2-|z.arg|) (hdf : 0 < df ∧ df ≤ π/2+|z.arg|) :
    gammaBudget d z (signedTiling z m h W ys yf hm hh hmh hw hs hf) ≤
      boxGammaTop Q m h W a b ds df ys yf / Real.sqrt ‖z‖ := by
  have hA : 0 ≤ (m:ℝ)*h := by positivity
  have hK := disk_nonneg (by linarith : 0 ≤ W/2) (by linarith : W/2 ≤ 9)
  have hN := Real.sqrt_nonneg ‖z‖
  have sw (dir e y : ℝ) (he : 0 < e) (hc : e ≤ π/2-dir*z.arg) (hy : 0 < y) :
      rayBound d z dir (m*h) W y ≤ rayCore (logBP Q y) e (m*h) W y/Real.sqrt ‖z‖ := by
    rw [ray_factored]
    exact div_le_div_of_nonneg_right (rayCore_box (logBP_nonneg d y) (logBP_order hd y) he hc hA hw.1 hy hK) hN
  have hc := (box_center (q:=d) hh.le hmh ha hb).trans
    (div_le_div_of_nonneg_right (core_order hd hh.le hmh a b) hN)
  have hys : 0 < ys := by linarith [hw.1]
  have hyf : 0 < yf := by linarith [hw.1]
  by_cases harg : 0 ≤ z.arg
  · rw [abs_of_nonneg harg] at hds hdf
    have hp := sw 1 ds ys hds.1 (by linarith [hds.2]) hys
    have hn := sw (-1) df yf hdf.1 (by linarith [hdf.2]) hyf
    simpa only [gammaBudget,signedTiling,if_pos harg,boxGammaTop,add_div] using add_le_add (add_le_add hc hp) hn
  · rw [abs_of_neg (lt_of_not_ge harg)] at hds hdf
    have hp := sw 1 df yf hdf.1 (by linarith [hdf.2]) hyf
    have hn := sw (-1) ds ys hds.1 (by linarith [hds.2]) hys
    simp only [gammaBudget,signedTiling,if_neg harg,boxGammaTop,add_div]
    linarith only [hc,hp,hn]

#print axioms gamma_on_box
end GoldbachEnergy
