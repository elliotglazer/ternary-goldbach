module

public import RoundArithmetic
public import ExpCheck
public import AtanCheck

@[expose] public section


open Real
namespace GoldbachEnergy

/-- A scalar certificate. Transcendental endpoints carry independent witnesses.
The value is determined by the expression and its real inputs. -/
inductive ScalarOp where
  | lit (x : ℚ) | input (i : ℕ) | pi
  | add | neg | mul | inv | min | max | sqrt | atan
  | exp (a b : ExpCert) | log (a b : ExpCert)

noncomputable def ScalarOp.value (op : ScalarOp) (input : ℕ → ℝ) (x y : ℝ) : ℝ :=
  match op with
  | .lit r => r | .input i => input i | .pi => π
  | .add => x+y | .neg => -x | .mul => x*y | .inv => x⁻¹ | .min => Min.min x y | .max => Max.max x y
  | .sqrt => Real.sqrt x | .atan => Real.arctan x
  | .exp .. => Real.exp x | .log .. => Real.log x

def fits (s t : RatBounds) := decide (t.lo ≤ s.lo ∧ s.hi ≤ t.hi)

def ScalarOp.check (op : ScalarOp) (inputs : ℕ → RatBounds) (s a b : RatBounds) : Bool :=
  match op with
  | .lit x => fits ⟨x,x⟩ s | .input i => fits (inputs i) s | .pi => fits ⟨piLower,piUpper⟩ s
  | .add => fits (a.addB b) s | .neg => fits a.negB s | .mul => fits (a.mulB b) s
  | .min => fits (a.minB b) s | .max => fits (a.maxB b) s
  | .inv => decide (0 < a.lo) && fits a.invB s
  | .sqrt => decide (0 ≤ s.hi ∧ s.lo*s.lo ≤ a.lo ∧ a.hi ≤ s.hi*s.hi)
  | .atan => decide (0 ≤ a.lo ∧ 0 ≤ a.hi) && fits ⟨(atanPos a.lo).lo,(atanPos a.hi).hi⟩ s
  | .exp l h => l.check a.lo && h.check a.hi && fits ⟨(l.output a.lo).lo,(h.output a.hi).hi⟩ s
  | .log l h => l.check s.lo && h.check s.hi && decide ((l.output s.lo).hi ≤ a.lo ∧ a.hi ≤ (h.output s.hi).lo)

theorem fits_sound {s t : RatBounds} {v : ℝ} (h : fits s t = true) (hv : s.Contains v) : t.Contains v :=
  RatBounds.weaken hv (of_decide_eq_true h)

theorem ScalarOp.sound (op : ScalarOp) {inputs : ℕ → RatBounds} {input : ℕ → ℝ}
    (hi : ∀ i, (inputs i).Contains (input i)) {a b s : RatBounds} {x y : ℝ}
    (hx : a.Contains x) (hy : b.Contains y) (hc : op.check inputs s a b = true) :
    s.Contains (op.value input x y) := by
  cases op with
  | lit r => exact fits_sound hc ⟨le_rfl,le_rfl⟩
  | input i => exact fits_sound hc (hi i)
  | pi => exact fits_sound hc pi_endpoint_bounds
  | add => exact fits_sound hc (RatBounds.add_sound hx hy)
  | neg => exact fits_sound hc (RatBounds.neg_sound hx)
  | mul => exact fits_sound hc (RatBounds.mul_sound hx hy)
  | min => exact fits_sound hc (RatBounds.min_sound hx hy)
  | max => exact fits_sound hc (RatBounds.max_sound hx hy)
  | inv =>
    obtain ⟨hp,h⟩ := Bool.and_eq_true_iff.mp hc
    exact fits_sound h (RatBounds.inv_sound hx (of_decide_eq_true hp))
  | sqrt =>
    obtain ⟨hp,hl,hu⟩ := of_decide_eq_true hc
    exact sqrt_by_squares (by exact_mod_cast hp) ⟨(by exact_mod_cast hl : (s.lo:ℝ)*s.lo ≤ a.lo).trans hx.1,
      hx.2.trans (by exact_mod_cast hu : (a.hi:ℝ) ≤ (s.hi:ℝ)*s.hi)⟩
  | atan =>
    obtain ⟨hp,h⟩ := Bool.and_eq_true_iff.mp hc
    obtain ⟨hl,hu⟩ := of_decide_eq_true hp
    exact fits_sound h ⟨(atanPos_sound a.lo hl).1.trans (Real.arctan_le_arctan_iff.mpr hx.1),
      (Real.arctan_le_arctan_iff.mpr hx.2).trans (atanPos_sound a.hi hu).2⟩
  | exp l h =>
    obtain ⟨hh,fit⟩ := Bool.and_eq_true_iff.mp hc
    obtain ⟨hl,hu⟩ := Bool.and_eq_true_iff.mp hh
    exact fits_sound fit ⟨(l.sound _ hl).1.trans (Real.exp_le_exp.mpr hx.1),
      (Real.exp_le_exp.mpr hx.2).trans (h.sound _ hu).2⟩
  | log l h =>
    obtain ⟨hh,fit⟩ := Bool.and_eq_true_iff.mp hc
    obtain ⟨hl,hu⟩ := Bool.and_eq_true_iff.mp hh
    obtain ⟨h1,h2⟩ := of_decide_eq_true fit
    exact log_by_exp ((l.sound _ hl).2.trans ((by exact_mod_cast h1 : ((l.output s.lo).hi:ℝ) ≤ a.lo).trans hx.1))
      (hx.2.trans ((by exact_mod_cast h2 : (a.hi:ℝ) ≤ (h.output s.hi).lo).trans (h.sound _ hu).1))

#print axioms ScalarOp.sound
end GoldbachEnergy
