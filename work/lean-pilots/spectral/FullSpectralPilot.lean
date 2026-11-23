import TernaryGoldbach.Explicit.LGrowth
import Mathlib.NumberTheory.LegendreSymbol.ZModChar
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.IntervalCases
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Deriv
import Mathlib.Analysis.Complex.Exponential
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.GCongr
import Mathlib.Analysis.SpecialFunctions.Pow.Complex
import Mathlib.Tactic.FieldSimp
import Mathlib.Analysis.SpecialFunctions.Gamma.BohrMollerup
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Tactic
import Mathlib.Analysis.SpecialFunctions.Gamma.Deligne

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral\CentralChi4.lean

/-! Internal pilot milestone: actual nonprincipal central L-value. -/
noncomputable section
open Complex MeasureTheory Set
open TernaryGoldbach.Explicit
namespace SpectralPilot

def chi4 : DirichletCharacter ℂ 4 :=
  ZMod.χ₄.ringHomComp (Int.castRingHom ℂ)

lemma chi4_nat (n : ℕ) : chi4 (n : ZMod 4) =
    if n % 2 = 0 then 0 else if n % 4 = 1 then 1 else -1 := by
  change ((ZMod.χ₄ (n : ZMod 4) : ℤ) : ℂ) = _
  rw [ZMod.χ₄_nat_eq_if_mod_four]
  split_ifs <;> norm_num

lemma chi4_ne_one : chi4 ≠ 1 := by
  intro h
  have hh := congrArg (fun f : DirichletCharacter ℂ 4 => f (3 : ZMod 4)) h
  have hc : chi4 (3 : ZMod 4) = -1 := by simpa using chi4_nat 3
  rw [hc] at hh
  rw [show (3 : ZMod 4) = -1 by decide] at hh
  norm_num [MulChar.one_apply] at hh

lemma sum_range_chi4 (n : ℕ) :
    (∑ k ∈ Finset.range n, chi4 (k : ZMod 4)) =
      if n % 4 = 2 ∨ n % 4 = 3 then 1 else 0 := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih, chi4_nat]
    have hn : n % 4 < 4 := Nat.mod_lt _ (by decide)
    interval_cases h : n % 4 <;>
      have h2 : n % 2 = (n % 4) % 2 := by omega
    all_goals simp only [h] at h2
    all_goals have h4 : (n + 1) % 4 = (n % 4 + 1) % 4 := by omega
    all_goals norm_num [h, h2, h4]

lemma psum_chi4 (n : ℕ) : psum chi4 n =
    if n % 4 = 1 ∨ n % 4 = 2 then 1 else 0 := by
  have h : (∑ k ∈ Finset.range (n + 1), chi4 (k : ZMod 4)) =
      chi4 (0 : ZMod 4) + psum chi4 n := by
    rw [Finset.sum_range_succ', add_comm, psum]
    congr 1
    rw [Finset.range_eq_Ico, Finset.sum_Ico_add' (fun k : ℕ => chi4 (k : ZMod 4)),
      zero_add, Finset.Ico_add_one_right_eq_Icc]
  have hz : chi4 (0 : ZMod 4) = 0 := by simpa using chi4_nat 0
  rw [hz, zero_add, sum_range_chi4] at h
  rw [← h]
  have hc : ((n + 1) % 4 = 2 ∨ (n + 1) % 4 = 3) ↔
      (n % 4 = 1 ∨ n % 4 = 2) := by omega
  simp only [hc]

def centralIntegrand (t : ℝ) : ℝ :=
  (psum chi4 ⌊t⌋₊).re * t ^ (-(3 / 2 : ℝ))

lemma psum_chi4_real (n : ℕ) :
    psum chi4 n = ((psum chi4 n).re : ℂ) := by
  rw [psum_chi4]
  split_ifs <;> norm_num

lemma psum_chi4_bounds (n : ℕ) :
    0 ≤ (psum chi4 n).re ∧ (psum chi4 n).re ≤ 1 := by
  rw [psum_chi4]
  split_ifs <;> norm_num

lemma centralIntegrand_nonneg {t : ℝ} (ht : 0 ≤ t) :
    0 ≤ centralIntegrand t :=
  mul_nonneg (psum_chi4_bounds _).1 (Real.rpow_nonneg ht _)

lemma centralIntegrand_le {t : ℝ} (ht : 0 ≤ t) :
    centralIntegrand t ≤ t ^ (-(3 / 2 : ℝ)) := by
  exact mul_le_of_le_one_left (Real.rpow_nonneg ht _) (psum_chi4_bounds _).2

lemma central_integrand_complex {t : ℝ} (ht : 0 ≤ t) :
    psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-((1 / 2 : ℂ) + 1)) =
      (centralIntegrand t : ℂ) := by
  rw [psum_chi4_real]
  unfold centralIntegrand
  rw [Complex.ofReal_mul, Complex.ofReal_cpow ht]
  congr 2
  norm_num

lemma centralIntegrand_integrable : IntegrableOn centralIntegrand (Ioi 1) := by
  have h := (integrableOn_integrand chi4_ne_one (by norm_num : 0 < (1 / 2 : ℂ).re)).re
  apply h.congr
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  rw [central_integrand_complex (le_of_lt (lt_trans zero_lt_one ht))]
  rfl

lemma actual_central_integral : chi4.LFunction (1 / 2) =
    ((1 / 2 * ∫ t in Ioi (1 : ℝ), centralIntegrand t : ℝ) : ℂ) := by
  rw [LFunction_eq_mul_Iint chi4_ne_one (by norm_num)]
  unfold Iint
  have he : (∫ t in Ioi (1 : ℝ), psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-((1 / 2 : ℂ) + 1))) =
      ∫ t in Ioi (1 : ℝ), (centralIntegrand t : ℂ) := by
    apply setIntegral_congr_fun measurableSet_Ioi
    intro t ht
    exact central_integrand_complex (le_of_lt (lt_trans zero_lt_one ht))
  rw [he, integral_complex_ofReal, Complex.ofReal_mul]
  norm_num

lemma centralIntegrand_on_initial {t : ℝ} (ht : t ∈ Icc (1 : ℝ) 2) :
    centralIntegrand t = t ^ (-(3 / 2 : ℝ)) := by
  have hf1 : 1 ≤ ⌊t⌋₊ := (Nat.le_floor_iff (by linarith [ht.1])).2 (by simpa using ht.1)
  have hf2 : ⌊t⌋₊ ≤ 2 := Nat.floor_le_of_le ht.2
  have hf : ⌊t⌋₊ = 1 ∨ ⌊t⌋₊ = 2 := by omega
  rcases hf with hf | hf <;> norm_num [centralIntegrand, hf, psum_chi4]

lemma initial_integral : (1 / 2 : ℝ) * ∫ t in (1 : ℝ)..2, centralIntegrand t =
    1 - 1 / Real.sqrt 2 := by
  have he : (∫ t in (1 : ℝ)..2, centralIntegrand t) =
      ∫ t in (1 : ℝ)..2, t ^ (-(3 / 2 : ℝ)) := by
    apply intervalIntegral.integral_congr
    intro t ht
    apply centralIntegrand_on_initial
    simpa only [uIcc_of_le (by norm_num : (1 : ℝ) ≤ 2)] using ht
  rw [he, integral_rpow (Or.inr ⟨by norm_num, by norm_num [uIcc_of_le]⟩)]
  norm_num
  rw [Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 2), ← Real.sqrt_eq_rpow]
  ring

def centralTail : ℝ := (1 / 2) * ∫ t in Ioi (2 : ℝ), centralIntegrand t

lemma central_tail_nonneg : 0 ≤ centralTail := by
  unfold centralTail
  apply mul_nonneg (by norm_num)
  apply integral_nonneg_of_ae
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  exact centralIntegrand_nonneg (le_trans (by norm_num : (0 : ℝ) ≤ 2) ht.le)

lemma central_tail_le : centralTail ≤ 1 / Real.sqrt 2 := by
  have hi : IntegrableOn centralIntegrand (Ioi 2) :=
    centralIntegrand_integrable.mono_set (Ioi_subset_Ioi (by norm_num))
  have hp : IntegrableOn (fun t : ℝ => t ^ (-(3 / 2 : ℝ))) (Ioi 2) :=
    integrableOn_Ioi_rpow_of_lt (by norm_num) (by norm_num)
  have hm := setIntegral_mono_on hi hp measurableSet_Ioi
    (fun t ht => centralIntegrand_le (le_trans (by norm_num : (0 : ℝ) ≤ 2) ht.le))
  have hr := integral_Ioi_rpow_of_lt (by norm_num : -(3 / 2 : ℝ) < -1)
    (by norm_num : (0 : ℝ) < 2)
  rw [hr] at hm
  norm_num at hm
  have he : (2 : ℝ) ^ (-(1 / 2 : ℝ)) = 1 / Real.sqrt 2 := by
    rw [Real.rpow_neg (by norm_num : (0 : ℝ) ≤ 2), ← Real.sqrt_eq_rpow, one_div]
  norm_num [he, div_eq_mul_inv] at hm
  unfold centralTail
  simp only [one_div]
  linarith

lemma actual_central_finite_approximation : chi4.LFunction (1 / 2) =
    ((1 - 1 / Real.sqrt 2 + centralTail : ℝ) : ℂ) := by
  rw [actual_central_integral]
  congr 1
  have hi : IntegrableOn centralIntegrand (Ioi 2) :=
    centralIntegrand_integrable.mono_set (Ioi_subset_Ioi (by norm_num))
  have he := intervalIntegral.integral_interval_add_Ioi centralIntegrand_integrable hi
  rw [← he, mul_add, initial_integral]
  rfl

lemma certified_sqrt_two : (4 / 3 : ℝ) < Real.sqrt 2 := by
  have hs := Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)
  have hn := Real.sqrt_nonneg (2 : ℝ)
  nlinarith only [hs, hn]

/-- A genuine central analytic L-value certificate, not a positive-height throughput pilot. -/
theorem central_chi4_certificate :
    (1 / 4 : ℝ) < (chi4.LFunction (1 / 2)).re ∧
      (chi4.LFunction (1 / 2)).re ≤ 1 ∧ (chi4.LFunction (1 / 2)).im = 0 := by
  rw [actual_central_finite_approximation]
  simp only [Complex.ofReal_re, Complex.ofReal_im]
  have hs := certified_sqrt_two
  have hsp : 0 < Real.sqrt 2 := by linarith
  have hinv : 1 / Real.sqrt 2 < (3 / 4 : ℝ) := (div_lt_iff₀ hsp).2 (by linarith)
  exact ⟨by linarith [central_tail_nonneg], by linarith [central_tail_le], trivial⟩

end SpectralPilot

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral\Elementary.lean

noncomputable section
open Complex Finset
namespace SpectralPilot

def logSeries (x : ℝ) : ℝ := 2 * ∑ i ∈ Finset.range 8, x ^ (2 * i + 1) / (2 * i + 1)

lemma logSeries_error {x : ℝ} (hx0 : 0 ≤ x) (hx : x ≤ 1 / 3) :
    |Real.log ((1 + x) / (1 - x)) - logSeries x| ≤ 1 / 50000000 := by
  have ha : |x| < 1 := by rw [abs_of_nonneg hx0]; linarith
  have h := Real.sum_range_sub_log_div_le ha 8
  rw [abs_of_nonneg hx0] at h
  have hd : (8 / 9 : ℝ) ≤ 1 - x ^ 2 := by nlinarith only [hx0, hx]
  have hp : x ^ 17 ≤ (1 / 3 : ℝ) ^ 17 := pow_le_pow_left₀ hx0 hx 17
  have hb : x ^ 17 / (1 - x ^ 2) ≤ (1 / 3 : ℝ) ^ 17 / (8 / 9) := by
    exact div_le_div₀ (by positivity) hp (by norm_num) hd
  have he : Real.log ((1 + x) / (1 - x)) - logSeries x =
      2 * (1 / 2 * Real.log ((1 + x) / (1 - x)) -
        ∑ i ∈ Finset.range 8, x ^ (2 * i + 1) / (2 * i + 1)) := by
    unfold logSeries
    ring
  rw [he, abs_mul]
  norm_num at h ⊢
  have hc : 2 * ((1 / 3 : ℝ) ^ 17 / (8 / 9)) ≤ 1 / 50000000 := by norm_num
  linarith

def expSeries (z : ℂ) : ℂ := ∑ m ∈ Finset.range 16, z ^ m / m.factorial

lemma expSeries_error {z : ℂ} (hz : ‖z‖ ≤ 2) :
    ‖Complex.exp z - expSeries z‖ ≤ 1 / 10000000 := by
  have h := Complex.exp_bound' (n := 16) (x := z) (by norm_num; linarith)
  have hp : ‖z‖ ^ 16 ≤ (2 : ℝ) ^ 16 := pow_le_pow_left₀ (norm_nonneg _) hz 16
  have hc : (2 : ℝ) ^ 16 / (Nat.factorial 16) * 2 ≤ 1 / 10000000 := by
    norm_num [Nat.factorial]
  exact h.trans ((mul_le_mul_of_nonneg_right
    (div_le_div_of_nonneg_right hp (by positivity)) (by norm_num)).trans hc)

lemma exp_transport {x y : ℂ} (hx : x.re ≤ 0) (hxy : ‖y - x‖ ≤ 1) :
    ‖Complex.exp y - Complex.exp x‖ ≤ 2 * ‖y - x‖ := by
  have he : Complex.exp y - Complex.exp x =
      Complex.exp x * (Complex.exp (y - x) - 1) := by
    rw [mul_sub, ← Complex.exp_add]
    simp only [add_sub_cancel, mul_one]
  rw [he, norm_mul]
  have hn : ‖Complex.exp x‖ ≤ 1 := by
    rw [Complex.norm_exp]
    exact Real.exp_le_one_iff.mpr hx
  exact (mul_le_mul hn (Complex.norm_exp_sub_one_le hxy) (norm_nonneg _)
    (by norm_num)).trans (by simp)

end SpectralPilot

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral\FiniteInputs.lean

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

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral\RoundedInputs.lean
noncomputable section
open Complex
namespace SpectralPilot

def rounded1 : ℂ := (1048576 : ℂ) / 1048576 + Complex.I * (0 / 1048576)
lemma round1_error : ‖powerCenter 1 0 - rounded1‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded1, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input1_error : ‖(1 : ℂ) ^ (-sampleS) - rounded1‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 1) (k := 0) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((1 : ℂ) ^ (-sampleS))
    (powerCenter 1 0) rounded1
  linarith [round1_error]

def rounded3 : ℂ := (603167 : ℂ) / 1048576 + Complex.I * (-51897 / 1048576)
lemma round3_error : ‖powerCenter 3 1 - rounded3‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded3, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input3_error : ‖(3 : ℂ) ^ (-sampleS) - rounded3‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 3) (k := 1) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((3 : ℂ) ^ (-sampleS))
    (powerCenter 3 1) rounded3
  linarith [round3_error]

def rounded5 : ℂ := (465235 : ℂ) / 1048576 + Complex.I * (-58808 / 1048576)
lemma round5_error : ‖powerCenter 5 2 - rounded5‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded5, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input5_error : ‖(5 : ℂ) ^ (-sampleS) - rounded5‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 5) (k := 2) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((5 : ℂ) ^ (-sampleS))
    (powerCenter 5 2) rounded5
  linarith [round5_error]

def rounded7 : ℂ := (391753 : ℂ) / 1048576 + Complex.I * (-60019 / 1048576)
lemma round7_error : ‖powerCenter 7 2 - rounded7‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded7, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input7_error : ‖(7 : ℂ) ^ (-sampleS) - rounded7‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 7) (k := 2) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((7 : ℂ) ^ (-sampleS))
    (powerCenter 7 2) rounded7
  linarith [round7_error]

def rounded9 : ℂ := (344388 : ℂ) / 1048576 + Complex.I * (-59705 / 1048576)
lemma round9_error : ‖powerCenter 9 3 - rounded9‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded9, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input9_error : ‖(9 : ℂ) ^ (-sampleS) - rounded9‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 9) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((9 : ℂ) ^ (-sampleS))
    (powerCenter 9 3) rounded9
  linarith [round9_error]

def rounded11 : ℂ := (310626 : ℂ) / 1048576 + Complex.I * (-58882 / 1048576)
lemma round11_error : ‖powerCenter 11 3 - rounded11‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded11, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input11_error : ‖(11 : ℂ) ^ (-sampleS) - rounded11‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 11) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((11 : ℂ) ^ (-sampleS))
    (powerCenter 11 3) rounded11
  linarith [round11_error]

def rounded13 : ℂ := (285003 : ℂ) / 1048576 + Complex.I * (-57888 / 1048576)
lemma round13_error : ‖powerCenter 13 3 - rounded13‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded13, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input13_error : ‖(13 : ℂ) ^ (-sampleS) - rounded13‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 13) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((13 : ℂ) ^ (-sampleS))
    (powerCenter 13 3) rounded13
  linarith [round13_error]

def rounded15 : ℂ := (264704 : ℂ) / 1048576 + Complex.I * (-56853 / 1048576)
lemma round15_error : ‖powerCenter 15 3 - rounded15‖ ≤ (1 / 1048576 : ℝ) := by
  apply (Complex.norm_le_abs_re_add_abs_im _).trans
  norm_num [rounded15, powerCenter, expSeries, logApprox, logSeries, Finset.sum_range_succ,
    Nat.factorial, sampleS, Complex.mul_re, Complex.mul_im, Complex.div_re, Complex.div_im,
    Complex.normSq, pow_succ]
lemma input15_error : ‖(15 : ℂ) ^ (-sampleS) - rounded15‖ ≤ (1 / 500000 : ℝ) := by
  have hp := powerCenter_error (n := 15) (k := 3) (by norm_num) (by norm_num)
    (by norm_num) (by norm_num) (by norm_num)
  have ht := norm_sub_le_norm_sub_add_norm_sub ((15 : ℂ) ^ (-sampleS))
    (powerCenter 15 3) rounded15
  linarith [round15_error]

def roundedInput (j : Fin 8) : ℂ :=
  ![rounded1, rounded3, rounded5, rounded7, rounded9, rounded11, rounded13, rounded15] j

lemma roundedInput_error (j : Fin 8) :
    ‖((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS) - roundedInput j‖ ≤ (1 / 500000 : ℝ) := by
  fin_cases j
  · simpa [roundedInput] using input1_error
  · simpa [roundedInput] using input3_error
  · simpa [roundedInput] using input5_error
  · simpa [roundedInput] using input7_error
  · simpa [roundedInput] using input9_error
  · simpa [roundedInput] using input11_error
  · simpa [roundedInput] using input13_error
  · simpa [roundedInput] using input15_error

end SpectralPilot

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral-abel\FiniteAbel.lean

/-! Internal finite Abel decomposition pilot. -/
noncomputable section
open Complex MeasureTheory Set
open TernaryGoldbach.Explicit

namespace SpectralAbelPilot

private lemma sum_zeroed (g : ℕ → ℂ) (n : ℕ) :
    (∑ k ∈ Finset.Icc 0 n, if k = 0 then 0 else g k) =
      ∑ k ∈ Finset.Icc 1 n, g k := by
  rw [← Finset.insert_Icc_add_one_left_eq_Icc n.zero_le,
    Finset.sum_insert (by simp)]
  simp only [ite_true, zero_add]
  refine Finset.sum_congr rfl fun k hk => ?_
  rw [ite_eq_right (Nat.ne_of_gt (lt_of_lt_of_le Nat.zero_lt_one (Finset.mem_Icc.mp hk).1))]

lemma finite_abel (g : ℕ → ℂ) (N : ℕ) (s : ℂ) (hs : 0 < s.re) :
    (∑ k ∈ Finset.Icc 1 N, g k * (k : ℂ) ^ (-s)) =
      (∑ k ∈ Finset.Icc 1 N, g k) * (N : ℂ) ^ (-s) +
      s * ∫ t in Ioc (1 : ℝ) N,
        (∑ k ∈ Finset.Icc 1 ⌊t⌋₊, g k) * (t : ℂ) ^ (-(s + 1)) := by
  have hs0 : -s ≠ 0 := neg_ne_zero.mpr (Complex.ne_zero_of_re_pos hs)
  have hd (t : ℝ) (ht : 1 ≤ t) :
      deriv (fun x : ℝ => (x : ℂ) ^ (-s)) t = -s * (t : ℂ) ^ (-(s + 1)) := by
    rw [Complex.deriv_ofReal_cpow_const (lt_of_lt_of_le zero_lt_one ht).ne' hs0]
    congr 2
    ring
  have hc : ContinuousOn (fun t : ℝ => -s * (t : ℂ) ^ (-(s + 1))) (Icc 1 N) := by
    intro t ht
    exact ((Complex.continuousAt_ofReal_cpow_const t _
      (Or.inr (lt_of_lt_of_le zero_lt_one ht.1).ne')).const_mul (-s)).continuousWithinAt
  have hi : IntegrableOn (deriv (fun x : ℝ => (x : ℂ) ^ (-s))) (Icc (1 : ℝ) N) := by
    refine hc.integrableOn_Icc.congr_fun (fun t ht => ?_) measurableSet_Icc
    exact (hd t ht.1).symm
  have hab := sum_mul_eq_sub_integral_mul₀'
    (fun k => if k = 0 then (0 : ℂ) else g k) (by simp) N
    (f := fun x : ℝ => (x : ℂ) ^ (-s))
    (fun t ht => differentiableAt_id.ofReal_cpow_const
      (lt_of_lt_of_le zero_lt_one ht.1).ne' hs0) hi
  simp only [Complex.ofReal_natCast] at hab
  have hleft : (∑ k ∈ Finset.Icc 0 N,
      (k : ℂ) ^ (-s) * (if k = 0 then 0 else g k)) =
      ∑ k ∈ Finset.Icc 1 N, g k * (k : ℂ) ^ (-s) := by
    have he : (fun k : ℕ => (k : ℂ) ^ (-s) * (if k = 0 then 0 else g k)) =
        (fun k => if k = 0 then 0 else g k * (k : ℂ) ^ (-s)) := by
      funext k
      split_ifs <;> simp only [mul_zero, mul_comm]
    rw [he, sum_zeroed]
  rw [hleft, sum_zeroed] at hab
  have hint : (∫ t in Ioc (1 : ℝ) N,
      deriv (fun x : ℝ => (x : ℂ) ^ (-s)) t *
        ∑ k ∈ Finset.Icc 0 ⌊t⌋₊, if k = 0 then 0 else g k) =
      -s * ∫ t in Ioc (1 : ℝ) N,
        (∑ k ∈ Finset.Icc 1 ⌊t⌋₊, g k) * (t : ℂ) ^ (-(s + 1)) := by
    rw [← integral_const_mul]
    refine setIntegral_congr_fun measurableSet_Ioc fun t ht => ?_
    rw [hd t ht.1.le, sum_zeroed]
    ring
  rw [hint] at hab
  calc
    _ = _ := hab
    _ = _ := by ring

theorem LFunction_finite_abel {q : ℕ} [NeZero q]
    {χ : DirichletCharacter ℂ q} (hχ : χ ≠ 1)
    {s : ℂ} (hs : 0 < s.re) {N : ℕ} (hN : 1 ≤ N) :
    χ.LFunction s =
      (∑ k ∈ Finset.Icc 1 N, χ (k : ZMod q) * (k : ℂ) ^ (-s)) -
      psum χ N * (N : ℂ) ^ (-s) +
      s * ∫ t in Ioi (N : ℝ), psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1)) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hi := integrableOn_integrand hχ hs
  have hsplit : Iint χ s =
      (∫ t in Ioc (1 : ℝ) N, psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1))) +
      ∫ t in Ioi (N : ℝ), psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1)) := by
    rw [Iint, ← Ioc_union_Ioi_eq_Ioi hNr, setIntegral_union Ioc_disjoint_Ioi_same
      measurableSet_Ioi]
    · exact hi.mono_set Ioc_subset_Ioi_self
    · exact hi.mono_set (fun t ht => lt_of_le_of_lt hNr ht)
  have hf := finite_abel (fun k => χ (k : ZMod q)) N s hs
  change (∑ k ∈ Finset.Icc 1 N, χ (k : ZMod q) * (k : ℂ) ^ (-s)) =
    psum χ N * (N : ℂ) ^ (-s) +
      s * ∫ t in Ioc (1 : ℝ) N, psum χ ⌊t⌋₊ * (t : ℂ) ^ (-(s + 1)) at hf
  rw [LFunction_eq_mul_Iint hχ hs, hsplit, hf]
  ring

end SpectralAbelPilot

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral\Tail.lean

noncomputable section
open Complex MeasureTheory Set TernaryGoldbach.Explicit
namespace SpectralPilot

lemma sampleS_norm_sharp : ‖sampleS‖ ≤ 33 / 64 := by
  have h := Complex.sq_norm sampleS
  norm_num [sampleS, Complex.normSq, Complex.mul_re, Complex.mul_im] at h
  change ‖sampleS‖ ^ 2 = 1049 / 4096 at h
  nlinarith only [h, norm_nonneg sampleS]

lemma norm_psum_chi4 (n : ℕ) : ‖psum chi4 n‖ ≤ 1 := by
  rw [psum_chi4]
  split_ifs <;> norm_num

def finiteSample : ℂ :=
  ∑ n ∈ Finset.Icc (1 : ℕ) 16, chi4 (n : ZMod 4) * (n : ℂ) ^ (-sampleS)

def sampleTail : ℂ := sampleS * ∫ t in Ioi (16 : ℝ),
  psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-(sampleS + 1))

lemma actual_sample_split : chi4.LFunction sampleS = finiteSample + sampleTail := by
  rw [SpectralAbelPilot.LFunction_finite_abel chi4_ne_one
    (by norm_num [sampleS] : 0 < sampleS.re) (by norm_num : 1 ≤ (16 : ℕ))]
  norm_num [psum_chi4, finiteSample, sampleTail]

lemma sampleTail_bound : ‖sampleTail‖ ≤ 33 / 128 := by
  have hi : IntegrableOn (fun t : ℝ => t ^ (-(3 / 2 : ℝ))) (Ioi 16) :=
    integrableOn_Ioi_rpow_of_lt (by norm_num) (by norm_num)
  have hb : ‖∫ t in Ioi (16 : ℝ), psum chi4 ⌊t⌋₊ *
      (t : ℂ) ^ (-(sampleS + 1))‖ ≤ (1 / 2 : ℝ) := by
    have hpoint : ∀ᵐ (t : ℝ) ∂volume.restrict (Ioi (16 : ℝ)),
        ‖psum chi4 ⌊t⌋₊ * (t : ℂ) ^ (-(sampleS + 1))‖ ≤ t ^ (-(3 / 2 : ℝ)) := by
      filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
      have ht0 : 0 < t := lt_trans (by norm_num : (0 : ℝ) < 16) ht
      rw [norm_mul, norm_cpow_neg ht0]
      norm_num [sampleS]
      exact mul_le_of_le_one_left (Real.rpow_nonneg ht0.le _)
        (norm_psum_chi4 _)
    apply (norm_integral_le_of_norm_le hi hpoint).trans
    rw [integral_Ioi_rpow_of_lt (by norm_num) (by norm_num)]
    norm_num [show (-(3 / 2 : ℝ) + 1) = -(1 / 2 : ℝ) by norm_num,
      Real.rpow_neg, ← Real.sqrt_eq_rpow]
  unfold sampleTail
  rw [norm_mul]
  have := mul_le_mul sampleS_norm_sharp hb (norm_nonneg _) (by norm_num : (0 : ℝ) ≤ 33 / 64)
  norm_num at this ⊢
  exact this

end SpectralPilot

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral\SampleBox.lean

noncomputable section
open Complex
namespace SpectralPilot

def indexedSample : ℂ := ∑ j : Fin 8,
  (-1 : ℂ) ^ j.val * ((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS)

def finiteRounded : ℂ := ∑ j : Fin 8, (-1 : ℂ) ^ j.val * roundedInput j

lemma finiteSample_eq_indexed : finiteSample = indexedSample := by
  norm_num [finiteSample, indexedSample, Fin.sum_univ_succ,
    Finset.sum_Icc_succ_top, Finset.Icc_self, chi4_nat]
  ring

lemma finiteRounded_eval : finiteRounded =
    (572952 : ℂ) / 1048576 + Complex.I * (51250 / 1048576) := by
  norm_num [finiteRounded, roundedInput, Fin.sum_univ_succ, rounded1, rounded3,
    rounded5, rounded7, rounded9, rounded11, rounded13, rounded15]
  ring

lemma finiteSample_rounding_error : ‖finiteSample - finiteRounded‖ ≤ (1 / 62500 : ℝ) := by
  rw [finiteSample_eq_indexed]
  unfold indexedSample finiteRounded
  rw [← Finset.sum_sub_distrib]
  have hp (j : Fin 8) :
      ‖(-1 : ℂ) ^ j.val * ((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS) -
        (-1 : ℂ) ^ j.val * roundedInput j‖ ≤ (1 / 500000 : ℝ) := by
    rw [← mul_sub, norm_mul]
    simpa using roundedInput_error j
  calc
    _ ≤ ∑ j : Fin 8, ‖(-1 : ℂ) ^ j.val * ((2 * j.val + 1 : ℕ) : ℂ) ^ (-sampleS) -
        (-1 : ℂ) ^ j.val * roundedInput j‖ := norm_sum_le _ _
    _ ≤ ∑ _j : Fin 8, (1 / 500000 : ℝ) := Finset.sum_le_sum (fun j _ => hp j)
    _ = _ := by norm_num

lemma actual_sample_disk : ‖chi4.LFunction sampleS - finiteRounded‖ ≤
    (33 / 128 + 1 / 62500 : ℝ) := by
  rw [actual_sample_split]
  have he : finiteSample + sampleTail - finiteRounded =
      (finiteSample - finiteRounded) + sampleTail := by ring
  rw [he]
  exact (norm_add_le _ _).trans (by linarith [finiteSample_rounding_error, sampleTail_bound])

/-- Actual positive-height L enclosure, obtained from certified finite inputs and the source tail. -/
theorem actual_sample_box : (1 / 4 : ℝ) < (chi4.LFunction sampleS).re ∧
    |(chi4.LFunction sampleS).im| < (1 / 2 : ℝ) := by
  have hr := (Complex.abs_re_le_norm (chi4.LFunction sampleS - finiteRounded)).trans actual_sample_disk
  have hi := (Complex.abs_im_le_norm (chi4.LFunction sampleS - finiteRounded)).trans actual_sample_disk
  rw [finiteRounded_eval] at hr hi
  norm_num at hr hi
  have hr' := abs_le.mp hr
  have hi' := abs_le.mp hi
  constructor
  · linarith
  · rw [abs_lt]
    constructor <;> linarith

end SpectralPilot

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral-completion\GammaEnclosure.lean

open MeasureTheory Set
open scoped Real

namespace SpectralCompletion

lemma gamma_between_one_two {x : ℝ} (h1 : 1 ≤ x) (h2 : x ≤ 2) :
    Real.Gamma x ≤ 1 := by
  have h := Real.convexOn_Gamma.2 (by norm_num : (1 : ℝ) ∈ Ioi 0)
    (by norm_num : (2 : ℝ) ∈ Ioi 0) (by linarith : 0 ≤ 2-x)
    (by linarith : 0 ≤ x-1) (by ring : (2-x)+(x-1)=1)
  have hG : Real.Gamma 2 = 1 := by
    simpa using (Real.Gamma_add_one (by norm_num : (1 : ℝ) ≠ 0))
  simp only [smul_eq_mul, Real.Gamma_one, hG] at h
  convert h using 1 <;> congr 1 <;> ring

lemma gamma_real_bounds :
    (16/15 : ℝ) ≤ Real.Gamma (3/4) ∧ Real.Gamma (3/4) ≤ 4/3 ∧
      Real.Gamma (1/4) ≤ 4 ∧ Real.Gamma (5/4) ≤ 1 := by
  have h7 := gamma_between_one_two (x := 7/4) (by norm_num) (by norm_num)
  have h5 := gamma_between_one_two (x := 5/4) (by norm_num) (by norm_num)
  have hrec7 := Real.Gamma_add_one (by norm_num : (3/4 : ℝ) ≠ 0)
  have hrec5 := Real.Gamma_add_one (by norm_num : (1/4 : ℝ) ≠ 0)
  norm_num only [show (3/4:ℝ)+1=7/4 by norm_num,
    show (1/4:ℝ)+1=5/4 by norm_num] at hrec7 hrec5
  have hc := Real.convexOn_Gamma.2 (by norm_num : (3/4 : ℝ) ∈ Ioi 0)
    (by norm_num : (7/4 : ℝ) ∈ Ioi 0)
    (by norm_num : (0:ℝ) ≤ 3/4) (by norm_num : (0:ℝ) ≤ 1/4)
    (by norm_num : (3/4:ℝ)+1/4=1)
  norm_num [smul_eq_mul, Real.Gamma_one] at hc
  constructor
  · linarith
  constructor
  · linarith
  constructor
  · linarith
  · exact h5

lemma abs_log_le_half_powers {x : ℝ} (hx : 0 < x) :
    |Real.log x| ≤ x^(1/2:ℝ)+x^(-1/2:ℝ) := by
  have hp := Real.two_mul_le_exp (x := Real.log x / 2)
  have hn := Real.two_mul_le_exp (x := -Real.log x / 2)
  rw [Real.rpow_def_of_pos hx, Real.rpow_def_of_pos hx]
  have e1 : Real.log x * (1/2:ℝ) = Real.log x / 2 := by ring
  have e2 : Real.log x * (-1/2:ℝ) = -Real.log x / 2 := by ring
  rw [e1, e2]
  apply abs_le.mpr
  constructor <;> nlinarith only [hp, hn, Real.exp_pos (Real.log x/2),
    Real.exp_pos (-Real.log x/2)]

lemma cpow_vertical_factor {x : ℝ} (hx : 0 < x) (a b : ℝ) :
    (x:ℂ)^((a:ℂ)+Complex.I*b-1) =
      (x^(a-1):ℝ) * Complex.exp (Complex.I * (b*Real.log x : ℝ)) := by
  have hxC : (x:ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr hx.ne'
  rw [show (a:ℂ)+Complex.I*b-1 = ((a-1:ℝ):ℂ)+Complex.I*b by push_cast; ring,
    Complex.cpow_add _ _ hxC, ← Complex.ofReal_cpow hx.le,
    Complex.cpow_def_of_ne_zero hxC, ← Complex.ofReal_log hx.le]
  congr 2
  push_cast
  ring

lemma gamma_integrand_difference_bound {x : ℝ} (hx : 0 < x) (a b : ℝ) :
    ‖(Real.exp (-x):ℂ)*(x:ℂ)^((a:ℂ)+Complex.I*b-1) -
       (Real.exp (-x):ℂ)*(x:ℂ)^((a:ℂ)-1)‖ ≤
    |b| *(Real.exp (-x)*x^(a-1+1/2) + Real.exp (-x)*x^(a-1-1/2)) := by
  rw [cpow_vertical_factor hx,
    show (a:ℂ)-1 = ((a-1:ℝ):ℂ) by push_cast; rfl,
    ← Complex.ofReal_cpow hx.le]
  rw [show (Real.exp (-x):ℂ)*((x^(a-1):ℝ)*Complex.exp (Complex.I*(b*Real.log x:ℝ))) -
      (Real.exp (-x):ℂ)*(x^(a-1):ℝ) =
      ((Real.exp (-x)*x^(a-1):ℝ):ℂ)*(Complex.exp (Complex.I*(b*Real.log x:ℝ))-1) by
        push_cast; ring,
    norm_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg (mul_nonneg (Real.exp_pos _).le (Real.rpow_nonneg hx.le _))]
  calc
    _ ≤ (Real.exp (-x)*x^(a-1))*|b *Real.log x| :=
      mul_le_mul_of_nonneg_left (by simpa only [Real.norm_eq_abs] using
        (Real.norm_exp_I_mul_ofReal_sub_one_le (x := b*Real.log x)))
        (mul_nonneg (Real.exp_pos _).le (Real.rpow_nonneg hx.le _))
    _ ≤ (Real.exp (-x)*x^(a-1))*(|b| *(x^(1/2:ℝ)+x^(-1/2:ℝ))) := by
      rw [abs_mul]
      gcongr
      exact abs_log_le_half_powers hx
    _ = _ := by
      rw [Real.rpow_add hx, sub_eq_add_neg (a-1) (1/2), Real.rpow_add hx]
      ring

lemma gamma_vertical_difference :
    ‖Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128)) - (Real.Gamma (3/4):ℂ)‖ ≤ 25/128 := by
  have hi1 := Complex.GammaIntegral_convergent
    (s := (3/4:ℂ)+Complex.I*(5/128)) (by norm_num)
  have hi0 := Complex.GammaIntegral_convergent (s := (3/4:ℂ)) (by norm_num)
  have hp := Real.GammaIntegral_convergent (s := 5/4) (by norm_num)
  have hm := Real.GammaIntegral_convergent (s := 1/4) (by norm_num)
  rw [← Complex.Gamma_ofReal, Complex.Gamma_eq_integral (by norm_num :
    0 < ((3/4:ℂ)+Complex.I*(5/128)).re),
    Complex.Gamma_eq_integral (by norm_num : 0 < ((3/4:ℝ):ℂ).re)]
  unfold Complex.GammaIntegral
  simp only [Complex.ofReal_div, Complex.ofReal_ofNat]
  rw [← integral_sub hi1 hi0]
  calc
      _ ≤ ∫ x in Ioi (0:ℝ), (5/128:ℝ)*
          (Real.exp (-x)*x^(5/4-1:ℝ)+Real.exp (-x)*x^(1/4-1:ℝ)) := by
        apply norm_integral_le_of_norm_le ((hp.add hm).const_mul (5/128:ℝ))
        filter_upwards [ae_restrict_mem measurableSet_Ioi] with x hx
        convert gamma_integrand_difference_bound hx (3/4) (5/128) using 1 <;> norm_num
      _ = (5/128:ℝ)*(Real.Gamma (5/4)+Real.Gamma (1/4)) := by
        rw [integral_const_mul, integral_add hp hm,
          ← Real.Gamma_eq_integral (by norm_num : (0:ℝ)<5/4),
          ← Real.Gamma_eq_integral (by norm_num : (0:ℝ)<1/4)]
      _ ≤ 25/128 := by
        have h := gamma_real_bounds
        linarith only [h.2.2.1, h.2.2.2]

noncomputable def gammaPhase : ℂ :=
  Complex.exp (Complex.I * (((5/128)*Real.log (4/Real.pi):ℝ):ℂ)) *
    Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))

lemma phase_abs_le : |(5/128:ℝ)*Real.log (4/Real.pi)| ≤ 5/384 := by
  have hpi := Real.pi_gt_three
  have hpi4 := Real.pi_lt_four
  have hp : 0 < 4/Real.pi := div_pos (by norm_num) Real.pi_pos
  have h1 : 1 ≤ 4/Real.pi := (le_div_iff₀ Real.pi_pos).mpr (by linarith)
  have h4 : 4/Real.pi < 4/3 := (div_lt_iff₀ Real.pi_pos).mpr (by linarith)
  rw [abs_of_nonneg (mul_nonneg (by norm_num) (Real.log_nonneg h1))]
  have hlog := Real.log_le_sub_one_of_pos hp
  linarith

lemma gammaPhase_distance :
    ‖gammaPhase - (Real.Gamma (3/4):ℂ)‖ ≤ 245/1152 := by
  let e := Complex.exp (Complex.I * (((5/128)*Real.log (4/Real.pi):ℝ):ℂ))
  let g := (Real.Gamma (3/4):ℂ)
  have he : ‖e‖ = 1 := Complex.norm_exp_I_mul_ofReal _
  have he1 : ‖e-1‖ ≤ 5/384 :=
    (Real.norm_exp_I_mul_ofReal_sub_one_le).trans (by
      simpa only [Real.norm_eq_abs] using phase_abs_le)
  have hg : ‖g‖ ≤ 4/3 := by
    dsimp [g]
    rw [Complex.norm_real, Real.norm_eq_abs,
      abs_of_pos (Real.Gamma_pos_of_pos (by norm_num : (0:ℝ)<3/4))]
    exact gamma_real_bounds.2.1
  have hid : gammaPhase-g =
      e*(Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))-g)+(e-1)*g := by
    dsimp [gammaPhase, e]; ring
  rw [hid]
  calc
    _ ≤ ‖e*(Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))-g)‖+‖(e-1)*g‖ := norm_add_le _ _
    _ = ‖Complex.Gamma ((3/4:ℂ)+Complex.I*(5/128))-g‖+‖e-1‖*‖g‖ := by
      rw [norm_mul, norm_mul, he, one_mul]
    _ ≤ (25/128:ℝ)+(5/384)*(4/3) := add_le_add gamma_vertical_difference
      (mul_le_mul he1 hg (norm_nonneg _) (by norm_num))
    _ = _ := by norm_num

theorem gammaPhase_enclosure :
    (3/4:ℝ) ≤ gammaPhase.re ∧ |gammaPhase.im| ≤ 1/4 := by
  have hd := gammaPhase_distance
  have hr := Complex.abs_re_le_norm (gammaPhase - (Real.Gamma (3/4):ℂ))
  have hi := Complex.abs_im_le_norm (gammaPhase - (Real.Gamma (3/4):ℂ))
  simp only [Complex.sub_re, Complex.ofReal_re] at hr
  simp only [Complex.sub_im, Complex.ofReal_im, sub_zero] at hi
  have hlo := gamma_real_bounds.1
  constructor
  · have hh := (abs_le.mp (hr.trans hd)).1
    linarith
  · linarith

end SpectralCompletion



-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral-completion\CompletionFactor.lean

namespace SpectralCompletion

noncomputable def samplePoint : ℂ := (1/2:ℂ)+Complex.I*(5/64)

noncomputable def completionScale : ℝ :=
  Real.exp (Real.log 4 / 4 - 3 * Real.log Real.pi / 4)

theorem completionScale_pos : 0 < completionScale := Real.exp_pos _

theorem completion_factor_eq :
    (4:ℂ)^(samplePoint/2) * Complex.Gammaℝ (samplePoint+1) =
      (completionScale:ℂ)*gammaPhase := by
  have hp : (Real.pi:ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr Real.pi_ne_zero
  have harg : (samplePoint+1)/2 = (3/4:ℂ)+Complex.I*(5/128) := by
    dsimp [samplePoint]; ring
  rw [Complex.Gammaℝ_def, harg]
  dsimp [completionScale, gammaPhase]
  rw [Complex.cpow_def_of_ne_zero (by norm_num : (4:ℂ) ≠ 0),
    Complex.cpow_def_of_ne_zero hp]
  rw [Complex.ofReal_exp]
  rw [← mul_assoc, ← Complex.exp_add]
  rw [← mul_assoc, ← Complex.exp_add]
  congr 2
  rw [← Complex.ofReal_log Real.pi_pos.le,
    show Complex.log (4:ℂ) = (Real.log 4:ℂ) by
      simpa only [Complex.ofReal_ofNat] using
        (Complex.ofReal_log (by norm_num : (0:ℝ)≤4)).symm]
  rw [Real.log_div (by norm_num : (4:ℝ)≠0) Real.pi_ne_zero]
  dsimp [samplePoint]
  push_cast
  ring

theorem completed_product_positive {L : ℂ}
    (hLre : (1/4:ℝ) < L.re) (hLim : |L.im| < 1/2) :
    0 < ((4:ℂ)^(samplePoint/2) * (Complex.Gammaℝ (samplePoint+1)*L)).re := by
  rw [← mul_assoc, completion_factor_eq, mul_assoc, Complex.re_ofReal_mul]
  apply mul_pos completionScale_pos
  rw [Complex.mul_re]
  have hg := gammaPhase_enclosure
  have hLpos : 0 < L.re := by linarith
  have hre : (3/4:ℝ)*L.re ≤ gammaPhase.re*L.re :=
    mul_le_mul_of_nonneg_right hg.1 hLpos.le
  have him : gammaPhase.im*L.im ≤ |gammaPhase.im| *|L.im| :=
    (le_abs_self _).trans_eq (abs_mul _ _)
  have hib : |gammaPhase.im| *|L.im| ≤ (1/4:ℝ)*(1/2) :=
    mul_le_mul hg.2 hLim.le (abs_nonneg _) (by norm_num)
  linarith

end SpectralCompletion


-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral-reality\Chi4Reality.lean

/-! Internal pilot: actual completed chi4 function is real on the critical line. -/
noncomputable section
open Complex MeasureTheory Set
open scoped ComplexConjugate
open TernaryGoldbach.Explicit SpectralPilot

namespace SpectralRealityPilot

lemma chi4_odd : chi4.Odd := by
  change chi4 (-1) = -1
  rw [show (-1 : ZMod 4) = (3 : ℕ) by decide, chi4_nat]
  norm_num

lemma chi4_inverse : chi4⁻¹ = chi4 := by
  apply MulChar.ext'
  intro x
  rw [MulChar.inv_apply_eq_inv']
  have h := chi4_nat x.val
  rw [ZMod.natCast_zmod_val] at h
  rw [h]
  split_ifs <;> norm_num

lemma chi4_primitive : chi4.IsPrimitive := by
  have hd := DirichletCharacter.conductor_dvd_level chi4
  have hp := DirichletCharacter.conductor_ne_zero chi4
  have hle : chi4.conductor ≤ 4 := Nat.le_of_dvd (by decide) hd
  have h1 : chi4.conductor ≠ 1 := by
    intro h
    exact chi4_ne_one (DirichletCharacter.eq_one_iff_conductor_eq_one.mpr h)
  have h2 : chi4.conductor ≠ 2 := by
    intro h
    have hf : chi4.FactorsThrough 2 := h ▸ DirichletCharacter.factorsThrough_conductor chi4
    obtain ⟨hd2, ψ, hψ⟩ := hf
    have he : chi4 (-1) = ψ (-1) := by
      rw [hψ]
      exact DirichletCharacter.changeLevel_eq_cast_of_dvd' ψ hd2 (a := -1) (by norm_num)
    rw [chi4_odd, show (-1 : ZMod 2) = 1 by decide, map_one] at he
    norm_num at he
  change chi4.conductor = 4
  interval_cases h : chi4.conductor <;> omega

lemma chi4_completed_central_ne_zero : chi4.completedLFunction (1 / 2) ≠ 0 := by
  intro hz
  have h := DirichletCharacter.LFunction_eq_completed_div_gammaFactor chi4 (1 / 2)
    (Or.inr (by decide))
  rw [hz, zero_div] at h
  have hp := central_chi4_certificate.1
  rw [h] at hp
  norm_num at hp

lemma chi4_rootNumber : chi4.rootNumber = 1 := by
  have h := chi4_primitive.completedLFunction_one_sub (1 / 2)
  rw [chi4_inverse, show (1 : ℂ) - 1 / 2 = 1 / 2 by ring,
    sub_self, Complex.cpow_zero, one_mul] at h
  apply mul_right_cancel₀ chi4_completed_central_ne_zero
  simpa only [one_mul] using h.symm

lemma real_cpow_conjugate {t : ℝ} (ht : 0 < t) (z : ℂ) :
    (t : ℂ) ^ conj z = conj ((t : ℂ) ^ z) := by
  have ha : (t : ℂ).arg ≠ Real.pi := by
    rw [Complex.arg_ofReal_of_nonneg ht.le]
    exact Real.pi_pos.ne
  simpa only [Complex.conj_ofReal] using Complex.cpow_conj (t : ℂ) z ha

lemma chi4_LFunction_conjugate {s : ℂ} (hs : 0 < s.re) :
    chi4.LFunction (conj s) = conj (chi4.LFunction s) := by
  rw [LFunction_eq_mul_Iint chi4_ne_one (by simpa using hs),
    LFunction_eq_mul_Iint chi4_ne_one hs, map_mul]
  congr 1
  rw [Iint, Iint, ← integral_conj]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro t ht
  dsimp only
  have hp : conj (psum chi4 ⌊t⌋₊) = psum chi4 ⌊t⌋₊ := by
    rw [psum_chi4_real]
    simp only [Complex.conj_ofReal]
  rw [map_mul, hp]
  congr 1
  simpa only [map_neg, map_add, map_one] using
    real_cpow_conjugate (lt_trans zero_lt_one ht) (-(s + 1))

lemma chi4_completed_eq {s : ℂ} (hs : 0 < s.re) :
    chi4.completedLFunction s = chi4.LFunction s * Complex.Gammaℝ (s + 1) := by
  have h := DirichletCharacter.LFunction_eq_completed_div_gammaFactor chi4 s
    (Or.inr (by decide))
  rw [chi4_odd.gammaFactor_def] at h
  have hg : Complex.Gammaℝ (s + 1) ≠ 0 :=
    Complex.Gammaℝ_ne_zero_of_re_pos (by
      simp only [Complex.add_re, Complex.one_re]
      linarith only [hs])
  exact ((eq_div_iff hg).mp h).symm

lemma chi4_completed_conjugate {s : ℂ} (hs : 0 < s.re) :
    chi4.completedLFunction (conj s) = conj (chi4.completedLFunction s) := by
  rw [chi4_completed_eq (by simpa using hs), chi4_completed_eq hs,
    map_mul, chi4_LFunction_conjugate hs]
  congr 1
  rw [show conj s + 1 = conj (s + 1) by simp only [map_add, map_one], Complex.Gammaℝ_conj]

theorem normalized_completed_chi4_real (t : ℝ) :
    ((4 : ℂ) ^ (((1 / 2 : ℂ) + I * t) / 2) *
      chi4.completedLFunction ((1 / 2 : ℂ) + I * t)).im = 0 := by
  let s : ℂ := 1 / 2 + I * t
  have hs : 0 < s.re := by simp [s]
  have hsc : conj s = 1 - s := by
    apply Complex.ext <;> norm_num [s]
  have hf := chi4_primitive.completedLFunction_one_sub s
  rw [chi4_inverse, chi4_rootNumber, mul_one] at hf
  norm_num only [Nat.cast_ofNat] at hf
  have hpow : (4 : ℂ) ^ conj (s / 2) = conj ((4 : ℂ) ^ (s / 2)) := by
    simpa only [Complex.ofReal_ofNat] using
      real_cpow_conjugate (by norm_num : (0 : ℝ) < 4) (s / 2)
  have hc : conj ((4 : ℂ) ^ (s / 2) * chi4.completedLFunction s) =
      (4 : ℂ) ^ (s / 2) * chi4.completedLFunction s := by
    rw [map_mul, ← chi4_completed_conjugate hs, ← hpow]
    rw [map_div₀, map_ofNat, hsc, hf]
    rw [← mul_assoc, ← Complex.cpow_add _ _ (by norm_num : (4 : ℂ) ≠ 0)]
    congr 2
    ring
  have him := congrArg Complex.im hc
  simp only [Complex.conj_im] at him
  change ((4 : ℂ) ^ (s / 2) * chi4.completedLFunction s).im = 0
  linarith only [him]

end SpectralRealityPilot

-- BEGIN OWN SOURCE C:\Users\glaze\Documents\Codex\2026-11-10\https-github-com-sthubbar-goldbach-lean\work\lean-pilots\spectral\PositiveHeight.lean

noncomputable section
open Complex
namespace SpectralPilot

/-- Strict sign and exact reality of the actual conductor-normalized completion at the first
positive coarse sample. All finite input, tail, rounding and completion bounds are proved. -/
theorem positive_height_chi4_certificate :
    0 < (((4 : ℂ) ^ (((1 / 2 : ℂ) + I * (5 / 64)) / 2)) *
      chi4.completedLFunction ((1 / 2 : ℂ) + I * (5 / 64))).re ∧
    (((4 : ℂ) ^ (((1 / 2 : ℂ) + I * (5 / 64)) / 2)) *
      chi4.completedLFunction ((1 / 2 : ℂ) + I * (5 / 64))).im = 0 := by
  constructor
  · change 0 < ((4 : ℂ) ^ (sampleS / 2) * chi4.completedLFunction sampleS).re
    rw [SpectralRealityPilot.chi4_completed_eq (by norm_num [sampleS])]
    rw [mul_comm (chi4.LFunction sampleS) (Complex.Gammaℝ (sampleS + 1))]
    exact SpectralCompletion.completed_product_positive actual_sample_box.1 actual_sample_box.2
  · simpa using SpectralRealityPilot.normalized_completed_chi4_real (5 / 64 : ℝ)

end SpectralPilot
