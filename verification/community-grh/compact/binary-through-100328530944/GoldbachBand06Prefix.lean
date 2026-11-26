module

public import GoldbachBand05Prefix
public import GoldbachBand06Shard0
public import GoldbachBand06Shard1
public import GoldbachBand06Shard2
public import GoldbachBand06Shard3
public import GoldbachBand06Shard4
public import GoldbachBand06Shard5
public import GoldbachBand06Shard6
public import GoldbachBand06Shard7
public import GoldbachBand06Shard8
public import GoldbachBand06Shard9
public import GoldbachBand06Shard10
public import GoldbachBand06Shard11
public import GoldbachBand06Shard12
public import GoldbachBand06Shard13
public import GoldbachBand06Shard14
public import GoldbachBand06Shard15
public import GoldbachBand06Shard16
public import GoldbachBand06Shard17
public import GoldbachBand06Shard18
public import GoldbachBand06Shard19
public import GoldbachBand06Shard20
public import GoldbachBand06Shard21
public import GoldbachBand06Shard22
public import GoldbachBand06Shard23
public import GoldbachBand06Shard24
public import GoldbachBand06Shard25
public import GoldbachBand06Shard26
public import GoldbachBand06Shard27
public import GoldbachBand06Shard28
public import GoldbachBand06Shard29
public import GoldbachBand06Shard30
public import GoldbachBand06Shard31
public import GoldbachBand06Shard32
public import GoldbachBand06Shard33
public import GoldbachBand06Shard34
public import GoldbachBand06Shard35
public import GoldbachBand06Shard36
public import GoldbachBand06Shard37
public import GoldbachBand06Shard38
public import GoldbachBand06Shard39
public import GoldbachBand06Shard40
public import GoldbachBand06Shard41
public import GoldbachBand06Shard42
public import GoldbachBand06Shard43
public import GoldbachBand06Shard44
public import GoldbachBand06Shard45
public import GoldbachBand06Shard46
public import GoldbachBand06Shard47
public import GoldbachBand06Shard48
public import GoldbachBand06Shard49
public import GoldbachBand06Shard50
public import GoldbachBand06Shard51
public import GoldbachBand06Shard52
public import GoldbachBand06Shard53
public import GoldbachBand06Shard54
public import GoldbachBand06Shard55
public import GoldbachBand06Shard56
public import GoldbachBand06Shard57
public import GoldbachBand06Shard58
public import GoldbachBand06Shard59
public import GoldbachBand06Shard60

@[expose] public section
namespace SmallGoldbach.GoldbachBand06
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 100328530944 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 67579405312
  · exact SmallGoldbach.GoldbachBand05.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11)) (SmallGoldbach.join (SmallGoldbach.join shard12 shard13) (SmallGoldbach.join shard14 shard15)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard16 shard17) (SmallGoldbach.join shard18 shard19)) (SmallGoldbach.join (SmallGoldbach.join shard20 shard21) (SmallGoldbach.join shard22 shard23))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard24 shard25) (SmallGoldbach.join shard26 shard27)) (SmallGoldbach.join (SmallGoldbach.join shard28 shard29) (SmallGoldbach.join shard30 shard31))))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard32 shard33) (SmallGoldbach.join shard34 shard35)) (SmallGoldbach.join (SmallGoldbach.join shard36 shard37) (SmallGoldbach.join shard38 shard39))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard40 shard41) (SmallGoldbach.join shard42 shard43)) (SmallGoldbach.join (SmallGoldbach.join shard44 shard45) (SmallGoldbach.join shard46 shard47)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard48 shard49) (SmallGoldbach.join shard50 shard51)) (SmallGoldbach.join (SmallGoldbach.join shard52 shard53) (SmallGoldbach.join shard54 shard55))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard56 shard57) (SmallGoldbach.join shard58 shard59)) shard60)))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand06
