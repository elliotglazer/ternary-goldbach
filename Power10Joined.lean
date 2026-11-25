module

public import Power10Block00
public import Power10Block01
public import Power10Block02
public import Power10Block03
public import Power10Block04
public import Power10Block05
public import Power10Block06
public import Power10Block07

@[expose] public section
namespace SmallGoldbach.Power10
open SmallGoldbach
theorem binaryGoldbachUpTo : ∀ n : Nat, Even n → 4 ≤ n → n ≤ 10^10 →
    ∃ p q : Nat, p.Prime ∧ q.Prime ∧ p+q=n :=
  prefix_of_covered (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join block0 block1) (SmallGoldbach.join block2 block3)) (SmallGoldbach.join (SmallGoldbach.join block4 block5) (SmallGoldbach.join block6 block7))) (by decide)
end SmallGoldbach.Power10
