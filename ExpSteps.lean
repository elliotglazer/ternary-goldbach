module

public import LogCertificate

@[expose] public section


open Real
namespace GoldbachEnergy

structure RatBounds where
  lo : ℚ
  hi : ℚ
  deriving DecidableEq

def RatBounds.Contains (b : RatBounds) (x : ℝ) : Prop := b.lo ≤ x ∧ x ≤ b.hi

/-- Rounding after each squaring keeps all certificate operands small. -/
def checkSquares (b : RatBounds) : List RatBounds → Bool
  | [] => true
  | c::cs => decide (0 ≤ b.lo ∧ c.lo ≤ b.lo*b.lo ∧ b.hi*b.hi ≤ c.hi) && checkSquares c cs

def finalBounds (b : RatBounds) : List RatBounds → RatBounds
  | [] => b
  | c::cs => finalBounds c cs

theorem squares_sound {b : RatBounds} {x : ℝ} (hx : b.Contains (Real.exp x))
    (cs : List RatBounds) (hc : checkSquares b cs = true) :
    (finalBounds b cs).Contains (Real.exp ((2:ℝ)^cs.length*x)) := by
  induction cs generalizing x b with
  | nil => simpa [finalBounds] using hx
  | cons c cs ih =>
    change (decide _ && checkSquares c cs) = true at hc
    obtain ⟨hr,hc'⟩ := Bool.and_eq_true_iff.mp hc
    obtain ⟨hp,hl,hu⟩ := of_decide_eq_true hr
    have hp' : (0:ℝ) ≤ b.lo := by exact_mod_cast hp
    have hl' : (c.lo:ℝ) ≤ (b.lo:ℝ)*b.lo := by exact_mod_cast hl
    have hu' : (b.hi:ℝ)*b.hi ≤ (c.hi:ℝ) := by exact_mod_cast hu
    have hp1 := (Real.exp_pos x).le
    have hsq : c.Contains (Real.exp (2*x)) := by
      rw [two_mul,Real.exp_add]
      exact ⟨hl'.trans (mul_self_le_mul_self hp' hx.1),
        (mul_self_le_mul_self hp1 hx.2).trans hu'⟩
    have h := ih hsq hc'
    simpa only [finalBounds,List.length_cons,pow_succ,mul_assoc] using h

theorem exp_seed {b : RatBounds} (s : ℚ) (hs : 0 ≤ s ∧ s ≤ 1)
    (h : b.lo ≤ expPoly s ∧ expPoly s+s^6*7/4320 ≤ b.hi) :
    b.Contains (Real.exp s) := by
  have hs0 : 0 ≤ (s:ℝ) := by exact_mod_cast hs.1
  have hs1 : (s:ℝ) ≤ 1 := by exact_mod_cast hs.2
  have a := Real.sum_le_exp_of_nonneg hs0 6
  have b' := Real.exp_bound' hs0 hs1 (by decide : 0 < 6)
  have l : (b.lo:ℝ) ≤ (expPoly s:ℝ) := by exact_mod_cast h.1
  have u : ((expPoly s+s^6*7/4320:ℚ):ℝ) ≤ (b.hi:ℝ) := by exact_mod_cast h.2
  norm_num [Finset.sum_range_succ,Nat.factorial] at a b'
  unfold expPoly at l u
  push_cast at l u
  exact ⟨by linarith,by linarith⟩

#print axioms squares_sound
#print axioms exp_seed
end GoldbachEnergy
