module

public import RationalArcs

@[expose] public section


open Real Set
noncomputable section
namespace GoldbachEnergy

theorem log_two_e19 {N : ℝ} (hn : 2*10^19 ≤ N) : 44 ≤ Real.log N := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  apply (Real.le_log_iff_exp_le hn0).mpr
  calc Real.exp 44 = Real.exp 1^44 := by rw [← Real.exp_nat_mul]; norm_num
       _ ≤ (2.7182818286:ℝ)^44 := pow_le_pow_left₀ (Real.exp_pos 1).le Real.exp_one_lt_d9.le _
       _ ≤ 2*10^19 := by norm_num
       _ ≤ _ := hn

theorem separation_budget_from_two_e19 {N : ℝ} (hn : (2*10^19) ≤ N) :
    4*Real.log N*(modulusCutoff N)^2 < N := by
  have h0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hl := log_two_e19 hn
  have hL : 0<Real.log N := by linarith
  have h := Real.pow_div_factorial_le_exp (Real.log N) hL.le 9
  rw [Real.exp_log h0] at h
  have hf : ((9:ℕ).factorial : ℝ) = 362880 := by norm_num [Nat.factorial]
  rw [hf] at h
  have h₄ := pow_le_pow_left₀ (by norm_num : (0:ℝ)≤44) hl 4
  have ht : 4.84*362880 < (Real.log N)^4 := by linarith
  have h₅ : 0 < (Real.log N)^5 := by positivity
  unfold modulusCutoff
  nlinarith only [mul_lt_mul_of_pos_right ht h₅,h]

theorem separation_budget {N : ℝ} (hn : 10^20 ≤ N) :
    4*Real.log N*(modulusCutoff N)^2 < N :=
  separation_budget_from_two_e19 ((by norm_num : (2:ℝ)*10^19 ≤ 10^20).trans hn)

theorem rat_distance_lower {r s : ℚ} (hrs : r ≠ s) :
    1/((r.den:ℝ)*s.den) ≤ |(r:ℝ)-s| := by
  have hdet : r.num*(s.den:ℤ)-s.num*(r.den:ℤ) ≠ 0 :=
    sub_ne_zero.mpr (fun h => hrs (Rat.eq_iff_mul_eq_mul.mpr h))
  have hInt : (1:ℤ) ≤ |r.num*(s.den:ℤ)-s.num*(r.den:ℤ)| := by
    have hp := abs_pos.mpr hdet
    omega
  have hR : (1:ℝ) ≤ |(r.num:ℝ)*s.den-s.num*r.den| := by exact_mod_cast hInt
  have hr : 0 < (r.den:ℝ) := by exact_mod_cast r.pos
  have hs : 0 < (s.den:ℝ) := by exact_mod_cast s.pos
  rw [div_le_iff₀ (mul_pos hr hs)]
  have he : ((r:ℝ)-(s:ℝ))*((r.den:ℝ)*s.den) = (r.num:ℝ)*s.den-s.num*r.den := by
    rw [Rat.cast_def,Rat.cast_def]
    push_cast
    field_simp
  simpa [← he,abs_mul,abs_of_pos hr,abs_of_pos hs,mul_assoc] using hR

theorem disjoint_central_windows_from_two_e19 {N : ℝ} (hn : (2*10^19) ≤ N) {r s : ℚ} (hrs : r ≠ s)
    (hr : (r.den:ℝ) ≤ modulusCutoff N) (hs : (s.den:ℝ) ≤ modulusCutoff N) :
    Disjoint (Icc ((r:ℝ)-radius N r.den) ((r:ℝ)+radius N r.den))
      (Icc ((s:ℝ)-radius N s.den) ((s:ℝ)+radius N s.den)) := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hL := Real.log_pos (show 1<N from lt_of_lt_of_le (by norm_num) hn)
  have hden (a : ℚ) : 0<(a.den:ℝ) := by exact_mod_cast a.pos
  have hφ (a : ℚ) : (1:ℝ) ≤ a.den.totient := by exact_mod_cast Nat.totient_pos.mpr a.pos
  have hrad (a : ℚ) : radius N a.den ≤ 2*Real.log N/N := by
    apply div_le_div_of_nonneg_left (by positivity) hn0
    simpa using mul_le_mul_of_nonneg_right (hφ a) hn0.le
  have hsmall : 4*Real.log N/N < 1/((r.den:ℝ)*s.den) := by
    rw [div_lt_div_iff₀ hn0 (mul_pos (hden r) (hden s)),one_mul]
    have hprod := mul_le_mul hr hs (hden s).le ((hden r).le.trans hr)
    exact (mul_le_mul_of_nonneg_left hprod (by positivity)).trans_lt (by simpa [sq] using separation_budget_from_two_e19 hn)
  refine Set.disjoint_left.mpr fun t ht hu => ?_
  have hd := rat_distance_lower hrs
  have hd' : |(r:ℝ)-s| ≤ radius N r.den + radius N s.den := by
    apply abs_le.mpr
    exact ⟨by linarith [ht.1,hu.2,ht.2,hu.1],by linarith [ht.1,hu.2,ht.2,hu.1]⟩
  apply (not_lt_of_ge (hd.trans (hd'.trans ((add_le_add (hrad r) (hrad s)).trans_eq (by ring))))) hsmall

theorem disjoint_central_windows {N : ℝ} (hn : 10^20 ≤ N) {r s : ℚ} (hrs : r ≠ s)
    (hr : (r.den:ℝ) ≤ modulusCutoff N) (hs : (s.den:ℝ) ≤ modulusCutoff N) :
    Disjoint (Icc ((r:ℝ)-radius N r.den) ((r:ℝ)+radius N r.den))
      (Icc ((s:ℝ)-radius N s.den) ((s:ℝ)+radius N s.den)) :=
  disjoint_central_windows_from_two_e19 ((by norm_num : (2:ℝ)*10^19 ≤ 10^20).trans hn) hrs hr hs

#print axioms disjoint_central_windows
end GoldbachEnergy
