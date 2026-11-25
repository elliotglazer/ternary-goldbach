module

public import TailProduct
public import TailGamma
public import TailScale
public import RationalCoordinates

@[expose] public section


open Real Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

private theorem half_log_two : 1/2 ≤ Real.log 2 := by
  have h := lower_log_certificate 0 (1/2) 2 (by norm_num) (by norm_num) (by norm_num [expPoly])
  simpa using h

private theorem dn_le_bp0 (d : ℕ) [NeZero d] : DN d ≤ Real.log (BP d 0/0.355) := by
  have h0 : (0:ℝ)<d := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne d)
  unfold DN
  apply Real.log_le_log (by positivity)
  unfold BP; rw [show (10:ℝ)=(10:ℕ) by norm_num,Real.rpow_natCast]
  norm_num only [abs_zero,zero_add]
  have hh : (512:ℝ) ≤ 1400*22*(1.25*11)^10 := by norm_num
  have hv := mul_le_mul_of_nonneg_right hh (show (0:ℝ) ≤ (d:ℝ)^9*(d+1) by positivity)
  apply div_le_div_of_nonneg_right _ (by norm_num); linarith only [hv]

def tailCharCeiling (N δ : ℝ) :=
  let L := Real.log N
  let z := twistRate δ
  Real.sqrt N*(98*L+4.3*L*Real.sqrt ‖z‖)+33*L^2+103*L+500*L*‖z‖+7

theorem character_envelope {d : ℕ} [NeZero d] {D N δ : ℝ}
    (hn : 1≤N) (hL : 44≤Real.log N) (hD : D≤11*Real.log N)
    (hzN : ‖twistRate δ‖≤N) (hbp0 : Real.log (BP d 0/0.355) ≤ 11*Real.log N)
    (g u : ZeroTiling) (G U : ℝ) (hg : gammaBudget d (twistRate δ) g ≤ G) (hu : gammaBudget d 1 u ≤ U) :
    charBudget d D N δ g u ≤ Real.sqrt N*G+33*(Real.log N)^2+U+500*Real.log N*‖twistRate δ‖+7 := by
  let L := Real.log N
  let z := twistRate δ
  have hl : 44≤L := hL
  have hl0 : 0<L := by linarith
  have hN : 0<N := lt_of_lt_of_le zero_lt_one hn
  have hz0 : 1≤‖z‖ := (twist_norm_bounds δ).1
  have hzp : 0<‖z‖ := by linarith
  change ‖z‖≤N at hzN
  change Real.log (BP d 0/0.355) ≤ 11*L at hbp0
  have hgap := inverse_norm_le_gap δ
  have hgap0 : 0<gapAngle z := (one_div_pos.mpr hzp).trans_le hgap
  have hgap' : 2/gapAngle z ≤ 2*‖z‖ := by
    have h := one_div_le_one_div_of_le (one_div_pos.mpr hzp) hgap
    rw [one_div_one_div] at h
    change 1/gapAngle z ≤ ‖z‖ at h
    simpa only [mul_one_div] using mul_le_mul_of_nonneg_left h (by norm_num : (0:ℝ) ≤ 2)
  have hleft : leftCoeff D ≤ 210*L := by
    have h2 : 2/Real.log 2 ≤ 4 := by rw [div_le_iff₀ (by linarith [half_log_two])]; linarith [half_log_two]
    have hpos : 0 ≤ 2/Real.log 2+4.8 := by positivity
    unfold leftCoeff
    have hh := mul_le_mul_of_nonneg_left (show 2*(D+37)+2.6≤22*L+76.6 by dsimp [L]; linarith) hpos
    have hh' := mul_le_mul_of_nonneg_right (show 2/Real.log 2+4.8≤8.8 by linarith) (show 0≤22*L+76.6 by linarith)
    linarith
  have hpi : Real.sqrt (2*π) ≤ 3 := (Real.sqrt_le_left (by norm_num)).mpr (by linarith [Real.pi_lt_four])
  have hfac : (Real.sqrt ‖z‖+Real.sqrt N)*N^(-(1/2):ℝ) ≤ 2 := by
    rw [Real.rpow_neg hN.le,← Real.sqrt_eq_rpow,← div_eq_mul_inv,div_le_iff₀ (Real.sqrt_pos.mpr hN)]
    linarith only [Real.sqrt_le_sqrt hzN]
  have hcont : contourBudget D N δ/(2*π) ≤ 500*L*‖z‖ := by
    unfold contourBudget
    rw [div_le_iff₀ (by positivity)]
    have hh := mul_le_mul (mul_le_mul hleft hpi (Real.sqrt_nonneg _) (by positivity)) hfac
      (show 0≤(Real.sqrt ‖z‖+Real.sqrt N)*N^(-(1/2):ℝ) by positivity) (by positivity)
    have hv := mul_le_mul hh hgap' (by positivity : 0≤2/gapAngle z) (by positivity)
    change leftCoeff D*Real.sqrt (2*π)*(Real.sqrt ‖z‖+Real.sqrt N)*N^(-(1/2):ℝ)*(2/gapAngle z) ≤ _
    nlinarith only [hv,mul_le_mul_of_nonneg_right Real.pi_gt_three.le (mul_nonneg hl0.le hzp.le),mul_nonneg hl0.le hzp.le]
  have harg : |z.arg| < π/2 := Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl (by simp [z,twistRate]))
  have hlogz : ‖Complex.log z‖ ≤ L+2 := by
    have h := Complex.norm_le_abs_re_add_abs_im (Complex.log z)
    rw [Complex.log_re,Complex.log_im,abs_of_nonneg (Real.log_nonneg hz0)] at h
    have hh : Real.log ‖z‖≤L := Real.log_le_log hzp hzN
    linarith only [h,hh,harg,Real.pi_lt_four]
  have hlogN : ‖Complex.log (N:ℂ)‖ = L := by
    rw [← Complex.ofReal_log hN.le,Complex.norm_real,Real.norm_eq_abs,abs_of_nonneg (Real.log_nonneg hn)]
  have hhlog : ‖Complex.log (N:ℂ)-Complex.log z‖ ≤ 3*L := by
    have h := norm_sub_le (Complex.log (N:ℂ)) (Complex.log z); rw [hlogN] at h; linarith
  have hden : 1≤Real.log (10/2) := (Real.le_log_iff_exp_le (by norm_num)).mpr (by linarith [Real.exp_one_lt_three])
  have hzero : Real.log (BP d 0/0.355)/Real.log (10/2) ≤ 11*L := by
    rw [div_le_iff₀ (by linarith)]
    nlinarith only [hbp0,mul_le_mul_of_nonneg_left hden hl0.le]
  have hres := mul_le_mul hzero hhlog (norm_nonneg _) (by positivity)
  have hmain := mul_le_mul_of_nonneg_left hg (Real.sqrt_nonneg N)
  change Real.sqrt N*gammaBudget d z g ≤ Real.sqrt N*G at hmain
  unfold charBudget residueBudget
  change _ + (Real.sqrt N*gammaBudget d z g + gammaBudget d 1 u) + _ + 7 ≤ Real.sqrt N*G+33*L^2+U+500*L*‖z‖+7
  linarith only [hres,hmain,hu,hcont]

theorem tail_character {q d : ℕ} [NeZero d] (hd : d≤q) {D N δ : ℝ}
    (hn : 1≤N) (hL : 56≤Real.log N) (hD : D≤11*Real.log N)
    (hprod : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N) :
    charBudget d D N δ (tailTiling (twistRate δ)) (tailTiling 1) ≤ tailCharCeiling N δ := by
  let L := Real.log N
  let z := twistRate δ
  have hl : 56≤L := hL
  have hl0 : 0<L := by linarith
  have hN : 0<N := lt_of_lt_of_le zero_lt_one hn
  have hz0 : 1≤‖z‖ := (twist_norm_bounds δ).1
  have hq0 : 0<q := lt_of_lt_of_le (Nat.pos_of_ne_zero (NeZero.ne d)) hd
  have hq : (1:ℝ)≤q := by exact_mod_cast hq0
  have hprod' : 4*(q:ℝ)*(8+‖z‖+22)≤N := by simpa [z,abs_of_nonneg (by positivity : 0≤8+‖twistRate δ‖)] using hprod
  have hzp : 0<‖z‖ := by linarith
  have hzN : ‖z‖≤N := by nlinarith only [hprod',mul_le_mul_of_nonneg_right hq hzp.le,hq,hzp]
  have hbp := product_log_BP hd hN hprod
  have hbp0 : Real.log (BP d 0/0.355) ≤ 11*L := (log_BP_mono d (c:=0) (c':=8+‖z‖) (by simp)).trans hbp
  have hbp1 : Real.log (BP d (8+‖(1:ℂ)‖)/0.355) ≤ 11*L := by
    apply (log_BP_mono d (c':=8+‖z‖) _).trans hbp
    rw [norm_one,abs_of_nonneg (by norm_num),abs_of_nonneg (by positivity)]; linarith
  apply character_envelope hn (by linarith) hD hzN hbp0
  · exact tail_gamma hL z hz0 (inverse_norm_le_gap δ) hbp
  · have hh := tail_gamma hL (1:ℂ) (by simp) (by simp; linarith [Real.pi_gt_three]) hbp1
    simp only [norm_one,Real.sqrt_one,mul_one] at hh
    linarith only [hh,hL]

theorem tail_conductor {N δ : ℝ} (hn : 1≤N) (hL : 56≤Real.log N) (q : ℕ) (hq : 0<q)
    (hp : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N) :
    conductorBudget q N δ (tailTiling (twistRate δ)) (tailTiling 1) ≤ tailCharCeiling N δ := by
  unfold conductorBudget; apply max_le
  · exact tail_character (d:=1) hq hn hL (by linarith) hp
  · apply sup'_le; intro d hd
    have hpos : 0<d := by rcases mem_insert.mp hd with h|h; omega; exact Nat.pos_of_mem_divisors h
    have he : d≤q := by rcases mem_insert.mp hd with h|h; omega; exact Nat.le_of_dvd hq (Nat.mem_divisors.mp h).1
    letI : NeZero d := ⟨hpos.ne'⟩
    apply tail_character he hn hL _ hp
    apply (dn_le_bp0 d).trans
    exact (log_BP_mono d (c:=0) (c':=8+‖twistRate δ‖) (by simp)).trans (product_log_BP he (by linarith) hp)

#print axioms tail_conductor
end GoldbachEnergy
