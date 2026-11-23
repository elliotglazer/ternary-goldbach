import ExtensionCommon
import ExtensionCommonB
namespace SmallGoldbach.IndependentAudit
theorem factorial_extend {d m f g : Nat} (depth : Nat)
    (hf : f = d.factorial) (hg : g = f * rangeProduct depth (1+d) m) :
    g = (d+m).factorial := by
  rw [hg, hf, rangeProduct_eq, ← Nat.one_ascFactorial d,
      Nat.ascFactorial_mul_ascFactorial, Nat.one_ascFactorial]
end SmallGoldbach.IndependentAudit
