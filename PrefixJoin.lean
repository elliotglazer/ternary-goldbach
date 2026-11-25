module

public import PrefixSource

@[expose] public section

namespace SmallGoldbach
open PrimeCoverage

def Covered (lo hi : Nat) : Prop :=
  ∀ n, lo ≤ n → n < hi → n % 2 = 0 → BinaryGoldbach n

theorem checked_interval {bits fac d halo lo hi : Nat} (hs : PrimeBitmap 3 bits)
    (hf : fac = d.factorial) (rs : List Row) (ho : 6 ≤ lo) (he : lo % 2 = 0)
    (hc : checkRows bits fac d halo lo rs = true) (hl : hi ≤ lo+2*span rs) :
    Covered lo hi := by
  intro n hn hh hp
  exact rows_sound hs hf rs lo ho he hc n hn (Nat.lt_of_lt_of_le hh hl) hp

theorem join {lo mid hi : Nat} (a : Covered lo mid) (b : Covered mid hi) : Covered lo hi := by
  intro n hl hh he
  by_cases h : n < mid
  · exact a n hl h he
  · exact b n (by omega) hh he

theorem prefix_of_covered {bound hi : Nat} (h : Covered 6 hi) (hhi : bound < hi) :
    ∀ n : Nat, Even n → 4 ≤ n → n ≤ bound → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  obtain ⟨k, hk⟩ := he
  by_cases hsmall : n = 4
  · exact ⟨2,2,Nat.prime_two,Nat.prime_two,by omega⟩
  · exact h n (by omega) (by omega) (by omega)

end SmallGoldbach
