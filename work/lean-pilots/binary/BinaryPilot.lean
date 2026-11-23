import PilotPrimes
namespace BinaryPilot

def sourcePrimes_0 : List Nat := [8589921467, 8589921491, 8589921493, 8589921497, 8589921503, 8589921541, 8589921553, 8589921559, 8589921563, 8589921577, 8589921589, 8589921643, 8589921647]
theorem sourcePrimes_0_prime : ∀ p ∈ sourcePrimes_0, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_0, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  · subst p; exact prime_8589921467
  · subst p; exact prime_8589921491
  · subst p; exact prime_8589921493
  · subst p; exact prime_8589921497
  · subst p; exact prime_8589921503
  · subst p; exact prime_8589921541
  · subst p; exact prime_8589921553
  · subst p; exact prime_8589921559
  · subst p; exact prime_8589921563
  · subst p; exact prime_8589921577
  · subst p; exact prime_8589921589
  · subst p; exact prime_8589921643
  · subst p; exact prime_8589921647

theorem source_0_membership : ∀ j : Fin 128,
    Nat.testBit 830767498623048963777032631942643712 j.val = true → 8589921409 + 2*j.val ∈ sourcePrimes_0 := by
  decide +kernel

theorem source_0_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 830767498623048963777032631942643712 j = true → Nat.Prime (8589921409+2*j) := by
  intro j hj hb
  exact sourcePrimes_0_prime _ (source_0_membership ⟨j,hj⟩ hb)

def slice_0_0 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589921409
  sourceMask := 830767498623048963777032631942643712
  shift := 27
  anchor := 3999999988766602061
  shift_bound := by decide
  source_prime := source_0_sound
  anchor_prime := prime_3999999988766602061
  connection := by decide

def slice_1_0 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589921409
  sourceMask := 830767498623048963777032631942643712
  shift := 59
  anchor := 3999999988766602061
  shift_bound := by decide
  source_prime := source_0_sound
  anchor_prime := prime_3999999988766602061
  connection := by decide

def sourcePrimes_1 : List Nat := [8589929857, 8589929863, 8589929869, 8589929893, 8589929939, 8589929941, 8589929951, 8589929969, 8589929977, 8589929981, 8589930031, 8589930061, 8589930067, 8589930071, 8589930073]
theorem sourcePrimes_1_prime : ∀ p ∈ sourcePrimes_1, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_1, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14
  · subst p; exact prime_8589929857
  · subst p; exact prime_8589929863
  · subst p; exact prime_8589929869
  · subst p; exact prime_8589929893
  · subst p; exact prime_8589929939
  · subst p; exact prime_8589929941
  · subst p; exact prime_8589929951
  · subst p; exact prime_8589929969
  · subst p; exact prime_8589929977
  · subst p; exact prime_8589929981
  · subst p; exact prime_8589930031
  · subst p; exact prime_8589930061
  · subst p; exact prime_8589930067
  · subst p; exact prime_8589930071
  · subst p; exact prime_8589930073

theorem source_1_membership : ∀ j : Fin 128,
    Nat.testBit 532413406838367096113601339195465 j.val = true → 8589929857 + 2*j.val ∈ sourcePrimes_1 := by
  decide +kernel

theorem source_1_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 532413406838367096113601339195465 j = true → Nat.Prime (8589929857+2*j) := by
  intro j hj hb
  exact sourcePrimes_1_prime _ (source_1_membership ⟨j,hj⟩ hb)

def slice_0_1 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589929857
  sourceMask := 532413406838367096113601339195465
  shift := 0
  anchor := 3999999988766593667
  shift_bound := by decide
  source_prime := source_1_sound
  anchor_prime := prime_3999999988766593667
  connection := by decide

def slice_1_1 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589929857
  sourceMask := 532413406838367096113601339195465
  shift := 32
  anchor := 3999999988766593667
  shift_bound := by decide
  source_prime := source_1_sound
  anchor_prime := prime_3999999988766593667
  connection := by decide

def sourcePrimes_2 : List Nat := [8589924481, 8589924559, 8589924569, 8589924587, 8589924589, 8589924593, 8589924599, 8589924631, 8589924653, 8589924661, 8589924709]
theorem sourcePrimes_2_prime : ∀ p ∈ sourcePrimes_2, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_2, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  · subst p; exact prime_8589924481
  · subst p; exact prime_8589924559
  · subst p; exact prime_8589924569
  · subst p; exact prime_8589924587
  · subst p; exact prime_8589924589
  · subst p; exact prime_8589924593
  · subst p; exact prime_8589924599
  · subst p; exact prime_8589924631
  · subst p; exact prime_8589924653
  · subst p; exact prime_8589924661
  · subst p; exact prime_8589924709

theorem source_2_membership : ∀ j : Fin 128,
    Nat.testBit 20769188749488381862259570606342145 j.val = true → 8589924481 + 2*j.val ∈ sourcePrimes_2 := by
  decide +kernel

theorem source_2_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 20769188749488381862259570606342145 j = true → Nat.Prime (8589924481+2*j) := by
  intro j hj hb
  exact sourcePrimes_2_prime _ (source_2_membership ⟨j,hj⟩ hb)

def slice_0_2 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589924481
  sourceMask := 20769188749488381862259570606342145
  shift := 32
  anchor := 3999999988766598979
  shift_bound := by decide
  source_prime := source_2_sound
  anchor_prime := prime_3999999988766598979
  connection := by decide

def slice_1_2 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589924481
  sourceMask := 20769188749488381862259570606342145
  shift := 64
  anchor := 3999999988766598979
  shift_bound := by decide
  source_prime := source_2_sound
  anchor_prime := prime_3999999988766598979
  connection := by decide

def sourcePrimes_3 : List Nat := [8589920551, 8589920579, 8589920593, 8589920609, 8589920617, 8589920621, 8589920623, 8589920639, 8589920641, 8589920683, 8589920693, 8589920761]
theorem sourcePrimes_3_prime : ∀ p ∈ sourcePrimes_3, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_3, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  · subst p; exact prime_8589920551
  · subst p; exact prime_8589920579
  · subst p; exact prime_8589920593
  · subst p; exact prime_8589920609
  · subst p; exact prime_8589920617
  · subst p; exact prime_8589920621
  · subst p; exact prime_8589920623
  · subst p; exact prime_8589920639
  · subst p; exact prime_8589920641
  · subst p; exact prime_8589920683
  · subst p; exact prime_8589920693
  · subst p; exact prime_8589920761

theorem source_3_membership : ∀ j : Fin 128,
    Nat.testBit 21267647933835279659702906861774176256 j.val = true → 8589920513 + 2*j.val ∈ sourcePrimes_3 := by
  decide +kernel

theorem source_3_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 21267647933835279659702906861774176256 j = true → Nat.Prime (8589920513+2*j) := by
  intro j hj hb
  exact sourcePrimes_3_prime _ (source_3_membership ⟨j,hj⟩ hb)

def slice_0_3 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589920513
  sourceMask := 21267647933835279659702906861774176256
  shift := 24
  anchor := 3999999988766602963
  shift_bound := by decide
  source_prime := source_3_sound
  anchor_prime := prime_3999999988766602963
  connection := by decide

def slice_1_3 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589920513
  sourceMask := 21267647933835279659702906861774176256
  shift := 56
  anchor := 3999999988766602963
  shift_bound := by decide
  source_prime := source_3_sound
  anchor_prime := prime_3999999988766602963
  connection := by decide

def sourcePrimes_4 : List Nat := [8589933217, 8589933223, 8589933229, 8589933241, 8589933271, 8589933311, 8589933323, 8589933337, 8589933347, 8589933353, 8589933377, 8589933379, 8589933397, 8589933419]
theorem sourcePrimes_4_prime : ∀ p ∈ sourcePrimes_4, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_4, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13
  · subst p; exact prime_8589933217
  · subst p; exact prime_8589933223
  · subst p; exact prime_8589933229
  · subst p; exact prime_8589933241
  · subst p; exact prime_8589933271
  · subst p; exact prime_8589933311
  · subst p; exact prime_8589933323
  · subst p; exact prime_8589933337
  · subst p; exact prime_8589933347
  · subst p; exact prime_8589933353
  · subst p; exact prime_8589933377
  · subst p; exact prime_8589933379
  · subst p; exact prime_8589933397
  · subst p; exact prime_8589933419

theorem source_4_membership : ∀ j : Fin 128,
    Nat.testBit 166234866817853455723664883566837760 j.val = true → 8589933185 + 2*j.val ∈ sourcePrimes_4 := by
  decide +kernel

theorem source_4_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 166234866817853455723664883566837760 j = true → Nat.Prime (8589933185+2*j) := by
  intro j hj hb
  exact sourcePrimes_4_prime _ (source_4_membership ⟨j,hj⟩ hb)

def slice_0_4 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589933185
  sourceMask := 166234866817853455723664883566837760
  shift := 58
  anchor := 3999999988766590223
  shift_bound := by decide
  source_prime := source_4_sound
  anchor_prime := prime_3999999988766590223
  connection := by decide

def slice_1_4 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589933185
  sourceMask := 166234866817853455723664883566837760
  shift := 90
  anchor := 3999999988766590223
  shift_bound := by decide
  source_prime := source_4_sound
  anchor_prime := prime_3999999988766590223
  connection := by decide

def sourcePrimes_5 : List Nat := [8589934487, 8589934513, 8589934543, 8589934567, 8589934583, 8589934609, 8589934621, 8589934627, 8589934631, 8589934651, 8589934663, 8589934669, 8589934693, 8589934711]
theorem sourcePrimes_5_prime : ∀ p ∈ sourcePrimes_5, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_5, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13
  · subst p; exact prime_8589934487
  · subst p; exact prime_8589934513
  · subst p; exact prime_8589934543
  · subst p; exact prime_8589934567
  · subst p; exact prime_8589934583
  · subst p; exact prime_8589934609
  · subst p; exact prime_8589934621
  · subst p; exact prime_8589934627
  · subst p; exact prime_8589934631
  · subst p; exact prime_8589934651
  · subst p; exact prime_8589934663
  · subst p; exact prime_8589934669
  · subst p; exact prime_8589934693
  · subst p; exact prime_8589934711

theorem source_5_membership : ∀ j : Fin 128,
    Nat.testBit 10654598868057083847656173322492708864 j.val = true → 8589934465 + 2*j.val ∈ sourcePrimes_5 := by
  decide +kernel

theorem source_5_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 10654598868057083847656173322492708864 j = true → Nat.Prime (8589934465+2*j) := by
  intro j hj hb
  exact sourcePrimes_5_prime _ (source_5_membership ⟨j,hj⟩ hb)

def slice_0_5 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589934465
  sourceMask := 10654598868057083847656173322492708864
  shift := 26
  anchor := 3999999988766589007
  shift_bound := by decide
  source_prime := source_5_sound
  anchor_prime := prime_3999999988766589007
  connection := by decide

def slice_1_5 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589934465
  sourceMask := 10654598868057083847656173322492708864
  shift := 58
  anchor := 3999999988766589007
  shift_bound := by decide
  source_prime := source_5_sound
  anchor_prime := prime_3999999988766589007
  connection := by decide

def sourcePrimes_6 : List Nat := [8589922189, 8589922199, 8589922213, 8589922223, 8589922261, 8589922267, 8589922279, 8589922283, 8589922301, 8589922303, 8589922307, 8589922373, 8589922427]
theorem sourcePrimes_6_prime : ∀ p ∈ sourcePrimes_6, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_6, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  · subst p; exact prime_8589922189
  · subst p; exact prime_8589922199
  · subst p; exact prime_8589922213
  · subst p; exact prime_8589922223
  · subst p; exact prime_8589922261
  · subst p; exact prime_8589922267
  · subst p; exact prime_8589922279
  · subst p; exact prime_8589922283
  · subst p; exact prime_8589922301
  · subst p; exact prime_8589922303
  · subst p; exact prime_8589922307
  · subst p; exact prime_8589922373
  · subst p; exact prime_8589922427

theorem source_6_membership : ∀ j : Fin 128,
    Nat.testBit 42535296182029958040719021087343773760 j.val = true → 8589922177 + 2*j.val ∈ sourcePrimes_6 := by
  decide +kernel

theorem source_6_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 42535296182029958040719021087343773760 j = true → Nat.Prime (8589922177+2*j) := by
  intro j hj hb
  exact sourcePrimes_6_prime _ (source_6_membership ⟨j,hj⟩ hb)

def slice_0_6 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589922177
  sourceMask := 42535296182029958040719021087343773760
  shift := 14
  anchor := 3999999988766601319
  shift_bound := by decide
  source_prime := source_6_sound
  anchor_prime := prime_3999999988766601319
  connection := by decide

def slice_1_6 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589922177
  sourceMask := 42535296182029958040719021087343773760
  shift := 46
  anchor := 3999999988766601319
  shift_bound := by decide
  source_prime := source_6_sound
  anchor_prime := prime_3999999988766601319
  connection := by decide

def sourcePrimes_7 : List Nat := [8589919237, 8589919241, 8589919253, 8589919279, 8589919321, 8589919337, 8589919339, 8589919357, 8589919369, 8589919391, 8589919397, 8589919423, 8589919433, 8589919453, 8589919463]
theorem sourcePrimes_7_prime : ∀ p ∈ sourcePrimes_7, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_7, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14
  · subst p; exact prime_8589919237
  · subst p; exact prime_8589919241
  · subst p; exact prime_8589919253
  · subst p; exact prime_8589919279
  · subst p; exact prime_8589919321
  · subst p; exact prime_8589919337
  · subst p; exact prime_8589919339
  · subst p; exact prime_8589919357
  · subst p; exact prime_8589919369
  · subst p; exact prime_8589919391
  · subst p; exact prime_8589919397
  · subst p; exact prime_8589919423
  · subst p; exact prime_8589919433
  · subst p; exact prime_8589919453
  · subst p; exact prime_8589919463

theorem source_7_membership : ∀ j : Fin 128,
    Nat.testBit 42837756353034279258332308334183444 j.val = true → 8589919233 + 2*j.val ∈ sourcePrimes_7 := by
  decide +kernel

theorem source_7_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 42837756353034279258332308334183444 j = true → Nat.Prime (8589919233+2*j) := by
  intro j hj hb
  exact sourcePrimes_7_prime _ (source_7_membership ⟨j,hj⟩ hb)

def slice_0_7 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589919233
  sourceMask := 42837756353034279258332308334183444
  shift := 47
  anchor := 3999999988766604197
  shift_bound := by decide
  source_prime := source_7_sound
  anchor_prime := prime_3999999988766604197
  connection := by decide

def slice_1_7 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589919233
  sourceMask := 42837756353034279258332308334183444
  shift := 79
  anchor := 3999999988766604197
  shift_bound := by decide
  source_prime := source_7_sound
  anchor_prime := prime_3999999988766604197
  connection := by decide

def sourcePrimes_8 : List Nat := [8589918251, 8589918257, 8589918269, 8589918277, 8589918283, 8589918329, 8589918331, 8589918341, 8589918367, 8589918413, 8589918437, 8589918451]
theorem sourcePrimes_8_prime : ∀ p ∈ sourcePrimes_8, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_8, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  · subst p; exact prime_8589918251
  · subst p; exact prime_8589918257
  · subst p; exact prime_8589918269
  · subst p; exact prime_8589918277
  · subst p; exact prime_8589918283
  · subst p; exact prime_8589918329
  · subst p; exact prime_8589918331
  · subst p; exact prime_8589918341
  · subst p; exact prime_8589918367
  · subst p; exact prime_8589918413
  · subst p; exact prime_8589918437
  · subst p; exact prime_8589918451

theorem source_8_membership : ∀ j : Fin 128,
    Nat.testBit 2679230249606976509394890371647930368 j.val = true → 8589918209 + 2*j.val ∈ sourcePrimes_8 := by
  decide +kernel

theorem source_8_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 2679230249606976509394890371647930368 j = true → Nat.Prime (8589918209+2*j) := by
  intro j hj hb
  exact sourcePrimes_8_prime _ (source_8_membership ⟨j,hj⟩ hb)

def slice_0_8 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589918209
  sourceMask := 2679230249606976509394890371647930368
  shift := 27
  anchor := 3999999988766605261
  shift_bound := by decide
  source_prime := source_8_sound
  anchor_prime := prime_3999999988766605261
  connection := by decide

def slice_1_8 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589918209
  sourceMask := 2679230249606976509394890371647930368
  shift := 59
  anchor := 3999999988766605261
  shift_bound := by decide
  source_prime := source_8_sound
  anchor_prime := prime_3999999988766605261
  connection := by decide

def sourcePrimes_9 : List Nat := [8589919109, 8589919159, 8589919187, 8589919189, 8589919199, 8589919237, 8589919241, 8589919253, 8589919279, 8589919321, 8589919337, 8589919339, 8589919357]
theorem sourcePrimes_9_prime : ∀ p ∈ sourcePrimes_9, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_9, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  · subst p; exact prime_8589919109
  · subst p; exact prime_8589919159
  · subst p; exact prime_8589919187
  · subst p; exact prime_8589919189
  · subst p; exact prime_8589919199
  · subst p; exact prime_8589919237
  · subst p; exact prime_8589919241
  · subst p; exact prime_8589919253
  · subst p; exact prime_8589919279
  · subst p; exact prime_8589919321
  · subst p; exact prime_8589919337
  · subst p; exact prime_8589919339
  · subst p; exact prime_8589919357

theorem source_9_membership : ∀ j : Fin 128,
    Nat.testBit 85320146498152707782051531659591811076 j.val = true → 8589919105 + 2*j.val ∈ sourcePrimes_9 := by
  decide +kernel

theorem source_9_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 85320146498152707782051531659591811076 j = true → Nat.Prime (8589919105+2*j) := by
  intro j hj hb
  exact sourcePrimes_9_prime _ (source_9_membership ⟨j,hj⟩ hb)

def slice_0_9 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589919105
  sourceMask := 85320146498152707782051531659591811076
  shift := 30
  anchor := 3999999988766604359
  shift_bound := by decide
  source_prime := source_9_sound
  anchor_prime := prime_3999999988766604359
  connection := by decide

def slice_1_9 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589919105
  sourceMask := 85320146498152707782051531659591811076
  shift := 62
  anchor := 3999999988766604359
  shift_bound := by decide
  source_prime := source_9_sound
  anchor_prime := prime_3999999988766604359
  connection := by decide

def sourcePrimes_10 : List Nat := [8589923093, 8589923099, 8589923107, 8589923119, 8589923129, 8589923171, 8589923191, 8589923197, 8589923227, 8589923231, 8589923261, 8589923323]
theorem sourcePrimes_10_prime : ∀ p ∈ sourcePrimes_10, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_10, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  · subst p; exact prime_8589923093
  · subst p; exact prime_8589923099
  · subst p; exact prime_8589923107
  · subst p; exact prime_8589923119
  · subst p; exact prime_8589923129
  · subst p; exact prime_8589923171
  · subst p; exact prime_8589923191
  · subst p; exact prime_8589923197
  · subst p; exact prime_8589923227
  · subst p; exact prime_8589923231
  · subst p; exact prime_8589923261
  · subst p; exact prime_8589923323

theorem source_10_membership : ∀ j : Fin 128,
    Nat.testBit 42535295884925104145313879191552402432 j.val = true → 8589923073 + 2*j.val ∈ sourcePrimes_10 := by
  decide +kernel

theorem source_10_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 42535295884925104145313879191552402432 j = true → Nat.Prime (8589923073+2*j) := by
  intro j hj hb
  exact sourcePrimes_10_prime _ (source_10_membership ⟨j,hj⟩ hb)

def slice_0_10 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589923073
  sourceMask := 42535295884925104145313879191552402432
  shift := 20
  anchor := 3999999988766600411
  shift_bound := by decide
  source_prime := source_10_sound
  anchor_prime := prime_3999999988766600411
  connection := by decide

def slice_1_10 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589923073
  sourceMask := 42535295884925104145313879191552402432
  shift := 52
  anchor := 3999999988766600411
  shift_bound := by decide
  source_prime := source_10_sound
  anchor_prime := prime_3999999988766600411
  connection := by decide

def sourcePrimes_11 : List Nat := [8589926791, 8589926801, 8589926819, 8589926827, 8589926857, 8589926861, 8589926869, 8589926893, 8589926903, 8589926911, 8589926953, 8589926981, 8589927007, 8589927019, 8589927023, 8589927029]
theorem sourcePrimes_11_prime : ∀ p ∈ sourcePrimes_11, Nat.Prime p := by
  intro p hp
  simp only [sourcePrimes_11, List.mem_cons, List.not_mem_nil, or_false] at hp
  rcases hp with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15
  · subst p; exact prime_8589926791
  · subst p; exact prime_8589926801
  · subst p; exact prime_8589926819
  · subst p; exact prime_8589926827
  · subst p; exact prime_8589926857
  · subst p; exact prime_8589926861
  · subst p; exact prime_8589926869
  · subst p; exact prime_8589926893
  · subst p; exact prime_8589926903
  · subst p; exact prime_8589926911
  · subst p; exact prime_8589926953
  · subst p; exact prime_8589926981
  · subst p; exact prime_8589927007
  · subst p; exact prime_8589927019
  · subst p; exact prime_8589927023
  · subst p; exact prime_8589927029

theorem source_11_membership : ∀ j : Fin 128,
    Nat.testBit 6150275945866496205983409272246108424 j.val = true → 8589926785 + 2*j.val ∈ sourcePrimes_11 := by
  decide +kernel

theorem source_11_sound : ∀ j : Nat, j < 128 →
    Nat.testBit 6150275945866496205983409272246108424 j = true → Nat.Prime (8589926785+2*j) := by
  intro j hj hb
  exact sourcePrimes_11_prime _ (source_11_membership ⟨j,hj⟩ hb)

def slice_0_11 : SliceCertificate 3999999997356523524 32 where
  sourceBase := 8589926785
  sourceMask := 6150275945866496205983409272246108424
  shift := 35
  anchor := 3999999988766596669
  shift_bound := by decide
  source_prime := source_11_sound
  anchor_prime := prime_3999999988766596669
  connection := by decide

def slice_1_11 : SliceCertificate 3999999997356523588 32 where
  sourceBase := 8589926785
  sourceMask := 6150275945866496205983409272246108424
  shift := 67
  anchor := 3999999988766596669
  shift_bound := by decide
  source_prime := source_11_sound
  anchor_prime := prime_3999999988766596669
  connection := by decide

def slices_0 : List (SliceCertificate 3999999997356523524 32) :=
  [slice_0_0, slice_0_1, slice_0_2, slice_0_3, slice_0_4, slice_0_5, slice_0_6, slice_0_7, slice_0_8, slice_0_9, slice_0_10, slice_0_11]
theorem tile_0_coverage : unionMasks (slices_0.map sliceMask) = 2^32-1 := rfl

theorem tile_0 : ∀ t : Nat, t < 32 →
    ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ 3999999997356523524+2*t=p+q :=
  certified_tile slices_0 tile_0_coverage

def slices_1 : List (SliceCertificate 3999999997356523588 32) :=
  [slice_1_0, slice_1_1, slice_1_2, slice_1_3, slice_1_4, slice_1_5, slice_1_6, slice_1_7, slice_1_8, slice_1_9, slice_1_10, slice_1_11]
theorem tile_1_coverage : unionMasks (slices_1.map sliceMask) = 2^32-1 := rfl

theorem tile_1 : ∀ t : Nat, t < 32 →
    ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ 3999999997356523588+2*t=p+q :=
  certified_tile slices_1 tile_1_coverage

theorem binary_interval : ∀ n : Nat, 3999999997356523524 ≤ n → n ≤ 3999999997356523650 →
    Even n → ∃ p q : Nat, Nat.Prime p ∧ Nat.Prime q ∧ n = p+q := by
  intro n hlo hhi heven
  obtain ⟨k, hk⟩ := heven
  by_cases hmid : n < 3999999997356523588
  · have ht : (n-3999999997356523524)/2 < 32 := by omega
    have hn : n = 3999999997356523524+2*((n-3999999997356523524)/2) := by omega
    rw [hn]; exact tile_0 _ ht
  · have ht : (n-3999999997356523588)/2 < 32 := by omega
    have hn : n = 3999999997356523588+2*((n-3999999997356523588)/2) := by omega
    rw [hn]; exact tile_1 _ ht

end BinaryPilot
