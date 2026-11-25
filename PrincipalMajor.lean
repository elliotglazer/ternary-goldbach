module

public import PrincipalTransform
public import PrincipalTail

@[expose] public section


open Real MeasureTheory Finset ArithmeticFunction TernaryGoldbach Filter
open scoped ArithmeticFunction.Moebius
noncomputable section
namespace GoldbachEnergy

def ratAmplitude (q : ℕ) : ℂ := ((μ q : ℂ)/q.totient)^3
def centrePhase (N q : ℕ) : ℂ :=
  ∑ b ∈ (range q).filter (fun b => Nat.Coprime b q), e (-(N*((b:ℝ)/q)))
def localCube (N : ℝ) (q : ℕ) (u : ℝ) : ℂ :=
  principalWave N q u ^ 3 * e (-N*u)
def restrictedModel (N : ℕ) : ℂ :=
  ∑ q ∈ Icc 1 ⌊modulusCutoff N⌋₊, centrePhase N q *
    ∫ u in Set.Ioc (-radius N q) (radius N q), localCube N q u

theorem localCube_eq (N : ℝ) (q : ℕ) (u : ℝ) :
    localCube N q u = ratAmplitude q * ((1/centralDen (1/N) u^3)*e (-N*u)) := by
  unfold localCube principalWave centralDen ratAmplitude
  push_cast
  simp [div_eq_mul_inv,mul_pow,← inv_pow,mul_assoc]

theorem integrable_localCube {N : ℝ} (hN : 0<N) (q : ℕ) : Integrable (localCube N q) := by
  simp_rw [funext (localCube_eq N q)]
  apply Integrable.const_mul
  apply (integrable_invDen (one_div_pos.mpr hN)).mul_bdd (c := 1)
  · exact (continuous_e.comp (continuous_const.mul continuous_id)).aestronglyMeasurable
  · exact Eventually.of_forall fun u => (norm_e _).le

theorem localCube_full {N : ℝ} (hN : 0<N) (q : ℕ) :
    (∫ u : ℝ, localCube N q u) = ratAmplitude q * ((N^2/(2*Real.exp 1) : ℝ):ℂ) := by
  simp_rw [localCube_eq, integral_const_mul, central_integral (one_div_pos.mpr hN) hN]
  have ha : (-(↑(1/N):ℂ))*(N:ℂ) = -1 := by push_cast; field_simp [show (N:ℂ) ≠ 0 by exact_mod_cast hN.ne']
  rw [ha, ← Complex.ofReal_one, ← Complex.ofReal_neg, ← Complex.ofReal_exp,Real.exp_neg]
  push_cast; ring

theorem localCube_window_error {N : ℝ} (hN : 1<N) (q : ℕ) (hq : 0<q) :
    ‖(∫ u in Set.Ioc (-radius N q) (radius N q), localCube N q u) - ∫ u, localCube N q u‖ ≤
    (∫ t in Set.Ioi (radius N q), ‖principalWave N q t‖^3) +
    (∫ t in Set.Ioi (radius N q), ‖principalWave N q (-t)‖^3) := by
  let R := radius N q
  have hi := integrable_localCube (show 0<N by linarith) q
  have hφ : (0:ℝ)<q.totient := by exact_mod_cast Nat.totient_pos.mpr hq
  have hR : 0 ≤ R := by dsimp [R,radius]; positivity [Real.log_pos hN]
  have hc : (Set.Ioc (-R) R)ᶜ = Set.Iic (-R) ∪ Set.Ioi R := by
    ext t; simp only [Set.mem_compl_iff, Set.mem_Ioc,Set.mem_union,Set.mem_Iic,Set.mem_Ioi]; grind
  have hd : Disjoint (Set.Iic (-R)) (Set.Ioi R) := by
    apply Set.disjoint_left.mpr
    intro t h₁ h₂
    change t ≤ -R at h₁
    change R < t at h₂
    linarith
  rw [← integral_add_compl (s := Set.Ioc (-R) R) measurableSet_Ioc hi, sub_add_cancel_left, norm_neg]
  rw [hc, setIntegral_union hd measurableSet_Ioi hi.integrableOn hi.integrableOn]
  apply (norm_add_le _ _).trans
  rw [add_comm]
  apply add_le_add
  · simpa [localCube,norm_mul,norm_e] using (norm_integral_le_integral_norm
      («μ» := volume.restrict (Set.Ioi R)) (localCube N q))
  · rw [← integral_comp_neg_Ioi R (localCube N q)]
    simpa [localCube,norm_mul,norm_e] using (norm_integral_le_integral_norm
      («μ» := volume.restrict (Set.Ioi R)) (fun t => localCube N q (-t)))

theorem norm_centrePhase (N q : ℕ) : ‖centrePhase N q‖ ≤ q.totient := by
  unfold centrePhase
  apply (norm_sum_le _ _).trans_eq
  simp [norm_e,Nat.totient_eq_card_coprime,Nat.coprime_comm]

/-- The integral of the principal model over its finite windows has an absolute
error at most 0.00112 N² from the exact truncated singular main term. -/
theorem restrictedModel_error_from_two_e19 {N : ℕ} (hN : (2*10^19) ≤ N) :
    ‖restrictedModel N - (∑ q ∈ Icc 1 ⌊modulusCutoff N⌋₊,
      GoldbachSingular.fourierCoefficient N q) * (((N:ℝ)^2/(2*Real.exp 1):ℝ):ℂ)‖ ≤
      0.00112*(N:ℝ)^2 := by
  have hn : 1<(N:ℝ) := by exact_mod_cast (show 1<N by omega)
  have hM (q : ℕ) : GoldbachSingular.fourierCoefficient N q * (((N:ℝ)^2/(2*Real.exp 1):ℝ):ℂ) =
      centrePhase N q * ∫ u, localCube N q u := by
    rw [localCube_full (show 0<(N:ℝ) by linarith)]
    change (ratAmplitude q * centrePhase N q) * _ = _
    ring
  unfold restrictedModel
  rw [sum_mul]
  simp_rw [hM]
  rw [← sum_sub_distrib]
  simp_rw [← mul_sub]
  apply (norm_sum_le _ _).trans
  apply le_trans _ (sum_principal_tails_from_two_e19 (by exact_mod_cast hN))
  apply sum_le_sum
  intro q hq
  rw [norm_mul]
  exact mul_le_mul (norm_centrePhase N q) (localCube_window_error hn q (mem_Icc.mp hq).1)
    (norm_nonneg _) (by positivity)

theorem restrictedModel_error {N : ℕ} (hN : 10^20 ≤ N) :
    ‖restrictedModel N - (∑ q ∈ Icc 1 ⌊modulusCutoff N⌋₊,
      GoldbachSingular.fourierCoefficient N q) * (((N:ℝ)^2/(2*Real.exp 1):ℝ):ℂ)‖ ≤
      0.00112*(N:ℝ)^2 :=
  restrictedModel_error_from_two_e19 ((by norm_num : (2:ℕ)*10^19 ≤ 10^20).trans hN)

#print axioms restrictedModel_error
end GoldbachEnergy
