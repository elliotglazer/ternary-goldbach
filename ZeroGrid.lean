module

public import CentralZeros

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

/-- Bound the gamma weight on the pair of cells lo <= |t| <= hi. -/
def cellWeight (z : ℂ) (lo hi : ℝ) : ℝ :=
  min (Real.sqrt (2*π)/Real.sqrt ‖z‖*Real.exp (-((π/2-|z.arg|)*lo)))
    (Real.sqrt (π/Real.cosh (π*lo))/Real.sqrt ‖z‖ * Real.exp (|z.arg| * hi))

theorem gamma_on_cell {z : ℂ} (hz : z ≠ 0) (ha : |z.arg|<π/2)
    {lo hi t : ℝ} (hl : 0≤lo) (hlt : lo≤|t|) (htu : |t| ≤ hi) :
    ‖Complex.Gamma (critical t)*z^(-critical t)‖ ≤ cellWeight z lo hi := by
  apply le_min
  · apply (critical_gamma_rate t hz).trans
    apply mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr _) (by positivity)
    exact neg_le_neg (mul_le_mul_of_nonneg_left hlt (sub_nonneg.mpr ha.le))
  · have hnorm : ‖Complex.Gamma (critical t)‖ ≤ Real.sqrt (π/Real.cosh (π*lo)) := by
      apply Real.le_sqrt_of_sq_le
      rw [critical_gamma_sq]
      apply div_le_div_of_nonneg_left Real.pi_pos.le (Real.cosh_pos _) _
      rw [← Real.cosh_abs (π*t),abs_mul,abs_of_pos Real.pi_pos]
      apply Real.cosh_le_cosh.mpr
      rw [abs_of_nonneg (mul_nonneg Real.pi_pos.le hl),abs_of_nonneg (mul_nonneg Real.pi_pos.le (abs_nonneg _))]
      exact mul_le_mul_of_nonneg_left hlt Real.pi_pos.le
    rw [norm_mul,Complex.norm_cpow_of_ne_zero hz]
    have hre : (-critical t).re = -(1/2:ℝ) := by simp [critical]
    have him : (-critical t).im = -t := by simp [critical]
    rw [hre,him,Real.rpow_neg (norm_nonneg _),← Real.sqrt_eq_rpow,mul_neg,Real.exp_neg,div_inv_eq_mul]
    have he : z.arg*t ≤ |z.arg| * hi := (le_abs_self _).trans (by
      rw [abs_mul]; exact mul_le_mul_of_nonneg_left htu (abs_nonneg _))
    calc _ ≤ Real.sqrt (π/Real.cosh (π*lo))*((Real.sqrt ‖z‖)⁻¹*Real.exp (|z.arg| * hi)) :=
            mul_le_mul hnorm (mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr he) (by positivity)) (by positivity) (by positivity)
         _ = _ := by ring

/-- Differences of consecutive step heights give an additive cover of all nested disks. -/
theorem step_cover (m j : ℕ) (hj : j < m) (w : ℕ → ℝ) (hw : w m=0)
    (x h : ℝ) (hh : 0≤h) (hx : x ≤ (j+1:ℕ)*h) :
    w j ≤ ∑ i ∈ range m, if x ≤ (i+1:ℕ)*h then max (w i - w (i+1)) 0 else 0 := by
  have hsum : (∑ i ∈ Ico j m, (w i-w (i+1)))=w j := by
    rw [sum_Ico_eq_sub _ hj.le,sum_range_sub',sum_range_sub',hw]; ring
  rw [← hsum]
  apply le_trans (b := ∑ i ∈ Ico j m, if x ≤ (i+1:ℕ)*h then max (w i-w (i+1)) 0 else 0)
  · apply sum_le_sum; intro i hi
    have hji := (mem_Ico.mp hi).1
    rw [if_pos (hx.trans (mul_le_mul_of_nonneg_right (by exact_mod_cast Nat.succ_le_succ hji) hh))]
    exact le_max_left _ _
  · apply sum_le_sum_of_subset_of_nonneg (fun k hk => mem_range.mpr (mem_Ico.mp hk).2)
    intro k _ _; split <;> simp

def clippedWeight (m : ℕ) (z : ℂ) (h : ℝ) (i : ℕ) : ℝ :=
  if i < m then cellWeight z (i*h) ((i+1:ℕ)*h) else 0

def gridIncrement (m : ℕ) (z : ℂ) (h : ℝ) (i : ℕ) :=
  max (clippedWeight m z h i-clippedWeight m z h (i+1)) 0

theorem grid_covers (m : ℕ) (hm : 0 < m) {z : ℂ} (hz : z ≠ 0) (ha : |z.arg| < π/2)
    {h t : ℝ} (hh : 0<h) (ht : |t| ≤ m*h) :
    ‖Complex.Gamma (critical t)*z^(-critical t)‖ ≤
      ∑ i ∈ range m, if |t| ≤ (i+1:ℕ)*h then gridIncrement m z h i else 0 := by
  let k := ⌊|t|/h⌋₊
  let j := min k (m-1)
  have hj : j < m := lt_of_le_of_lt (min_le_right _ _) (by omega)
  have hl : (j:ℝ)*h ≤ |t| := (le_div_iff₀ hh).mp ((show (j:ℝ) ≤ k by exact_mod_cast min_le_left k (m-1)).trans
    (Nat.floor_le (div_nonneg (abs_nonneg _) hh.le)))
  have hu : |t| ≤ (j+1:ℕ)*h := by
    by_cases hk : k ≤ m-1
    · dsimp only [j]; rw [min_eq_left hk,Nat.cast_add,Nat.cast_one]
      exact ((div_lt_iff₀ hh).mp (Nat.lt_floor_add_one _)).le
    · dsimp only [j]; rw [min_eq_right (le_of_not_ge hk),Nat.sub_add_cancel (show 1 ≤ m by omega)]
      exact ht
  have hg := gamma_on_cell hz ha (show 0≤(j:ℝ)*h by positivity) hl hu
  have hc := step_cover m j hj (clippedWeight m z h) (by simp [clippedWeight]) |t| h hh.le hu
  rw [show clippedWeight m z h j=cellWeight z (j*h) ((j+1:ℕ)*h) by simp [clippedWeight,hj]] at hc
  exact hg.trans hc

#print axioms grid_covers
end GoldbachEnergy
