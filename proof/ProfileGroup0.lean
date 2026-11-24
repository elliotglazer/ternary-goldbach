import ProfileG0R0N4Interval
import ProfileG0R4N12Batch
import ProfileG0R16N12Batch
import ProfileG0R28N12Batch
import ProfileG0R40N12Batch
import ProfileG0R52N4Batch
open GoldbachEnergy.Profile
namespace ProfileGroup0
theorem rows : PriceRows 44.44 46.052 30 1 100000000 pieces0 := Between.all (n:=56) (by decide +kernel) (Between.join (Between.join ProfileG0R0N4.interval (Between.join ProfileG0R4N12.interval ProfileG0R16N12.interval)) (Between.join ProfileG0R28N12.interval (Between.join ProfileG0R40N12.interval ProfileG0R52N4.interval)))
#print axioms rows
end ProfileGroup0
