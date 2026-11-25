module

public import ZeroGrid

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

/-- A central mesh and independent geometric-series majorants for the two tails. -/
structure ZeroTiling where
  cells : ℕ
  step : ℝ
  wp : ℝ
  wm : ℝ
  yp : ℝ
  ym : ℝ
  cells_pos : 0 < cells
  step_pos : 0 < step
  radius_le : cells * step ≤ 9
  pos_tail : 0 < wp ∧ wp ≤ 18 ∧ cells * step + wp/2 ≤ yp
  neg_tail : 0 < wm ∧ wm ≤ 18 ∧ cells * step + wm/2 ≤ ym

def gammaBudget (q : ℕ) (z : ℂ) (g : ZeroTiling) : ℝ :=
  (∑ i ∈ range g.cells, gridIncrement g.cells z g.step i * centerCount q ((i+1:ℕ)*g.step)) +
    rayBound q z 1 (g.cells*g.step) g.wp g.yp +
    rayBound q z (-1) (g.cells*g.step) g.wm g.ym

theorem critical_sum_le_budget_of_count {q : ℕ} [NeZero q] {Z : Finset ℂ} {ord : ℂ → ℕ}
    (cnt : JensenCount q Z ord) (S : Finset ℂ) (hS : S ⊆ Z)
    (hline : ∀ s ∈ S, s.re=1/2) {z : ℂ} (hz : z ≠ 0) (ha : |z.arg| < π/2) (g : ZeroTiling) :
    ∑ s ∈ S, (ord s:ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤ gammaBudget q z g := by
  have hh := g.step_pos
  apply all_critical_zeros_of_count cnt S hS hline hz ha (mul_nonneg (Nat.cast_nonneg _) hh.le)
    g.pos_tail g.neg_tail (range g.cells) (fun i => (i+1:ℕ)*g.step) (gridIncrement g.cells z g.step)
  · intro i hi
    exact ⟨by positivity, (mul_le_mul_of_nonneg_right (show ((i+1:ℕ):ℝ) ≤ g.cells by exact_mod_cast mem_range.mp hi) hh.le).trans g.radius_le⟩
  · exact fun i _ => le_max_right _ _
  · intro s hs ht
    have he : critical s.im = s := by
      apply Complex.ext <;> simp [critical, hline s hs]
    simpa only [he] using grid_covers g.cells g.cells_pos hz ha hh ht

theorem critical_sum_le_budget {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1) {T : ℝ} (S : Finset ℂ) (hS : S ⊆ zerosRect χ T)
    (hline : ∀ s ∈ S, s.re=1/2) {z : ℂ} (hz : z ≠ 0) (ha : |z.arg| < π/2) (g : ZeroTiling) :
    ∑ s ∈ S, (multRect χ T s:ℝ)*‖Complex.Gamma s*z^(-s)‖ ≤ gammaBudget q z g :=
  critical_sum_le_budget_of_count (character_count hp hχ T) S hS hline hz ha g

#print axioms critical_sum_le_budget
end GoldbachEnergy
