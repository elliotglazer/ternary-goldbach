module

public import AdmissibleWave
public import PrincipalWave
public import TernaryGoldbach.Explicit.ZetaExplicit

@[expose] public section


open Complex Real MeasureTheory Filter Set TernaryGoldbach.Explicit
open scoped Topology
noncomputable section
namespace GoldbachEnergy

theorem cancelled_pole {N : ℝ} (hN : 1 ≤ N) (β : ℝ) :
    mellin (cancelledWeight N (N*β)) 1*(N:ℂ) = principalWave N 1 β-1 := by
  have hN0 : (N:ℂ) ≠ 0 := by exact_mod_cast (show N ≠ 0 by linarith)
  rw [cancelled_mellin_right hN _ (by norm_num),Complex.Gamma_one,mul_one,
    Complex.cpow_neg_one,Complex.cpow_neg_one,sub_mul,inv_mul_cancel₀ hN0]
  congr 1
  unfold principalWave
  simp only [ArithmeticFunction.moebius_apply_one,Nat.totient_one,Nat.cast_one,Int.cast_one,div_one,Complex.ofReal_one]
  let z := twistRate (N*β)
  have h : ((1/N:ℝ):ℂ) - ((2*π*β:ℝ):ℂ)*I = z/(N:ℂ) := by
    dsimp [z,twistRate]; push_cast; field_simp <;> ring
  rw [h,one_div,inv_div]
  change z⁻¹ * (N:ℂ) = (N:ℂ)/z
  ring

theorem cancelled_zeta_formula {N : ℝ} (hN : 1 ≤ N) (β : ℝ) :
    ∃ T : ℕ → ℝ, (∀ k : ℕ, T k ∈ Icc ((k:ℝ)+1) ((k:ℝ)+2)) ∧
      Tendsto (fun k => ∑ s ∈ zerosRectD zetaF (T k), (multRectD zetaF (T k) s : ℂ)*
        (mellin (cancelledWeight N (N*β)) s*(N:ℂ)^s)) atTop
        (𝓝 (principalWave N 1 β - 1 - SsumG (1 : DirichletCharacter ℂ 1) (cancelledWeight N (N*β)) N -
          (1/(2*π):ℂ)*∫ y : ℝ, hZeta (cancelledWeight N (N*β)) N (((-1/2:ℝ):ℂ)+y*I))) := by
  obtain ⟨K,c,h⟩ := good_cancelled_weight hN (N*β)
  simpa only [cancelled_pole hN β] using explicit_formula_zeta h (show 0<N by linarith)

#print axioms cancelled_pole
#print axioms cancelled_zeta_formula
end GoldbachEnergy
