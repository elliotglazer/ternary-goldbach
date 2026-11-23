import ExtendedPrefixB
open SmallGoldbach
example : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 11207959552 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=
  SmallGoldbach.ContiguousExtensionB.binaryGoldbachUpTo
example : Covered 10134217730 10671088642 :=
  SmallGoldbach.join ContiguousExtensionB.shard0 ContiguousExtensionB.shard1
#print axioms SmallGoldbach.ContiguousExtensionB.binaryGoldbachUpTo
