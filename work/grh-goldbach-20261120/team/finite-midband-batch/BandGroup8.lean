import BandRows
import BatchWitness
import SampleBits
import BandMillionFactorial
namespace BandGroup8
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece0 : Covered 612345678900 612354067508 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part0 ++ BandRows.part1) BandRows.witness8_0
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece8 : Covered 612354067508 612362456116 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part2 ++ BandRows.part3) BandRows.witness8_1
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece16 : Covered 612362456116 612370844724 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part4 ++ BandRows.part5) BandRows.witness8_2
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece24 : Covered 612370844724 612379233332 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part6 ++ BandRows.part7) BandRows.witness8_3
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece32 : Covered 612379233332 612387621940 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part8 ++ BandRows.part9) BandRows.witness8_4
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece40 : Covered 612387621940 612396010548 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part10 ++ BandRows.part11) BandRows.witness8_5
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece48 : Covered 612396010548 612404399156 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part12 ++ BandRows.part13) BandRows.witness8_6
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece56 : Covered 612404399156 612412787764 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part14 ++ BandRows.part15) BandRows.witness8_7
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece64 : Covered 612412787764 612421176372 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part16 ++ BandRows.part17) BandRows.witness8_8
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece72 : Covered 612421176372 612429564980 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part18 ++ BandRows.part19) BandRows.witness8_9
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece80 : Covered 612429564980 612437953588 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part20 ++ BandRows.part21) BandRows.witness8_10
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece88 : Covered 612437953588 612446342196 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part22 ++ BandRows.part23) BandRows.witness8_11
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece96 : Covered 612446342196 612454730804 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part24 ++ BandRows.part25) BandRows.witness8_12
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece104 : Covered 612454730804 612463119412 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part26 ++ BandRows.part27) BandRows.witness8_13
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece112 : Covered 612463119412 612471508020 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part28 ++ BandRows.part29) BandRows.witness8_14
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece120 : Covered 612471508020 612479896628 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part30 ++ BandRows.part31) BandRows.witness8_15
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece128 : Covered 612479896628 612488285236 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part32 ++ BandRows.part33) BandRows.witness8_16
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece136 : Covered 612488285236 612496673844 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part34 ++ BandRows.part35) BandRows.witness8_17
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece144 : Covered 612496673844 612505062452 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part36 ++ BandRows.part37) BandRows.witness8_18
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece152 : Covered 612505062452 612513451060 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part38 ++ BandRows.part39) BandRows.witness8_19
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece160 : Covered 612513451060 612521839668 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part40 ++ BandRows.part41) BandRows.witness8_20
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece168 : Covered 612521839668 612530228276 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part42 ++ BandRows.part43) BandRows.witness8_21
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece176 : Covered 612530228276 612538616884 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part44 ++ BandRows.part45) BandRows.witness8_22
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece184 : Covered 612538616884 612547005492 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part46 ++ BandRows.part47) BandRows.witness8_23
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece192 : Covered 612547005492 612555394100 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part48 ++ BandRows.part49) BandRows.witness8_24
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece200 : Covered 612555394100 612563782708 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part50 ++ BandRows.part51) BandRows.witness8_25
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece208 : Covered 612563782708 612572171316 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part52 ++ BandRows.part53) BandRows.witness8_26
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece216 : Covered 612572171316 612580559924 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part54 ++ BandRows.part55) BandRows.witness8_27
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece224 : Covered 612580559924 612588948532 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part56 ++ BandRows.part57) BandRows.witness8_28
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece232 : Covered 612588948532 612597337140 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part58 ++ BandRows.part59) BandRows.witness8_29
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece240 : Covered 612597337140 612605725748 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part60 ++ BandRows.part61) BandRows.witness8_30
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece248 : Covered 612605725748 612614114356 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part62 ++ BandRows.part63) BandRows.witness8_31
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 612345678900 612614114356 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece0 piece8) (SmallGoldbach.join piece16 piece24)) (SmallGoldbach.join (SmallGoldbach.join piece32 piece40) (SmallGoldbach.join piece48 piece56))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece64 piece72) (SmallGoldbach.join piece80 piece88)) (SmallGoldbach.join (SmallGoldbach.join piece96 piece104) (SmallGoldbach.join piece112 piece120)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece128 piece136) (SmallGoldbach.join piece144 piece152)) (SmallGoldbach.join (SmallGoldbach.join piece160 piece168) (SmallGoldbach.join piece176 piece184))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece192 piece200) (SmallGoldbach.join piece208 piece216)) (SmallGoldbach.join (SmallGoldbach.join piece224 piece232) (SmallGoldbach.join piece240 piece248)))))
#print axioms covered
end BandGroup8
