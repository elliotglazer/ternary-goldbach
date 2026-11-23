import FactorialExtend
namespace SmallGoldbach.IndependentAudit
theorem checkedFactorial : ContiguousExtensionB.fac = Nat.factorial 106000 :=
  factorial_of_product 12 (by decide +kernel)
#print axioms checkedFactorial
end SmallGoldbach.IndependentAudit
