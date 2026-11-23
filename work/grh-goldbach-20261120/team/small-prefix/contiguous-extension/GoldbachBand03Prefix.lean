import GoldbachBand02Prefix
import GoldbachBand03Shard0
import GoldbachBand03Shard1
import GoldbachBand03Shard2
import GoldbachBand03Shard3
import GoldbachBand03Shard4
import GoldbachBand03Shard5
import GoldbachBand03Shard6
import GoldbachBand03Shard7
import GoldbachBand03Shard8
import GoldbachBand03Shard9
import GoldbachBand03Shard10
import GoldbachBand03Shard11
import GoldbachBand03Shard12
import GoldbachBand03Shard13
import GoldbachBand03Shard14
import GoldbachBand03Shard15
import GoldbachBand03Shard16
import GoldbachBand03Shard17
namespace SmallGoldbach.GoldbachBand03
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 31609054208 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 21945377792
  · exact SmallGoldbach.GoldbachBand02.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11)) (SmallGoldbach.join (SmallGoldbach.join shard12 shard13) (SmallGoldbach.join shard14 shard15)))) (SmallGoldbach.join shard16 shard17)) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand03
