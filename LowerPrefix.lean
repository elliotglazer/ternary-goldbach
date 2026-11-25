module

public import LadderToQuadrillion
public import TernaryGoldbach.Statement

@[expose] public section


open TernaryGoldbach TestedLadder
namespace GoldbachFinite

/-- A checked ladder supplies the odd prime, with the remaining even in the archived prefix. -/
theorem through_quadrillion (bg : BinaryGoldbachUpTo 100328530944) :
    TernaryGoldbachUpTo (10^15+4) := by
  intro n hn h5 htop
  by_cases h : n ≤ 100328530944+3
  · obtain ⟨q,r,hq,hr,he⟩ := bg (n-3) (Nat.Odd.sub_odd hn (by decide : Odd 3))
      (by obtain ⟨k,hk⟩ := hn; omega) (by omega)
    exact ⟨3,q,r,Nat.prime_three,hq,hr,by omega⟩
  · obtain ⟨p,hp,ho,hlo,hhi,hp'⟩ := LadderToQuadrillion.gapCover n hn (by omega) (by omega)
    obtain ⟨q,r,hq,hr,he⟩ := bg (n-p) (Nat.Odd.sub_odd hn ho) hlo hhi
    exact ⟨p,q,r,hp,hq,hr,by omega⟩

/-- Use the short interval that the Gaussian prime-extraction argument actually produces. -/
theorem through_1e20_gaussian
    (gap : ∀ x : ℝ, 10^15 ≤ x → x ≤ 10^20 →
      ∃ p : ℕ, p.Prime ∧ x - 126.2*Real.sqrt x < p ∧ (p:ℝ) ≤ x)
    (bg : BinaryGoldbachUpTo 1262000000002) : TernaryGoldbachUpTo (10^20) := by
  intro n hn h5 htop
  by_cases hs : n ≤ 10^15+4
  · apply through_quadrillion _ n hn h5 hs
    exact fun m hmo hm hM => bg m hmo hm (by omega)
  · let x : ℝ := n-4
    have hx : (10:ℝ)^15 ≤ x := by
      have h : (10:ℝ)^15 + 4 < n := by exact_mod_cast lt_of_not_ge hs
      dsimp [x]; linarith
    have hX : x ≤ (10:ℝ)^20 := by
      have h : (n:ℝ) ≤ 10^20 := by exact_mod_cast htop
      dsimp [x]; linarith
    obtain ⟨p,hp,hl,hu⟩ := gap x hx hX
    have hroot : Real.sqrt x ≤ 10^10 := Real.sqrt_le_iff.mpr ⟨by norm_num, by nlinarith only [hX]⟩
    have h4 : p+4 ≤ n := by exact_mod_cast (show (p:ℝ)+4 ≤ n by dsimp [x] at hu; linarith)
    have hw : n < p+1262000000004 := by
      exact_mod_cast (show (n:ℝ) < p+1262000000004 by dsimp only [x] at hl hroot; linarith)
    have ho := hp.odd_of_ne_two (by omega)
    have hev := Nat.Odd.sub_odd hn ho
    obtain ⟨q,r,hq,hr,he⟩ := bg (n-p) hev (by omega) (by obtain ⟨k,hk⟩ := hev; omega)
    exact ⟨p,q,r,hp,hq,hr,by omega⟩
#print axioms through_quadrillion
#print axioms through_1e20_gaussian
end GoldbachFinite
