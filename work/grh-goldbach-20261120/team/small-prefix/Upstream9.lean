import TernaryGoldbach.Statement
import Power9

namespace SmallGoldbach

theorem binaryGoldbachUpToBillion : TernaryGoldbach.BinaryGoldbachUpTo (10^9) :=
  Power9.binaryGoldbachUpTo

theorem binaryGoldbachUpToFourHundredMillion : TernaryGoldbach.BinaryGoldbachUpTo (4*10^8) := by
  intro n he h4 hn
  exact binaryGoldbachUpToBillion n he h4 (Nat.le_trans hn (by decide))

end SmallGoldbach
