import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.Algebra.Order.BigOperators.GroupWithZero.Finset

namespace Finset

alias prod_le_prod₀ := Finset.prod_le_prod

end Finset

namespace TernaryGoldbach

variable {𝕜 𝕜' : Type*} [NontriviallyNormedField 𝕜] [NontriviallyNormedField 𝕜']
  [NormedAlgebra 𝕜 𝕜']

theorem logDeriv_mul {f g : 𝕜 → 𝕜'} (x : 𝕜) (hf : f x ≠ 0) (hg : g x ≠ 0)
    (hdf : DifferentiableAt 𝕜 f x) (hdg : DifferentiableAt 𝕜 g x) :
    logDeriv (f * g) x = logDeriv f x + logDeriv g x :=
  _root_.logDeriv_mul x hf hg hdf hdg

theorem logDeriv_prod {ι : Type*} {s : Finset ι} {f : ι → 𝕜 → 𝕜'} {x : 𝕜}
    (hf : ∀ i ∈ s, f i x ≠ 0) (hd : ∀ i ∈ s, DifferentiableAt 𝕜 (f i) x) :
    logDeriv (∏ i ∈ s, f i) x = ∑ i ∈ s, logDeriv (f i) x := by
  have heq : (∏ i ∈ s, f i) = fun w => ∏ i ∈ s, f i w := by
    ext w
    simp [Finset.prod_apply]
  rw [heq]
  exact _root_.logDeriv_prod hf hd

end TernaryGoldbach
