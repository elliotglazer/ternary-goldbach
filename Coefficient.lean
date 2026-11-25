module

public import MinorIntegral
public import TernaryGoldbach.Helfgott.NonPrime
public import Arith

@[expose] public section


open MeasureTheory TernaryGoldbach TernaryGoldbach.Helfgott Real Finset ArithmeticFunction
open scoped ArithmeticFunction
namespace GoldbachEnergy

noncomputable def integrand (N : ℕ) (x : ℝ) : ℂ := wave N x ^ 3 * e (-(N*x))

theorem coefficient (N : ℕ) (hn : 0<N) :
    (∫ x in Set.Ioc (0:ℝ) 1, integrand N x).re = tri (amp N) (amp N) (amp N) N := by
  let a := fun n : ℕ => (amp N n : ℂ)
  have hnon (n : ℕ) : 0 ≤ amp N n := mul_nonneg vonMangoldt_nonneg (Real.exp_pos _).le
  have ha : Summable (fun n => ‖a n‖) := by
    simpa [a, Real.norm_eq_abs, abs_of_nonneg (hnon _)] using
      amp_summable N (by exact_mod_cast hn)
  have hx := (circle_identity_tsum N ha ha ha).2
  have hi : (∫ x in Set.Ioc (0:ℝ) 1, integrand N x) =
      ∑ i ∈ range (N+1), ∑ j ∈ range (N+1), ∑ k ∈ range (N+1),
       if i+j+k=N then a i*a j*a k else 0 := by
    simpa only [integrand, wave, expTsum, pow_succ, pow_zero, one_mul, a] using hx
  rw [hi]
  simp [tri, a, ← Complex.ofReal_mul, apply_ite Complex.re]

private noncomputable def bad (n : ℕ) : ℝ := if n.Prime then 0 else Λ n
private theorem bad_nonneg (n : ℕ) : 0 ≤ bad n := by unfold bad; split <;> positivity

private theorem bad_sum (N : ℕ) :
    ∑ n ∈ range (N+1), bad n = Chebyshev.psi N - Chebyshev.theta N := by
  rw [Chebyshev.psi_sub_theta_eq_sum_not_prime, Nat.floor_natCast, sum_filter,
    Nat.range_succ_eq_Icc_zero, ← Finset.Ioc_insert_left (Nat.zero_le N), sum_insert (by simp)]
  simp [bad, Finset.mem_Ioc, ite_not]

private theorem all_sum (N : ℕ) :
    ∑ n ∈ range (N+1), Λ n = Chebyshev.psi N := by
  simp [Chebyshev.psi_eq_sum_Icc, Nat.range_succ_eq_Icc_zero]

private theorem small_nonprime {N : ℕ} (hN : 2*10^19 ≤ N) (h : ¬IsSumOfThreePrimes N) :
    tri (amp N) (amp N) (amp N) N ≤ 12 * (N:ℝ) * √(N:ℝ) * Real.log N^2 := by
  classical
  let f := fun n : ℕ => (Λ n : ℝ)
  have hf (n : ℕ) : 0 ≤ f n := vonMangoldt_nonneg
  have ha (n : ℕ) : amp N n ≤ f n := by
    apply mul_le_of_le_one_right (hf n)
    exact Real.exp_le_one_iff.mpr (div_nonpos_of_nonpos_of_nonneg (neg_nonpos.mpr (Nat.cast_nonneg _)) (Nat.cast_nonneg _))
  have ha0 (n : ℕ) : 0 ≤ amp N n := mul_nonneg (hf _) (exp_pos _).le
  have hp (i j k : ℕ) (hs : i+j+k=N) :
      amp N i*amp N j*amp N k ≤ bad i*f j*f k + f i*bad j*f k + f i*f j*bad k := by
    have hprod := mul_le_mul (mul_le_mul (ha i) (ha j) (ha0 j) (hf i)) (ha k) (ha0 k)
      (mul_nonneg (hf i) (hf j))
    have b1 := mul_nonneg (mul_nonneg (bad_nonneg i) (hf j)) (hf k)
    have b2 := mul_nonneg (mul_nonneg (hf i) (bad_nonneg j)) (hf k)
    have b3 := mul_nonneg (mul_nonneg (hf i) (hf j)) (bad_nonneg k)
    refine hprod.trans ?_
    by_cases hi : i.Prime
    · by_cases hj : j.Prime
      · have hk : ¬k.Prime := fun hp => h ⟨i,j,k,hi,hj,hp,hs⟩
        simp only [bad, hk, if_false, f] at *; linarith
      · simp only [bad, hj, if_false, f] at *; linarith
    · simp only [bad, hi, if_false, f] at *; linarith
  have hu : tri (amp N) (amp N) (amp N) N ≤
      tri bad f f N + tri f bad f N + tri f f bad N := by
    unfold tri
    simp only [← sum_add_distrib]
    refine sum_le_sum fun i _ => sum_le_sum fun j _ => sum_le_sum fun k _ => ?_
    by_cases hs : i+j+k=N <;> simp [hs, hp]
  have hNat : 1 ≤ N := by omega
  have hR : 1 ≤ (N:ℝ) := by exact_mod_cast hNat
  have hnR : 2*(10:ℝ)^19 ≤ N := by exact_mod_cast hN
  have hL := Real.log_nonneg hR
  have hup (n : ℕ) (hn : n ≤ N) : f n ≤ Real.log N := vonMangoldt_le_log_of_le hNat hn
  have h1 := tri_le bad_nonneg hf hf hup
  have h2 := tri_le hf bad_nonneg hf hup
  rw [tri_swap23 f f bad] at hu
  rw [bad_sum, show (∑ n ∈ range (N+1), f n) = Chebyshev.psi N from all_sum N] at h1 h2
  have hb := Chebyshev.psi_sub_theta_le hR
  have hall : Chebyshev.psi N ≤ 2*(N:ℝ) := by linarith [psi_affine (show 0 ≤ (N:ℝ) by positivity)]
  have hb0 : 0 ≤ 2*√(N:ℝ)*Real.log N := by positivity
  have hr := mul_le_mul_of_nonneg_right (mul_le_mul hb hall (Chebyshev.psi_nonneg _) hb0) hL
  rw [mul_comm (Chebyshev.psi N) (Chebyshev.psi N - Chebyshev.theta N)] at h2
  linarith
/-- Once the two arc estimates hold for the actual von Mangoldt wave, all other
parts of the large-case argument, including the prime-power contribution, follow. -/
theorem three_primes_from_arc_bounds {m c : ℝ} (hc : 0 ≤ c)
    (margin : 0.705*c+0.001 ≤ m) (N : ℕ) (hn : 10^20 ≤ N) {E : Set ℝ}
    (hE : MeasurableSet E) (hsub : E ⊆ Set.Ioc 0 1)
    (hminor : ∀ α ∈ E, ‖wave N α‖ ≤ c*N/Real.log N)
    (hmajor : m*(N:ℝ)^2 < (∫ x in Set.Ioc (0:ℝ) 1 \ E, integrand N x).re) :
    IsSumOfThreePrimes N := by
  by_contra h
  have hn0 : 0<N := by omega
  have hr0 : 0<(N:ℝ) := by exact_mod_cast hn0
  have hr : (10:ℝ)^20 ≤ N := by exact_mod_cast hn
  have hu := small_nonprime ((by norm_num : (2:ℕ)*10^19 ≤ 10^20).trans hn) h
  rw [← coefficient N hn0] at hu
  have hL := LeanLab.Zinoviev1997.log_1e20_ge.trans (Real.log_le_log (by norm_num) hr)
  have hcube := LeanLab.Zinoviev1997.cube_lt_exp (Real.log N) hL
  rw [Real.exp_half, Real.exp_log hr0] at hcube
  have hsq : 12*Real.log N^2 ≤ 0.001*√(N:ℝ) := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hL) (sq_nonneg (Real.log N)), Real.sqrt_nonneg (N:ℝ)]
  have hbound : 12 * (N:ℝ) * √(N:ℝ) * Real.log N^2 ≤ 0.001 * (N:ℝ)^2 := by
    have tmp := mul_le_mul_of_nonneg_left hsq (mul_nonneg hr0.le (Real.sqrt_nonneg (N:ℝ)))
    calc _ = ((N:ℝ)*√(N:ℝ))*(12*Real.log N^2) := by ring
         _ ≤ _ := tmp
         _ = _ := by nlinarith only [congrArg (fun y : ℝ => (N:ℝ) * y) (Real.sq_sqrt hr0.le)]
  have hcint : Continuous (integrand N) :=
    ((continuous_wave N hr0).pow 3).mul (continuous_e.comp (continuous_const.mul continuous_id).neg)
  have his : IntegrableOn (integrand N) (Set.Ioc (0:ℝ) 1) volume := hcint.integrableOn_Ioc
  rw [setIntegral_sdiff hE his hsub, Complex.sub_re] at hmajor
  have hm : ‖∫ x in E, integrand N x‖ ≤ (c*0.705) * (N:ℝ)^2 := by
    simpa only [integrand, neg_mul] using minor_integral_scaled hc hr hE hsub hminor
  have hlow := neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans hm)
  linarith [hu.trans hbound, mul_le_mul_of_nonneg_right margin (sq_nonneg (N:ℝ))]

theorem three_primes_from_bounded_arcs {m c : ℝ} (hc : 0 ≤ c)
    (margin : 0.705*c+0.001 ≤ m) (N : ℕ) (hn : 2*10^19 ≤ N) (hx : N ≤ 10^20) {E : Set ℝ}
    (hE : MeasurableSet E) (hsub : E ⊆ Set.Ioc 0 1)
    (hminor : ∀ α ∈ E, ‖wave N α‖ ≤ c*N/Real.log N)
    (hmajor : m*(N:ℝ)^2 < (∫ x in Set.Ioc (0:ℝ) 1 \ E, integrand N x).re) :
    IsSumOfThreePrimes N := by
  by_contra h
  have hn0 : 0<N := by omega
  have hr0 : 0<(N:ℝ) := by exact_mod_cast hn0
  have hr : 2*(10:ℝ)^19 ≤ N := by exact_mod_cast hn
  have hu := small_nonprime hn h
  rw [← coefficient N hn0] at hu
  have hupper : (N:ℝ) ≤ 10^20 := by exact_mod_cast hx
  have hL := Real.log_le_log hr0 hupper
  rw [Real.log_pow] at hL
  norm_num1 at hL
  have hL' : Real.log N ≤ 47 := hL.trans (by linarith only [LeanLab.Zinoviev1997.log_ten_bounds.2])
  have hL0 := Real.log_nonneg (show 1 ≤ (N:ℝ) by linarith)
  have hs : (1000000000:ℝ) ≤ √(N:ℝ) := Real.le_sqrt_of_sq_le (by linarith)
  have hsq : 12*Real.log N^2 ≤ 0.001*√(N:ℝ) := by
    nlinarith only [mul_self_le_mul_self hL0 hL', hs]
  have hbound : 12 * (N:ℝ) * √(N:ℝ) * Real.log N^2 ≤ 0.001 * (N:ℝ)^2 := by
    have tmp := mul_le_mul_of_nonneg_left hsq (mul_nonneg hr0.le (Real.sqrt_nonneg (N:ℝ)))
    calc _ = ((N:ℝ)*√(N:ℝ))*(12*Real.log N^2) := by ring
         _ ≤ _ := tmp
         _ = _ := by nlinarith only [congrArg (fun y : ℝ => (N:ℝ) * y) (Real.sq_sqrt hr0.le)]
  have hcint : Continuous (integrand N) :=
    ((continuous_wave N hr0).pow 3).mul (continuous_e.comp (continuous_const.mul continuous_id).neg)
  have his : IntegrableOn (integrand N) (Set.Ioc (0:ℝ) 1) volume := hcint.integrableOn_Ioc
  rw [setIntegral_sdiff hE his hsub, Complex.sub_re] at hmajor
  have hm : ‖∫ x in E, integrand N x‖ ≤ (c*0.705) * (N:ℝ)^2 := by
    simpa only [integrand, neg_mul] using minor_integral_scaled_from_two_e19 hc hr hE hsub hminor
  have hlow := neg_le_of_abs_le ((Complex.abs_re_le_norm _).trans hm)
  linarith [hu.trans hbound, mul_le_mul_of_nonneg_right margin (sq_nonneg (N:ℝ))]

theorem three_primes_from_arcs (N : ℕ) (hn : 10^20 ≤ N) {E : Set ℝ}
    (hE : MeasurableSet E) (hsub : E ⊆ Set.Ioc 0 1)
    (hminor : ∀ α ∈ E, ‖wave N α‖ ≤ 0.21*N/Real.log N)
    (hmajor : 0.18*(N:ℝ)^2 < (∫ x in Set.Ioc (0:ℝ) 1 \ E, integrand N x).re) :
    IsSumOfThreePrimes N :=
  three_primes_from_arc_bounds (by norm_num : (0:ℝ)≤0.21) (by norm_num : 0.705*(0.21:ℝ)+0.001≤0.18)
    N hn hE hsub hminor hmajor

#print axioms three_primes_from_arc_bounds
#print axioms three_primes_from_arcs
end GoldbachEnergy
