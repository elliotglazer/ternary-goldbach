import PrattChunk12
import SampleBits
namespace Pratt14Cover
open SmallGoldbach WideGoldbach PrimeCoverage
set_option maxRecDepth 20000
set_option maxHeartbeats 0
private theorem translates_witness (bits : Nat) (ss : List Nat) (j : Nat)
    (h : (translates bits ss).testBit j = true) :
    ∃ s ∈ ss, s ≤ j ∧ bits.testBit (j-s) = true := by
  induction ss with
  | nil => simp [translates] at h
  | cons s rest ih =>
    rw [translates, Nat.testBit_or, Bool.or_eq_true] at h
    rcases h with h | h
    · rw [Nat.testBit_shiftLeft, Bool.and_eq_true, decide_eq_true_eq] at h
      exact ⟨s, List.mem_cons_self, h.1, h.2⟩
    · obtain ⟨u, hu, hj⟩ := ih h
      exact ⟨u, List.mem_cons_of_mem _ hu, hj⟩

/-- The source and anchor numbers are both odd. Column zero denotes their base sum. -/
private theorem tile {bits a skip width : Nat} {ss : List Nat}
    (hs : PrimeBitmap 3 bits) (ha : ∀ s ∈ ss, (a+2*s).Prime)
    (hc : ((translates bits ss >>> skip) &&& (2^width-1)) = 2^width-1) :
    ∀ j < width, BinaryGoldbach (3+a+2*skip+2*j) := by
  intro j hj
  have ht := congrArg (fun v : Nat => v.testBit j) hc
  rw [Nat.testBit_and, Nat.testBit_two_pow_sub_one] at ht
  simp only [hj, decide_true, Bool.and_true, Nat.testBit_shiftRight] at ht
  obtain ⟨s, hmem, hle, hp⟩ := translates_witness _ _ _ ht
  exact ⟨3+2*(skip+j-s), a+2*s, hs _ hp, ha s hmem, by omega⟩


def offsets : List Nat := [14,16,44,50,88,101,119,124,128,136,140,143,206,214,235,248,254,269,344,350,365,371,431,451,500,506,508,514,521,544,565,569,574,598,599,625,638,640,653,656,665,674,686,688,715,716,719,751,781,800,806,815,820,823,829,830,833,856,869,871,883,884,938,941,953,961,1006,1040,3808,2479,3400,1540,1216,1870,2464,1279,1369,1130]
private def P (s : Nat) := Nat.Prime (99999998943231+2*s)
private theorem extend {s : Nat} {ss : List Nat} (hs : P s) (ht : ∀ u ∈ ss, P u) : ∀ u ∈ s::ss, P u := by
  intro u hu
  rcases List.mem_cons.mp hu with rfl | h
  · exact hs
  · exact ht _ h
private theorem anchors : ∀ u ∈ offsets, P u := by
  unfold offsets
  apply extend (s := 14) Pratt14.p99999998943259
  apply extend (s := 16) Pratt14.p99999998943263
  apply extend (s := 44) Pratt14.p99999998943319
  apply extend (s := 50) Pratt14.p99999998943331
  apply extend (s := 88) Pratt14.p99999998943407
  apply extend (s := 101) Pratt14.p99999998943433
  apply extend (s := 119) Pratt14.p99999998943469
  apply extend (s := 124) Pratt14.p99999998943479
  apply extend (s := 128) Pratt14.p99999998943487
  apply extend (s := 136) Pratt14.p99999998943503
  apply extend (s := 140) Pratt14.p99999998943511
  apply extend (s := 143) Pratt14.p99999998943517
  apply extend (s := 206) Pratt14.p99999998943643
  apply extend (s := 214) Pratt14.p99999998943659
  apply extend (s := 235) Pratt14.p99999998943701
  apply extend (s := 248) Pratt14.p99999998943727
  apply extend (s := 254) Pratt14.p99999998943739
  apply extend (s := 269) Pratt14.p99999998943769
  apply extend (s := 344) Pratt14.p99999998943919
  apply extend (s := 350) Pratt14.p99999998943931
  apply extend (s := 365) Pratt14.p99999998943961
  apply extend (s := 371) Pratt14.p99999998943973
  apply extend (s := 431) Pratt14.p99999998944093
  apply extend (s := 451) Pratt14.p99999998944133
  apply extend (s := 500) Pratt14.p99999998944231
  apply extend (s := 506) Pratt14.p99999998944243
  apply extend (s := 508) Pratt14.p99999998944247
  apply extend (s := 514) Pratt14.p99999998944259
  apply extend (s := 521) Pratt14.p99999998944273
  apply extend (s := 544) Pratt14.p99999998944319
  apply extend (s := 565) Pratt14.p99999998944361
  apply extend (s := 569) Pratt14.p99999998944369
  apply extend (s := 574) Pratt14.p99999998944379
  apply extend (s := 598) Pratt14.p99999998944427
  apply extend (s := 599) Pratt14.p99999998944429
  apply extend (s := 625) Pratt14.p99999998944481
  apply extend (s := 638) Pratt14.p99999998944507
  apply extend (s := 640) Pratt14.p99999998944511
  apply extend (s := 653) Pratt14.p99999998944537
  apply extend (s := 656) Pratt14.p99999998944543
  apply extend (s := 665) Pratt14.p99999998944561
  apply extend (s := 674) Pratt14.p99999998944579
  apply extend (s := 686) Pratt14.p99999998944603
  apply extend (s := 688) Pratt14.p99999998944607
  apply extend (s := 715) Pratt14.p99999998944661
  apply extend (s := 716) Pratt14.p99999998944663
  apply extend (s := 719) Pratt14.p99999998944669
  apply extend (s := 751) Pratt14.p99999998944733
  apply extend (s := 781) Pratt14.p99999998944793
  apply extend (s := 800) Pratt14.p99999998944831
  apply extend (s := 806) Pratt14.p99999998944843
  apply extend (s := 815) Pratt14.p99999998944861
  apply extend (s := 820) Pratt14.p99999998944871
  apply extend (s := 823) Pratt14.p99999998944877
  apply extend (s := 829) Pratt14.p99999998944889
  apply extend (s := 830) Pratt14.p99999998944891
  apply extend (s := 833) Pratt14.p99999998944897
  apply extend (s := 856) Pratt14.p99999998944943
  apply extend (s := 869) Pratt14.p99999998944969
  apply extend (s := 871) Pratt14.p99999998944973
  apply extend (s := 883) Pratt14.p99999998944997
  apply extend (s := 884) Pratt14.p99999998944999
  apply extend (s := 938) Pratt14.p99999998945107
  apply extend (s := 941) Pratt14.p99999998945113
  apply extend (s := 953) Pratt14.p99999998945137
  apply extend (s := 961) Pratt14.p99999998945153
  apply extend (s := 1006) Pratt14.p99999998945243
  apply extend (s := 1040) Pratt14.p99999998945311
  apply extend (s := 3808) Pratt14.p99999998950847
  apply extend (s := 2479) Pratt14.p99999998948189
  apply extend (s := 3400) Pratt14.p99999998950031
  apply extend (s := 1540) Pratt14.p99999998946311
  apply extend (s := 1216) Pratt14.p99999998945663
  apply extend (s := 1870) Pratt14.p99999998946971
  apply extend (s := 2464) Pratt14.p99999998948159
  apply extend (s := 1279) Pratt14.p99999998945789
  apply extend (s := 1369) Pratt14.p99999998945969
  apply extend (s := 1130) Pratt14.p99999998945491
  simp
theorem interval : Covered 99999998951426 100000000000002 := by
  have ht := tile (a := 99999998943231) (skip := 4096) (width := 524288) SampleWindow.source anchors (by decide +kernel)
  exact binaryGoldbach_interval 99999998951426 524288 (by decide) ht
#print axioms interval
end Pratt14Cover
