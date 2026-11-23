import LocalPowers
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-! Scalar bounds and extraction of a prime from the local weighted mass. -/

namespace GrhGoldbach.LocalAssembly
open Real Finset
open scoped ArithmeticFunction.vonMangoldt

theorem sqrt_range {x : ℝ} (hx : 10^15 ≤ x) (hX : x ≤ 10^27) :
    31000000 ≤ √x ∧ √x ≤ 31623000000000 := by
  have h : 0 ≤ x := by linarith only [hx]
  exact ⟨(Real.le_sqrt (by norm_num) h).mpr (by linarith only [hx]),
    Real.sqrt_le_iff.mpr ⟨by norm_num, by linarith only [hX]⟩⟩

/-- Lower bound on `x * Mg(a,b,δ,1)` in the real form of `Mg_one`. -/
theorem main_lower {v : ℝ} (hv : 31000000 ≤ v) :
    100.9996 * v ≤
      v ^ 2 * (exp ((2.8/v)^2 / 2) * (exp (-12.6/v) - exp (-113.6/v))) := by
  have hp : 0 < v := by linarith only [hv]
  have hab : -12.6/v = (-113.6/v) + 101/v := by ring
  have hdelta := Real.add_one_le_exp (101/v)
  have hlin := Real.add_one_le_exp (-113.6/v)
  have hdiff : exp (-113.6/v) * (101/v) ≤ exp (-12.6/v) - exp (-113.6/v) := by
    rw [hab, Real.exp_add]
    nlinarith only [mul_le_mul_of_nonneg_left hdelta (Real.exp_pos (-113.6/v)).le]
  have hdiff0 : 0 ≤ exp (-12.6/v) - exp (-113.6/v) := le_trans (by positivity) hdiff
  have h1 := (Real.one_le_exp_iff).2 (show 0 ≤ (2.8/v)^2 / 2 by positivity)
  have hmono := le_mul_of_one_le_left hdiff0 h1
  have hlog : -0.0000038 ≤ -113.6 / v := (le_div_iff₀ hp).2 (by linarith only [hv])
  have he : 100.9996 ≤ 101 * exp (-113.6/v) := by linarith only [hlin,hlog]
  calc
    _ ≤ (101 * exp (-113.6/v)) * v := mul_le_mul_of_nonneg_right he hp.le
    _ = v ^ 2 * (exp (-113.6/v) * (101/v)) := by field_simp
    _ ≤ _ := mul_le_mul_of_nonneg_left (hdiff.trans hmono) (sq_nonneg _)

private theorem exp_small {y : ℝ} (hy : 0 ≤ y) (hy' : y ≤ 0.0001) : exp y ≤ 1.001 := by
  refine (Real.exp_bound_div_one_sub_of_interval hy (by linarith only [hy'])).trans ?_
  rw [div_le_iff₀ (by linarith only [hy'])]
  linarith only [hy']

/-- After substitution `δv = 2.8`, the real coefficient of the left
vertical contour is at most 255. The factor 253.3 is `PsiRange.Vc_le`. -/
theorem vertical_le {v : ℝ} (hv : 31000000 ≤ v) :
    253.3 * exp ((2.8/v)^2/8) * (exp (6.3/v) + exp (56.8/v)) / 2.8 ≤ 255 := by
  have hp : 0 < v := by linarith only [hv]
  have hd : 2.8 / v ≤ 0.0001 := (div_le_iff₀ hp).2 (by linarith only [hv])
  have hd0 : 0 ≤ 2.8 / v := by positivity
  have hd2 := mul_le_mul hd hd hd0 (by norm_num)
  have h1 := exp_small (by positivity : 0 ≤ (2.8/v)^2 / 8) (by nlinarith only [hd2])
  have h2 := exp_small (by positivity : 0 ≤ 6.3/v)
    ((div_le_iff₀ hp).2 (by linarith only [hv]))
  have h3 := exp_small (by positivity : 0 ≤ 56.8/v)
    ((div_le_iff₀ hp).2 (by linarith only [hv]))
  have h := mul_le_mul (mul_le_mul_of_nonneg_left h1 (by norm_num : (0:ℝ) ≤ 253.3))
    (add_le_add h2 h3) (by positivity) (by norm_num)
  exact (div_le_iff₀ (by norm_num)).2 (h.trans (by norm_num))

/-- Elementary closure at n=x+4. The analytic premise is the lower
bound on the von Mangoldt sum already restricted to the exact window. -/
theorem prime_of_inner_mass {x : ℝ} (hx : 10^15 ≤ x) (hX : x ≤ 10^27)
    (w : ℕ → ℝ) (hw : ∀ n, w n ≤ 1)
    (hm : 362880 <
      ∑ n ∈ Ioc ⌊x * exp (-(126.2/√x))⌋₊ ⌊x⌋₊, Λ n * w n) :
    ∃ p : ℕ, p.Prime ∧ x - 4000000000000000 + 4 < p ∧ (p : ℝ) ≤ x := by
  have h0 : 0 < x := by linarith only [hx]
  have hv := Real.sqrt_pos.2 h0
  let A := ⌊x * exp (-(126.2/√x))⌋₊
  let B := ⌊x⌋₊
  have hnon := GrhGoldbach.LocalPowers.gaussian_nonprime_mass_le hx hX w hw
  have hex : ∃ p ∈ Ioc A B, Nat.Prime p := by
    by_contra! h
    have heq : (Ioc A B).filter (fun n => ¬ n.Prime) = Ioc A B :=
      Finset.filter_true_of_mem h
    change ∑ n ∈ (Ioc A B).filter (fun n => ¬n.Prime), Λ n * w n ≤ _ at hnon
    rw [heq] at hnon
    exact (not_lt_of_ge hnon) hm
  obtain ⟨p, hpm, hpp⟩ := hex
  obtain ⟨ha, hb⟩ := mem_Ioc.mp hpm
  have huv := (sqrt_range hx hX).2
  have hl := mul_le_mul_of_nonneg_left (Real.add_one_le_exp (-(126.2/√x))) h0.le
  have hre : x * (-(126.2/√x) + 1) = x - 126.2 * √x := by
    field_simp [hv.ne']
    nlinarith only [Real.sq_sqrt h0.le]
  rw [hre] at hl
  have ha' : x * exp (-(126.2/√x)) < p := (Nat.floor_lt (by positivity)).mp ha
  exact ⟨p, hpp, by linarith only [hl, huv, ha'], (Nat.le_floor_iff h0.le).mp hb⟩

/-- Convert a lower bound on the complete smoothed sum plus an upper
bound on its mass outside the interval into a prime in the target window. -/
theorem prime_of_budgets {x main low mid high vertical smoothed : ℝ}
    (hx : 10^15 ≤ x) (hX : x ≤ 10^27)
    (w : ℕ → ℝ) (hw : ∀ n, w n ≤ 1)
    (hmain : 100.9996 * √x ≤ main) (hlow : low ≤ 98.977 * √x)
    (hmid : mid ≤ 0.001 * √x) (hhigh : high ≤ 1) (hvertical : vertical ≤ 255)
    (herror : main - (low + mid + high + vertical) ≤ smoothed)
    (hleak : smoothed - (∑ n ∈ Ioc ⌊x * exp (-(126.2/√x))⌋₊ ⌊x⌋₊, Λ n * w n)
      ≤ 0.511 * √x) :
    ∃ p : ℕ, p.Prime ∧ x - 4000000000000000 + 4 < p ∧ (p : ℝ) ≤ x := by
  apply prime_of_inner_mass hx hX w hw
  linarith only [(sqrt_range hx hX).1, hmain, hlow, hmid, hhigh, hvertical, herror, hleak]

#print axioms main_lower
#print axioms vertical_le
#print axioms prime_of_budgets

end GrhGoldbach.LocalAssembly
