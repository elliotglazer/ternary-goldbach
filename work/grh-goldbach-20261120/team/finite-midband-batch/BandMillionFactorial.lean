import BandMillionProduct0
import BandMillionProduct1
import BandMillionProduct2
import BandMillionProduct3
import BandMillionProduct4
import BandMillionProduct5
import BandMillionProduct6
import BandMillionProduct7
namespace BandMillionFactorial
open SmallGoldbach
private theorem join (d a n : Nat) {u v : Nat}
    (hu : u = rangeProduct d a (n/2)) (hv : v = rangeProduct d (a+n/2) (n-n/2)) :
    u*v = rangeProduct (d+1) a n := congrArg₂ Nat.mul hu hv
def fac : Nat := ((((BandMillionProduct0.value0 * BandMillionProduct0.value1) * (BandMillionProduct1.value2 * BandMillionProduct1.value3)) * ((BandMillionProduct2.value4 * BandMillionProduct2.value5) * (BandMillionProduct3.value6 * BandMillionProduct3.value7))) * (((BandMillionProduct4.value8 * BandMillionProduct4.value9) * (BandMillionProduct5.value10 * BandMillionProduct5.value11)) * ((BandMillionProduct6.value12 * BandMillionProduct6.value13) * (BandMillionProduct7.value14 * BandMillionProduct7.value15))))
theorem fac_eq : fac = Nat.factorial 1000000 := factorial_of_product 15 (join 14 1 1000000 (join 13 1 500000 (join 12 1 250000 (join 11 1 125000 BandMillionProduct0.sound0 BandMillionProduct0.sound1) (join 11 125001 125000 BandMillionProduct1.sound2 BandMillionProduct1.sound3)) (join 12 250001 250000 (join 11 250001 125000 BandMillionProduct2.sound4 BandMillionProduct2.sound5) (join 11 375001 125000 BandMillionProduct3.sound6 BandMillionProduct3.sound7))) (join 13 500001 500000 (join 12 500001 250000 (join 11 500001 125000 BandMillionProduct4.sound8 BandMillionProduct4.sound9) (join 11 625001 125000 BandMillionProduct5.sound10 BandMillionProduct5.sound11)) (join 12 750001 250000 (join 11 750001 125000 BandMillionProduct6.sound12 BandMillionProduct6.sound13) (join 11 875001 125000 BandMillionProduct7.sound14 BandMillionProduct7.sound15))))
#print axioms fac_eq
end BandMillionFactorial
