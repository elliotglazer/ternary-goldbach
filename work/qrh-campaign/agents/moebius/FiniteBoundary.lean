import TernaryGoldbach.Prelim.SchoenfeldGen

/-!
Uncompiled research candidate at pinned source 23b2d68.
Finite prime estimates for the full existing Schoenfeld boundary range.
This file introduces no assumptions. The source repository is unchanged.
-/

open Finset
open scoped ArithmeticFunction.vonMangoldt ArithmeticFunction.Moebius

namespace TernaryGoldbach.Prelim

theorem psi_small_two_sided_finite {n : ℕ} (h1 : 12 ≤ n) (h2 : n < 1000000) :
    |psiN n - n| ≤ √(n : ℝ) := by
  obtain ⟨r1, r2, -, -⟩ := SmallTab.small_table (t := (n : ℝ))
    (by exact_mod_cast h1) (by exact_mod_cast h2)
  rw [Nat.floor_natCast, thS_add_ppS] at r1 r2
  norm_num at r1 r2
  unfold psiN
  rw [abs_le]
  constructor <;> linarith

theorem psiN_le_finite {n : ℕ} (h2 : n < 1000000) :
    psiN n ≤ 1.03883 * n := by
  by_cases hn : n = 0
  · subst n
    simp [psiN]
  rcases le_or_gt n 700 with h | h
  · exact (Small.psi_lt_small_700 (by omega) h).le
  have hB := (abs_le.1 (psi_small_two_sided_finite (by omega) h2)).2
  have hss := Real.mul_self_sqrt (Nat.cast_nonneg n : (0 : ℝ) ≤ n)
  have hs : (26.47 : ℝ) ≤ √(n : ℝ) := Real.le_sqrt_of_sq_le (by
    have hn701 : 701 ≤ n := by omega
    have : (701 : ℝ) ≤ n := by exact_mod_cast hn701
    linarith)
  nlinarith

theorem nonprime_mid_finite {N : ℕ} (h1 : 10 ^ 6 ≤ N) (h2 : N < 10 ^ 12) :
    ∑ m ∈ Icc 1 N, (if m.Prime then 0 else (Λ m : ℝ)) < 1.4262 * √(N : ℝ) := by
  have hN1 : 1 ≤ N := by omega
  have hN0 : (0 : ℝ) < N := by exact_mod_cast hN1
  have hN' : (1e6 : ℝ) ≤ N := by
    have := (Nat.cast_le (α := ℝ)).2 h1; norm_num at this ⊢; linarith
  refine (nonprime_sum_le4 N hN1).trans_lt ?_
  -- `v = N^{1/12}`
  set v := (N : ℝ) ^ ((1 / 12) : ℝ) with hv
  have hv0 : 0 < v := by positivity
  have hpow : ∀ k : ℕ, (N : ℝ) ^ ((k : ℝ) / 12) = v ^ k := fun k => by
    rw [hv, ← Real.rpow_natCast, ← Real.rpow_mul hN0.le]; congr 1; ring
  have hsq : √(N : ℝ) = v ^ 6 := by rw [Real.sqrt_eq_rpow, ← hpow 6]; norm_num
  have h13 : (N : ℝ) ^ ((1 / 3) : ℝ) = v ^ 4 := by rw [← hpow 4]; norm_num
  have h14 : (N : ℝ) ^ ((1 / 4) : ℝ) = v ^ 3 := by rw [← hpow 3]; norm_num
  have hv3 : 3.162 ≤ v := by
    have : (3.162 : ℝ) ^ (12 : ℕ) ≤ N := by norm_num; linarith
    calc (3.162 : ℝ) = ((3.162 : ℝ) ^ (12 : ℕ)) ^ ((1 / 12) : ℝ) := by
          rw [← Real.rpow_natCast, ← Real.rpow_mul (by norm_num)]; norm_num
      _ ≤ v := Real.rpow_le_rpow (by positivity) this (by norm_num)
  -- `θ(√N) ≤ ψ(√N) ≤ √N + N^{1/4}` (`small_table`, `√N < 10⁶`)
  have hsN : (Nat.sqrt N : ℝ) ≤ √(N : ℝ) := Real.nat_sqrt_le_real_sqrt
  have hs12 : 12 ≤ Nat.sqrt N := by
    rw [Nat.le_sqrt]; omega
  have hs6 : Nat.sqrt N < 1000000 := Nat.sqrt_lt'.2 (by norm_num; omega)
  have hb := psi_small_two_sided_finite hs12 hs6
  have hpsi : psiN (Nat.sqrt N) ≤ Nat.sqrt N + 1 * √(Nat.sqrt N : ℝ) := by
    linarith [(abs_le.1 hb).2]
  have hss : √(Nat.sqrt N : ℝ) ≤ v ^ 3 := by
    rw [← h14]
    calc √(Nat.sqrt N : ℝ) ≤ √(√(N : ℝ)) := Real.sqrt_le_sqrt hsN
      _ = (N : ℝ) ^ ((1 / 4) : ℝ) := by
          rw [Real.sqrt_eq_rpow, Real.sqrt_eq_rpow, ← Real.rpow_mul hN0.le]; norm_num
  have t2 : thetaN (Nat.sqrt N) ≤ v ^ 6 + 1 * v ^ 3 := by
    have := thetaN_le_psiN (Nat.sqrt N); rw [← hsq]; nlinarith
  have hroot : ∀ r : ℝ, r ≤ 1 / 2 → ⌊(N : ℝ) ^ r⌋₊ < 1000000 := by
    intro r hr
    apply (Nat.floor_lt (Real.rpow_nonneg hN0.le r)).2
    have hle := Real.rpow_le_rpow_of_exponent_le (show (1 : ℝ) ≤ N by
      exact_mod_cast hN1) hr
    rw [← Real.sqrt_eq_rpow] at hle
    have hNlt : (N : ℝ) < 1000000 ^ 2 := by exact_mod_cast h2
    have hsquare := Real.sq_sqrt hN0.le
    have hspos := Real.sqrt_nonneg (N : ℝ)
    nlinarith
  have t3 : thetaN ⌊(N : ℝ) ^ ((1 / 3) : ℝ)⌋₊ ≤ 1.03883 * v ^ 4 := by
    refine (thetaN_le_psiN _).trans ((psiN_le_finite (hroot _ (by norm_num))).trans ?_)
    rw [← h13]; exact mul_le_mul_of_nonneg_left (Nat.floor_le (by positivity)) (by norm_num)
  have t4 : thetaN ⌊(N : ℝ) ^ ((1 / 4) : ℝ)⌋₊ ≤ 1.03883 * v ^ 3 := by
    refine (thetaN_le_psiN _).trans ((psiN_le_finite (hroot _ (by norm_num))).trans ?_)
    rw [← h14]; exact mul_le_mul_of_nonneg_left (Nat.floor_le (by positivity)) (by norm_num)
  -- `N^{1/5} log N ≤ 7.3576 N^{1/4}`
  have t5 : (N : ℝ) ^ ((1 / 5) : ℝ) * Real.log N ≤ 7.3576 * v ^ 3 := by
    have hl : Real.log N = 20 * Real.log ((N : ℝ) ^ ((1 / 20) : ℝ)) := by
      rw [Real.log_rpow hN0]; ring
    have hle := log_le_div_e (x := (N : ℝ) ^ ((1 / 20) : ℝ)) (by positivity)
    have he : (20 : ℝ) / Real.exp 1 ≤ 7.3576 := by
      rw [div_le_iff₀ (Real.exp_pos 1)]; have := Real.exp_one_gt_d9; linarith
    have hm : (N : ℝ) ^ ((1 / 5) : ℝ) * (N : ℝ) ^ ((1 / 20) : ℝ) = v ^ 3 := by
      rw [← Real.rpow_add hN0, ← h14]; norm_num
    have h15 : 0 ≤ (N : ℝ) ^ ((1 / 5) : ℝ) := by positivity
    have h120 : 0 ≤ (N : ℝ) ^ ((1 / 20) : ℝ) := by positivity
    calc (N : ℝ) ^ ((1 / 5) : ℝ) * Real.log N
        ≤ (N : ℝ) ^ ((1 / 5) : ℝ) * (20 * ((N : ℝ) ^ ((1 / 20) : ℝ) / Real.exp 1)) := by
          rw [hl]; exact mul_le_mul_of_nonneg_left (by linarith) h15
      _ = 20 / Real.exp 1 * ((N : ℝ) ^ ((1 / 5) : ℝ) * (N : ℝ) ^ ((1 / 20) : ℝ)) := by ring
      _ ≤ 7.3576 * v ^ 3 := by
          rw [hm]; exact mul_le_mul_of_nonneg_right he (by positivity)
  rw [hsq]
  have hv3' : 0 < v ^ 3 := by positivity
  have key : 9.39643 + 1.03883 * v < 0.4262 * v ^ 3 := by
    have hw : 0 ≤ v - 3.162 := by linarith
    nlinarith [mul_nonneg (mul_nonneg hw hw) hw, mul_nonneg hw hw]
  have key2 : 9.39643 * v ^ 3 + 1.03883 * v ^ 4 < 0.4262 * v ^ 6 :=
    calc 9.39643 * v ^ 3 + 1.03883 * v ^ 4 = v ^ 3 * (9.39643 + 1.03883 * v) := by ring
      _ < v ^ 3 * (0.4262 * v ^ 3) := mul_lt_mul_of_pos_left key hv3'
      _ = 0.4262 * v ^ 6 := by ring
  linarith

theorem nonprime_small_finite (n : ℕ) (h1 : 1 ≤ n) (h : n < 10 ^ 12) :
    ∑ m ∈ Icc 1 n, (if m.Prime then 0 else (Λ m : ℝ)) < 1.4262 * √n := by
  rcases le_or_gt n (10 ^ 6) with h6 | h6
  · exact SmallNP.nonprime_small_kernel n h1 h6
  · exact nonprime_mid_finite h6.le h

theorem psi_le_two_finite {n : ℕ} (h1 : 12 ≤ n) (h2 : n < 1000000000) : |psiN n - n| ≤ 2 * √(n : ℝ) := by
  have hs := Real.sqrt_nonneg (n : ℝ)
  rcases lt_or_ge n 1000000 with h | h
  · exact (psi_small_two_sided_finite h1 h).trans (by linarith)
  · have hR := SieveTab.sieve_table3 (t := (n : ℝ)) (by exact_mod_cast h) (by exact_mod_cast h2)
    unfold SieveTab.RtT at hR
    rw [Nat.floor_natCast] at hR
    have e : SmallTab.thS n = thetaN n := rfl
    rw [e] at hR
    norm_num at hR
    have hnp := nonprime_small_finite n (by omega) (by omega)
    have hnp0 : 0 ≤ ∑ m ∈ Finset.Icc 1 n, (if m.Prime then 0 else (Λ m : ℝ)) :=
      Finset.sum_nonneg fun m _ => by split_ifs <;> simp [ArithmeticFunction.vonMangoldt_nonneg]
    rw [psiN_eq, abs_le]
    constructor <;> nlinarith [hR.1, hR.2]

namespace Sch

theorem bTerm_le_finite {cs : List (ℕ × ℚ)} (hc : McovR (X0 + 1) cs)
    {A B Y sA rY D : ℕ} (hend : endC (X0 + 1) cs = A) (hY : 12 ≤ Y) (hY9 : Y < 1000000000)
    (hlo : 100 ≤ A / (Y + 1)) (hhi : (B - 1) / (Y + 1) < A) (hsA : 1 ≤ sA) (hsAA : sA * sA ≤ A)
    (hrY : 1 ≤ rY) (hrY2 : rY * rY ≤ Y + 1) (hAD : A ≤ D) (hDB : D < B) :
    |ρn Y| * |Mn (D / (Y + 1))| ≤ D * (bVal cs A B Y sA rY : ℝ) := by
  set p := Mrange cs (A / (Y + 1)) ((B - 1) / (Y + 1))
  obtain ⟨p1, p2⟩ := Mrange_nonneg cs (A / (Y + 1)) ((B - 1) / (Y + 1))
  have p1' : (0 : ℝ) ≤ p.1 := by exact_mod_cast p1
  have p2' : (0 : ℝ) ≤ p.2 := by exact_mod_cast p2
  set u := D / (Y + 1) with hu
  have hM : |Mn u| ≤ (p.1 : ℝ) * √(u : ℝ) + (p.2 : ℝ) * u :=
    Mrange_spec hc hlo (by omega) (Nat.div_le_div_right hAD) (Nat.div_le_div_right (by omega))
  have hρ : |ρn Y| ≤ 2 * √(Y : ℝ) := by
    rw [rho_eq]
    exact psi_le_two_finite hY hY9
  have hY0 : (0 : ℝ) ≤ Y := Nat.cast_nonneg _
  have hu0 : (0 : ℝ) ≤ u := Nat.cast_nonneg _
  have hD0 : (0 : ℝ) ≤ D := Nat.cast_nonneg _
  have hsY := Real.sqrt_nonneg (Y : ℝ)
  have hsu := Real.sqrt_nonneg (u : ℝ)
  have hYu : ((Y : ℝ) + 1) * u ≤ D := by
    have := Nat.div_mul_le_self D (Y + 1)
    have h' : ((u * (Y + 1) : ℕ) : ℝ) ≤ D := by exact_mod_cast this
    push_cast at h'; linarith
  -- `√Y √u ≤ √D ≤ D/sA`
  have h1 : √(Y : ℝ) * √(u : ℝ) ≤ D / sA := by
    rw [← Real.sqrt_mul hY0]
    refine le_trans (Real.sqrt_le_sqrt (by nlinarith)) (sqrt_le_div hsA (le_trans hsAA hAD))
  -- `√Y u ≤ D/rY`
  have h2 : √(Y : ℝ) * u ≤ D / rY := by
    have hr0 : (0 : ℝ) < rY := by exact_mod_cast hrY
    have hY1 : (0 : ℝ) ≤ (Y : ℝ) + 1 := by linarith
    have hs1 := Real.sq_sqrt hY1
    have hsle : √(Y : ℝ) ≤ √((Y : ℝ) + 1) := Real.sqrt_le_sqrt (by linarith)
    have hrle : (rY : ℝ) ≤ √((Y : ℝ) + 1) := by
      rw [show (rY : ℝ) = √((rY : ℝ) * rY) by rw [Real.sqrt_mul_self hr0.le]]
      exact Real.sqrt_le_sqrt (by exact_mod_cast (by push_cast at hrY2 ⊢; exact_mod_cast hrY2 : rY * rY ≤ Y + 1))
    rw [le_div_iff₀ hr0]
    have hs10 := Real.sqrt_nonneg ((Y : ℝ) + 1)
    calc √(Y : ℝ) * u * rY ≤ √((Y : ℝ) + 1) * u * √((Y : ℝ) + 1) := by
          apply mul_le_mul (mul_le_mul_of_nonneg_right hsle hu0) hrle (by positivity) (by positivity)
      _ = ((Y : ℝ) + 1) * u := by rw [mul_comm, ← mul_assoc, ← sq, hs1]
      _ ≤ D := hYu
  have hsA0 : (0 : ℝ) < sA := by exact_mod_cast hsA
  have hr0 : (0 : ℝ) < rY := by exact_mod_cast hrY
  have e : (D : ℝ) * (bVal cs A B Y sA rY : ℝ) = 2 * p.1 * (D / sA) + 2 * p.2 * (D / rY) := by
    show (D : ℝ) * ((2 * p.1 / sA + 2 * p.2 / rY : ℚ) : ℝ) = _
    push_cast; field_simp
  rw [e]
  calc |ρn Y| * |Mn u| ≤ 2 * √(Y : ℝ) * ((p.1 : ℝ) * √(u : ℝ) + (p.2 : ℝ) * u) :=
        mul_le_mul hρ hM (abs_nonneg _) (by positivity)
    _ = 2 * p.1 * (√(Y : ℝ) * √(u : ℝ)) + 2 * p.2 * (√(Y : ℝ) * u) := by ring
    _ ≤ 2 * p.1 * (D / sA) + 2 * p.2 * (D / rY) := by
        gcongr

end Sch

#print axioms psi_small_two_sided_finite
#print axioms psiN_le_finite
#print axioms nonprime_mid_finite
#print axioms nonprime_small_finite
#print axioms psi_le_two_finite
#print axioms Sch.bTerm_le_finite

end TernaryGoldbach.Prelim
