module

public import CharacterFormula
public import TernaryGoldbach.Explicit.ZeroSums

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

/-- A zero window has different decay constants on the two half-lines. -/
theorem signed_exponent_window {z : ℂ} (hz : |z.arg| < π/2)
    {l t u : ℝ} (hlt : l ≤ t) (htu : t ≤ u) :
    -(π*|t|/2)+z.arg*t ≤ -((π/2-z.arg)*max l 0 + (π/2+z.arg)*max (-u) 0) := by
  have hpos : 0 ≤ π/2-z.arg := by linarith [le_abs_self z.arg]
  have hneg : 0 ≤ π/2+z.arg := by linarith [neg_abs_le z.arg]
  have ha := mul_le_mul_of_nonneg_left (max_le_max hlt (le_refl 0)) hpos
  have hb := mul_le_mul_of_nonneg_left (max_le_max (neg_le_neg htu) (le_refl 0)) hneg
  by_cases ht : 0 ≤ t
  · rw [abs_of_nonneg ht]
    rw [max_eq_left ht] at ha
    rw [max_eq_right (neg_nonpos.mpr ht)] at hb
    linarith
  · have ht' := (lt_of_not_ge ht).le
    rw [abs_of_nonpos ht']
    rw [max_eq_right ht'] at ha
    rw [max_eq_left (neg_nonneg.mpr ht')] at hb
    linarith

/-- A Jensen bound for the number of zeros, counted with multiplicity, in a disk. -/
def JensenCount (q : ℕ) (Z : Finset ℂ) (ord : ℂ → ℕ) : Prop :=
  ∀ (S : Finset ℂ), S ⊆ Z → ∀ c : ℝ, ∀ {r : ℝ}, 0 < r → r < 10 →
    (∀ s ∈ S, ‖s-(2+c*I)‖ ≤ r) →
    ∑ s ∈ S, (ord s : ℝ) ≤ Real.log (BP q c/0.355)/Real.log (10/r)

theorem character_count {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) (T : ℝ) : JensenCount q (zerosRect χ T) (multRect χ T) :=
  fun S hS v _ hr hr10 hball => sum_multRect_le hp hχ S hS v hr hr10 hball

theorem critical_window_of_count {q : ℕ} [NeZero q] {Z : Finset ℂ} {ord : ℂ → ℕ}
    (cnt : JensenCount q Z ord) (S : Finset ℂ) (hS : S ⊆ Z)
    (v : ℝ) {w : ℝ} (hw : 0 ≤ w) (hw9 : w ≤ 9)
    (hline : ∀ s ∈ S, s.re = 1/2 ∧ |s.im-v| ≤ w) {z : ℂ} (hz : z ≠ 0) (ha : |z.arg| < π/2) :
    ∑ s ∈ S, (ord s : ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤
      (Real.log (BP q v/0.355)/Real.log (10/Real.sqrt (9/4+w^2)))*
      (Real.sqrt (2*π)/Real.sqrt ‖z‖ *
        Real.exp (-((π/2-z.arg)*max (v-w) 0+(π/2+z.arg)*max (-(v+w)) 0))) := by
  let r := Real.sqrt (9/4+w^2)
  have hr : 0 < r := by dsimp [r]; positivity
  have hr10 : r < 10 := (Real.sqrt_lt' (by norm_num)).mpr (by nlinarith [sq_nonneg (9-w),mul_self_le_mul_self hw hw9])
  have hball (s : ℂ) (hs : s ∈ S) : ‖s-(2+v*I)‖ ≤ r := by
    obtain ⟨hre,him⟩ := hline s hs
    apply Real.le_sqrt_of_sq_le
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp [hre, pow_two] at ⊢
    nlinarith [(sq_le_sq₀ (abs_nonneg (s.im-v)) hw).2 him, sq_abs (s.im-v)]
  have hcount := cnt S hS v hr hr10 hball
  let W := Real.sqrt (2*π)/Real.sqrt ‖z‖ *
    Real.exp (-((π/2-z.arg)*max (v-w) 0+(π/2+z.arg)*max (-(v+w)) 0))
  have hweight (s : ℂ) (hs : s ∈ S) : ‖Complex.Gamma s*z^(-s)‖ ≤ W := by
    obtain ⟨hre,him⟩ := hline s hs
    have hs' : critical s.im = s := by apply Complex.ext <;> simp [critical,hre]
    have hg := critical_gamma_signed s.im hz
    rw [hs'] at hg
    apply hg.trans
    apply mul_le_mul_of_nonneg_left (Real.exp_le_exp.mpr _) (by positivity)
    exact signed_exponent_window ha (by linarith [(abs_le.mp him).1]) (by linarith [(abs_le.mp him).2])
  calc _ ≤ ∑ s ∈ S, (ord s : ℝ)*W := Finset.sum_le_sum fun s hs =>
          mul_le_mul_of_nonneg_left (hweight s hs) (by positivity)
       _ = (∑ s ∈ S, (ord s : ℝ))*W := (Finset.sum_mul ..).symm
       _ ≤ _ := mul_le_mul_of_nonneg_right hcount (by dsimp [W]; positivity)

theorem critical_window {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) {T : ℝ} (S : Finset ℂ) (hS : S ⊆ zerosRect χ T)
    (v : ℝ) {w : ℝ} (hw : 0 ≤ w) (hw9 : w ≤ 9)
    (hline : ∀ s ∈ S, s.re = 1/2 ∧ |s.im-v| ≤ w) {z : ℂ} (hz : z ≠ 0) (ha : |z.arg| < π/2) :
    ∑ s ∈ S, (multRect χ T s : ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤
      (Real.log (BP q v/0.355)/Real.log (10/Real.sqrt (9/4+w^2)))*
      (Real.sqrt (2*π)/Real.sqrt ‖z‖ *
        Real.exp (-((π/2-z.arg)*max (v-w) 0+(π/2+z.arg)*max (-(v+w)) 0))) :=
  critical_window_of_count (character_count hp hχ T) S hS v hw hw9 hline hz ha

#print axioms critical_window
end GoldbachEnergy
