module

public import BoxFunctions
public import Mathlib.Analysis.Real.Pi.Bounds

@[expose] public section


open Real
namespace GoldbachEnergy

def piLower : ℚ := 314159265358979323846/10^20
def piUpper : ℚ := 314159265358979323847/10^20

theorem pi_endpoint_bounds : (piLower:ℝ) ≤ π ∧ π ≤ (piUpper:ℝ) := by
  rw [show (piLower:ℝ)=3.14159265358979323846 by norm_num [piLower],
      show (piUpper:ℝ)=3.14159265358979323847 by norm_num [piUpper]]
  exact ⟨Real.pi_gt_d20.le,Real.pi_lt_d20.le⟩

def smallAtan (t : ℚ) : RatBounds :=
  let l := t-t^3/3+t^5/5-t^7/7+t^9/9-t^11/11
  ⟨l,l+t^13/13⟩

theorem smallAtan_sound (t : ℚ) (ht : 0 ≤ t) : (smallAtan t).Contains (Real.arctan t) := by
  simpa [smallAtan,atanLower,RatBounds.Contains] using
    (arctan_enclosure (by exact_mod_cast ht : 0 ≤ (t:ℝ)))

def piPartMinus (d : ℚ) (s : RatBounds) : RatBounds := ⟨piLower/d-s.hi,piUpper/d-s.lo⟩

theorem piPartMinus_sound (d : ℚ) (hd : 0 < d) {s : RatBounds} {x : ℝ} (h : s.Contains x) :
    (piPartMinus d s).Contains (π/d-x) := by
  have hd' : 0 ≤ (d:ℝ) := by exact_mod_cast hd.le
  simpa [RatBounds.Contains,piPartMinus] using And.intro
    (sub_le_sub (div_le_div_of_nonneg_right pi_endpoint_bounds.1 hd') h.2)
    (sub_le_sub (div_le_div_of_nonneg_right pi_endpoint_bounds.2 hd') h.1)

def atanUnit (t : ℚ) : RatBounds :=
  if t ≤ 1/2 then smallAtan t else piPartMinus 4 (smallAtan ((1-t)/(1+t)))

theorem atanUnit_sound (t : ℚ) (h0 : 0 ≤ t) (h1 : t ≤ 1) : (atanUnit t).Contains (Real.arctan t) := by
  unfold atanUnit; split
  · exact smallAtan_sound _ h0
  · rw [atan_shift (by exact_mod_cast h0 : 0 ≤ (t:ℝ))]
    have h := piPartMinus_sound 4 (by norm_num)
      (smallAtan_sound ((1-t)/(1+t)) (div_nonneg (sub_nonneg.mpr h1) (by positivity)))
    simpa using h

def atanPos (t : ℚ) := if t ≤ 1 then atanUnit t else piPartMinus 2 (atanUnit t⁻¹)

theorem atanPos_sound (t : ℚ) (ht : 0 ≤ t) : (atanPos t).Contains (Real.arctan t) := by
  unfold atanPos; split
  · exact atanUnit_sound _ ht (by assumption)
  · rename_i hh
    have hr := lt_of_not_ge hh
    have h0 : 0 < t := by linarith
    have h := piPartMinus_sound 2 (by norm_num) (atanUnit_sound t⁻¹ (inv_nonneg.mpr ht) (inv_le_one_of_one_le₀ hr.le))
    have he := Real.arctan_inv_of_pos (by exact_mod_cast h0 : 0 < (t:ℝ))
    simpa [he] using h

#print axioms atanPos_sound
end GoldbachEnergy
