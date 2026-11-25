module

public import ComplexRate
public import RegularizedWave
public import CriticalGamma

@[expose] public section


open Complex Real MeasureTheory Set Filter Asymptotics
open scoped Topology
noncomputable section
namespace GoldbachEnergy

theorem mellin_lap_rate {z s : ℂ} (hz : 0<z.re) (hs : 0<s.re) :
    mellin (lapWeight z) s = z^(-s)*Complex.Gamma s := by
  have hz0 : z ≠ 0 := by rintro rfl; simpa using hz
  have hn := norm_pos_iff.mpr hz0
  have h := mellin_lap_polar hs z.arg (Complex.abs_arg_lt_pi_div_two_iff.mpr (Or.inl hz)) hn
  rw [Complex.norm_mul_exp_arg_mul_I] at h
  rw [h,Complex.cpow_def_of_ne_zero (show (‖z‖:ℂ) ≠ 0 by exact_mod_cast hn.ne'),
    Complex.cpow_def_of_ne_zero hz0, ← Complex.ofReal_log hn.le, ← Complex.exp_add]
  congr 2
  rw [Complex.log]
  ring

private theorem convergent_lap {z s : ℂ} (hz : 0<z.re) (hs : 0<s.re) :
    MellinConvergent (lapWeight z) s := by
  have hc : Continuous (lapWeight z) := by unfold lapWeight; fun_prop
  apply mellinConvergent_of_isBigO_rpow_exp (a := z.re) (b := 0) hz
    (hc.continuousOn.locallyIntegrableOn measurableSet_Ioi) _ _ hs
  · apply IsBigO.of_bound 1
    filter_upwards with t
    simp [lapWeight,Complex.norm_exp,Complex.mul_re,abs_of_pos (Real.exp_pos _),neg_mul]
  · apply IsBigO.of_bound 1
    filter_upwards [self_mem_nhdsWithin] with t (ht : t ∈ Ioi (0:ℝ))
    simp [lapWeight,Complex.norm_exp,Complex.mul_re]
    exact mul_nonneg hz.le (le_of_lt ht)

def twistRate (δ : ℝ) : ℂ := 1-((2*π*δ:ℝ):ℂ)*I

theorem cancelled_mellin_right {N : ℝ} (hn : 1≤N) (δ : ℝ) {s : ℂ} (hs : 0<s.re) :
    mellin (cancelledWeight N δ) s =
    (twistRate δ^(-s)-(N:ℂ)^(-s))*Complex.Gamma s := by
  have hN : 0<N := by linarith
  have hz : 0<(twistRate δ).re := by simp [twistRate]
  have he : cancelledWeight N δ = fun t => lapWeight (twistRate δ) t-lapWeight (N:ℂ) t := by
    funext t; simp only [cancelledWeight,lapWeight,twistRate,neg_sub]; congr 3 <;> ring
  rw [he, show mellin (fun t => lapWeight (twistRate δ) t-lapWeight (N:ℂ) t) s =
      mellin (lapWeight (twistRate δ)) s - mellin (lapWeight (N:ℂ)) s by
        simp only [mellin,smul_sub]
        exact integral_sub (convergent_lap hz hs) (convergent_lap (by simpa using hN) hs),
    mellin_lap_rate hz hs, mellin_lap_rate (by simpa using hN) hs]
  ring

/-- Multiplication by s yields a regular identity across zero. -/
theorem cancelled_mellin_strip {N : ℝ} (hn : 1≤N) (δ : ℝ) {s : ℂ} (hs : -1<s.re) :
    s*mellin (cancelledWeight N δ) s =
    (twistRate δ^(-s)-(N:ℂ)^(-s))*Complex.Gamma (s+1) := by
  let U := {u : ℂ | -1 < u.re}
  have ho : IsOpen U := isOpen_lt continuous_const Complex.continuous_re
  have hconnected : IsPreconnected U :=
    (convex_halfSpace_re_gt (-1:ℝ)).isPreconnected
  let f := fun u : ℂ => u*mellin (cancelledWeight N δ) u
  let g := fun u : ℂ => (twistRate δ^(-u)-(N:ℂ)^(-u))*Complex.Gamma (u+1)
  have hN : (N:ℂ) ≠ 0 := by exact_mod_cast (show N ≠ 0 by linarith)
  have hz : twistRate δ ≠ 0 := by
    intro h; have hh := congrArg Complex.re h; simp [twistRate] at hh
  have hf : AnalyticOnNhd ℂ f U := by
    apply DifferentiableOn.analyticOnNhd _ ho
    intro u hu
    exact (differentiableAt_id.mul (cancelled_mellin hn δ hu).2).differentiableWithinAt
  have hg : AnalyticOnNhd ℂ g U := by
    apply DifferentiableOn.analyticOnNhd _ ho
    intro u hu
    have hg' := Complex.differentiableAt_Gamma (s := u+1) (fun n he => by
      have hh := congrArg Complex.re he
      simp at hh
      change -1<u.re at hu
      linarith [Nat.cast_nonneg (α := ℝ) n])
    apply DifferentiableAt.differentiableWithinAt
    dsimp only [g]
    apply DifferentiableAt.mul _ (hg'.comp u (differentiableAt_id.add_const 1))
    exact ((differentiableAt_id.neg).const_cpow (Or.inl hz)).sub
      ((differentiableAt_id.neg).const_cpow (Or.inl hN))
  have hfg : f =ᶠ[𝓝 (1:ℂ)] g := by
    filter_upwards [Complex.continuous_re.continuousAt.eventually
      (Ioi_mem_nhds (by norm_num : (0:ℝ)<(1:ℂ).re))] with u (hu : 0<u.re)
    have hnz : u ≠ 0 := by rintro rfl; simpa using hu
    dsimp [f,g]
    rw [cancelled_mellin_right hn δ hu, Complex.Gamma_add_one _ hnz]
    ring
  exact hf.eqOn_of_preconnected_of_eventuallyEq hg hconnected (show (1:ℂ) ∈ U by norm_num [U]) hfg hs

#print axioms cancelled_mellin_strip
end GoldbachEnergy
