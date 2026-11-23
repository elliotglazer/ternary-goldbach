import GoldbachBand05Prefix
import GoldbachBand06Shard0
import GoldbachBand06Shard1
import GoldbachBand06Shard2
import GoldbachBand06Shard3
import GoldbachBand06Shard4
import GoldbachBand06Shard5
import GoldbachBand06Shard6
import GoldbachBand06Shard7
import GoldbachBand06Shard8
import GoldbachBand06Shard9
import GoldbachBand06Shard10
import GoldbachBand06Shard11
import GoldbachBand06Shard12
import GoldbachBand06Shard13
import GoldbachBand06Shard14
import GoldbachBand06Shard15
import GoldbachBand06Shard16
import GoldbachBand06Shard17
import GoldbachBand06Shard18
import GoldbachBand06Shard19
import GoldbachBand06Shard20
import GoldbachBand06Shard21
import GoldbachBand06Shard22
import GoldbachBand06Shard23
import GoldbachBand06Shard24
import GoldbachBand06Shard25
import GoldbachBand06Shard26
import GoldbachBand06Shard27
import GoldbachBand06Shard28
import GoldbachBand06Shard29
import GoldbachBand06Shard30
import GoldbachBand06Shard31
import GoldbachBand06Shard32
import GoldbachBand06Shard33
import GoldbachBand06Shard34
import GoldbachBand06Shard35
import GoldbachBand06Shard36
import GoldbachBand06Shard37
import GoldbachBand06Shard38
import GoldbachBand06Shard39
import GoldbachBand06Shard40
import GoldbachBand06Shard41
import GoldbachBand06Shard42
import GoldbachBand06Shard43
import GoldbachBand06Shard44
import GoldbachBand06Shard45
import GoldbachBand06Shard46
import GoldbachBand06Shard47
import GoldbachBand06Shard48
import GoldbachBand06Shard49
import GoldbachBand06Shard50
import GoldbachBand06Shard51
import GoldbachBand06Shard52
import GoldbachBand06Shard53
import GoldbachBand06Shard54
import GoldbachBand06Shard55
import GoldbachBand06Shard56
import GoldbachBand06Shard57
import GoldbachBand06Shard58
import GoldbachBand06Shard59
import GoldbachBand06Shard60
namespace SmallGoldbach.GoldbachBand06
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 100328530944 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 67579405312
  · exact SmallGoldbach.GoldbachBand05.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11)) (SmallGoldbach.join (SmallGoldbach.join shard12 shard13) (SmallGoldbach.join shard14 shard15)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard16 shard17) (SmallGoldbach.join shard18 shard19)) (SmallGoldbach.join (SmallGoldbach.join shard20 shard21) (SmallGoldbach.join shard22 shard23))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard24 shard25) (SmallGoldbach.join shard26 shard27)) (SmallGoldbach.join (SmallGoldbach.join shard28 shard29) (SmallGoldbach.join shard30 shard31))))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard32 shard33) (SmallGoldbach.join shard34 shard35)) (SmallGoldbach.join (SmallGoldbach.join shard36 shard37) (SmallGoldbach.join shard38 shard39))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard40 shard41) (SmallGoldbach.join shard42 shard43)) (SmallGoldbach.join (SmallGoldbach.join shard44 shard45) (SmallGoldbach.join shard46 shard47)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard48 shard49) (SmallGoldbach.join shard50 shard51)) (SmallGoldbach.join (SmallGoldbach.join shard52 shard53) (SmallGoldbach.join shard54 shard55))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard56 shard57) (SmallGoldbach.join shard58 shard59)) shard60)))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand06
