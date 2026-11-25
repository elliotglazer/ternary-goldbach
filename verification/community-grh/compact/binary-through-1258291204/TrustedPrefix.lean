module
public import Mathlib.Data.Nat.Prime.Defs
public import Mathlib.Algebra.Ring.Parity
@[expose] public section

namespace PrimeCoverage
def BinaryGoldbach (n : Nat) : Prop :=
  ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n
end PrimeCoverage

namespace SmallGoldbach
open PrimeCoverage
def Covered (lo hi : Nat) : Prop :=
  ∀ n, lo ≤ n → n < hi → n % 2 = 0 → BinaryGoldbach n
namespace Power10
theorem block0 : Covered 6 1258291206 := by sorry
end Power10
end SmallGoldbach

namespace FinitePrefixAudit
theorem binary_goldbach_through_1258291204 : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 1258291204 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p + q = n := by sorry
end FinitePrefixAudit
