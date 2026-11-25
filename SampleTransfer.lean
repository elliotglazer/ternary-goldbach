module

public import LookupSamples
public import LookupOperation

@[expose] public section


open RadixExp GoldbachEnergy
namespace ExpLookup

def Sample.positive (s : Sample) : RatBounds := asBounds ⟨s.lo,s.hi⟩
def Sample.atSign (s : Sample) (x : ℚ) : RatBounds :=
  let b := s.positive
  if 0≤x then b else ⟨b.hi⁻¹,b.lo⁻¹⟩

theorem sample_sound (s : Sample) (hs : s.check=true) (x : ℚ)
    (hl : (s.n:ℚ)/ticks ≤ |x|) (hh : |x| ≤ ((s.n+1:Nat):ℚ)/ticks) :
    (s.atSign x).Contains (Real.exp (x:ℝ)) := by
  obtain ⟨hn,hp,hL,hH⟩ := of_decide_eq_true hs
  have p : (0:ℝ) < (s.positive.lo:ℝ) := by
    simp only [Sample.positive,asBounds,Rat.cast_div,Rat.cast_natCast]
    exact div_pos (by exact_mod_cast hp) (by norm_num [arithmeticScale])
  have lx : (s.n:ℝ)/ticks ≤ |(x:ℝ)| := by
    have h : (↑((s.n:ℚ)/ticks):ℝ) ≤ ((|x|:ℚ):ℝ) := Rat.cast_le.mpr hl
    simpa only [Rat.cast_div,Rat.cast_natCast,Rat.cast_abs] using h
  have hx : |(x:ℝ)| ≤ ((s.n+1:Nat):ℝ)/ticks := by
    have h : ((|x|:ℚ):ℝ) ≤ (↑(((s.n+1:Nat):ℚ)/ticks):ℝ) := Rat.cast_le.mpr hh
    simpa only [Rat.cast_div,Rat.cast_natCast,Rat.cast_abs] using h
  have L := (at_ticks s.n (by omega)).1.trans (Real.exp_le_exp.mpr lx)
  have H := (Real.exp_le_exp.mpr hx).trans (at_ticks (s.n+1) hn).2
  have b : s.positive.Contains (Real.exp |(x:ℝ)|) := by
    simp only [asBounds,Sample.positive,RatBounds.Contains,Rat.cast_div,Rat.cast_natCast] at L H ⊢
    refine ⟨(div_le_div_of_nonneg_right (by exact_mod_cast hL) (by positivity)).trans L,
      H.trans (div_le_div_of_nonneg_right (by exact_mod_cast hH) (by positivity))⟩
  by_cases pos : 0≤x
  · simpa [Sample.atSign,pos,abs_of_nonneg (by exact_mod_cast pos : (0:ℝ)≤x)] using b
  · have neg : (x:ℝ)<0 := by exact_mod_cast lt_of_not_ge pos
    simpa [Sample.atSign,pos,abs_of_neg neg,RatBounds.Contains] using exp_neg_bounds p b

#print axioms sample_sound
end ExpLookup
