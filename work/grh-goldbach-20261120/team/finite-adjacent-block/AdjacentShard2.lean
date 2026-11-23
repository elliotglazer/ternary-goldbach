import AdjacentData
namespace AdjacentShard2
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece16 : Covered 99384217728 99392606336 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows16) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece17 : Covered 99392606336 99400994944 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows17) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece18 : Covered 99400994944 99409383552 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows18) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece19 : Covered 99409383552 99417772160 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows19) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece20 : Covered 99417772160 99426160768 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows20) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece21 : Covered 99426160768 99434549376 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows21) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece22 : Covered 99434549376 99442937984 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows22) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece23 : Covered 99442937984 99451326592 :=
  checked_interval (halo := 4096) SampleWindow.source SampleHigherFactorial.fac_eq
    (AdjacentData.rows23) (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 99384217728 99451326592 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece16 piece17) (SmallGoldbach.join piece18 piece19)) (SmallGoldbach.join (SmallGoldbach.join piece20 piece21) (SmallGoldbach.join piece22 piece23)))
end AdjacentShard2
