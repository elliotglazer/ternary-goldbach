module

public import SingularWindow
public import TernaryGoldbach.MinorArcs.Montgomery

@[expose] public section


/- The Ramanujan coefficient identity is adapted from Charlie Reams,
MajorArcs/Singular.lean, Apache-2.0, commit 23b2d68ca344203d4384e0aff7affa4ec034bef9. -/
open Finset
open ArithmeticFunction (moebius)
open scoped ArithmeticFunction.Moebius
open TernaryGoldbach (e)
namespace GoldbachSingular
private def unitsBelow (q : ℕ) := (range q).filter (fun b => Nat.Coprime b q)
theorem ramanujan_sum (q n : ℕ) (hq : 1 ≤ q) :
    ∑ a ∈ (range q).filter q.Coprime, e (a * n / q) =
      ∑ d ∈ q.divisors, (μ d : ℂ) * (if q / d ∣ n then ((q / d : ℕ) : ℂ) else 0) := by
  rw [sum_filter]
  have h1 : ∀ a ∈ range q, (if q.Coprime a then e (a * n / q) else 0) =
      ∑ d ∈ q.divisors, if d ∣ a then (μ d : ℂ) * e (a * n / q) else 0 := by
    intro a _
    have hg : 1 ≤ Nat.gcd q a := Nat.gcd_pos_of_pos_left _ (by omega)
    have := TernaryGoldbach.sum_moebius_divisors (Nat.gcd q a) hg
    rw [← sum_filter]
    have hfilt : q.divisors.filter (· ∣ a) = (Nat.gcd q a).divisors := by
      ext d
      simp only [mem_filter, Nat.mem_divisors, Nat.dvd_gcd_iff]
      constructor
      · rintro ⟨⟨h1, _⟩, h2⟩; exact ⟨⟨h1, h2⟩, by omega⟩
      · rintro ⟨⟨h1, h2⟩, _⟩; exact ⟨⟨h1, by omega⟩, h2⟩
    rw [hfilt, ← sum_mul, this]
    simp only [Nat.Coprime]
    split_ifs <;> simp
  rw [sum_congr rfl h1, sum_comm]
  refine sum_congr rfl fun d hd => ?_
  rw [Nat.mem_divisors] at hd
  obtain ⟨⟨m, hm⟩, _⟩ := hd
  have hd0 : 0 < d := Nat.pos_of_ne_zero (by rintro rfl; simp at hm; omega)
  have hm1 : 1 ≤ m := Nat.pos_of_ne_zero (by rintro rfl; simp at hm; omega)
  have hqd : q / d = m := by rw [hm, Nat.mul_div_cancel_left _ hd0]
  rw [← sum_filter, ← mul_sum]
  have himg : (range q).filter (d ∣ ·) = (range m).map ⟨(d * ·), mul_right_injective₀ hd0.ne'⟩ := by
    ext a
    simp only [mem_filter, mem_range, mem_map, Function.Embedding.coeFn_mk]
    constructor
    · rintro ⟨ha, ⟨b, rfl⟩⟩
      exact ⟨b, by rw [hm] at ha; exact (Nat.mul_lt_mul_left hd0).1 ha, rfl⟩
    · rintro ⟨b, hb, rfl⟩
      exact ⟨by rw [hm]; exact (Nat.mul_lt_mul_left hd0).2 hb, dvd_mul_right _ _⟩
  rw [himg, sum_map]
  have h3 : ∀ b ∈ range m, e (((d * b : ℕ) : ℝ) * n / q) = e (b * n / m) := by
    intro b _
    congr 1; rw [hm]; push_cast
    have : (d : ℝ) ≠ 0 := by exact_mod_cast hd0.ne'
    field_simp
  simp only [Function.Embedding.coeFn_mk]
  rw [sum_congr rfl h3, TernaryGoldbach.sum_e_range m n hm1, hqd]

theorem isMultiplicative_divW (n : ℕ) : (divW n).IsMultiplicative := by
  refine ⟨by simp [divW_apply], fun {a b} hab => ?_⟩
  simp only [divW_apply]
  by_cases ha : a ∣ n <;> by_cases hb : b ∣ n
  · rw [if_pos (hab.mul_dvd_of_dvd_of_dvd ha hb), if_pos ha, if_pos hb]; push_cast; ring
  · rw [if_neg (fun h => hb ((dvd_mul_left b a).trans h)), if_neg hb, mul_zero]
  · rw [if_neg (fun h => ha ((dvd_mul_right a b).trans h)), if_neg ha, zero_mul]
  · rw [if_neg (fun h => ha ((dvd_mul_right a b).trans h)), if_neg ha, zero_mul]

theorem moebius_div_mul_moebius {q d : ℕ} (hq : Squarefree q) (hd : d ∣ q) :
    (μ (q / d) : ℝ) * μ q = μ d := by
  obtain ⟨k, rfl⟩ := hd
  have hd0 : 0 < d := Nat.pos_of_ne_zero (by rintro rfl; simp at hq)
  rw [Nat.mul_div_cancel_left _ hd0]
  have hcop : Nat.Coprime d k := Nat.coprime_of_squarefree_mul hq
  rw [ArithmeticFunction.isMultiplicative_moebius.map_mul_of_coprime hcop]
  have hk : Squarefree k := Squarefree.of_mul_right hq
  have : (μ k : ℝ) ^ 2 = 1 := by
    rw [ArithmeticFunction.moebius_apply_of_squarefree hk]; push_cast
    rw [← pow_mul, mul_comm, pow_mul]; norm_num
  push_cast
  linear_combination (μ d : ℝ) * this

/-- **`μ(q) c_q(n) = ∏_{p∣q} (1 − [p∣n] p)`** for squarefree `q`. -/
theorem moebius_mul_ramanujan {q : ℕ} (hq : Squarefree q) (n : ℕ) :
    (μ q : ℂ) * ∑ a ∈ (range q).filter q.Coprime, e (a * n / q) =
      ((∏ p ∈ q.primeFactors, (1 - divW n p) : ℝ) : ℂ) := by
  have hq1 : 1 ≤ q := Nat.pos_of_ne_zero (by rintro rfl; simp at hq)
  rw [ramanujan_sum q n hq1,
    (isMultiplicative_divW n).prodPrimeFactors_one_sub_of_squarefree _ hq, mul_sum]
  push_cast
  rw [← Nat.sum_div_divisors q (fun d => (μ d : ℂ) * ((divW n d : ℝ) : ℂ))]
  refine sum_congr rfl fun d hd => ?_
  have hdq : d ∣ q := Nat.dvd_of_mem_divisors hd
  have hd0 : 0 < d := Nat.pos_of_mem_divisors hd
  have hqd : q / (q / d) = d := Nat.div_div_self hdq (by omega)
  have hm := moebius_div_mul_moebius hq (Nat.div_dvd_of_dvd hdq)
  rw [hqd] at hm
  have hm' : (μ q : ℂ) * μ d = μ (q / d) := by rw [mul_comm]; exact_mod_cast hm
  rw [divW_apply, ← hm']
  split_ifs with h
  · push_cast; ring
  · simp

theorem totient_of_squarefree {q : ℕ} (hq : Squarefree q) :
    (q.totient : ℝ) = ∏ p ∈ q.primeFactors, ((p : ℝ) - 1) := by
  have hq0 : 0 < q := Nat.pos_of_ne_zero (by rintro rfl; simp at hq)
  rw [Nat.totient_eq_div_primeFactors_mul q, Nat.prod_primeFactors_of_squarefree hq,
    Nat.div_self hq0, one_mul]
  push_cast
  refine prod_congr rfl fun p hp => ?_
  have := (Nat.prime_of_mem_primeFactors hp).one_le
  push_cast [Nat.cast_sub this]; ring

theorem moebius_cube {q : ℕ} : (μ q : ℂ) ^ 3 = μ q := by
  by_cases hq : Squarefree q
  · rw [ArithmeticFunction.moebius_apply_of_squarefree hq]; push_cast
    rw [← pow_mul, show ArithmeticFunction.cardFactors q * 3 = ArithmeticFunction.cardFactors q +
      2 * ArithmeticFunction.cardFactors q by ring, pow_add, pow_mul]; norm_num
  · rw [ArithmeticFunction.moebius_eq_zero_of_not_squarefree hq]; simp

theorem e_neg_eq_conj (t : ℝ) : e (-t) = (starRingEnd ℂ) (e t) := by
  unfold TernaryGoldbach.e
  rw [← Complex.exp_conj]; congr 1
  simp only [map_mul, Complex.conj_ofReal, Complex.conj_I, map_ofNat]; push_cast; ring

/-- **The main-term coefficient**: `(μ(q)/φ(q))³ Σ_{b ∈ Bset q} e(−N b/q) = ∏_{p∣q} a_p(N)`. -/
private theorem coef_eq {N q : ℕ} (hq : 1 ≤ q) :
    ((μ q : ℂ) / q.totient) ^ 3 * ∑ b ∈ unitsBelow q, e (-(N * ((b : ℝ) / q))) =
      (coefN N q : ℂ) := by
  unfold coefN
  split_ifs with hsq
  · have hR := moebius_mul_ramanujan hsq N
    have hB : unitsBelow q = (range q).filter q.Coprime := by
      unfold unitsBelow
      exact filter_congr fun b _ => Nat.coprime_comm
    have hsum : ∑ b ∈ unitsBelow q, e (-(N * ((b : ℝ) / q))) =
        (starRingEnd ℂ) (∑ a ∈ (range q).filter q.Coprime, e (a * N / q)) := by
      rw [hB, map_sum]; refine sum_congr rfl fun b _ => ?_
      rw [← e_neg_eq_conj]; congr 1; ring
    have hconj : (μ q : ℂ) * ∑ b ∈ unitsBelow q, e (-(N * ((b : ℝ) / q))) =
        ((∏ p ∈ q.primeFactors, (1 - divW N p) : ℝ) : ℂ) := by
      rw [hsum, show (μ q : ℂ) = (starRingEnd ℂ) (μ q) by simp, ← map_mul, hR, Complex.conj_ofReal]
    rw [div_pow, moebius_cube, div_mul_eq_mul_div, hconj]
    have ht : ((q.totient : ℕ) : ℂ) = ((∏ p ∈ q.primeFactors, ((p : ℝ) - 1) : ℝ) : ℂ) := by
      rw [← totient_of_squarefree hsq]; push_cast; rfl
    rw [ht]
    unfold aP
    rw [prod_div_distrib, prod_pow]
    push_cast; ring
  · rw [ArithmeticFunction.moebius_eq_zero_of_not_squarefree hsq]; simp


noncomputable def fourierCoefficient (N q : ℕ) : ℂ :=
  ((μ q : ℂ) / q.totient)^3 *
    ∑ b ∈ (range q).filter (fun b => Nat.Coprime b q), e (-(N*((b:ℝ)/q)))

theorem truncated_ramanujan_lower {N Q : ℕ} (ho : Odd N) (hQ : 400 ≤ Q) :
    1.25 ≤ (∑ q ∈ Icc 1 Q, fourierCoefficient N q).re := by
  have eq : ∀ q ∈ Icc 1 Q, fourierCoefficient N q = (coefN N q : ℂ) :=
    fun q hq => coef_eq (mem_Icc.mp hq).1
  rw [sum_congr rfl eq, ← Complex.ofReal_sum, Complex.ofReal_re]
  exact truncated_lower ho hQ

theorem full_ramanujan_lower {N : ℕ} (ho : Odd N) :
    1.25 ≤ (∑' j : ℕ, fourierCoefficient N (j+1)).re := by
  have h (j : ℕ) : fourierCoefficient N (j+1) = (coefN N (j+1) : ℂ) := coef_eq (by omega)
  simp_rw [h]
  rw [← Complex.ofReal_tsum, Complex.ofReal_re]
  exact singular_series_lower ho

#print axioms truncated_ramanujan_lower
#print axioms full_ramanujan_lower
end GoldbachSingular
