module

public import ExpSteps

@[expose] public section

open Real Finset
namespace GoldbachEnergy

def partialExp (s : ℚ) (n : ℕ) : ℚ :=
  ∑ i ∈ range n, s^i / i.factorial

theorem exp_seed_order {b : RatBounds} (n : ℕ) (s : ℚ) (hn : 0<n) (hs : 0 ≤ s ∧ s ≤ 1)
    (h : b.lo ≤ partialExp s n ∧ partialExp s n+s^n*(n+1)/(n.factorial*n) ≤ b.hi) :
    b.Contains (Real.exp s) := by
  have h0 : (0:ℝ) ≤ s := by exact_mod_cast hs.1
  have h1 : (s:ℝ) ≤ 1 := by exact_mod_cast hs.2
  have he := Real.exp_bound' h0 h1 hn
  have hl := Real.sum_le_exp_of_nonneg h0 n
  have hlo := h.1
  have hhi := h.2
  unfold partialExp at hlo hhi
  constructor
  · exact (by exact_mod_cast hlo : (b.lo:ℝ) ≤ ∑ i ∈ range n, (s:ℝ)^i/i.factorial).trans hl
  · apply he.trans
    exact_mod_cast hhi

#print axioms exp_seed_order
end GoldbachEnergy
