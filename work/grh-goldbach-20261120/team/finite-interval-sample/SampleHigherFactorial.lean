import SampleHighProduct0
import SampleHighProduct1
import SampleHighProduct2
import SampleHighProduct3
namespace SampleHigherFactorial
open SmallGoldbach
def fac : Nat := ((SampleHighProduct0.value * SampleHighProduct1.value) * (SampleHighProduct2.value * SampleHighProduct3.value))
private theorem join (d a n : Nat) {u v : Nat}
    (hu : u = rangeProduct d a (n/2)) (hv : v = rangeProduct d (a+n/2) (n-n/2)) :
    u*v = rangeProduct (d+1) a n := congrArg₂ Nat.mul hu hv
theorem fac_eq : fac = Nat.factorial 316227 := factorial_of_product 14
  (join 13 1 316227 (join 12 1 158113 SampleHighProduct0.eq_prod SampleHighProduct1.eq_prod)
    (join 12 158114 158114 SampleHighProduct2.eq_prod SampleHighProduct3.eq_prod))
end SampleHigherFactorial
