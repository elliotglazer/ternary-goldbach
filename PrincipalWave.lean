module

public import MajorBudget

@[expose] public section


open Real ArithmeticFunction TernaryGoldbach
open scoped ArithmeticFunction.Moebius
namespace GoldbachEnergy

/-- The continuous principal term at a reduced rational a/q with offset β. -/
noncomputable def principalWave (N : ℝ) (q : ℕ) (β : ℝ) : ℂ :=
  (((μ q : ℝ) / q.totient : ℝ) : ℂ) / ((1/N : ℝ) - ((2*π*β : ℝ):ℂ)*Complex.I)

theorem norm_principal_of_den {N β d : ℝ} {q : ℕ} (hq : 0<q) (hn : 0<N)
    (hd : 0<d)
    (hden : d/N ≤ ‖((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I‖) :
    ‖principalWave N q β‖ ≤ (N/q.totient)/d := by
  have hφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hm : |(μ q : ℝ)| ≤ 1 := by exact_mod_cast (abs_moebius_le_one (n := q))
  unfold principalWave
  rw [norm_div, Complex.norm_real, Real.norm_eq_abs,abs_div,abs_of_pos hφ]
  calc _ ≤ (1/(q.totient:ℝ))/(d/N) :=
        div_le_div₀ (by positivity) (div_le_div_of_nonneg_right hm hφ.le) (by positivity) hden
       _ = _ := by field_simp

theorem norm_principal (N : ℝ) (q : ℕ) (β : ℝ) (hn : 0<N) (hq : 0<q) :
    ‖principalWave N q β‖ ≤ N/q.totient := by
  have h := Complex.abs_re_le_norm (((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I)
  have hd : (1:ℝ)/N ≤ ‖((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I‖ := by
    simpa [abs_of_pos hn] using h
  simpa using norm_principal_of_den hq hn zero_lt_one hd

theorem norm_principal_off_center {N β : ℝ} {q : ℕ} (hn : 0<N) (hq : 0<q)
    (hoff : 10 ≤ 2*π*N*|β|) : ‖principalWave N q β‖ ≤ (N/q.totient)/10 := by
  have h := Complex.abs_im_le_norm (((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I)
  have h0 : 2*π*|β| ≤ ‖((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I‖ := by
    simpa [abs_mul,abs_of_pos Real.pi_pos] using h
  apply norm_principal_of_den hq hn (by norm_num)
  exact ((div_le_iff₀ hn).mpr (by linarith only [hoff])).trans h0

/-- The real minor-arc obligation for large q can be stated directly as a
bound on the error after subtracting the continuous principal term. -/
theorem wave_large_q_of_error {N α β c : ℝ} {q : ℕ} (hn : 10^20 ≤ N)
    (hq : 1.1*(Real.log N)^2 < q)
    (he : ‖wave N α - principalWave N q β‖ ≤ (c-0.088)*N/Real.log N) :
    ‖wave N α‖ ≤ c*N/Real.log N := by
  have hn0 : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hq0 : (0:ℝ)<q := lt_of_le_of_lt (by positivity) hq
  have hp := norm_principal N q β hn0 (by exact_mod_cast hq0)
  apply sup_from_remainder hn hq hp he
  have ht := norm_add_le (wave N α-principalWave N q β) (principalWave N q β)
  rw [sub_add_cancel] at ht; linarith
#print axioms wave_large_q_of_error
#print axioms norm_principal_off_center
end GoldbachEnergy
