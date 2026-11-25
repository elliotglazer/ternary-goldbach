module

public import GammaBudget
public import TrivialZero

@[expose] public section


open Real Complex Finset TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

theorem critical_residue {N : ℝ} (hn : 1 ≤ N) (δ : ℝ) {s : ℂ} (hs : s.re=1/2) :
    ‖mellin (cancelledWeight N δ) s*(N:ℂ)^s‖ ≤
      Real.sqrt N*‖Complex.Gamma s*twistRate δ^(-s)‖+‖Complex.Gamma s‖ := by
  have hn0 : 0<N := by linarith
  have hnz : (N:ℂ)≠0 := by exact_mod_cast hn0.ne'
  have hpow : (N:ℂ)^s ≠ 0 := Complex.cpow_ne_zero_iff.mpr (Or.inl hnz)
  rw [cancelled_mellin_right hn δ (by rw [hs]; norm_num),Complex.cpow_neg (N:ℂ) s]
  have hid : (twistRate δ^(-s)-((N:ℂ)^s)⁻¹)*Complex.Gamma s*(N:ℂ)^s =
      Complex.Gamma s*twistRate δ^(-s)*(N:ℂ)^s-Complex.Gamma s  := by field_simp [hpow] <;> ring
  rw [hid]
  apply (norm_sub_le _ _).trans_eq
  rw [norm_mul (Complex.Gamma s*_), norm_cpow_x hn0, hs, ← Real.sqrt_eq_rpow, mul_comm]

def residueBudget (q : ℕ) (N δ : ℝ) (g u : ZeroTiling) : ℝ :=
  (Real.log (BP q 0/0.355)/Real.log (10/2))*‖Complex.log (N:ℂ)-Complex.log (twistRate δ)‖ +
  (Real.sqrt N*gammaBudget q (twistRate δ) g+gammaBudget q 1 u)

theorem rectangle_residues_of_count {q : ℕ} [NeZero q] {Z : Finset ℂ} {ord : ℂ → ℕ}
    (cnt : JensenCount q Z ord) (cls : ∀ s ∈ Z, s=0 ∨ s.re=1/2)
    {N : ℝ} (hn : 1 ≤ N) (δ : ℝ) (g u : ZeroTiling) :
    ‖∑ s ∈ Z, (ord s:ℂ)*(mellin (cancelledWeight N δ) s*(N:ℂ)^s)‖ ≤
      residueBudget q N δ g u := by
  classical
  let S := Z.filter (fun s => s ≠ 0)
  let O := Z.filter (fun s => s = 0)
  let F := fun s : ℂ => (ord s:ℝ)*‖mellin (cancelledWeight N δ) s*(N:ℂ)^s‖
  have hS : S ⊆ Z := filter_subset _ _
  have hline (s : ℂ) (hs : s ∈ S) : s.re = 1/2 :=
    (cls s (hS hs)).resolve_left (mem_filter.mp hs).2
  have hz : 0<(twistRate δ).re := by simp [twistRate]
  have hzne : twistRate δ ≠ 0 := by intro hh; rw [hh] at hz; simp at hz
  have htw := critical_sum_le_budget_of_count cnt S hS hline hzne (Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl hz)) g
  have hone := critical_sum_le_budget_of_count cnt S hS hline (z := 1) one_ne_zero (by simp [Real.pi_pos]) u
  simp only [Complex.one_cpow,mul_one] at hone
  have hc : ∑ s ∈ S, F s ≤ Real.sqrt N*gammaBudget q (twistRate δ) g+gammaBudget q 1 u := by
    calc _ ≤ ∑ s ∈ S, (ord s:ℝ)*(Real.sqrt N*‖Complex.Gamma s*twistRate δ^(-s)‖+‖Complex.Gamma s‖) :=
          sum_le_sum fun s hs => mul_le_mul_of_nonneg_left (critical_residue hn δ (hline s hs)) (by positivity)
         _ = Real.sqrt N*(∑ s ∈ S, (ord s:ℝ)*‖Complex.Gamma s*twistRate δ^(-s)‖)+
               ∑ s ∈ S, (ord s:ℝ)*‖Complex.Gamma s‖ := by
           simp_rw [mul_add, mul_left_comm (ord _:ℝ) (Real.sqrt N)]
           rw [sum_add_distrib,← mul_sum]
         _ ≤ _ := add_le_add (mul_le_mul_of_nonneg_left htw (Real.sqrt_nonneg _)) hone
  have hcount := cnt O (filter_subset _ _) 0 (r:=2) (by norm_num) (by norm_num)
    (fun s hs => by rw [(mem_filter.mp hs).2]; norm_num)
  have hO : ∑ s ∈ O, F s ≤ (Real.log (BP q 0/0.355)/Real.log (10/2))*‖Complex.log (N:ℂ)-Complex.log (twistRate δ)‖ := calc
    _ = ∑ s ∈ O, (ord s:ℝ)*‖Complex.log (N:ℂ)-Complex.log (twistRate δ)‖ := by
      apply sum_congr rfl; intro s hs; rw [(mem_filter.mp hs).2]
      simp [F,cancelled_mellin_zero hn]
    _ ≤ _ := by rw [← sum_mul]; exact mul_le_mul_of_nonneg_right hcount (norm_nonneg _)
  apply (norm_sum_le _ _).trans
  change ∑ s ∈ Z, _ ≤ _
  simp only [norm_mul (ord _:ℂ),Complex.norm_natCast]
  change ∑ s ∈ Z, F s ≤ _
  rw [← sum_filter_add_sum_filter_not Z (fun s => s=0)]
  exact add_le_add hO hc

theorem rectangle_residues {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1)
    (grh : ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℝ} (hn : 1 ≤ N) (δ T : ℝ) (g u : ZeroTiling) :
    ‖∑ s ∈ zerosRect χ T, (multRect χ T s:ℂ)*(mellin (cancelledWeight N δ) s*(N:ℂ)^s)‖ ≤
      residueBudget q N δ g u :=
  rectangle_residues_of_count (character_count hp hχ T) (fun _ hs => critical_or_zero hp hχ grh hs) hn δ g u


#print axioms rectangle_residues
end GoldbachEnergy
