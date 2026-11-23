import AdjacentData
namespace AdjacentShard1
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece8 : Covered 99317108864 99325497472 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows8) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece9 : Covered 99325497472 99333886080 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows9) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece10 : Covered 99333886080 99342274688 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows10) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece11 : Covered 99342274688 99350663296 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows11) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece12 : Covered 99350663296 99359051904 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows12) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece13 : Covered 99359051904 99367440512 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows13) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece14 : Covered 99367440512 99375829120 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows14) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece15 : Covered 99375829120 99384217728 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows15) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 99317108864 99384217728 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece8 piece9) (SmallGoldbach.join piece10 piece11)) (SmallGoldbach.join (SmallGoldbach.join piece12 piece13) (SmallGoldbach.join piece14 piece15)))
end AdjacentShard1
