import TernaryGoldbach.Statement
import Power10Joined

namespace SmallGoldbach

theorem binaryGoldbachUpToTenBillion : TernaryGoldbach.BinaryGoldbachUpTo (10^10) :=
  Power10.binaryGoldbachUpTo

theorem binaryGoldbachUpTo_of_le_ten_billion {b : ℕ} (hb : b ≤ 10^10) :
    TernaryGoldbach.BinaryGoldbachUpTo b := by
  intro n he h4 hn
  exact binaryGoldbachUpToTenBillion n he h4 (hn.trans hb)

theorem binaryGoldbachUpToPower {k : ℕ} (hk : k ≤ 10) :
    TernaryGoldbach.BinaryGoldbachUpTo (10^k) :=
  binaryGoldbachUpTo_of_le_ten_billion (Nat.pow_le_pow_right (n := 10) (by decide) hk)

end SmallGoldbach
