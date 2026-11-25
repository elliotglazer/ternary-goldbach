module

public import RadixExpSound
public import ExpLookup
public import ExpCheck

@[expose] public section


open Real GoldbachEnergy RadixExp
namespace ExpLookup

def asBounds (b : Interval) : RatBounds := ⟨(b.lo:ℚ)/arithmeticScale,(b.hi:ℚ)/arithmeticScale⟩

theorem asBounds_iff (b : Interval) (x : ℝ) : (asBounds b).Contains x ↔ b.Holds arithmeticScale x := by
  have h : (0:ℝ)<(arithmeticScale:ℕ) := by norm_num [arithmeticScale]
  simp [asBounds,RatBounds.Contains,Interval.Holds,Rat.cast_div,div_le_iff₀ h,le_div_iff₀ h]

theorem seed_sound : seed.Holds arithmeticScale (Real.exp (1/(ticks:ℝ))) := by
  let s : ℚ := 1/(ticks:ℚ)
  have h := exp_seed_order (b:=asBounds seed) 2 s (by decide) (by decide +kernel) (by decide +kernel)
  apply (asBounds_iff _ _).mp
  simpa [s] using h

theorem at_ticks (n : Nat) (hn : n<16^31) :
    (asBounds (eval arithmeticScale rows n)).Contains (Real.exp ((n:ℝ)/ticks)) := by
  rw [asBounds_iff,table_check]
  have h := eval_holds (S:=arithmeticScale) (by decide) 31 seed _ seed_sound n hn
  simpa [standardRows,div_eq_mul_inv] using h

def positiveBounds (n : Nat) : RatBounds :=
  ⟨(asBounds (eval arithmeticScale rows n)).lo,(asBounds (eval arithmeticScale rows (n+1))).hi⟩

def valid (x : ℚ) (n : Nat) := decide (n+1<16^31 ∧ (n:ℚ)/ticks ≤ |x| ∧ |x| ≤ ((n+1:Nat):ℚ)/ticks ∧
    0 < (eval arithmeticScale rows n).lo)

def enclosure (x : ℚ) (n : Nat) : RatBounds :=
  let b := positiveBounds n
  if 0 ≤ x then b else ⟨b.hi⁻¹,b.lo⁻¹⟩

theorem enclosure_sound (x : ℚ) (n : Nat) (hc : valid x n=true) : (enclosure x n).Contains (Real.exp (x:ℝ)) := by
  obtain ⟨hn,hl,hh,hpos⟩ := of_decide_eq_true hc
  have hlo : (n:ℝ)/(ticks:ℝ) ≤ |(x:ℝ)| := by
    have c : (↑((n:ℚ)/ticks) : ℝ) ≤ ((|x|:ℚ):ℝ) := Rat.cast_le.mpr hl
    simpa only [Rat.cast_div,Rat.cast_natCast,Rat.cast_abs] using c
  have hhi : |(x:ℝ)| ≤ ((n+1:Nat):ℝ)/(ticks:ℝ) := by
    have c : ((|x|:ℚ):ℝ) ≤ (↑(((n+1:Nat):ℚ)/ticks) : ℝ) := Rat.cast_le.mpr hh
    simpa only [Rat.cast_div,Rat.cast_natCast,Rat.cast_abs] using c
  have b : (positiveBounds n).Contains (Real.exp |(x:ℝ)|) :=
    ⟨(at_ticks n (by omega)).1.trans (Real.exp_le_exp.mpr hlo),
     (Real.exp_le_exp.mpr hhi).trans (at_ticks (n+1) hn).2⟩
  by_cases hx : 0 ≤ x
  · simpa [enclosure,hx,abs_of_nonneg (by exact_mod_cast hx : (0:ℝ)≤x)] using b
  · have hneg : (x:ℝ)<0 := by exact_mod_cast lt_of_not_ge hx
    have lower : (0:ℝ)<(positiveBounds n).lo := by
      simp only [positiveBounds,asBounds,Rat.cast_div,Rat.cast_natCast]
      exact div_pos (by exact_mod_cast hpos) (by norm_num [arithmeticScale])
    have hb := exp_neg_bounds lower b
    simpa [enclosure,hx,abs_of_neg hneg,RatBounds.Contains] using hb

#print axioms enclosure_sound
end ExpLookup
