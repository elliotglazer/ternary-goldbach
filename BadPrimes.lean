module

public import FourierEnergy

@[expose] public section


open Real Finset ArithmeticFunction
open scoped ArithmeticFunction
noncomputable section
namespace GoldbachEnergy

def badLambda (q n : ℕ) : ℝ := if n.Coprime q then 0 else Λ n

private theorem badLambda_nonneg (q n : ℕ) : 0 ≤ badLambda q n := by
  unfold badLambda; split <;> simp

/-- Each relevant prime power at most k is a divisor of q^{floor(log_2 k)}. -/
theorem bad_pre (q k : ℕ) (hq : 0<q) :
    pre (badLambda q) k ≤ (Nat.log 2 k:ℝ)*Real.log q := by
  let j := Nat.log 2 k
  let D := (q^j).divisors
  have hle (n : ℕ) (hn : n ≤ k) :
      badLambda q n ≤ if n ∈ D then Λ n else 0 := by
    by_cases hc : n.Coprime q
    · rw [badLambda,if_pos hc]; split
      · exact vonMangoldt_nonneg
      · exact le_rfl
    by_cases hm : Λ n = 0
    · simp [badLambda,hm]
    obtain ⟨e,he,_,p,_,rfl,hp⟩ := (isPrimePow_nat_iff_bounded_log _).mp (vonMangoldt_ne_zero_iff.mp hm)
    have hpq : p ∣ q := by
      by_contra h; exact hc ((hp.coprime_iff_not_dvd.mpr h).pow_left _)
    have hej : e ≤ j := he.trans (Nat.log_monotone hn)
    have hd : p^e ∈ D := Nat.mem_divisors.mpr
      ⟨(pow_dvd_pow p hej).trans (pow_dvd_pow_of_dvd hpq j),pow_ne_zero _ hq.ne'⟩
    simp [badLambda,hc,hd]
  have hz : badLambda q 0 = 0 := by simp [badLambda]
  have heq : pre (badLambda q) k = ∑ n ∈ range (k+1), badLambda q n := by
    simp [pre,sum_range_succ',hz]
  rw [heq]
  calc _ ≤ ∑ n ∈ range (k+1), if n ∈ D then Λ n else 0 :=
            sum_le_sum fun n hn => hle n (by have := mem_range.mp hn; omega)
       _ = ∑ n ∈ (range (k+1)).filter (· ∈ D), Λ n := (sum_filter ..).symm
       _ ≤ ∑ n ∈ D, Λ n := sum_le_sum_of_subset_of_nonneg
            (fun n hn => (mem_filter.mp hn).2) (fun _ _ _ => vonMangoldt_nonneg)
       _ = _ := by rw [show D=(q^j).divisors from rfl,vonMangoldt_sum,Nat.cast_pow,Real.log_pow]

/-- Total exponentially weighted mass discarded by restriction to units modulo q. -/
theorem bad_mass (q : ℕ) (hq : 0<q) {N : ℝ} (hN : 1 ≤ N) :
    ∑' n : ℕ, badLambda q n*Real.exp (-(n:ℝ)/N) ≤
      (Real.log q/Real.log 2)*(1+Real.log N) := by
  let C := Real.log q/Real.log 2
  have hN0 : 0<N := by linarith
  have hl2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hq0 : 0 ≤ Real.log (q:ℝ) := Real.log_nonneg (by exact_mod_cast hq)
  have hC : 0 ≤ C := div_nonneg hq0 hl2.le
  have hpre (k : ℕ) : pre (badLambda q) k ≤ C/N*k + C*Real.log N := by
    rcases k.eq_zero_or_pos with rfl|hk
    · simp [pre]; exact mul_nonneg hC (Real.log_nonneg hN)
    have hk' : (0:ℝ)<k := by exact_mod_cast hk
    have hl := Real.log_le_log (by positivity : 0<(2:ℝ)^(Nat.log 2 k))
      (show (2:ℝ)^(Nat.log 2 k) ≤ k by exact_mod_cast Nat.pow_log_le_self 2 hk.ne')
    rw [Real.log_pow] at hl
    have ht := Real.log_le_sub_one_of_pos (div_pos hk' hN0)
    rw [Real.log_div hk'.ne' hN0.ne'] at ht
    have hh := mul_le_mul_of_nonneg_left (show Real.log k ≤ k/N+Real.log N by linarith) hC
    have hbase : (Nat.log 2 k:ℝ)*Real.log q ≤ C*Real.log k := by
      dsimp [C]; rw [div_mul_eq_mul_div,le_div_iff₀ hl2]
      nlinarith only [mul_le_mul_of_nonneg_right hl hq0]
    apply (bad_pre q k hq).trans (hbase.trans (hh.trans_eq _))
    ring
  apply Real.tsum_le_of_sum_range_le (fun n => mul_nonneg (badLambda_nonneg q n) (Real.exp_pos _).le)
  intro k; cases k with
  | zero => simpa using mul_nonneg hC (show 0≤1+Real.log N by linarith [Real.log_nonneg hN])
  | succ k =>
    have h := weighted_exp (t := 1/N) (one_div_pos.mpr hN0) (div_nonneg hC hN0.le) hpre k
    have hz : badLambda q 0=0 := by simp [badLambda]
    rw [sum_range_succ']; simp only [hz,zero_mul,add_zero]
    unfold weighted at h
    calc _ = ∑ i ∈ range k, badLambda q (i+1)*Real.exp (-(1/N))^(i+1) := by
           apply sum_congr rfl; intro i _; rw [← Real.exp_nat_mul]; congr 2; push_cast; ring
         _ ≤ _ := h
         _ = _ := by change C/N/(1/N)+C*Real.log N = C*(1+Real.log N); field_simp

#print axioms bad_mass
end GoldbachEnergy
