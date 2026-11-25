module

public import SharpMoment
public import TernaryGoldbach.CircleMethod
public import Mathlib.MeasureTheory.Integral.DominatedConvergence
public import Mathlib.Topology.Algebra.InfiniteSum.Real

@[expose] public section


open MeasureTheory Real Finset Filter ArithmeticFunction TernaryGoldbach
open scoped ArithmeticFunction Topology
noncomputable section
namespace GoldbachEnergy

def amp (N : ℝ) (n : ℕ) : ℝ := Λ n * exp (-(n:ℝ)/N)
def wave (N α : ℝ) : ℂ := ∑' n : ℕ, (amp N n : ℂ) * e (n*α)
private theorem amp_nonneg (N : ℝ) (n : ℕ) : 0 ≤ amp N n :=
  mul_nonneg vonMangoldt_nonneg (exp_pos _).le

private theorem mass (N : ℝ) (hn : 0<N) (k : ℕ) :
    ∑ n ∈ range (k+1), amp N n ≤ 1.6*N+1024 := by
  rw [sum_range_succ']
  simp only [amp, show (Λ 0 : ℝ) = 0 by simp, zero_mul, add_zero]
  have h := mangoldt_weight (1/N) (by positivity) k
  unfold weighted at h
  rw [show (1.6:ℝ)/(1/N) = 1.6*N by field_simp] at h
  apply le_trans (le_of_eq ?_) h
  apply sum_congr rfl; intro n _
  congr 1
  rw [← exp_nat_mul]; congr 1; ring

theorem amp_summable (N : ℝ) (hn : 0<N) : Summable (amp N) := by
  apply summable_of_sum_range_le (amp_nonneg N) (c := 1.6*N+1024)
  intro k; cases k with
  | zero => simp; linarith
  | succ k => exact mass N hn k

theorem continuous_wave (N : ℝ) (hn : 0<N) : Continuous (wave N) := by
  apply continuous_tsum (u := amp N)
  · intro n
    exact continuous_const.mul (continuous_e.comp (continuous_const.mul continuous_id))
  · exact amp_summable N hn
  · intro n α
    simp [norm_e, Real.norm_eq_abs, abs_of_nonneg (amp_nonneg N n)]

theorem partial_energy_sharp_from_two_e19 (N : ℝ) (hn : (2*10^19) ≤ N) (k : ℕ) :
    ∫ α in Set.Ioc (0:ℝ) 1, ‖expSum k (fun n => (amp N n:ℂ)) α‖^2 ≤
      0.705*N*Real.log N := by
  rw [setIntegral_norm_sq_expSum, sum_range_succ']
  simp only [amp, show (Λ 0 : ℝ) = 0 by simp, zero_mul, Complex.ofReal_zero, norm_zero, ne_eq,
    OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, add_zero]
  apply le_trans (le_of_eq ?_) (energy_range_sharp_from_two_e19 N hn k)
  apply sum_congr rfl; intro i _
  rw [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (mul_nonneg vonMangoldt_nonneg (exp_pos _).le), mul_pow,
    ← Real.exp_nat_mul]
  congr 2
  push_cast; ring

theorem partial_energy_sharp (N : ℝ) (hn : 10^20 ≤ N) (k : ℕ) :
    ∫ α in Set.Ioc (0:ℝ) 1, ‖expSum k (fun n => (amp N n:ℂ)) α‖^2 ≤
      0.705*N*Real.log N :=
  partial_energy_sharp_from_two_e19 N ((by norm_num : (2:ℝ)*10^19 ≤ 10^20).trans hn) k

theorem integral_energy_sharp_from_two_e19 (N : ℝ) (hn : (2*10^19) ≤ N) :
    ∫ α in Set.Ioc (0:ℝ) 1, ‖wave N α‖^2 ≤ 0.705*N*Real.log N := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  let s := Set.Ioc (0:ℝ) 1
  let P := fun (k : ℕ) => expSum k (fun n => (amp N n:ℂ))
  have hp (k : ℕ) : Continuous (P k) := continuous_expSum _ _
  have pointwise (α : ℝ) : Tendsto (fun k => P k α) atTop (𝓝 (wave N α)) := by
    have hs : Summable (fun n : ℕ => (amp N n : ℂ)*e (n*α)) := by
      apply Summable.of_norm_bounded (amp_summable N hn0)
      intro n; simp [norm_e, Real.norm_eq_abs, abs_of_nonneg (amp_nonneg N n)]
    exact hs.hasSum.tendsto_sum_nat.comp (tendsto_add_atTop_nat 1)
  have bound (k : ℕ) (α : ℝ) : ‖P k α‖ ≤ 1.6*N+1024 := by
    unfold P expSum
    apply le_trans (norm_sum_le ..)
    simpa only [norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (amp_nonneg _ _)] using mass N hn0 k
  have ht := tendsto_integral_of_dominated_convergence (μ := volume.restrict s)
    (F := fun k α => ‖P k α‖^2) (f := fun α => ‖wave N α‖^2)
    (fun _ => (1.6*N+1024)^2)
    (fun k => ((hp k).norm.pow 2).aestronglyMeasurable)
    (by dsimp [s]; exact integrableOn_const measure_Ioc_lt_top.ne)
    (fun k => ae_of_all _ fun α => by
      rw [Real.norm_eq_abs, abs_of_nonneg (sq_nonneg _)]
      exact pow_le_pow_left₀ (norm_nonneg _) (bound k α) 2)
    (ae_of_all _ fun α => (pointwise α).norm.pow 2)
  exact le_of_tendsto ht (Eventually.of_forall (partial_energy_sharp_from_two_e19 N hn))

theorem integral_energy_sharp (N : ℝ) (hn : 10^20 ≤ N) :
    ∫ α in Set.Ioc (0:ℝ) 1, ‖wave N α‖^2 ≤ 0.705*N*Real.log N :=
  integral_energy_sharp_from_two_e19 N ((by norm_num : (2:ℝ)*10^19 ≤ 10^20).trans hn)

theorem partial_energy (N : ℝ) (hn : 10^20 ≤ N) (k : ℕ) :
    ∫ α in Set.Ioc (0:ℝ) 1, ‖expSum k (fun n => (amp N n:ℂ)) α‖^2 ≤
      0.84*N*Real.log N := by
  apply (partial_energy_sharp N hn k).trans
  gcongr <;> first | (apply Real.log_nonneg; linarith) | linarith | norm_num

theorem integral_energy (N : ℝ) (hn : 10^20 ≤ N) :
    ∫ α in Set.Ioc (0:ℝ) 1, ‖wave N α‖^2 ≤ 0.84*N*Real.log N := by
  apply (integral_energy_sharp N hn).trans
  gcongr <;> first | (apply Real.log_nonneg; linarith) | linarith | norm_num

#print axioms integral_energy_sharp
#print axioms integral_energy
end GoldbachEnergy
