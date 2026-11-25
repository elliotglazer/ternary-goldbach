module

public import TailBudget

@[expose] public section

open Real Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy.Profile
private theorem dn_le_bp0 (d : ℕ) [NeZero d] : DN d ≤ Real.log (BP d 0/0.355) := by
  have h0 : (0:ℝ)<d := by exact_mod_cast Nat.pos_of_ne_zero (NeZero.ne d)
  unfold DN
  apply Real.log_le_log (by positivity)
  unfold BP; rw [show (10:ℝ)=(10:ℕ) by norm_num,Real.rpow_natCast]
  norm_num only [abs_zero,zero_add]
  have hh : (512:ℝ) ≤ 1400*22*(1.25*11)^10 := by norm_num
  have hv := mul_le_mul_of_nonneg_right hh (show (0:ℝ) ≤ (d:ℝ)^9*(d+1) by positivity)
  apply div_le_div_of_nonneg_right _ (by norm_num); linarith only [hv]

def charBound (N δ G : ℝ) :=
  let L := Real.log N
  Real.sqrt N*G+33*L^2+205*L+500*L*‖twistRate δ‖+7

theorem character {q d : ℕ} [NeZero d] (hd : d≤q) {D N δ : ℝ}
    (hn : 1≤N) (hL : 44≤Real.log N) (hD : D≤11*Real.log N)
    (g : ZeroTiling) (G : ℝ) (hg : gammaBudget d (twistRate δ) g ≤ G)
    (hprod : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N) :
    charBudget d D N δ g (tailTiling 1) ≤ charBound N δ G := by
  let L := Real.log N
  let z := twistRate δ
  have hl : 44≤L := hL
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
  · exact hg
  · have hh := gamma_of_log_bounds (q:=d) (L:=2*L) (by positivity) (1:ℂ) (by simp) (by simp; linarith [Real.pi_gt_three]) (by linarith only [hbp1,hl]) (by linarith only [hbp1,hl])
    simp only [norm_one,Real.sqrt_one,mul_one] at hh
    linarith only [hh,hL]

theorem conductor {N δ : ℝ} (hn : 1≤N) (hL : 44≤Real.log N) (q : ℕ) (hq : 0<q)
    (g : ZeroTiling) (G : ℝ) (hg : ∀ (d : ℕ) [NeZero d], d≤q → gammaBudget d (twistRate δ) g ≤ G)
    (hp : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N) :
    conductorBudget q N δ g (tailTiling 1) ≤ charBound N δ G := by
  unfold conductorBudget; apply max_le
  · exact character (d:=1) hq hn hL (by linarith) g G (hg 1 hq) hp
  · apply sup'_le; intro d hd
    have hpos : 0<d := by rcases mem_insert.mp hd with h|h; omega; exact Nat.pos_of_mem_divisors h
    have he : d≤q := by rcases mem_insert.mp hd with h|h; omega; exact Nat.le_of_dvd hq (Nat.mem_divisors.mp h).1
    letI : NeZero d := ⟨hpos.ne'⟩
    apply character he hn hL _ g G (hg d he) hp
    apply (dn_le_bp0 d).trans
    exact (log_BP_mono d (c:=0) (c':=8+‖twistRate δ‖) (by simp)).trans (product_log_BP he (by linarith) hp)

theorem twist {N δ : ℝ} (hn : 1≤N) (hl : 44≤Real.log N) (q : ℕ) (hq : 0<q)
    (hp : 4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ N)
    (g : ZeroTiling) (G : ℝ) (hg : ∀ (d : ℕ) [NeZero d], d≤q → gammaBudget d (twistRate δ) g ≤ G) :
    twistedBudget N q δ g (tailTiling 1) ≤ Real.sqrt q*(Real.sqrt N*G+57*(Real.log N)^2+3150*(Real.log N)*|δ|) := by
  let L := Real.log N
  have hL : 44≤L := hl
  have h0 : 0<L := by linarith
  have hq1 : (1:ℝ)≤q := by exact_mod_cast hq
  have hq' : (0:ℝ)<q := by linarith
  have hqN : (q:ℝ)≤N := by nlinarith only [hp,mul_nonneg hq'.le (abs_nonneg (8+‖twistRate δ‖)),hq1]
  have hs : 1 ≤ Real.sqrt q := by simpa using Real.sqrt_le_sqrt hq1
  have hh2 : 1/2≤Real.log 2 := by
    have h := lower_log_certificate 0 (1/2) 2 (by norm_num) (by norm_num) (by norm_num [expPoly]); simpa using h
  let D := Real.log q/Real.log 2*(1+L)
  have hD : D ≤ 3*L^2 := by
    have hh : Real.log q/Real.log 2 ≤ 2*L := by
      rw [div_le_iff₀ (by linarith)]
      nlinarith only [show Real.log q≤L from Real.log_le_log hq' hqN,mul_le_mul_of_nonneg_left hh2 h0.le]
    have hv := mul_le_mul_of_nonneg_right hh (by linarith : 0≤1+L)
    dsimp [D]; nlinarith only [hv,mul_le_mul_of_nonneg_right hL h0.le]
  have h1 := conductor hn hl q hq g G hg hp
  have hz := mul_le_mul_of_nonneg_left (twist_norm_bounds δ).2 h0.le
  let Y := Real.sqrt N*(G)+57*L^2+3150*L*|δ|
  have hc : charBound N δ G+2*(3*L^2) ≤ Y := by
    change Real.sqrt N*(G)+33*L^2+205*L+500*L*‖twistRate δ‖+7+2*(3*L^2) ≤ _
    dsimp only [Y]
    nlinarith only [hz,mul_le_mul_of_nonneg_right hL h0.le,hL,abs_nonneg δ,mul_nonneg h0.le (abs_nonneg δ)]
  have hsD := mul_le_mul_of_nonneg_right hs (show 0≤3*L^2 by positivity)
  have hsum := mul_le_mul_of_nonneg_left (add_le_add h1 hD) (Real.sqrt_nonneg q)
  have hh := mul_le_mul_of_nonneg_left hc (Real.sqrt_nonneg q)
  change D+Real.sqrt q*(conductorBudget q N δ g (tailTiling 1)+D) ≤ Real.sqrt q*Y
  linarith only [hD,hsD,hsum,hh]

#print axioms twist
end GoldbachEnergy.Profile
