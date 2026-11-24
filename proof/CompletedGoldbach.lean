import Main
import CompletedFiniteRows

namespace CompletedGoldbach

theorem ternary_goldbach : TernaryGoldbach.Statement :=
  GoldbachFinite.completed_of_release riemannHypothesis LFunction_eq_zero_re_of_isPrimitive

#print axioms ternary_goldbach

end CompletedGoldbach
