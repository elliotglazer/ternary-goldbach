module

public import Mathlib.Analysis.SpecialFunctions.Log.Basic
public import Mathlib.Analysis.Complex.ExponentialBounds
public import Mathlib.Algebra.BigOperators.Group.Finset.Basic
public import Mathlib.Algebra.Order.BigOperators.Group.Finset
public import Mathlib.Algebra.Order.Floor.Ring
public import Mathlib.Tactic.GCongr
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.Positivity

@[expose] public section


/-! Coarse numeric bounds at height H=5·10^14 on the Gaussian zero tails.
The expressions below are the expansions of the definitions BPz2, LWH,
EBg, Z3g, c3g, rhoG and TailBH in calr3/ternary-goldbach. -/
namespace GrhGoldbach.ZeroBudget
open Real Finset

noncomputable def jensenBound (t : ℝ) : ℝ :=
  9200 * (|t|+22) * (1.25*(|t|+11))^9 +
  20 * (|t|+22)^3 * (1.25*(|t|+11))^2

noncomputable def lineWindows (H : ℝ) : ℝ :=
  2 * ∑ m ∈ range (⌊H / 6⌋₊ + 1),
    log (jensenBound (((m:ℝ)+1/2)*6) / 0.355) / log (10/3.36) *
    (1 / max (1/2:ℝ) (6*(m:ℝ)))

noncomputable def highTail (a δ H : ℝ) : ℝ :=
  (2 * exp (δ^2/2 + |a|) * exp (-(δ^2*H^2/2)) / H) *
  (2 * (log (jensenBound H / 0.355) / log (10/3)) / (1 - exp (-(4.4*δ^2*H))) +
   2 * (10 * 4.4 / H / log (10/3)) / (1 - exp (-(4.4*δ^2*H)))^2)

private theorem log_jensen_le {t : ℝ} (h : |t| ≤ 6e14) :
    log (jensenBound t / 0.355) ≤ 2000 := by
  have h₁ : |t| + 22 ≤ 1e15 := by linarith only [h]
  have h₂ : 1.25*(|t|+11) ≤ 1e15 := by linarith only [h]
  have h3 : jensenBound t / 0.355 ≤ (10:ℝ)^160 := by
    unfold jensenBound
    calc
      _ ≤ ((9200*1e15*(1e15)^9 + 20*(1e15)^3*(1e15)^2)/0.355 : ℝ) := by gcongr
      _ ≤ (10:ℝ)^160 := by norm_num
  have hpos : 0 < jensenBound t / 0.355 := by unfold jensenBound; positivity
  have hl := Real.log_le_log hpos h3
  rw [Real.log_pow] at hl
  linarith only [hl, Real.log_le_sub_one_of_pos (by norm_num : (0:ℝ)<10)]

private theorem log_rad_le {r : ℝ} (hr : 2.72 ≤ r) : 1 ≤ log r := by
  apply (Real.le_log_iff_exp_le (by linarith only [hr])).2
  linarith only [Real.exp_one_lt_d9, hr]

/-- A deliberately coarse count suffices because the middle-height tail
starts at δY≥16. The fixed range is bounded symbolically. -/
theorem lineWindows_le : lineWindows (5e14) ≤ 1e18 := by
  have hn : ⌊(5e14:ℝ)/6⌋₊ + 1 ≤ 100000000000000 := by
    apply Nat.succ_le_of_lt
    apply (Nat.floor_lt (by norm_num)).2
    norm_num
  have hr := log_rad_le (r := 10 / 3.36) (by norm_num)
  have hden : 0 < log (10/3.36) := by linarith only [hr]
  unfold lineWindows
  have hs := Finset.sum_le_sum (s := range (⌊(5e14:ℝ)/6⌋₊ + 1))
    (g := fun _ => (4000:ℝ)) (fun m hm => by
      have hm' : m < 100000000000000 := (Finset.mem_range.mp hm).trans_le hn
      have hm'' : (m:ℝ) < 100000000000000 := by exact_mod_cast hm'
      have hm₀ : (0:ℝ) ≤ m := by positivity
      have hmt : |((m:ℝ) + 1/2)*6| ≤ 6e14 := by
        rw [abs_of_nonneg (by positivity)]
        have hle : m ≤ 99999999999999 := by omega
        have hle' : (m:ℝ) ≤ 99999999999999 := by exact_mod_cast hle
        linarith only [hle']
      have hlog : log (jensenBound (((m:ℝ)+1/2)*6) / 0.355) / log (10/3.36) ≤ 2000 :=
        (div_le_iff₀ hden).2 (by linarith only [log_jensen_le hmt, hr])
      have hd := le_max_left (1/2:ℝ) (6*(m:ℝ))
      have hdpos : 0 < max (1/2:ℝ) (6*(m:ℝ)) := by linarith only [hd]
      have hinv : 1 / max (1/2:ℝ) (6*(m:ℝ)) ≤ 2 :=
        (div_le_iff₀ hdpos).2 (by linarith only [hd])
      exact (mul_le_mul hlog hinv (by positivity) (by norm_num)).trans (by norm_num))
  rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul] at hs
  have hn' : ((⌊(5e14:ℝ)/6⌋₊+1 : ℕ):ℝ) ≤ 100000000000000 := by exact_mod_cast hn
  linarith only [hs,hn']

theorem delta_range {v : ℝ} (h : 31000000 ≤ v) (H : v ≤ 31623000000000) :
    8e-14 ≤ 2.8/v ∧ 2.8/v ≤ 1e-7 := by
  have hv : 0 < v := by linarith only [h]
  exact ⟨(le_div_iff₀ hv).2 (by linarith only [H]), (div_le_iff₀ hv).2 (by linarith only [h])⟩

private theorem exp_neg_small {y : ℝ} {n : ℕ} (h : n ≤ y) :
    exp (-y) ≤ 1 / (2:ℝ)^n := by
  rw [Real.exp_neg, ← one_div]
  apply one_div_le_one_div_of_le (by positivity)
  calc
    (2:ℝ)^n ≤ (exp 1)^n := pow_le_pow_left₀ (by norm_num) (by linarith only [Real.exp_one_gt_d9]) n
    _ = exp (n:ℝ) := by rw [← Real.exp_nat_mul]; norm_num
    _ ≤ _ := Real.exp_le_exp.2 h

/-- Middle-zero coefficient in line_sum_midH, including both endpoint exponentials. -/
theorem mid_le {a b δ : ℝ} (ha : a ≤ 0) (hb : b ≤ 0) (hd : 8e-14 ≤ δ) (hd' : δ ≤ 1e-7) :
    exp (δ^2/8) * (exp (a/2)+exp (b/2)) *
      exp (-(δ^2*(2e14:ℝ)^2/2)) * lineWindows 5e14 ≤ 0.001 := by
  have hdp : 0 ≤ δ := by linarith only [hd]
  have he : exp (δ^2/8) ≤ 3 := by
    calc
      _ ≤ exp 1 := Real.exp_le_exp.2 (by nlinarith only [mul_le_mul hd' hd' hdp (by norm_num)])
      _ ≤ _ := by linarith only [Real.exp_one_lt_d9]
  have hpair := add_le_add (Real.exp_le_one_iff.2 (show a/2 ≤ 0 by linarith only [ha]))
    (Real.exp_le_one_iff.2 (show b/2 ≤ 0 by linarith only [hb]))
  have hh : (128:ℝ) ≤ δ^2 * (2e14:ℝ)^2/2 := by
    nlinarith only [mul_le_mul hd hd (by norm_num : (0:ℝ) ≤ 8e-14) hdp]
  have he2 : exp (-(δ^2*(2e14:ℝ)^2/2)) ≤ 1e-38 :=
    (exp_neg_small (n := 128) (by exact_mod_cast hh)).trans (by norm_num)
  calc
    _ ≤ (exp (δ^2/8) * (exp (a/2)+exp (b/2)) * exp (-(δ^2*(2e14:ℝ)^2/2))) * 1e18 :=
      mul_le_mul_of_nonneg_left lineWindows_le (by positivity)
    _ ≤ (3*(1+1)*1e-38) * 1e18 := by gcongr
    _ ≤ _ := by norm_num

/-- Absolute contribution from zeros strictly above H=5·10^14, after the
factor x in the explicit formula. Only δH≥20 is needed in its Gaussian. -/
theorem high_le {a δ x : ℝ} (ha : |a| ≤ 1) (hd : 8e-14 ≤ δ) (hd' : δ ≤ 1e-7)
    (hx : 0 ≤ x) (hX : x ≤ 1e27) : x * highTail a δ (5e14) ≤ 1 := by
  have hdp : 0 ≤ δ := by linarith only [hd]
  have hsq := mul_le_mul hd hd (by norm_num : (0:ℝ) ≤ 8e-14) hdp
  have hsq' := mul_le_mul hd' hd' hdp (by norm_num : (0:ℝ) ≤ 1e-7)
  let d : ℝ := 1 - exp (-(4.4*δ^2*(5e14)))
  have hz : (1e-12:ℝ) ≤ 4.4 * δ^2 * (5e14) := by nlinarith only [hsq]
  have hden : 1e-13 ≤ d := by
    have he := (Real.add_one_le_exp (4.4*δ^2*(5e14)))
    have hfrac := one_div_le_one_div_of_le (by norm_num : (0:ℝ) < 1+1e-12)
      (show 1+1e-12 ≤ exp (4.4*δ^2*(5e14)) by linarith only [he,hz])
    change 1e-13 ≤ 1 - exp (-(4.4*δ^2*(5e14)))
    rw [Real.exp_neg, ← one_div]
    linarith only [hfrac]
  have hdpos : 0 < d := by linarith only [hden]
  have hden2 := mul_le_mul hden hden (by norm_num : (0:ℝ) ≤ 1e-13) hdpos.le
  have hrad := log_rad_le (r := 10/3) (by norm_num)
  have hrpos : 0 < log (10/3) := by linarith only [hrad]
  have hZ : log (jensenBound 5e14 / 0.355) / log (10/3) ≤ 2000 :=
    (div_le_iff₀ hrpos).2 (by
      linarith only [log_jensen_le (t := 5e14) (by norm_num), hrad])
  have hc : 10*4.4/(5e14)/log (10/3) ≤ 1 :=
    (div_le_iff₀ hrpos).2 (by linarith only [hrad])
  have hB1 : 2*(log (jensenBound 5e14 / 0.355) / log (10/3))/d ≤ 4e16 :=
    (div_le_iff₀ hdpos).2 (by linarith only [hZ,hden])
  have hB2 : 2*(10*4.4/(5e14)/log (10/3))/d^2 ≤ 2e26 :=
    (div_le_iff₀ (sq_pos_of_pos hdpos)).2 (by nlinarith only [hc,hden2])
  have hS := add_le_add hB1 hB2
  have hex : exp (δ^2/2 + |a|) ≤ 9 := by
    calc
      _ ≤ exp (1+1) := Real.exp_le_exp.2 (by nlinarith only [ha,hsq'])
      _ = exp 1 * exp 1 := Real.exp_add _ _
      _ ≤ (3:ℝ)*3 := mul_le_mul (by linarith only [Real.exp_one_lt_d9])
        (by linarith only [Real.exp_one_lt_d9]) (Real.exp_pos 1).le (by norm_num)
      _ = _ := by norm_num
  have harg : (200:ℝ) ≤ δ^2*(5e14:ℝ)^2/2 := by nlinarith only [hsq]
  have hg : exp (-(δ^2*(5e14:ℝ)^2/2)) ≤ 1e-60 :=
    (exp_neg_small (n := 200) (by exact_mod_cast harg)).trans (by norm_num)
  have hE : 2 * exp (δ^2/2 + |a|) * exp (-(δ^2*(5e14:ℝ)^2/2)) / 5e14 ≤ 1e-60 := by
    apply (div_le_iff₀ (by norm_num)).2
    calc
      _ ≤ (2*9*1e-60:ℝ) := by gcongr
      _ ≤ (1e-60:ℝ)*5e14 := by norm_num
  unfold highTail
  change x*((2*exp (δ^2/2+|a|)*exp (-(δ^2*(5e14:ℝ)^2/2))/5e14) *
    (2*(log (jensenBound 5e14 / 0.355)/log (10/3))/d +
     2*(10*4.4/5e14/log (10/3))/d^2)) ≤ 1
  calc
    _ ≤ x*((2*exp (δ^2/2+|a|)*exp (-(δ^2*(5e14:ℝ)^2/2))/5e14)*(4e16+2e26)) :=
      mul_le_mul_of_nonneg_left (mul_le_mul_of_nonneg_left hS (by positivity)) hx
    _ ≤ 1e27*(1e-60*(4e16+2e26)) := by gcongr
    _ ≤ _ := by norm_num

#print axioms lineWindows_le
#print axioms mid_le
#print axioms high_le
end GrhGoldbach.ZeroBudget
