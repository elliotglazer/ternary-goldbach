import ProfileG2R0N12Batch
import ProfileG2R12N2Batch
open GoldbachEnergy.Profile
namespace ProfileGroup2
theorem rows : PriceRows 46.05 56 70 1 100000000 pieces2 := Between.all (n:=14) (by decide +kernel) (Between.join ProfileG2R0N12.interval ProfileG2R12N2.interval)
#print axioms rows
end ProfileGroup2
