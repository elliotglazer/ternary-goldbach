import Power10Block00
import Power10Block01
import Power10Block02
import Power10Block03
import Power10Block04
import Power10Block05
import Power10Block06
import Power10Block07
import Power10Block08
import Power10Block09
import Power10Block10
import Power10Block11
import Power10Block12
import Power10Block13
import Power10Block14
import Power10Block15
import Power10Block16
import Power10Block17
import Power10Block18
namespace SmallGoldbach.Power10
open SmallGoldbach
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^10 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=
  prefix_of_covered (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join block0 block1) (SmallGoldbach.join block2 block3)) (SmallGoldbach.join (SmallGoldbach.join block4 block5) (SmallGoldbach.join block6 block7))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join block8 block9) (SmallGoldbach.join block10 block11)) (SmallGoldbach.join (SmallGoldbach.join block12 block13) (SmallGoldbach.join block14 block15)))) (SmallGoldbach.join (SmallGoldbach.join block16 block17) block18)) (by decide)
end SmallGoldbach.Power10
