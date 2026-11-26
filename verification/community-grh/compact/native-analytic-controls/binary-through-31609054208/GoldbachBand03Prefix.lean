module

public import GoldbachBand02Prefix
public import GoldbachBand03Shard0
public import GoldbachBand03Shard1
public import GoldbachBand03Shard2
public import GoldbachBand03Shard3
public import GoldbachBand03Shard4
public import GoldbachBand03Shard5
public import GoldbachBand03Shard6
public import GoldbachBand03Shard7
public import GoldbachBand03Shard8
public import GoldbachBand03Shard9
public import GoldbachBand03Shard10
public import GoldbachBand03Shard11
public import GoldbachBand03Shard12
public import GoldbachBand03Shard13
public import GoldbachBand03Shard14
public import GoldbachBand03Shard15
public import GoldbachBand03Shard16
public import GoldbachBand03Shard17

@[expose] public section
namespace SmallGoldbach.GoldbachBand03
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 31609054208 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 21945377792
  · exact SmallGoldbach.GoldbachBand02.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11)) (SmallGoldbach.join (SmallGoldbach.join shard12 shard13) (SmallGoldbach.join shard14 shard15)))) (SmallGoldbach.join shard16 shard17)) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand03
