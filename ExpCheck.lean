module

public import PreciseExp
public import BoxFunctions

@[expose] public section


open Real
namespace GoldbachEnergy

structure ExpCert where
  seed : RatBounds
  steps : List RatBounds

def ExpCert.input (e : ExpCert) (x : ℚ) := |x|/(2:ℚ)^e.steps.length
def ExpCert.output (e : ExpCert) (x : ℚ) : RatBounds :=
  let t := finalBounds e.seed e.steps
  if 0 ≤ x then t else ⟨t.hi⁻¹,t.lo⁻¹⟩

def ExpCert.check (e : ExpCert) (x : ℚ) : Bool :=
  let s := e.input x
  let n := 18
  let b := e.seed
  decide (s ≤ 1 ∧ b.lo ≤ partialExp s n ∧ partialExp s n+s^n*(n+1)/(n.factorial*n) ≤ b.hi ∧
    0 < (finalBounds b e.steps).lo) && checkSquares b e.steps

theorem ExpCert.sound (e : ExpCert) (x : ℚ) (h : e.check x = true) :
    (e.output x).Contains (Real.exp (x:ℝ)) := by
  obtain ⟨hs,hc⟩ := Bool.and_eq_true_iff.mp h
  obtain ⟨h1,hlo,hhi,hp⟩ := of_decide_eq_true hs
  have h0 : 0 ≤ e.input x := by unfold input; positivity
  have hseed := exp_seed_order 18 (e.input x) (by decide) ⟨h0,h1⟩ ⟨hlo,hhi⟩
  have he := squares_sound hseed e.steps hc
  have hi : (2:ℝ)^e.steps.length*((e.input x:ℚ):ℝ) = |(x:ℝ)| := by
    unfold input; push_cast; field_simp
  rw [hi] at he
  by_cases hx : 0 ≤ x
  · rw [output,if_pos hx]
    rwa [abs_of_nonneg (by exact_mod_cast hx : 0 ≤ (x:ℝ))] at he
  · have hh : (0:ℝ) < (finalBounds e.seed e.steps).lo := by exact_mod_cast hp
    rw [abs_of_neg (by exact_mod_cast lt_of_not_ge hx : (x:ℝ) < 0)] at he
    have hv := exp_neg_bounds hh he
    simpa [output,hx,RatBounds.Contains] using hv

#print axioms ExpCert.sound
end GoldbachEnergy
