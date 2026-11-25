module

public import RegularizedMellin
public import TernaryGoldbach.Explicit.ExplicitFormula

@[expose] public section


open Complex Real Set TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

private theorem strip_rate {z s : ℂ} (hz : 1 ≤ ‖z‖) (hs : -1/2 ≤ s.re) :
    ‖z ^ (-s)‖ ≤ Real.sqrt ‖z‖ * Real.exp (|z.arg| * |s.im|) := by
  have hz' : z ≠ 0 := by rintro rfl; norm_num at hz
  rw [Complex.norm_cpow_of_ne_zero hz', Complex.neg_re,Complex.neg_im,mul_neg,
    Real.exp_neg,div_inv_eq_mul,Real.sqrt_eq_rpow]
  apply mul_le_mul (Real.rpow_le_rpow_of_exponent_le hz (by linarith))
    (Real.exp_le_exp.mpr _) (Real.exp_pos _).le (Real.rpow_nonneg (norm_nonneg _) _)
  simpa only [abs_mul] using le_abs_self (z.arg*s.im)

private theorem gamma_strip {φ : ℝ} (hφ : 0 ≤ φ) (hπ : φ < π/2) :
    ∃ B ≥ (0:ℝ), ∀ s : ℂ, -1/2 ≤ s.re → s.re ≤ 3/2 →
      ‖Complex.Gamma (s+1)‖ ≤ B*Real.exp (-(φ*|s.im|)) := by
  let f := fun x : ℝ => Real.Gamma x*(Real.cos φ)^(-x)
  have hp : 0 < Real.cos φ := Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos],hπ⟩
  have hf : ContinuousOn f (Icc (1/2:ℝ) (5/2)) := by
    apply ContinuousOn.mul
    · exact Real.differentiableOn_Gamma_Ioi.continuousOn.mono (fun x hx => by
        have := hx.1; exact (show 0<x by linarith))
    · fun_prop (disch := positivity)
  obtain ⟨B,hB⟩ := isCompact_Icc.exists_bound_of_continuousOn hf
  refine ⟨max 0 B,le_max_left _ _,fun s h1 h2 => ?_⟩
  have hmem : (s+1).re ∈ Icc (1/2:ℝ) (5/2) := by
    simp only [Complex.add_re,Complex.one_re]; constructor <;> linarith
  have hb : f (s+1).re ≤ max 0 B :=
    (le_abs_self _).trans ((hB _ hmem).trans (le_max_right _ _))
  have h := norm_Gamma_le_rot (a := s+1) (by linarith [hmem.1]) hφ hπ
  simp only [Complex.add_im,Complex.one_im,add_zero] at h
  calc _ ≤ _ := h
       _ = f (s+1).re * Real.exp (-(φ*|s.im|)) := by dsimp [f]; ring
       _ ≤ _ := mul_le_mul_of_nonneg_right hb (Real.exp_pos _).le

private theorem bounded_middle {N : ℝ} (hN : 1≤N) (δ c : ℝ) :
    ∃ B : ℝ, ∀ s : ℂ, -1/2 ≤ s.re → s.re ≤ 3/2 → |s.im| ≤ 1 →
    ‖mellin (cancelledWeight N δ) s‖*Real.exp (c*|s.im|) ≤ B := by
  let V := (Icc (-1/2:ℝ) (3/2)) ×ˢ (Icc (-1:ℝ) 1)
  let Z := fun p : ℝ × ℝ => (p.1:ℂ) + (p.2:ℂ)*I
  have hZ : Continuous Z := by dsimp [Z]; fun_prop
  let F := fun p : ℝ × ℝ => ‖mellin (cancelledWeight N δ) (Z p)‖*Real.exp (c*|p.2|)
  have hF : ContinuousOn F V := by
    apply ContinuousOn.mul
    · intro p hp
      have hre : -1 < (Z p).re := by
        have hh : -1/2 ≤ p.1 := hp.1.1
        simp [Z]; linarith
      exact (((cancelled_mellin hN δ hre).2.continuousAt.comp hZ.continuousAt).norm).continuousWithinAt
    · fun_prop
  obtain ⟨B,hB⟩ := (isCompact_Icc.prod isCompact_Icc).exists_bound_of_continuousOn hF
  refine ⟨B,fun s h1 h2 ht => ?_⟩
  have h := (le_abs_self _).trans (hB (s.re,s.im) ⟨⟨h1,h2⟩,abs_le.mp ht⟩)
  simpa [F,Z] using h

theorem good_cancelled_weight {N : ℝ} (hN : 1 ≤ N) (δ : ℝ) :
    ∃ K c : ℝ, GoodSmoothing (cancelledWeight N δ) K c := by
  let z := twistRate δ
  let a := |z.arg|
  have hz : 1 ≤ ‖z‖ := by simpa [z,twistRate] using Complex.abs_re_le_norm z
  have hangle : a < π/2 := Complex.abs_arg_lt_pi_div_two_iff.mpr
    (Or.inl (show 0 < z.re by simp [z,twistRate]))
  let c := (π/2-a)/2
  have hc : 0 < c := by dsimp [c]; linarith
  have ha : 0 ≤ a := abs_nonneg _
  obtain ⟨B,hB,hgamma⟩ := gamma_strip (φ := a+c) (by linarith) (by dsimp [c]; linarith)
  obtain ⟨D,hD⟩ := bounded_middle hN δ c
  let A := Real.sqrt ‖z‖ + Real.sqrt N
  refine ⟨max D (A*B),c,?_,(cancelled_mellin hN δ (by norm_num)).1,
    fun s hs => (cancelled_mellin hN δ hs).2,hc,?_⟩
  · intro y _; unfold cancelledWeight; fun_prop
  intro s h1 h2
  by_cases ht : |s.im| ≤ 1
  · rw [Real.exp_neg, ← div_eq_mul_inv, le_div_iff₀ (Real.exp_pos _)]
    exact (hD s h1 h2 ht).trans (le_max_left _ _)
  have hsn : 1 ≤ ‖s‖ := (le_of_not_ge ht).trans (Complex.abs_im_le_norm _)
  have hN' : 1 ≤ ‖(N:ℂ)‖ := by simpa [abs_of_nonneg (show 0≤N by linarith)] using hN
  have he : 1 ≤ Real.exp (a*|s.im|) := Real.one_le_exp (mul_nonneg ha (abs_nonneg _))
  have hrate := strip_rate (s := s) hN' h1
  simp [Complex.arg_ofReal_of_nonneg (show 0≤N by linarith),
    abs_of_nonneg (show 0≤N by linarith)] at hrate
  have hsub : ‖z^(-s)-(N:ℂ)^(-s)‖ ≤ A*Real.exp (a*|s.im|) := by
    apply (norm_sub_le _ _).trans
    dsimp only [A]; rw [add_mul]
    exact add_le_add (strip_rate hz h1) (hrate.trans (le_mul_of_one_le_right (Real.sqrt_nonneg _) he))
  have h := congrArg norm (cancelled_mellin_strip hN δ (s := s) (by linarith))
  simp only [norm_mul] at h
  calc ‖mellin (cancelledWeight N δ) s‖ ≤ ‖s‖*‖mellin (cancelledWeight N δ) s‖ :=
          le_mul_of_one_le_left (norm_nonneg _) hsn
       _ = _ := h
       _ ≤ (A*Real.exp (a*|s.im|))*(B*Real.exp (-((a+c)*|s.im|))) :=
          mul_le_mul hsub (hgamma s h1 h2) (norm_nonneg _) (by dsimp [A]; positivity)
       _ = (A*B)*Real.exp (-(c*|s.im|)) := by
          rw [show -(c*|s.im|) = a*|s.im| + -((a+c)*|s.im|) by ring,Real.exp_add]; ring
       _ ≤ _ := mul_le_mul_of_nonneg_right (le_max_right _ _) (Real.exp_pos _).le

#print axioms good_cancelled_weight
end GoldbachEnergy
