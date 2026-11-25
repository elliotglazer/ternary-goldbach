module

public import RegularizedMellin
public import TernaryGoldbach.Explicit.ZeroSums

@[expose] public section


open Real Complex Filter MeasureTheory Set TernaryGoldbach.Explicit
open scoped Topology
noncomputable section
namespace GoldbachEnergy

theorem cancelled_mellin_zero {N : ℝ} (hn : 1 ≤ N) (δ : ℝ) :
    mellin (cancelledWeight N δ) 0 = Complex.log (N:ℂ)-Complex.log (twistRate δ) := by
  have hn' : (N:ℂ) ≠ 0 := by exact_mod_cast (show N ≠ 0 by linarith)
  have hz : twistRate δ ≠ 0 := by
    intro h; have hh := congrArg Complex.re h; simp [twistRate] at hh
  have hd := (hasDerivAt_id (0:ℂ)).mul ((cancelled_mellin hn δ (s := 0) (by norm_num)).2.hasDerivAt)
  have hg1 : HasDerivAt Complex.Gamma (deriv Complex.Gamma 1) (id (0:ℂ)+1) := by
    simpa using Complex.differentiableAt_Gamma_one.hasDerivAt
  have hg := hg1.comp (0:ℂ) ((hasDerivAt_id (0:ℂ)).add_const 1)
  have hr := ((((hasDerivAt_id (0:ℂ)).neg.const_cpow (Or.inl hz)).sub
    ((hasDerivAt_id (0:ℂ)).neg.const_cpow (Or.inl hn'))).mul hg)
  have he : (fun s : ℂ => s*mellin (cancelledWeight N δ) s) =ᶠ[𝓝 (0:ℂ)]
      fun s => (twistRate δ^(-s)-(N:ℂ)^(-s))*Complex.Gamma (s+1) := by
    filter_upwards [Complex.continuous_re.continuousAt.eventually
      (Ioi_mem_nhds (show (-1:ℝ)<(0:ℂ).re by norm_num))] with s hs
    exact cancelled_mellin_strip hn δ hs
  have e := (hd.congr_of_eventuallyEq he.symm).unique hr
  simpa [Complex.Gamma_one,sub_eq_add_neg,add_comm] using e

theorem critical_or_zero {q : ℕ} [NeZero q] {χ : DirichletCharacter ℂ q}
    (hp : χ.IsPrimitive) (hχ : χ ≠ 1)
    (grh : ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {T : ℝ} {s : ℂ} (hs : s ∈ zerosRect χ T) : s=0 ∨ s.re=1/2 := by
  obtain ⟨hz,_,ha|⟨ha,hb⟩⟩ := zerosRect_cases hp hχ hs
  · exact Or.inl ha
  · exact Or.inr (grh s ha hb hz)

#print axioms cancelled_mellin_zero
end GoldbachEnergy
