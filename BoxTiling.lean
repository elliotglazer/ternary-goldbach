module

public import CellSeries
public import BoxRay

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def signedTiling (z : ℂ) (m : ℕ) (h W ys yf : ℝ) (hm : 0 < m) (hh : 0 < h)
    (hmh : m*h ≤ 9) (hw : 0 < W ∧ W ≤ 18) (hs : m*h+W/2 ≤ ys) (hf : m*h+W/2 ≤ yf) :
    ZeroTiling where
  cells := m
  step := h
  wp := W
  wm := W
  yp := if 0 ≤ z.arg then ys else yf
  ym := if 0 ≤ z.arg then yf else ys
  cells_pos := hm
  step_pos := hh
  radius_le := hmh
  pos_tail := ⟨hw.1,hw.2,by split <;> assumption⟩
  neg_tail := ⟨hw.1,hw.2,by split <;> assumption⟩

def coreSum (q : ℕ) (m : ℕ) (h lo hi : ℝ) : ℝ :=
  ∑ j ∈ range m, max (clippedScaled m hi h j-clippedScaled m lo h (j+1)) 0 * centerCount q ((j+1:ℕ)*h)

theorem disk_nonneg {w : ℝ} (hw : 0 ≤ w) (h9 : w ≤ 9) : 0 ≤ invDisk w := by
  apply inv_nonneg.mpr
  apply le_of_lt
  apply log_ratio_pos (by positivity)
  apply (Real.sqrt_lt' (by norm_num)).mpr
  nlinarith only [sq_le_sq' (by linarith : -(9:ℝ) ≤ w) h9]

theorem box_center {q m : ℕ} [NeZero q] {h lo hi : ℝ} {z : ℂ} (hh : 0 ≤ h) (h9 : m*h ≤ 9)
    (ha : lo ≤ |z.arg|) (hb : |z.arg| ≤ hi) :
    (∑ j ∈ range m, gridIncrement m z h j * centerCount q ((j+1:ℕ)*h)) ≤
      coreSum q m h lo hi / Real.sqrt ‖z‖ := by
  rw [coreSum,Finset.sum_div]
  apply sum_le_sum
  intro j hj
  have hj' : ((j+1:ℕ):ℝ) ≤ m := by exact_mod_cast mem_range.mp hj
  have hw := (mul_le_mul_of_nonneg_right hj' hh).trans h9
  have hI := disk_nonneg (by positivity) hw
  have hJ : 0 ≤ Real.log (BP q 0/0.355) := Real.log_nonneg (by
    rw [le_div_iff₀ (by norm_num),one_mul]; exact (by norm_num : (0.355:ℝ) ≤ 1400).trans (one_le_BP (N:=q) 0))
  have hc : 0 ≤ centerCount q ((j+1:ℕ)*h) := by
    dsimp only [centerCount]; rw [div_eq_mul_inv]; exact mul_nonneg hJ hI
  apply (mul_le_mul_of_nonneg_right (grid_box (i:=j) (m:=m) ha hb hh) hc).trans
  apply le_of_eq; ring

#print axioms signedTiling
#print axioms box_center
end GoldbachEnergy
