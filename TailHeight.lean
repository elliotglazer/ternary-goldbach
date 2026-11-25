module

public import LogCertificate
public import LongRay
public import TernaryGoldbach.Explicit.ExplicitBound

@[expose] public section


open Real TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

private theorem constant_log_bounds :
    Real.log 4900 ≤ 9 ∧ Real.log 100 ≤ 4.7 ∧ Real.log 125 ≤ 5 := by
  constructor
  · have h := upper_log_certificate 9 0 4900 (by norm_num) (by norm_num) (by norm_num) (by norm_num [expPoly])
    simpa using h
  constructor
  · have h := upper_log_certificate 4 (7/10) 100 (by norm_num) (by norm_num) (by norm_num) (by norm_num [expPoly])
    norm_num at h ⊢; linarith
  · have h := upper_log_certificate 5 0 125 (by norm_num) (by norm_num) (by norm_num) (by norm_num [expPoly])
    simpa using h

theorem tail_log_level {L : ℝ} (hL : 100≤L) (q : ℕ) (hq : 0<q) (hl : (q:ℝ)≤4900*L^4) :
    Real.log q ≤ 0.28*L := by
  have hL0 : 0<L := by linarith
  have h := Real.log_le_sub_one_of_pos (show 0<L/100 by positivity)
  rw [Real.log_div hL0.ne' (by norm_num)] at h
  have hi := Real.log_le_log (by exact_mod_cast hq : 0<(q:ℝ)) hl
  rw [Real.log_mul (by norm_num) (pow_pos hL0 4).ne',Real.log_pow] at hi
  norm_num only [Nat.cast_ofNat] at hi
  have e₁ := constant_log_bounds.1
  have e₂ := constant_log_bounds.2.1
  linarith

/-- A single zero-count bound for the unbounded range log N >= 100. -/
theorem tail_log_BP {N Y : ℝ} (hn : 1≤N) (hL : 100≤Real.log N) (q : ℕ) [NeZero q]
    (hl : (q:ℝ) ≤ 4900*(Real.log N)^4) (hY : |Y| ≤ 40*N) :
    Real.log (BP q Y/0.355) ≤ 15*Real.log N := by
  have hp : 0<N := lt_of_lt_of_le zero_lt_one hn
  have hq0 := Nat.pos_of_ne_zero (NeZero.ne q)
  have hq : (1:ℝ)≤q := by exact_mod_cast hq0
  have hq' : (0:ℝ)<q := lt_of_lt_of_le zero_lt_one hq
  have hplus := Real.log_le_log (show (0:ℝ)<(q:ℝ)+1 by positivity) (show (q:ℝ)+1≤2*q by linarith)
  rw [Real.log_mul (by norm_num) hq'.ne'] at hplus
  have h2 := Real.log_le_sub_one_of_pos (by norm_num : (0:ℝ)<2)
  have hc : Real.log 1400 - Real.log 0.355 ≤ 9 := by
    rw [← Real.log_div (by norm_num) (by norm_num)]
    exact (Real.log_le_log (by norm_num) (by norm_num : (1400:ℝ)/0.355 ≤ 4900)).trans constant_log_bounds.1
  have ha := Real.log_le_log (show 0 < |Y|+22 by positivity) (show |Y|+22≤125*N by linarith)
  have hb := Real.log_le_log (show 0<1.25*(|Y|+11) by positivity) (show 1.25*(|Y|+11)≤125*N by linarith)
  rw [Real.log_mul (by norm_num) hp.ne'] at ha hb
  rw [log_BP_eq]
  linarith only [tail_log_level hL q hq0 hl,hplus,h2,hc,ha,hb,constant_log_bounds.2.2,hL]

#print axioms tail_log_level
#print axioms tail_log_BP
end GoldbachEnergy
