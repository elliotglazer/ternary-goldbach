import GoldbachLarge
import FullGRH
import Statements

namespace GrhGoldbach

/-- The large case of ternary Goldbach follows from the release's full Dirichlet GRH. -/
theorem ternary_goldbach_large_of_dirichletGRH (h : DirichletLZerosOnLine) :
    TernaryGoldbach.TernaryGoldbachFrom (10 ^ 27) :=
  TernaryGoldbach.ternary_goldbach_large_of_hypotheses (plattGRH_of_fullGRH h)

end GrhGoldbach
