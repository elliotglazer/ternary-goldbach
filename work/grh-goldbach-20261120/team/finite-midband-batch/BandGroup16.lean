import BandRows
import BatchWitness
import SampleBits
import BandMillionFactorial
namespace BandGroup16
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece0 : Covered 612345678900 612362456116 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part0 ++ BandRows.part1 ++ BandRows.part2 ++ BandRows.part3) BandRows.witness16_0
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece16 : Covered 612362456116 612379233332 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part4 ++ BandRows.part5 ++ BandRows.part6 ++ BandRows.part7) BandRows.witness16_1
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece32 : Covered 612379233332 612396010548 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part8 ++ BandRows.part9 ++ BandRows.part10 ++ BandRows.part11) BandRows.witness16_2
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece48 : Covered 612396010548 612412787764 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part12 ++ BandRows.part13 ++ BandRows.part14 ++ BandRows.part15) BandRows.witness16_3
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece64 : Covered 612412787764 612429564980 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part16 ++ BandRows.part17 ++ BandRows.part18 ++ BandRows.part19) BandRows.witness16_4
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece80 : Covered 612429564980 612446342196 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part20 ++ BandRows.part21 ++ BandRows.part22 ++ BandRows.part23) BandRows.witness16_5
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece96 : Covered 612446342196 612463119412 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part24 ++ BandRows.part25 ++ BandRows.part26 ++ BandRows.part27) BandRows.witness16_6
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece112 : Covered 612463119412 612479896628 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part28 ++ BandRows.part29 ++ BandRows.part30 ++ BandRows.part31) BandRows.witness16_7
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece128 : Covered 612479896628 612496673844 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part32 ++ BandRows.part33 ++ BandRows.part34 ++ BandRows.part35) BandRows.witness16_8
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece144 : Covered 612496673844 612513451060 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part36 ++ BandRows.part37 ++ BandRows.part38 ++ BandRows.part39) BandRows.witness16_9
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece160 : Covered 612513451060 612530228276 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part40 ++ BandRows.part41 ++ BandRows.part42 ++ BandRows.part43) BandRows.witness16_10
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece176 : Covered 612530228276 612547005492 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part44 ++ BandRows.part45 ++ BandRows.part46 ++ BandRows.part47) BandRows.witness16_11
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece192 : Covered 612547005492 612563782708 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part48 ++ BandRows.part49 ++ BandRows.part50 ++ BandRows.part51) BandRows.witness16_12
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece208 : Covered 612563782708 612580559924 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part52 ++ BandRows.part53 ++ BandRows.part54 ++ BandRows.part55) BandRows.witness16_13
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece224 : Covered 612580559924 612597337140 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part56 ++ BandRows.part57 ++ BandRows.part58 ++ BandRows.part59) BandRows.witness16_14
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece240 : Covered 612597337140 612614114356 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part60 ++ BandRows.part61 ++ BandRows.part62 ++ BandRows.part63) BandRows.witness16_15
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 612345678900 612614114356 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece0 piece16) (SmallGoldbach.join piece32 piece48)) (SmallGoldbach.join (SmallGoldbach.join piece64 piece80) (SmallGoldbach.join piece96 piece112))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece128 piece144) (SmallGoldbach.join piece160 piece176)) (SmallGoldbach.join (SmallGoldbach.join piece192 piece208) (SmallGoldbach.join piece224 piece240))))
#print axioms covered
end BandGroup16
