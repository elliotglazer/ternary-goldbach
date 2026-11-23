import GoldbachBand04Prefix
import GoldbachBand05Shard0
import GoldbachBand05Shard1
import GoldbachBand05Shard2
import GoldbachBand05Shard3
import GoldbachBand05Shard4
import GoldbachBand05Shard5
import GoldbachBand05Shard6
import GoldbachBand05Shard7
import GoldbachBand05Shard8
import GoldbachBand05Shard9
import GoldbachBand05Shard10
import GoldbachBand05Shard11
import GoldbachBand05Shard12
import GoldbachBand05Shard13
import GoldbachBand05Shard14
import GoldbachBand05Shard15
import GoldbachBand05Shard16
import GoldbachBand05Shard17
import GoldbachBand05Shard18
import GoldbachBand05Shard19
import GoldbachBand05Shard20
import GoldbachBand05Shard21
import GoldbachBand05Shard22
import GoldbachBand05Shard23
import GoldbachBand05Shard24
import GoldbachBand05Shard25
import GoldbachBand05Shard26
import GoldbachBand05Shard27
import GoldbachBand05Shard28
import GoldbachBand05Shard29
import GoldbachBand05Shard30
import GoldbachBand05Shard31
import GoldbachBand05Shard32
import GoldbachBand05Shard33
import GoldbachBand05Shard34
import GoldbachBand05Shard35
import GoldbachBand05Shard36
import GoldbachBand05Shard37
import GoldbachBand05Shard38
import GoldbachBand05Shard39
namespace SmallGoldbach.GoldbachBand05
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 67579405312 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 46104568832
  · exact SmallGoldbach.GoldbachBand04.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11)) (SmallGoldbach.join (SmallGoldbach.join shard12 shard13) (SmallGoldbach.join shard14 shard15)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard16 shard17) (SmallGoldbach.join shard18 shard19)) (SmallGoldbach.join (SmallGoldbach.join shard20 shard21) (SmallGoldbach.join shard22 shard23))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard24 shard25) (SmallGoldbach.join shard26 shard27)) (SmallGoldbach.join (SmallGoldbach.join shard28 shard29) (SmallGoldbach.join shard30 shard31))))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard32 shard33) (SmallGoldbach.join shard34 shard35)) (SmallGoldbach.join (SmallGoldbach.join shard36 shard37) (SmallGoldbach.join shard38 shard39)))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand05
