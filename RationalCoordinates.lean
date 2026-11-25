module

public import RationalError
public import Mathlib.Data.ZMod.Units

@[expose] public section


open Real TernaryGoldbach TernaryGoldbach.Explicit
noncomputable section
namespace GoldbachEnergy

def twistedBudget (N : ℝ) (q : ℕ) (δ : ℝ) (g u : ZeroTiling) : ℝ :=
  let D := (Real.log q/Real.log 2)*(1+Real.log N)
  D+Real.sqrt q*(conductorBudget q N δ g u+D)

theorem wave_add_int (N x : ℝ) (k : ℤ) : wave N (x+k) = wave N x := by
  unfold wave
  apply tsum_congr; intro n
  have he (m : ℤ) : e (m:ℝ) = 1 := by
    rw [e, show 2*(π:ℂ)*Complex.I*((m:ℝ):ℂ) = m*(2*π*Complex.I) by push_cast; ring]
    exact Complex.exp_int_mul_two_pi_mul_I m
  rw [mul_add,e_add,show (n:ℝ)*(k:ℝ) = ((n*k:ℤ):ℝ) by push_cast; rfl,he,mul_one]

theorem error_at_rational (rh : RiemannHypothesis)
    (grh : ∀ (d : ℕ) [NeZero d] (χ : DirichletCharacter ℂ d), χ.IsPrimitive →
      ∀ s : ℂ, 0 < s.re → s.re < 1 → χ.LFunction s=0 → s.re=1/2)
    {N : ℝ} (hn : 1≤N) (r : ℚ) (β : ℝ) (g u : ZeroTiling) :
    ‖wave N (r+β)-principalWave N r.den β‖ ≤ twistedBudget N r.den (N*β) g u := by
  letI : NeZero r.den := ⟨r.pos.ne'⟩
  let b : ZMod r.den := r.num
  have hb : IsUnit b := by
    apply (ZMod.coe_int_isUnit_iff_isCoprime _ _).mpr
    rw [isCoprime_comm,Int.isCoprime_iff_gcd_eq_one]
    exact r.reduced
  have hmod : (b.val:ℤ) = r.num % r.den := ZMod.val_intCast r.num
  have hsplit := Int.emod_add_mul_ediv r.num (r.den:ℤ)
  rw [← hmod] at hsplit
  have hR : (b.val:ℝ)+(r.den:ℝ)*((r.num/r.den:ℤ):ℝ)=(r.num:ℝ) := by exact_mod_cast hsplit
  have decomp : (r:ℝ)+β = ((b.val:ℝ)/r.den+β)+((r.num/r.den:ℤ):ℝ) := by
    rw [Rat.cast_def]
    field_simp [show (r.den:ℝ)≠0 by exact_mod_cast r.pos.ne']; linarith only [hR]
  rw [decomp,wave_add_int]
  exact rational_wave_error rh grh hn β hb g u

#print axioms wave_add_int
#print axioms error_at_rational
end GoldbachEnergy
