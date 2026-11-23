import BandRows
import BatchWitness
import SampleBits
import BandMillionFactorial
namespace BandGroup4
open SmallGoldbach
set_option maxHeartbeats 0
set_option maxRecDepth 20000
theorem piece0 : Covered 612345678900 612349873204 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part0) BandRows.witness4_0
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece4 : Covered 612349873204 612354067508 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part1) BandRows.witness4_1
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece8 : Covered 612354067508 612358261812 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part2) BandRows.witness4_2
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece12 : Covered 612358261812 612362456116 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part3) BandRows.witness4_3
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece16 : Covered 612362456116 612366650420 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part4) BandRows.witness4_4
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece20 : Covered 612366650420 612370844724 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part5) BandRows.witness4_5
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece24 : Covered 612370844724 612375039028 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part6) BandRows.witness4_6
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece28 : Covered 612375039028 612379233332 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part7) BandRows.witness4_7
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece32 : Covered 612379233332 612383427636 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part8) BandRows.witness4_8
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece36 : Covered 612383427636 612387621940 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part9) BandRows.witness4_9
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece40 : Covered 612387621940 612391816244 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part10) BandRows.witness4_10
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece44 : Covered 612391816244 612396010548 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part11) BandRows.witness4_11
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece48 : Covered 612396010548 612400204852 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part12) BandRows.witness4_12
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece52 : Covered 612400204852 612404399156 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part13) BandRows.witness4_13
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece56 : Covered 612404399156 612408593460 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part14) BandRows.witness4_14
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece60 : Covered 612408593460 612412787764 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part15) BandRows.witness4_15
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece64 : Covered 612412787764 612416982068 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part16) BandRows.witness4_16
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece68 : Covered 612416982068 612421176372 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part17) BandRows.witness4_17
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece72 : Covered 612421176372 612425370676 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part18) BandRows.witness4_18
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece76 : Covered 612425370676 612429564980 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part19) BandRows.witness4_19
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece80 : Covered 612429564980 612433759284 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part20) BandRows.witness4_20
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece84 : Covered 612433759284 612437953588 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part21) BandRows.witness4_21
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece88 : Covered 612437953588 612442147892 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part22) BandRows.witness4_22
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece92 : Covered 612442147892 612446342196 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part23) BandRows.witness4_23
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece96 : Covered 612446342196 612450536500 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part24) BandRows.witness4_24
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece100 : Covered 612450536500 612454730804 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part25) BandRows.witness4_25
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece104 : Covered 612454730804 612458925108 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part26) BandRows.witness4_26
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece108 : Covered 612458925108 612463119412 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part27) BandRows.witness4_27
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece112 : Covered 612463119412 612467313716 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part28) BandRows.witness4_28
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece116 : Covered 612467313716 612471508020 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part29) BandRows.witness4_29
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece120 : Covered 612471508020 612475702324 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part30) BandRows.witness4_30
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece124 : Covered 612475702324 612479896628 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part31) BandRows.witness4_31
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece128 : Covered 612479896628 612484090932 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part32) BandRows.witness4_32
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece132 : Covered 612484090932 612488285236 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part33) BandRows.witness4_33
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece136 : Covered 612488285236 612492479540 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part34) BandRows.witness4_34
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece140 : Covered 612492479540 612496673844 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part35) BandRows.witness4_35
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece144 : Covered 612496673844 612500868148 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part36) BandRows.witness4_36
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece148 : Covered 612500868148 612505062452 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part37) BandRows.witness4_37
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece152 : Covered 612505062452 612509256756 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part38) BandRows.witness4_38
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece156 : Covered 612509256756 612513451060 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part39) BandRows.witness4_39
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece160 : Covered 612513451060 612517645364 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part40) BandRows.witness4_40
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece164 : Covered 612517645364 612521839668 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part41) BandRows.witness4_41
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece168 : Covered 612521839668 612526033972 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part42) BandRows.witness4_42
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece172 : Covered 612526033972 612530228276 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part43) BandRows.witness4_43
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece176 : Covered 612530228276 612534422580 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part44) BandRows.witness4_44
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece180 : Covered 612534422580 612538616884 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part45) BandRows.witness4_45
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece184 : Covered 612538616884 612542811188 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part46) BandRows.witness4_46
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece188 : Covered 612542811188 612547005492 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part47) BandRows.witness4_47
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece192 : Covered 612547005492 612551199796 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part48) BandRows.witness4_48
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece196 : Covered 612551199796 612555394100 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part49) BandRows.witness4_49
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece200 : Covered 612555394100 612559588404 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part50) BandRows.witness4_50
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece204 : Covered 612559588404 612563782708 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part51) BandRows.witness4_51
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece208 : Covered 612563782708 612567977012 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part52) BandRows.witness4_52
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece212 : Covered 612567977012 612572171316 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part53) BandRows.witness4_53
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece216 : Covered 612572171316 612576365620 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part54) BandRows.witness4_54
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece220 : Covered 612576365620 612580559924 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part55) BandRows.witness4_55
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece224 : Covered 612580559924 612584754228 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part56) BandRows.witness4_56
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece228 : Covered 612584754228 612588948532 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part57) BandRows.witness4_57
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece232 : Covered 612588948532 612593142836 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part58) BandRows.witness4_58
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece236 : Covered 612593142836 612597337140 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part59) BandRows.witness4_59
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece240 : Covered 612597337140 612601531444 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part60) BandRows.witness4_60
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece244 : Covered 612601531444 612605725748 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part61) BandRows.witness4_61
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece248 : Covered 612605725748 612609920052 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part62) BandRows.witness4_62
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem piece252 : Covered 612609920052 612614114356 :=
  BatchWitness.interval (halo := 4096) SampleWindow.source BandMillionFactorial.fac_eq (BandRows.part63) BandRows.witness4_63
    (by decide) (by decide) (by decide +kernel) (by decide +kernel) (by decide +kernel)
theorem covered : Covered 612345678900 612614114356 :=
  (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece0 piece4) (SmallGoldbach.join piece8 piece12)) (SmallGoldbach.join (SmallGoldbach.join piece16 piece20) (SmallGoldbach.join piece24 piece28))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece32 piece36) (SmallGoldbach.join piece40 piece44)) (SmallGoldbach.join (SmallGoldbach.join piece48 piece52) (SmallGoldbach.join piece56 piece60)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece64 piece68) (SmallGoldbach.join piece72 piece76)) (SmallGoldbach.join (SmallGoldbach.join piece80 piece84) (SmallGoldbach.join piece88 piece92))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece96 piece100) (SmallGoldbach.join piece104 piece108)) (SmallGoldbach.join (SmallGoldbach.join piece112 piece116) (SmallGoldbach.join piece120 piece124))))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece128 piece132) (SmallGoldbach.join piece136 piece140)) (SmallGoldbach.join (SmallGoldbach.join piece144 piece148) (SmallGoldbach.join piece152 piece156))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece160 piece164) (SmallGoldbach.join piece168 piece172)) (SmallGoldbach.join (SmallGoldbach.join piece176 piece180) (SmallGoldbach.join piece184 piece188)))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece192 piece196) (SmallGoldbach.join piece200 piece204)) (SmallGoldbach.join (SmallGoldbach.join piece208 piece212) (SmallGoldbach.join piece216 piece220))) (SmallGoldbach.join (SmallGoldbach.join (SmallGoldbach.join piece224 piece228) (SmallGoldbach.join piece232 piece236)) (SmallGoldbach.join (SmallGoldbach.join piece240 piece244) (SmallGoldbach.join piece248 piece252))))))
#print axioms covered
end BandGroup4
