import GoldbachLargeOfDirichletGRH
import Main

namespace GrhGoldbach

/-- Every odd natural number at least 10²⁷ is a sum of three primes. -/
theorem ternary_goldbach_large : TernaryGoldbach.TernaryGoldbachFrom (10 ^ 27) :=
  ternary_goldbach_large_of_dirichletGRH LFunction_eq_zero_re

end GrhGoldbach
