import AdjacentData
namespace AdjacentShard0
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece0 : Covered 99250000000 99258388608 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows0) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece1 : Covered 99258388608 99266777216 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows1) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece2 : Covered 99266777216 99275165824 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows2) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece3 : Covered 99275165824 99283554432 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows3) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece4 : Covered 99283554432 99291943040 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows4) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece5 : Covered 99291943040 99300331648 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows5) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece6 : Covered 99300331648 99308720256 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows6) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece7 : Covered 99308720256 99317108864 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows7) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 99250000000 99317108864 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece0 piece1) (SmallGoldbach.join piece2 piece3)) (SmallGoldbach.join (SmallGoldbach.join piece4 piece5) (SmallGoldbach.join piece6 piece7)))
end AdjacentShard0
