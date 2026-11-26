module

public import GoldbachBand02Prefix

public section

namespace SmallGoldbach.F17bFiniteAudit

theorem ternaryGoldbachThrough21945377795 :
    ∀ n : Nat, Odd n → 5 < n → n ≤ 21945377795 →
      ∃ p q r : Nat, p.Prime ∧ q.Prime ∧ r.Prime ∧ p + q + r = n := by
  intro n hn h5 hmax
  obtain ⟨k, hk⟩ := hn
  have he : Even (n - 3) := ⟨k - 1, by omega⟩
  obtain ⟨p, q, hp, hq, hsum⟩ :=
    GoldbachBand02.binaryGoldbachUpTo (n - 3) he (by omega) (by omega)
  exact ⟨p, q, 3, hp, hq, Nat.prime_three, by omega⟩

#print axioms ternaryGoldbachThrough21945377795

end SmallGoldbach.F17bFiniteAudit
