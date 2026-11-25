module

public import ExpSteps

@[expose] public section


namespace GoldbachEnergy
namespace RatBounds

def addB (a b : RatBounds) : RatBounds := ⟨a.lo+b.lo,a.hi+b.hi⟩
def negB (a : RatBounds) : RatBounds := ⟨-a.hi,-a.lo⟩
def minB (a b : RatBounds) : RatBounds := ⟨min a.lo b.lo,min a.hi b.hi⟩
def maxB (a b : RatBounds) : RatBounds := ⟨max a.lo b.lo,max a.hi b.hi⟩
def invB (a : RatBounds) : RatBounds := ⟨a.hi⁻¹,a.lo⁻¹⟩
def mulB (a b : RatBounds) : RatBounds :=
  ⟨min (min (a.lo*b.lo) (a.hi*b.lo)) (min (a.lo*b.hi) (a.hi*b.hi)),
   max (max (a.lo*b.lo) (a.hi*b.lo)) (max (a.lo*b.hi) (a.hi*b.hi))⟩

theorem weaken {s t : RatBounds} {x : ℝ} (hx : s.Contains x) (h : t.lo ≤ s.lo ∧ s.hi ≤ t.hi) :
    t.Contains x := ⟨(by exact_mod_cast h.1 : (t.lo:ℝ) ≤ s.lo).trans hx.1,
      hx.2.trans (by exact_mod_cast h.2 : (s.hi:ℝ) ≤ t.hi)⟩

theorem add_sound {a b : RatBounds} {x y : ℝ} (ha : a.Contains x) (hb : b.Contains y) :
    (addB a b).Contains (x+y) := by
  simpa [addB,Contains] using And.intro (add_le_add ha.1 hb.1) (add_le_add ha.2 hb.2)

theorem neg_sound {a : RatBounds} {x : ℝ} (ha : a.Contains x) : (negB a).Contains (-x) := by
  simpa [negB,Contains] using And.intro (neg_le_neg ha.2) (neg_le_neg ha.1)

theorem min_sound {a b : RatBounds} {x y : ℝ} (ha : a.Contains x) (hb : b.Contains y) :
    (minB a b).Contains (min x y) := by
  simpa [minB,Contains] using And.intro (min_le_min ha.1 hb.1) (min_le_min ha.2 hb.2)

theorem max_sound {a b : RatBounds} {x y : ℝ} (ha : a.Contains x) (hb : b.Contains y) :
    (maxB a b).Contains (max x y) := by
  simpa [maxB,Contains] using And.intro (max_le_max ha.1 hb.1) (max_le_max ha.2 hb.2)

theorem inv_sound {a : RatBounds} {x : ℝ} (ha : a.Contains x) (hp : 0 < a.lo) :
    (invB a).Contains x⁻¹ := by
  have h : (0:ℝ) < a.lo := by exact_mod_cast hp
  simpa [invB,Contains] using And.intro (inv_anti₀ (h.trans_le ha.1) ha.2) (inv_anti₀ h ha.1)

private theorem lower_linear {a b x v w : ℝ} (hx : a ≤ x ∧ x ≤ b) (ha : w ≤ a*v) (hb : w ≤ b*v) : w ≤ x*v := by
  rcases le_total 0 v with h|h
  · exact ha.trans (mul_le_mul_of_nonneg_right hx.1 h)
  · exact hb.trans (mul_le_mul_of_nonpos_right hx.2 h)

private theorem upper_linear {a b x v w : ℝ} (hx : a ≤ x ∧ x ≤ b) (ha : a*v ≤ w) (hb : b*v ≤ w) : x*v ≤ w := by
  rcases le_total 0 v with h|h
  · exact (mul_le_mul_of_nonneg_right hx.2 h).trans hb
  · exact (mul_le_mul_of_nonpos_right hx.1 h).trans ha

theorem mul_sound {a b : RatBounds} {x y : ℝ} (ha : a.Contains x) (hb : b.Contains y) :
    (mulB a b).Contains (x*y) := by
  simp only [mulB,Contains,Rat.cast_min,Rat.cast_max,Rat.cast_mul]
  rw [mul_comm x y]
  constructor
  · apply lower_linear hb
    · rw [mul_comm (b.lo:ℝ) x]; apply lower_linear ha <;> exact (min_le_left _ _).trans (by first | apply min_le_left | apply min_le_right)
    · rw [mul_comm (b.hi:ℝ) x]; apply lower_linear ha <;> exact (min_le_right _ _).trans (by first | apply min_le_left | apply min_le_right)
  · apply upper_linear hb
    · rw [mul_comm (b.lo:ℝ) x]; apply upper_linear ha <;> apply le_trans _ (le_max_left _ _) <;> first | apply le_max_left | apply le_max_right
    · rw [mul_comm (b.hi:ℝ) x]; apply upper_linear ha <;> apply le_trans _ (le_max_right _ _) <;> first | apply le_max_left | apply le_max_right

#print axioms mul_sound
end RatBounds
end GoldbachEnergy
