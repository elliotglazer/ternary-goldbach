module

public import ProfileG3R0N12Batch
public import ProfileG3R12N9Batch
public import ProfileG3R21N1Interval
public import ProfileG3R22N1Interval
public import ProfileG3R23N12Batch
public import ProfileG3R35N12Batch
public import ProfileG3R47N4Batch

@[expose] public section

open GoldbachEnergy.Profile
namespace ProfileGroup3
theorem rows : PriceRows 46.05 56 70 100000000 48189030400 pieces3 := Between.all (n:=51) (by decide +kernel) (Between.join (Between.join ProfileG3R0N12.interval (Between.join ProfileG3R12N9.interval ProfileG3R21N1.interval)) (Between.join (Between.join ProfileG3R22N1.interval ProfileG3R23N12.interval) (Between.join ProfileG3R35N12.interval ProfileG3R47N4.interval)))
#print axioms rows
end ProfileGroup3
