module

public import ProfileEnvelope
public import ProfileRemainder
public import RectPrincipal

@[expose] public section


open Real TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy.Profile

theorem product_limit {N δ : ℝ} {q : ℕ} (hn : 2*10^19 ≤ N) (hl : 44 ≤ Real.log N)
    (hu : Real.log N ≤ 56) (hq : 0 < q) (ho : (q:ℝ) ≤ minorOrder N)
    (hd : |δ| ≤ N/(minorOrder N*q)) :
    4*(q:ℝ)*(|8+‖twistRate δ‖|+22) ≤ 3000000000000000 := by
  let L := Real.log N
  have hL : 44 ≤ L := hl
  have hN : 0 < N := by linarith
  have hh := Real.exp_le_exp.mpr hu
  rw [Real.exp_log hN,show (56:ℝ)=(56:ℕ)*(1:ℝ) by norm_num,Real.exp_nat_mul] at hh
  have hhigh : N ≤ 21*10^23 := hh.trans ((pow_le_pow_left₀ (Real.exp_pos _).le Real.exp_one_lt_d9.le 56).trans (by norm_num))
  have hq0 : (0:ℝ) < q := by exact_mod_cast hq
  have lo := pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 44) hL 4
  have hi := pow_le_pow_left₀ (show 0 ≤ L by linarith) hu 4
  have hlog : 0 < Real.log N := by linarith only [hl]
  have ord0 : 0 < minorOrder N := by unfold minorOrder; split <;> positivity
  have hprod := (le_div_iff₀ (mul_pos ord0 hq0)).mp hd
  have pos := mul_nonneg hq0.le (abs_nonneg δ)
  have qmax : (q:ℝ) ≤ 50000000000 := by
    unfold minorOrder at ho; split at ho <;> dsimp [L] at hi <;> nlinarith only [hi,ho]
  have prod : (q:ℝ)* |δ| ≤ 116000000000000 := by
    unfold minorOrder at hprod
    split at hprod
    · rename_i hs
      dsimp [L] at lo
      nlinarith only [hs,hprod,mul_le_mul_of_nonneg_right lo pos]
    · dsimp [L] at lo
      nlinarith only [hhigh,hprod,mul_le_mul_of_nonneg_right lo pos]
  rw [abs_of_nonneg (by positivity : 0 ≤ 8+‖twistRate δ‖)]
  nlinarith only [qmax,prod,mul_le_mul_of_nonneg_left (twist_norm_bounds δ).2 hq0.le]

theorem tail_profile {N δ : ℝ} {d q : ℕ} [NeZero d] (hdq : d ≤ q)
    (hn : 2*10^19 ≤ N) (hl : 44 ≤ Real.log N) (hu : Real.log N ≤ 56)
    (hq : 0 < q) (ho : (q:ℝ) ≤ minorOrder N) (hd : |δ| ≤ N/(minorOrder N*q)) (hδ : 262144 ≤ |δ|) :
    gammaBudget d (twistRate δ) (tailTiling (twistRate δ)) ≤ 409*Real.sqrt |δ| := by
  have hp := product_limit hn hl hu hq ho hd
  have he : (2.7:ℝ)^36 ≤ Real.exp 36 := by
    rw [show (36:ℝ)=(36:ℕ)*(1:ℝ) by norm_num,Real.exp_nat_mul]
    apply pow_le_pow_left₀ (by norm_num); linarith only [Real.exp_one_gt_d9]
  have lb : Real.log (3000000000000000:ℝ) ≤ 36 := (Real.log_le_iff_le_exp (by norm_num)).mpr
    ((show (3000000000000000:ℝ) ≤ 2.7^36 by norm_num).trans he)
  have hb := product_log_BP hdq (by norm_num) hp
  have h := gamma_of_log_bounds (q:=d) (L:=37) (by norm_num) (twistRate δ) (twist_norm_bounds δ).1 (inverse_norm_le_gap δ)
    (by linarith only [hb,lb]) (by linarith only [hb,lb])
  have hs : 512 ≤ Real.sqrt |δ| := Real.le_sqrt_of_sq_le (by linarith only [hδ])
  linarith only [h,hs,sqrt_twist_bound δ]

#print axioms product_limit
#print axioms tail_profile
end GoldbachEnergy.Profile
