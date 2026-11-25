module

public import TernaryGoldbach.Statement
public import Mathlib.Analysis.Complex.ExponentialBounds
public import Mathlib.Analysis.Real.Pi.Bounds
public import Mathlib.Tactic

@[expose] public section


open Real TernaryGoldbach
namespace GoldbachFinite

-- Exactly the backward real-prime window used in Dudek's Theorem 2.
def BackwardGap := ∀ x : ℝ, 2 ≤ x → ∃ p : ℕ, p.Prime ∧
    x - (4/Real.pi)*Real.sqrt x*Real.log x < p ∧ (p : ℝ) ≤ x

theorem gap_width {x : ℝ} (hx : 2 ≤ x) (ht : x ≤ 10^20) :
    (4/Real.pi)*Real.sqrt x*Real.log x ≤ 587000000000-4 := by
  have hlog := Real.log_le_log (show 0 < x by linarith) ht
  rw [Real.log_pow, Real.log_ten_eq] at hlog
  have hL : Real.log x ≤ 46.052 := by
    push_cast at hlog; linarith [Real.log_two_lt_d9,Real.log_five_lt_d9]
  have hs : Real.sqrt x ≤ 10^10 := (Real.sqrt_le_iff).mpr ⟨by norm_num, by nlinarith⟩
  have hpi : 4/Real.pi ≤ (1.274 : ℝ) := by
    rw [div_le_iff₀ Real.pi_pos]; linarith [Real.pi_gt_d6]
  calc (4/Real.pi)*Real.sqrt x*Real.log x ≤ 1.274*(10^10)*46.052 := by
         have hL0 : 0 ≤ Real.log x := Real.log_nonneg (by linarith)
         gcongr
       _ ≤ _ := by norm_num

theorem through_1e20 (gap : BackwardGap) (bg : BinaryGoldbachUpTo 587000000000) :
    TernaryGoldbachUpTo (10^20) := by
  intro n hn h5 htop
  by_cases h : n ≤ 587000000000+3
  · have hev : Even (n-3) := Nat.Odd.sub_odd hn (by decide : Odd 3)
    obtain ⟨q,r,hq,hr,hs⟩ := bg (n-3) hev (by obtain ⟨k,hk⟩ := hn; omega) (by omega)
    exact ⟨3,q,r,Nat.prime_three,hq,hr,by omega⟩
  · let x : ℝ := (n:ℝ)-4
    have hn' : (587000000003:ℝ) < n := by exact_mod_cast (show 587000000003<n by omega)
    have hx : 2 ≤ x := by dsimp [x]; linarith
    have ht : x ≤ 10^20 := by
      have hh : (n:ℝ) ≤ 10^20 := by exact_mod_cast htop
      dsimp [x]; linarith
    obtain ⟨p,hp,hpl,hpu⟩ := gap x hx
    have hd := gap_width hx ht
    have low : n ≤ p+587000000000 := by
      have : (n:ℝ) ≤ (p:ℝ)+587000000000 := by dsimp [x] at *; linarith
      exact_mod_cast this
    have high : p+4 ≤ n := by
      have : (p:ℝ)+4 ≤ n := by dsimp [x] at hpu; linarith
      exact_mod_cast this
    have po := hp.odd_of_ne_two (by omega)
    have hev : Even (n-p) := Nat.Odd.sub_odd hn po
    obtain ⟨q,r,hq,hr,hs⟩ := bg (n-p) hev (by omega) (by omega)
    exact ⟨p,q,r,hp,hq,hr,by omega⟩

#print axioms through_1e20
end GoldbachFinite
