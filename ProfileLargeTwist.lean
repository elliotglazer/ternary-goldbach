module

public import ProfileTransfer

@[expose] public section


open Real
noncomputable section
namespace GoldbachEnergy.Profile

theorem beyond_intervals {N δ c : ℝ} {q : ℕ}
    (hn : 2*10^19 ≤ N) (hl : 44 ≤ Real.log N) (hu : Real.log N ≤ 56)
    (hc : 30 ≤ c) (hc' : c ≤ 70) (order : minorOrder N=c^2*(Real.log N)^4)
    (hq : 0 < q) (ho : (q:ℝ) ≤ minorOrder N) (hd : |δ| ≤ N/(minorOrder N*q)) (hδ : 262144 ≤ |δ|) :
    ∃ g u : ZeroTiling, twistedBudget N q δ g u+minorPrincipalBudget N q δ ≤ 0.315*N/Real.log N := by
  let t := Real.sqrt q
  let s := Real.sqrt |δ|
  let L := Real.log N
  let R := Real.sqrt N
  have hN : 0 < N := by linarith
  have hr : 0 < R := Real.sqrt_pos.mpr hN
  have h0 : 0 < L := by dsimp [L]; linarith
  have hL : 44 ≤ L := hl
  have geo := geometry hN hl hc hc' order hq ho hd
  have hts : 0 ≤ t*s*L := mul_nonneg (mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)) h0.le
  have coef := mul_le_mul hc hL (by norm_num : (0:ℝ) ≤ 44) (show 0 ≤ c by linarith)
  have coef' : 409 ≤ 0.31*(c*L) := by linarith only [coef]
  have hv : t*L/R*(409*s) ≤ 0.31 := by
    rw [div_mul_eq_mul_div,div_le_iff₀ hr]
    linarith only [mul_le_mul_of_nonneg_right coef' hts,mul_le_mul_of_nonneg_left geo.2.1 (by norm_num : (0:ℝ) ≤ 0.31)]
  have normlb : 100000 ≤ ‖twistRate δ‖ := by
    rw [twist_norm_exact]
    apply Real.le_sqrt_of_sq_le
    have hpi := mul_le_mul_of_nonneg_right Real.pi_gt_three.le (abs_nonneg δ)
    have h : (100000:ℝ) ≤ 2*π* |δ| := by linarith only [hpi,hδ]
    linarith only [pow_le_pow_left₀ (by norm_num : (0:ℝ) ≤ 100000) h 2]
  have pc : minorConstant N ≤ 0.096 := by unfold minorConstant; split <;> norm_num
  have h1 : (1:ℝ) ≤ q := by exact_mod_cast hq
  have pp := principal_on_box (q:=q) (δ:=δ) hq (by linarith only [hn]) hu pc
    (by norm_num : (0:ℝ) < 100000) normlb (by norm_num : (0:ℝ) < 1) h1
  have hp : L/N*minorPrincipalBudget N q δ ≤ 0.001 := by
    apply pp.trans ((min_le_right _ _).trans ?_)
    have hs : Real.sqrt (2/1:ℝ) ≤ 1.5 := Real.sqrt_le_iff.mpr ⟨by norm_num,by norm_num⟩
    linarith only [hs]
  exact of_normalized (tailTiling (twistRate δ)) hn hl hu hc hc' order hq ho hd
    (fun d _ h => tail_profile h hn hl hu hq ho hd hδ) hp hv (by norm_num)
#print axioms beyond_intervals
end GoldbachEnergy.Profile
