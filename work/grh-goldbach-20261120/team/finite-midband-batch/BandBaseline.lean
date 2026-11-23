import BandRows
import BatchWitness
import SampleBits
import BandMillionFactorial
namespace BandBaseline
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece0 : Covered 612345678900 612354067508 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part0 ++ BandRows.part1)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece8 : Covered 612354067508 612362456116 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part2 ++ BandRows.part3)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece16 : Covered 612362456116 612370844724 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part4 ++ BandRows.part5)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece24 : Covered 612370844724 612379233332 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part6 ++ BandRows.part7)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece32 : Covered 612379233332 612387621940 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part8 ++ BandRows.part9)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece40 : Covered 612387621940 612396010548 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part10 ++ BandRows.part11)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece48 : Covered 612396010548 612404399156 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part12 ++ BandRows.part13)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece56 : Covered 612404399156 612412787764 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part14 ++ BandRows.part15)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece64 : Covered 612412787764 612421176372 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part16 ++ BandRows.part17)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece72 : Covered 612421176372 612429564980 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part18 ++ BandRows.part19)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece80 : Covered 612429564980 612437953588 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part20 ++ BandRows.part21)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece88 : Covered 612437953588 612446342196 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part22 ++ BandRows.part23)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece96 : Covered 612446342196 612454730804 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part24 ++ BandRows.part25)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece104 : Covered 612454730804 612463119412 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part26 ++ BandRows.part27)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece112 : Covered 612463119412 612471508020 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part28 ++ BandRows.part29)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece120 : Covered 612471508020 612479896628 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part30 ++ BandRows.part31)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece128 : Covered 612479896628 612488285236 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part32 ++ BandRows.part33)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece136 : Covered 612488285236 612496673844 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part34 ++ BandRows.part35)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece144 : Covered 612496673844 612505062452 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part36 ++ BandRows.part37)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece152 : Covered 612505062452 612513451060 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part38 ++ BandRows.part39)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece160 : Covered 612513451060 612521839668 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part40 ++ BandRows.part41)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece168 : Covered 612521839668 612530228276 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part42 ++ BandRows.part43)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece176 : Covered 612530228276 612538616884 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part44 ++ BandRows.part45)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece184 : Covered 612538616884 612547005492 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part46 ++ BandRows.part47)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece192 : Covered 612547005492 612555394100 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part48 ++ BandRows.part49)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece200 : Covered 612555394100 612563782708 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part50 ++ BandRows.part51)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece208 : Covered 612563782708 612572171316 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part52 ++ BandRows.part53)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece216 : Covered 612572171316 612580559924 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part54 ++ BandRows.part55)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece224 : Covered 612580559924 612588948532 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part56 ++ BandRows.part57)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece232 : Covered 612588948532 612597337140 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part58 ++ BandRows.part59)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece240 : Covered 612597337140 612605725748 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part60 ++ BandRows.part61)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem piece248 : Covered 612605725748 612614114356 :=
  checked_interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part62 ++ BandRows.part63)
    (by decide) (by decide) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 612345678900 612614114356 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece0 piece8) (SmallGoldbach.join piece16 piece24)) (SmallGoldbach.join (SmallGoldbach.join piece32 piece40) (SmallGoldbach.join piece48 piece56))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece64 piece72) (SmallGoldbach.join piece80 piece88)) (SmallGoldbach.join (SmallGoldbach.join piece96 piece104) (SmallGoldbach.join piece112 piece120)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece128 piece136) (SmallGoldbach.join piece144 piece152)) (SmallGoldbach.join (SmallGoldbach.join piece160 piece168) (SmallGoldbach.join piece176 piece184))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece192 piece200) (SmallGoldbach.join piece208 piece216)) (SmallGoldbach.join (SmallGoldbach.join piece224 piece232) (SmallGoldbach.join piece240 piece248)))))
#print axioms covered
end BandBaseline
