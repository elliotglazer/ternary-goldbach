import Elementary
import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.Tactic.FieldSimp

noncomputable section
open Complex
namespace SpectralPilot

def logApprox (n k : ℕ) : ℝ :=
  k * logSeries (1 / 3) + logSeries (((n : ℝ) - 2 ^ k) / (n + 2 ^ k))

lemma logApprox_error {n k : ℕ} (hn : 0 < n) (hk : k ≤ 3)
    (hlo : (2 : ℝ) ^ k ≤ n) (hhi : (n : ℝ) ≤ 2 * 2 ^ k) :
    |Real.log n - logApprox n k| ≤ 1 / 10000000 := by
  let a : ℝ := 2 ^ k
  have ha : 0 < a := by dsimp [a]; positivity
  have hnr : (0 : ℝ) < n := by exact_mod_cast hn
  have hd : 0 < (n : ℝ) + a := by positivity
  let x : ℝ := ((n : ℝ) - a) / (n + a)
  have hx0 : 0 ≤ x := div_nonneg (sub_nonneg.mpr hlo) hd.le
  have hx : x ≤ 1 / 3 := (div_le_iff₀ hd).2 (by dsimp [a] at *; linarith)
  have hratio : (1 + x) / (1 - x) = (n : ℝ) / a := by
    dsimp [x]
    field_simp [ha.ne', hd.ne']
    ring
  have h2 := logSeries_error (x := 1 / 3) (by norm_num) le_rfl
  norm_num at h2
  have hy := logSeries_error hx0 hx
  rw [hratio, Real.log_div hnr.ne' ha.ne', Real.log_pow] at hy
  have he : Real.log n - logApprox n k =
      (Real.log n - k * Real.log 2 - logSeries x) +
        k * (Real.log 2 - logSeries (1 / 3)) := by
    dsimp [logApprox, x, a]
    ring
  rw [he]
  calc
    _ ≤ |Real.log n - k * Real.log 2 - logSeries x| +
        |(k : ℝ) * (Real.log 2 - logSeries (1 / 3))| := abs_add_le _ _
    _ ≤ 1 / 50000000 + (k : ℝ) * (1 / 50000000) := by
      rw [abs_mul, show |(k : ℝ)| = k from abs_of_nonneg (Nat.cast_nonneg k)]
      exact add_le_add hy (mul_le_mul_of_nonneg_left h2 (Nat.cast_nonneg _))
    _ ≤ 1 / 10000000 := by
      have hkr : (k : ℝ) ≤ 3 := by exact_mod_cast hk
      linarith

def sampleS : ℂ := (1 / 2) + Complex.I * (5 / 64)
def powerCenter (n k : ℕ) : ℂ := expSeries (-sampleS * (logApprox n k : ℂ))

lemma sampleS_norm : ‖sampleS‖ ≤ 3 / 5 := by
  have h := Complex.norm_le_abs_re_add_abs_im sampleS
  norm_num [sampleS] at h ⊢
  linarith

lemma log_nat_le_three {n : ℕ} (hn : 0 < n) (hN : n ≤ 16) : Real.log n < 3 := by
  apply (Real.log_lt_iff_lt_exp (by exact_mod_cast hn)).2
  have h := Real.sum_le_exp_of_nonneg (by norm_num : (0 : ℝ) ≤ 3) 5
  norm_num [Finset.sum_range_succ, Nat.factorial] at h
  have hnr : (n : ℝ) ≤ 16 := by exact_mod_cast hN
  linarith

lemma powerCenter_error {n k : ℕ} (hn : 0 < n) (hN : n ≤ 16) (hk : k ≤ 3)
    (hlo : (2 : ℝ) ^ k ≤ n) (hhi : (n : ℝ) ≤ 2 * 2 ^ k) :
    ‖(n : ℂ) ^ (-sampleS) - powerCenter n k‖ ≤ 3 / 10000000 := by
  have hl := logApprox_error hn hk hlo hhi
  have hlog0 : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast hn)
  have hlog := log_nat_le_three hn hN
  have habs := abs_le.mp hl
  have hlA : |logApprox n k| ≤ 3 + 1 / 10000000 := by
    rw [abs_le]
    constructor <;> linarith
  let x : ℂ := -sampleS * (Real.log n : ℂ)
  let y : ℂ := -sampleS * (logApprox n k : ℂ)
  have hexy : ‖y - x‖ ≤ (3 / 5 : ℝ) * (1 / 10000000) := by
    have he : y - x = -sampleS * ((logApprox n k - Real.log n : ℝ) : ℂ) := by
      dsimp [x, y]; push_cast; ring
    rw [he, norm_mul, norm_neg, Complex.norm_real, Real.norm_eq_abs, abs_sub_comm]
    exact mul_le_mul sampleS_norm hl (abs_nonneg _) (by norm_num)
  have hx : x.re ≤ 0 := by
    dsimp [x, sampleS]
    simp only [Complex.mul_re, Complex.neg_re, Complex.neg_im, Complex.add_re,
      Complex.add_im, Complex.div_re, Complex.div_im, Complex.one_re, Complex.one_im,
      Complex.I_re, Complex.I_im,
      Complex.ofReal_re, Complex.ofReal_im]
    norm_num [Complex.normSq]
    linarith
  have hy : ‖y‖ ≤ 2 := by
    dsimp [y]
    rw [norm_mul, norm_neg, Complex.norm_real, Real.norm_eq_abs]
    have := mul_le_mul sampleS_norm hlA (abs_nonneg _) (by norm_num : (0 : ℝ) ≤ 3 / 5)
    linarith
  have ht := exp_transport hx (hexy.trans (by norm_num))
  have hp := expSeries_error hy
  have hcp : (n : ℂ) ^ (-sampleS) = Complex.exp x := by
    rw [Complex.cpow_def_of_ne_zero (by exact_mod_cast (Nat.ne_of_gt hn))]
    rw [← Complex.ofReal_natCast, ← Complex.ofReal_log (by positivity : (0 : ℝ) ≤ n)]
    congr 1
    dsimp [x]
    ring
  rw [hcp]
  change ‖Complex.exp x - expSeries y‖ ≤ _
  have hs := norm_sub_le_norm_sub_add_norm_sub (Complex.exp x) (Complex.exp y) (expSeries y)
  rw [norm_sub_rev (Complex.exp x) (Complex.exp y)] at hs
  linarith

end SpectralPilot
