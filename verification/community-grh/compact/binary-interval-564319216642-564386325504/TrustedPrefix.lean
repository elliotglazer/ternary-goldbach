module

public import Mathlib.Data.Nat.Prime.Defs

@[expose] public section

namespace PrimeCoverage

def BinaryGoldbach (n : Nat) : Prop :=
  ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n

end PrimeCoverage

namespace SmallGoldbach

open PrimeCoverage

def Covered (lo hi : Nat) : Prop :=
  ∀ n, lo ≤ n → n < hi → n % 2 = 0 → BinaryGoldbach n

namespace ProductRange564319216642

theorem covered : Covered 564319216642 564386325506 := by
  sorry

end ProductRange564319216642
end SmallGoldbach
