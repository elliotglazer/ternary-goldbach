module

public import PrincipalWave
public import Route
public import Mathlib.NumberTheory.DiophantineApproximation.Basic

@[expose] public section


open Real MeasureTheory TernaryGoldbach
namespace GoldbachEnergy

noncomputable def modulusCutoff (N : ℝ) := 1.1*(Real.log N)^2
noncomputable def approximationOrder (N : ℝ) := 4900*(Real.log N)^4
noncomputable def radius (N : ℝ) (q : ℕ) := 2*Real.log N/(q.totient*N)

/-- All translates are included so the major arcs wrap across the period endpoint. -/
def centralArcs (N : ℝ) : Set ℝ :=
  ⋃ r : {r : ℚ // (r.den:ℝ) ≤ modulusCutoff N},
    Set.Icc ((r.val:ℝ)-radius N r.val.den) ((r.val:ℝ)+radius N r.val.den)
def minorArcs (N : ℝ) := Set.Ioc (0:ℝ) 1 \ centralArcs N

theorem measurable_minorArcs (N : ℝ) : MeasurableSet (minorArcs N) :=
  measurableSet_Ioc.diff (MeasurableSet.iUnion (fun _ => measurableSet_Icc))

theorem rational_cover {τ x : ℝ} (hτ : 1 ≤ τ) :
    ∃ r : ℚ, (r.den:ℝ) ≤ τ ∧ |x-r| ≤ 1/(τ*r.den) := by
  have hf : 1 ≤ ⌊τ⌋₊ := Nat.le_floor (by simpa using hτ)
  obtain ⟨r,he,hd⟩ := Real.exists_rat_abs_sub_le_and_den_le x (by omega : 0<⌊τ⌋₊)
  have hf' := Nat.lt_floor_add_one τ
  have hr : 0 < (r.den:ℝ) := by exact_mod_cast r.pos
  refine ⟨r, (show (r.den:ℝ) ≤ (⌊τ⌋₊:ℕ) by exact_mod_cast hd).trans (Nat.floor_le (by linarith)),he.trans ?_⟩
  apply one_div_le_one_div_of_le (mul_pos (by linarith) hr)
  exact mul_le_mul_of_nonneg_right hf'.le hr.le

theorem principal_small_q {N α : ℝ} {r : ℚ} (hn : 1 < N) (hα : α ∉ centralArcs N)
    (hq : (r.den:ℝ) ≤ modulusCutoff N) :
    ‖principalWave N r.den (α-r)‖ ≤ 0.08*N/Real.log N := by
  let β := α-(r:ℝ)
  have hn0 : 0<N := by linarith
  have hL := Real.log_pos hn
  have hφ : (0:ℝ)<r.den.totient := by exact_mod_cast Nat.totient_pos.mpr r.pos
  have hoff : radius N r.den < |β| := by
    by_contra! h
    apply hα
    apply Set.mem_iUnion.mpr
    refine ⟨⟨r,hq⟩,?_⟩
    dsimp only [β] at h
    exact ⟨by linarith [(abs_le.mp h).2, (abs_le.mp h).1],
           by linarith [(abs_le.mp h).2, (abs_le.mp h).1]⟩
  have hx := (div_lt_iff₀ (mul_pos hφ hn0)).mp hoff
  have hi := Complex.abs_im_le_norm (((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I)
  have hIm : 2*π*|β| ≤ ‖((1/N : ℝ):ℂ) - ((2*π*β : ℝ):ℂ)*Complex.I‖ := by
    simpa [abs_mul,abs_of_pos Real.pi_pos] using hi
  have hfactor : 1 ≤ (0.08:ℝ)*2*π*2 := by linarith [Real.pi_gt_d6]
  have hnum : Real.log N ≤ (0.08*2*π)*(|β| *(r.den.totient*N)) := by
    have h1 := mul_le_mul_of_nonneg_right hfactor hL.le
    have h2 := mul_le_mul_of_nonneg_left hx.le (show (0:ℝ)≤0.08*2*π by positivity)
    calc Real.log N = 1 * Real.log N := (one_mul _).symm
         _ ≤ (0.08*2*π*2)*Real.log N := h1
         _ = (0.08*2*π)*(2*Real.log N) := by ring
         _ ≤ _ := h2
  let d := Real.log N/(0.08*r.den.totient)
  have hd : 0<d := by dsimp [d]; positivity
  have hden : d/N ≤ 2*π*|β| := by
    rw [div_le_iff₀ hn0]; unfold d; rw [div_le_iff₀ (by positivity)]
    calc _ ≤ _ := hnum
         _ = _ := by ring
  apply (norm_principal_of_den r.pos hn0 hd (hden.trans hIm)).trans_eq
  dsimp [d]; field_simp

theorem principal_on_minor {N α : ℝ} (hn : 10^20 ≤ N) (hα : α ∈ minorArcs N) (r : ℚ) :
    ‖principalWave N r.den (α-r)‖ ≤ 0.088*N/Real.log N := by
  have hn1 : 1<N := lt_of_lt_of_le (by norm_num) hn
  have hn0 : 0<N := by linarith
  have hl := Real.log_pos hn1
  by_cases hq : (r.den:ℝ) ≤ modulusCutoff N
  · apply (principal_small_q hn1 hα.2 hq).trans
    exact div_le_div_of_nonneg_right (mul_le_mul_of_nonneg_right (by norm_num) hn0.le) hl.le
  · have hratio := principal_ratio N r.den hn (lt_of_not_ge hq)
    have hφ : (0:ℝ)<r.den.totient := by exact_mod_cast Nat.totient_pos.mpr r.pos
    rw [div_lt_iff₀ hφ] at hratio
    apply (norm_principal N r.den (α-r) hn0 r.pos).trans
    rw [le_div_iff₀ hl,div_mul_eq_mul_div,div_le_iff₀ hφ]
    nlinarith only [mul_le_mul_of_nonneg_left hratio.le hn0.le]

/-- A single GRH estimate for the twisted remainder, on a rational approximation,
now suffices across both families of minor arcs. -/
theorem pointwise_from_twisted_estimate {N : ℝ} (hn : 10^20 ≤ N) {c : ℝ}
    (hrem : ∀ α ∈ minorArcs N, ∀ r : ℚ, (r.den:ℝ) ≤ approximationOrder N →
      |α-r| ≤ 1/(approximationOrder N*r.den) →
      ‖wave N α - principalWave N r.den (α-r)‖ ≤ (c-0.088)*N/Real.log N) :
    ∀ α ∈ minorArcs N, ‖wave N α‖ ≤ c*N/Real.log N := by
  intro α hα
  have hL := LeanLab.Zinoviev1997.log_1e20_ge.trans (Real.log_le_log (by norm_num) hn)
  have ht : 1 ≤ approximationOrder N := by
    dsimp [approximationOrder]
    nlinarith only [pow_le_pow_left₀ (by norm_num : (0:ℝ)≤46) hL 4]
  obtain ⟨r,hq,hβ⟩ := rational_cover (x := α) ht
  have h := hrem α hα r hq hβ
  have hp := principal_on_minor hn hα r
  have htri := norm_add_le (wave N α-principalWave N r.den (α-r)) (principalWave N r.den (α-r))
  rw [sub_add_cancel] at htri
  calc ‖wave N α‖ ≤ (c-0.088)*N/Real.log N + 0.088*N/Real.log N := htri.trans (add_le_add h hp)
       _ = _ := by ring

#print axioms principal_on_minor
#print axioms pointwise_from_twisted_estimate
end GoldbachEnergy
