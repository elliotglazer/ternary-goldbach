module

public import Mathlib
public import GoldbachVersionAliases

@[expose] public section

/- Adapted from Charlie Reams, Ternary Goldbach in Lean 4, Apache-2.0,
commit 23b2d68ca344203d4384e0aff7affa4ec034bef9,
MajorArcs/Singular.lean and Prelim/MertensProduct.lean. -/
open Finset
namespace GoldbachSingular
theorem sum_inv_mul_pred_le {a b : ℕ} (ha : 1 ≤ a) (hab : a ≤ b) :
    ∑ n ∈ Ioc a b, (1 : ℝ) / (n * (n - 1)) ≤ 1 / a - 1 / b := by
  induction b with
  | zero => omega
  | succ b ih =>
    rcases Nat.lt_or_ge a (b + 1) with h | h
    · have hab' : a ≤ b := by omega
      rw [sum_Ioc_succ_top hab']
      have := ih hab'
      have hb : (0 : ℝ) < b := by exact_mod_cast (by omega : 0 < b)
      have e : (1 : ℝ) / (((b : ℝ) + 1) * ((b : ℝ) + 1 - 1)) = 1 / b - 1 / (b + 1) := by
        rw [show (b : ℝ) + 1 - 1 = b by ring]; field_simp; ring
      push_cast; rw [e]; linarith
    · have : a = b + 1 := by omega
      subst this; simp

noncomputable def divW (n : ℕ) : ArithmeticFunction ℝ :=
  ⟨fun d => if d ∣ n then (d : ℝ) else 0, by simp⟩

theorem divW_apply (n d : ℕ) : divW n d = if d ∣ n then (d : ℝ) else 0 := rfl

noncomputable def aP (N p : ℕ) : ℝ := (1 - divW N p) / ((p : ℝ) - 1) ^ 3

/-- `μ(q) c_q(N)/φ(q)³ = ∏_{p∣q} a_p(N)` for squarefree `q`, `0` otherwise. -/
noncomputable def coefN (N q : ℕ) : ℝ := if Squarefree q then ∏ p ∈ q.primeFactors, aP N p else 0

theorem divW_two_of_odd {N : ℕ} (hN : Odd N) : divW N 2 = 0 := by
  rw [divW_apply, if_neg]; exact fun h => (Nat.not_even_iff_odd.2 hN) (even_iff_two_dvd.2 h)

theorem coefN_two_mul {N : ℕ} (hN : Odd N) (q : ℕ) : coefN N (2 * q) = if Odd q then coefN N q else 0 := by
  split_ifs with ho
  · have hcop : Nat.Coprime 2 q := (Nat.coprime_two_left).2 ho
    have hsq : Squarefree (2 * q) ↔ Squarefree q := by
      rw [Nat.squarefree_mul hcop]; simp [Nat.squarefree_two]
    unfold coefN
    by_cases h : Squarefree q
    · rw [if_pos (hsq.2 h), if_pos h, Nat.primeFactors_mul (by norm_num) (by rintro rfl; simp at ho),
        Nat.Prime.primeFactors Nat.prime_two]
      have h2 : 2 ∉ q.primeFactors := fun hm =>
        (Nat.not_even_iff_odd.2 ho) (even_iff_two_dvd.2 (Nat.dvd_of_mem_primeFactors hm))
      rw [show ({2} : Finset ℕ) ∪ q.primeFactors = insert 2 q.primeFactors by rfl, prod_insert h2]
      unfold aP; rw [divW_two_of_odd hN]; norm_num
    · rw [if_neg (fun h' => h (hsq.1 h')), if_neg h]
  · have he : Even q := Nat.not_odd_iff_even.1 ho
    obtain ⟨k, rfl⟩ := he
    have hns : ¬Squarefree (2 * (k + k)) := by
      intro hs
      have h4 : 2 * 2 ∣ 2 * (k + k) := ⟨k, by ring⟩
      have := hs 2 h4
      norm_num at this
    unfold coefN; rw [if_neg hns]

def oddPrimes (R : ℕ) : Finset ℕ := (Icc 3 R).filter Nat.Prime

theorem mem_oddPrimes {R p : ℕ} : p ∈ oddPrimes R ↔ (3 ≤ p ∧ p ≤ R) ∧ p.Prime := by
  unfold oddPrimes; rw [mem_filter, mem_Icc]

theorem sum_odd_sqfree_eq (g : ℕ → ℝ) (R : ℕ) :
    ∑ q ∈ (Icc 1 R).filter Odd, (if Squarefree q then ∏ p ∈ q.primeFactors, g p else 0) =
      ∑ t ∈ (oddPrimes R).powerset.filter (fun t => ∏ p ∈ t, p ≤ R), ∏ p ∈ t, g p := by
  have e1 : ∑ q ∈ (Icc 1 R).filter Odd, (if Squarefree q then ∏ p ∈ q.primeFactors, g p else 0) =
      ∑ q ∈ ((Icc 1 R).filter Odd).filter Squarefree, ∏ p ∈ q.primeFactors, g p := by
    symm; rw [sum_filter]
  rw [e1]
  refine sum_bij' (fun q _ => q.primeFactors) (fun t _ => ∏ p ∈ t, p) ?_ ?_ ?_ ?_ ?_
  · intro q hq
    simp only [mem_filter, mem_Icc] at hq
    obtain ⟨⟨⟨h1, h2⟩, ho⟩, hsq⟩ := hq
    rw [mem_filter, mem_powerset, Nat.prod_primeFactors_of_squarefree hsq]
    refine ⟨fun p hp => ?_, h2⟩
    have hpp := Nat.prime_of_mem_primeFactors hp
    have hpq := Nat.dvd_of_mem_primeFactors hp
    rw [mem_oddPrimes]
    refine ⟨⟨?_, (Nat.le_of_dvd (by omega) hpq).trans h2⟩, hpp⟩
    have h2p := hpp.two_le
    by_contra h3
    have : p = 2 := by omega
    subst this
    exact (Nat.not_even_iff_odd.2 ho) (even_iff_two_dvd.2 hpq)
  · intro t ht
    rw [mem_filter, mem_powerset] at ht
    obtain ⟨hts, hle⟩ := ht
    have hprime : ∀ p ∈ t, p.Prime := fun p hp => (mem_oddPrimes.1 (hts hp)).2
    have hpos : 0 < ∏ p ∈ t, p := prod_pos fun p hp => (hprime p hp).pos
    simp only [mem_filter, mem_Icc]
    refine ⟨⟨⟨hpos, hle⟩, ?_⟩, ?_⟩
    · refine Finset.prod_induction _ Odd (fun a b ha hb => ha.mul hb) odd_one fun p hp => ?_
      have h3 := (mem_oddPrimes.1 (hts hp)).1.1
      exact (hprime p hp).odd_of_ne_two (by omega)
    · refine Finset.squarefree_prod_of_pairwise_isCoprime ?_ fun p hp => (hprime p hp).squarefree
      intro a ha b hb hab
      exact Nat.coprime_iff_isRelPrime.1 ((Nat.coprime_primes (hprime a ha) (hprime b hb)).2 hab)
  · intro q hq
    simp only [mem_filter] at hq
    exact Nat.prod_primeFactors_of_squarefree hq.2
  · intro t ht
    rw [mem_filter, mem_powerset] at ht
    exact Nat.primeFactors_prod fun p hp => (mem_oddPrimes.1 (ht.1 hp)).2
  · intro q _; rfl

theorem sum_odd_coefN_eq (N R : ℕ) :
    ∑ q ∈ (Icc 1 R).filter Odd, coefN N q =
      ∑ t ∈ (oddPrimes R).powerset.filter (fun t => ∏ p ∈ t, p ≤ R), ∏ p ∈ t, aP N p :=
  sum_odd_sqfree_eq (aP N) R

theorem oddPrimes_200 : oddPrimes 200 = {3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199} := by
  ext p
  rw [mem_oddPrimes]
  simp only [mem_insert, mem_singleton]
  constructor
  · rintro ⟨⟨h1, h2⟩, hp⟩
    interval_cases p <;> revert hp <;> norm_num
  · rintro (rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl|rfl) <;> norm_num

theorem prod_200_upper : ∏ p ∈ oddPrimes 200, (1 + 1 / ((p : ℝ) - 1) ^ 2) ≤ 1.4122 := by
  rw [oddPrimes_200]; norm_num

theorem aP_cases {N p : ℕ} (hp : 3 ≤ p) :
    aP N p = -(1 / ((p : ℝ) - 1) ^ 2) ∨ (0 ≤ aP N p ∧ aP N p ≤ 1 / ((p : ℝ) - 1) ^ 2) := by
  have hp1 : (2 : ℝ) ≤ (p : ℝ) - 1 := by
    have : (3 : ℝ) ≤ p := by exact_mod_cast hp
    linarith
  unfold aP; rw [divW_apply]
  split_ifs with h
  · left; field_simp; ring
  · right
    rw [sub_zero]
    constructor
    · positivity
    · rw [div_le_div_iff₀ (by positivity) (by positivity)]; nlinarith

theorem aP_ge {N p : ℕ} (hp : 3 ≤ p) : -(1 / ((p : ℝ) - 1) ^ 2) ≤ aP N p := by
  rcases aP_cases (N := N) hp with h | ⟨h0, -⟩
  · rw [h]
  · have : (0 : ℝ) ≤ 1 / ((p : ℝ) - 1) ^ 2 := by positivity
    linarith

theorem abs_aP_le {N p : ℕ} (hp : 3 ≤ p) : |aP N p| ≤ 1 / ((p : ℝ) - 1) ^ 2 := by
  rcases aP_cases (N := N) hp with h | ⟨h0, h1⟩
  · rw [h, abs_neg, abs_of_nonneg (by positivity)]
  · rw [abs_of_nonneg h0]; exact h1

theorem sum_rest_le {R : ℕ} (hR : 200 ≤ R) :
    ∑ p ∈ oddPrimes R \ oddPrimes 200, 1 / ((p : ℝ) - 1) ^ 2 ≤ 1 / 199 := by
  set rest := oddPrimes R \ oddPrimes 200
  have hmem : ∀ p ∈ rest, 201 ≤ p ∧ p ≤ R := by
    intro p hp
    rw [mem_sdiff, mem_oddPrimes, mem_oddPrimes] at hp
    obtain ⟨⟨⟨h3, hR'⟩, hpr⟩, hn⟩ := hp
    refine ⟨?_, hR'⟩
    by_contra h
    exact hn ⟨⟨h3, by omega⟩, hpr⟩
  set g : ℕ → ℝ := fun m => 1 / ((m : ℝ) * ((m : ℝ) - 1)) with hg
  have hle : ∀ p ∈ rest, 1 / ((p : ℝ) - 1) ^ 2 ≤ g (p - 1) := by
    intro p hp
    obtain ⟨h1, -⟩ := hmem p hp
    have hc : ((p - 1 : ℕ) : ℝ) = (p : ℝ) - 1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ p)]; push_cast; ring
    simp only [hg, hc]
    have hp' : (201 : ℝ) ≤ p := by exact_mod_cast h1
    rw [div_le_div_iff₀ (by nlinarith) (by nlinarith)]; nlinarith
  have hinj : ∀ a ∈ rest, ∀ b ∈ rest, a - 1 = b - 1 → a = b := by
    intro a ha b hb hab
    have := (hmem a ha).1; have := (hmem b hb).1
    omega
  have hsub : rest.image (· - 1) ⊆ Ioc 199 R := by
    intro m hm
    rw [mem_image] at hm
    obtain ⟨p, hp, rfl⟩ := hm
    obtain ⟨h1, h2⟩ := hmem p hp
    rw [mem_Ioc]; constructor <;> omega
  have hg0 : ∀ m ∈ Ioc 199 R, 0 ≤ g m := by
    intro m hm
    rw [mem_Ioc] at hm
    have : (200 : ℝ) ≤ m := by exact_mod_cast hm.1
    simp only [hg]
    have : 0 < (m : ℝ) * ((m : ℝ) - 1) := by nlinarith
    positivity
  have htel : ∑ m ∈ Ioc 199 R, g m ≤ 1 / 199 - 1 / R :=
    sum_inv_mul_pred_le (by norm_num) (by omega)
  have hR0 : (0 : ℝ) ≤ 1 / R := by positivity
  calc ∑ p ∈ rest, 1 / ((p : ℝ) - 1) ^ 2 ≤ ∑ p ∈ rest, g (p - 1) := sum_le_sum hle
    _ = ∑ m ∈ rest.image (· - 1), g m := (sum_image hinj).symm
    _ ≤ ∑ m ∈ Ioc 199 R, g m := sum_le_sum_of_subset_of_nonneg hsub fun m hm _ => hg0 m hm
    _ ≤ 1 / 199 := by linarith

theorem oddPrimes_200_subset {R : ℕ} (hR : 200 ≤ R) : oddPrimes 200 ⊆ oddPrimes R := by
  intro p hp; rw [mem_oddPrimes] at hp ⊢; exact ⟨⟨hp.1.1, by omega⟩, hp.2⟩

theorem three_le_of_mem {R p : ℕ} (hp : p ∈ oddPrimes R) : 3 ≤ p := (mem_oddPrimes.1 hp).1.1

theorem two_le_sub_one {p : ℕ} (hp : 3 ≤ p) : (2 : ℝ) ≤ (p : ℝ) - 1 := by
  have : (3 : ℝ) ≤ p := by exact_mod_cast hp
  linarith

theorem prod_upper_bound {R : ℕ} (hR : 200 ≤ R) :
    ∏ p ∈ oddPrimes R, (1 + 1 / ((p : ℝ) - 1) ^ 2) ≤ 1.4122 * Real.exp (1 / 199) := by
  rw [← prod_sdiff (oddPrimes_200_subset hR)]
  have hrest : ∏ p ∈ oddPrimes R \ oddPrimes 200, (1 + 1 / ((p : ℝ) - 1) ^ 2) ≤ Real.exp (1 / 199) := by
    calc ∏ p ∈ oddPrimes R \ oddPrimes 200, (1 + 1 / ((p : ℝ) - 1) ^ 2)
        ≤ ∏ p ∈ oddPrimes R \ oddPrimes 200, Real.exp (1 / ((p : ℝ) - 1) ^ 2) := by
          refine Finset.prod_le_prod (fun p _ => by positivity) (fun p _ => ?_)
          have := Real.add_one_le_exp (1 / ((p : ℝ) - 1) ^ 2); linarith
      _ = Real.exp (∑ p ∈ oddPrimes R \ oddPrimes 200, 1 / ((p : ℝ) - 1) ^ 2) := (Real.exp_sum _ _).symm
      _ ≤ Real.exp (1 / 199) := Real.exp_le_exp.2 (sum_rest_le hR)
  calc (∏ p ∈ oddPrimes R \ oddPrimes 200, (1 + 1 / ((p : ℝ) - 1) ^ 2)) *
        ∏ p ∈ oddPrimes 200, (1 + 1 / ((p : ℝ) - 1) ^ 2)
      ≤ Real.exp (1 / 199) * 1.4122 := mul_le_mul hrest prod_200_upper (by positivity) (by positivity)
    _ = 1.4122 * Real.exp (1 / 199) := by ring

theorem exp_inv199_le : Real.exp (1 / 199) ≤ 1.006 := by
  have h := Real.add_one_le_exp (-(1 / 199))
  have hp := Real.exp_pos (1 / 199)
  have : Real.exp (-(1 / 199)) * Real.exp (1 / 199) = 1 := by rw [← Real.exp_add]; simp
  nlinarith

end GoldbachSingular
