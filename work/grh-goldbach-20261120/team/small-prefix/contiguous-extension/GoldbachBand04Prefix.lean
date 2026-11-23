import GoldbachBand03Prefix
import GoldbachBand04Shard0
import GoldbachBand04Shard1
import GoldbachBand04Shard2
import GoldbachBand04Shard3
import GoldbachBand04Shard4
import GoldbachBand04Shard5
import GoldbachBand04Shard6
import GoldbachBand04Shard7
import GoldbachBand04Shard8
import GoldbachBand04Shard9
import GoldbachBand04Shard10
import GoldbachBand04Shard11
import GoldbachBand04Shard12
import GoldbachBand04Shard13
import GoldbachBand04Shard14
import GoldbachBand04Shard15
import GoldbachBand04Shard16
import GoldbachBand04Shard17
import GoldbachBand04Shard18
import GoldbachBand04Shard19
import GoldbachBand04Shard20
import GoldbachBand04Shard21
import GoldbachBand04Shard22
import GoldbachBand04Shard23
import GoldbachBand04Shard24
import GoldbachBand04Shard25
import GoldbachBand04Shard26
namespace SmallGoldbach.GoldbachBand04
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 46104568832 → ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n := by
  intro n he h4 hh
  by_cases h : n ≤ 31609054208
  · exact SmallGoldbach.GoldbachBand03.binaryGoldbachUpTo n he h4 h
  · obtain ⟨k, hk⟩ := he
    exact (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard0 shard1) (SmallGoldbach.join shard2 shard3)) (SmallGoldbach.join (SmallGoldbach.join shard4 shard5) (SmallGoldbach.join shard6 shard7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard8 shard9) (SmallGoldbach.join shard10 shard11)) (SmallGoldbach.join (SmallGoldbach.join shard12 shard13) (SmallGoldbach.join shard14 shard15)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join shard16 shard17) (SmallGoldbach.join shard18 shard19)) (SmallGoldbach.join (SmallGoldbach.join shard20 shard21) (SmallGoldbach.join shard22 shard23))) (SmallGoldbach.join (SmallGoldbach.join shard24 shard25) shard26))) n (by omega) (by omega) (by omega)
#print axioms binaryGoldbachUpTo
end SmallGoldbach.GoldbachBand04
