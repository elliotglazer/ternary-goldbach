module

public import TailScale
public import TotientSquare
public import MajorNumerics

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy

theorem major_scale {N : ℝ} (hn : 2*10^19 ≤ N) :
    (Real.log N)^2 ≤ 0.000000455*Real.sqrt N := by
  let L := Real.log N
  have hN : 0<N := lt_of_lt_of_le (by norm_num) hn
  have hl : 44 ≤ L := log_two_e19 hn
  have hroot : 4470000000 ≤ Real.sqrt N := Real.le_sqrt_of_sq_le (by linarith)
  by_cases h : L ≤ 45
  · change L^2 ≤ _
    have h2 := sq_le_sq' (by linarith : -(45:ℝ)≤L) h
    linarith only [h2,hroot]
  have h45 := le_of_not_ge h
  have hx := Real.log_le_sub_one_of_pos (show 0<L/45 by positivity)
  have hlog : Real.log ((L/45)^2) ≤ (L-45)/2 := by rw [Real.log_pow]; norm_num; linarith
  have hpow := Real.exp_le_exp.mpr hlog
  rw [Real.exp_log (pow_pos (by positivity) 2)] at hpow
  have hnum : (45:ℝ)^2 ≤ 0.000000455*Real.exp (45/2) := by
    rw [show (45:ℝ)/2=(22:ℕ)*(1:ℝ)+1/2 by norm_num,Real.exp_add,Real.exp_nat_mul]
    have he : (2.7:ℝ)≤Real.exp 1 := by linarith [Real.exp_one_gt_d9]
    have hhalf := Real.add_one_le_exp (1/2)
    have hh := mul_le_mul (pow_le_pow_left₀ (by norm_num) he 22) hhalf (by norm_num) (by positivity)
    linarith only [hh]
  have h1 := mul_le_mul hpow hnum (by norm_num : (0:ℝ)≤45^2) (Real.exp_pos _).le
  have hs : Real.sqrt N = Real.exp (L/2) := by
    rw [Real.sqrt_eq_rpow,Real.rpow_def_of_pos hN]; congr 1; unfold L; ring
  rw [show Real.exp ((L-45)/2)*(0.000000455*Real.exp (45/2)) = 0.000000455*Real.exp (L/2) by
        rw [mul_left_comm,← Real.exp_add]; congr 2; ring] at h1
  rw [hs]; change L^2 ≤ _
  calc L^2 = (L/45)^2*(45:ℝ)^2 := by ring
       _ ≤ _ := h1

theorem major_geometry {N δ : ℝ} (hn : 2*10^19 ≤ N) (q : ℕ) (hq : 0<q)
    (hqmax : (q:ℝ) ≤ modulusCutoff N) (hd : |δ| ≤ 2*Real.log N/q.totient) :
    Real.sqrt q ≤ 1.05*Real.log N ∧
    Real.sqrt q*Real.sqrt ‖twistRate δ‖ ≤ 4.5*Real.log N := by
  let L := Real.log N
  let t := Real.sqrt q
  have hl : 44≤L := log_two_e19 hn
  have h0 : 0<L := by linarith
  have ht0 : 0≤t := Real.sqrt_nonneg _
  have ht2 : t^2=(q:ℝ) := Real.sq_sqrt (Nat.cast_nonneg q)
  have htφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hqL : (q:ℝ)≤1.1*L^2 := hqmax
  have ht : t≤1.05*L := by apply (Real.sqrt_le_left (by positivity)).mpr; nlinarith only [hqL,sq_nonneg L]
  have hφ : t≤1.42*(q.totient:ℝ) := by
    apply (Real.sqrt_le_left (by positivity)).mpr
    have h := (show (q:ℝ) ≤ 2*(q.totient:ℝ)^2 by exact_mod_cast totient_square_bound q)
    nlinarith only [h,sq_nonneg (q.totient:ℝ)]
  have hδ := (le_div_iff₀ htφ).mp hd
  have hqδ : (q:ℝ)*|δ| ≤ 2.982*L^2 := by
    have h1 := mul_le_mul_of_nonneg_right hφ (mul_nonneg ht0 (abs_nonneg δ))
    have h2 := mul_le_mul_of_nonneg_right hδ ht0
    have h3 := mul_le_mul_of_nonneg_right ht h0.le
    rw [← ht2]
    change |δ| * (q.totient:ℝ) ≤ 2*L at hδ
    change |δ| * (q.totient:ℝ)*t ≤ 2*L*t at h2
    nlinarith only [h1,h2,h3]
  refine ⟨ht,(sq_le_sq₀ (mul_nonneg ht0 (Real.sqrt_nonneg _)) (by positivity)).mp ?_⟩
  change (t*Real.sqrt ‖twistRate δ‖)^2 ≤ (4.5*L)^2
  rw [mul_pow,ht2,Real.sq_sqrt (norm_nonneg _)]
  have hz := mul_le_mul_of_nonneg_left (twist_norm_bounds δ).2 (Nat.cast_nonneg q : (0:ℝ)≤q)
  nlinarith only [hz,hqδ,hqL,sq_nonneg L]

#print axioms major_geometry
#print axioms major_scale
end GoldbachEnergy
