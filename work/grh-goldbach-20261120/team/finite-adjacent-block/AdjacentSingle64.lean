import AdjacentData
namespace AdjacentSingle64
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem covered : Covered 99250000000 99317108864 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows0 ++ AdjacentData.rows1 ++ AdjacentData.rows2 ++ AdjacentData.rows3 ++ AdjacentData.rows4 ++ AdjacentData.rows5 ++ AdjacentData.rows6 ++ AdjacentData.rows7) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
#print axioms covered
end AdjacentSingle64
