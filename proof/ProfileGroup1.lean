import ProfileG1R0N12Batch
import ProfileG1R12N1Interval
import ProfileG1R13N12Batch
import ProfileG1R25N12Batch
import ProfileG1R37N12Batch
import ProfileG1R49N12Batch
import ProfileG1R61N12Batch
import ProfileG1R73N12Batch
import ProfileG1R85N12Batch
import ProfileG1R97N5Batch
open GoldbachEnergy.Profile
namespace ProfileGroup1
theorem rows : PriceRows 44.44 46.052 30 100000000 4047962620 pieces1 := Between.all (n:=102) (by decide +kernel) (Between.join (Between.join (Between.join ProfileG1R0N12.interval ProfileG1R12N1.interval) (Between.join ProfileG1R13N12.interval (Between.join ProfileG1R25N12.interval ProfileG1R37N12.interval))) (Between.join (Between.join ProfileG1R49N12.interval ProfileG1R61N12.interval) (Between.join ProfileG1R73N12.interval (Between.join ProfileG1R85N12.interval ProfileG1R97N5.interval))))
#print axioms rows
end ProfileGroup1
