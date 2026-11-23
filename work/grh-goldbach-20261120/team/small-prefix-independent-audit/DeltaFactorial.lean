import FactorialExtend
namespace SmallGoldbach.IndependentAudit
theorem checkedFactorial : ContiguousExtensionB.fac = Nat.factorial 106000 :=
  factorial_extend (d := 101000) (m := 5000) 8 ContiguousExtension.fac_eq (by decide +kernel)
#print axioms checkedFactorial
end SmallGoldbach.IndependentAudit
