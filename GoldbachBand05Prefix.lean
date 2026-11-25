module

public import GoldbachBand04Prefix
public import GoldbachBand05Shard0
public import GoldbachBand05Shard1
public import GoldbachBand05Shard2
public import GoldbachBand05Shard3
public import GoldbachBand05Shard4
public import GoldbachBand05Shard5
public import GoldbachBand05Shard6
public import GoldbachBand05Shard7
public import GoldbachBand05Shard8
public import GoldbachBand05Shard9
public import GoldbachBand05Shard10
public import GoldbachBand05Shard11
public import GoldbachBand05Shard12
public import GoldbachBand05Shard13
public import GoldbachBand05Shard14
public import GoldbachBand05Shard15
public import GoldbachBand05Shard16
public import GoldbachBand05Shard17
public import GoldbachBand05Shard18
public import GoldbachBand05Shard19
public import GoldbachBand05Shard20
public import GoldbachBand05Shard21
public import GoldbachBand05Shard22
public import GoldbachBand05Shard23
public import GoldbachBand05Shard24
public import GoldbachBand05Shard25
public import GoldbachBand05Shard26
public import GoldbachBand05Shard27
public import GoldbachBand05Shard28
public import GoldbachBand05Shard29
public import GoldbachBand05Shard30
public import GoldbachBand05Shard31
public import GoldbachBand05Shard32
public import GoldbachBand05Shard33
public import GoldbachBand05Shard34
public import GoldbachBand05Shard35
public import GoldbachBand05Shard36
public import GoldbachBand05Shard37
public import GoldbachBand05Shard38
public import GoldbachBand05Shard39

@[expose] public section
namespace SmallGoldbach.GoldbachBand05
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 67579405312 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 46104568832
  · exact SmallGoldbach.GoldbachBand04.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11)) (SmallGoldbach.join (SmallGoldbach.join shard12 shard13) (SmallGoldbach.join shard14 shard15)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard16 shard17) (SmallGoldbach.join shard18 shard19)) (SmallGoldbach.join (SmallGoldbach.join shard20 shard21) (SmallGoldbach.join shard22 shard23))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard24 shard25) (SmallGoldbach.join shard26 shard27)) (SmallGoldbach.join (SmallGoldbach.join shard28 shard29) (SmallGoldbach.join shard30 shard31))))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard32 shard33) (SmallGoldbach.join shard34 shard35)) (SmallGoldbach.join (SmallGoldbach.join shard36 shard37) (SmallGoldbach.join shard38 shard39)))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand05
