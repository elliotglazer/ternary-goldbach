import AdjacentData
namespace AdjacentShard3
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece24 : Covered 99451326592 99459715200 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows24) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece25 : Covered 99459715200 99468103808 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows25) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece26 : Covered 99468103808 99476492416 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows26) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece27 : Covered 99476492416 99484881024 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows27) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece28 : Covered 99484881024 99493269632 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows28) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece29 : Covered 99493269632 99501658240 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows29) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece30 : Covered 99501658240 99510046848 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows30) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece31 : Covered 99510046848 99518435456 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows31) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 99451326592 99518435456 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece24 piece25) (SmallGoldbach.join piece26 piece27)) (SmallGoldbach.join (SmallGoldbach.join piece28 piece29) (SmallGoldbach.join piece30 piece31)))
end AdjacentShard3
