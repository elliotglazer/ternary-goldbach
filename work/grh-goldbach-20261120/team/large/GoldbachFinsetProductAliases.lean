import Mathlib.Algebra.Order.BigOperators.GroupWithZero.Finset
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/- Lean's two Mathlib versions use different names for these exact inequalities.
Restrict the newer spelling to the namespace of the Goldbach source. -/
namespace TernaryGoldbach

alias prod_le_prod_of_subset_of_one_le₀ := Finset.prod_le_prod_of_subset_of_one_le
alias prod_le_prod_of_subset_of_one_le := Finset.prod_le_prod_of_subset_of_one_le'

end TernaryGoldbach
