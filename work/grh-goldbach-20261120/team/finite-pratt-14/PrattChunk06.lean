import PrattChunk05
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p28181 : Nat.Prime 28181 := by
  apply lucasNat 28181 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28181-1 = 2 * (2 * (5 * (1409))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p1409] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p28627 : Nat.Prime 28627 := by
  apply lucasNat 28627 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 28627-1 = 2 * (3 * (13 * (367))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p367] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p32117 : Nat.Prime 32117 := by
  apply lucasNat 32117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32117-1 = 2 * (2 * (7 * (31 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p32237 : Nat.Prime 32237 := by
  apply lucasNat 32237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 32237-1 = 2 * (2 * (8059)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p8059] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p36997 : Nat.Prime 36997 := by
  apply lucasNat 36997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 36997-1 = 2 * (2 * (3 * (3083))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p3083] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p39209 : Nat.Prime 39209 := by
  apply lucasNat 39209 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 39209-1 = 2 * (2 * (2 * (13 * (13 * (29))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p40883 : Nat.Prime 40883 := by
  apply lucasNat 40883 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 40883-1 = 2 * (20441) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p20441] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p42499 : Nat.Prime 42499 := by
  apply lucasNat 42499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 42499-1 = 2 * (3 * (3 * (3 * (787)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p787] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p43777 : Nat.Prime 43777 := by
  apply lucasNat 43777 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43777-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (19)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem p43991 : Nat.Prime 43991 := by
  apply lucasNat 43991 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 43991-1 = 2 * (5 * (53 * (83))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p44501 : Nat.Prime 44501 := by
  apply lucasNat 44501 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 44501-1 = 2 * (2 * (5 * (5 * (5 * (89))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p89] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p50123 : Nat.Prime 50123 := by
  apply lucasNat 50123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 50123-1 = 2 * (19 * (1319)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p1319] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p51043 : Nat.Prime 51043 := by
  apply lucasNat 51043 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 51043-1 = 2 * (3 * (47 * (181))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p47, Nat.prime_dvd_prime_iff_eq hq p181] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p52579 : Nat.Prime 52579 := by
  apply lucasNat 52579 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 52579-1 = 2 * (3 * (3 * (23 * (127)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p56713 : Nat.Prime 56713 := by
  apply lucasNat 56713 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 56713-1 = 2 * (2 * (2 * (3 * (17 * (139))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p139] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p61651 : Nat.Prime 61651 := by
  apply lucasNat 61651 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61651-1 = 2 * (3 * (3 * (5 * (5 * (137))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p137] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p61681 : Nat.Prime 61681 := by
  apply lucasNat 61681 29 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 61681-1 = 2 * (2 * (2 * (2 * (3 * (5 * (257)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p257] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p64921 : Nat.Prime 64921 := by
  apply lucasNat 64921 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 64921-1 = 2 * (2 * (2 * (3 * (5 * (541))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p541] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p65617 : Nat.Prime 65617 := by
  apply lucasNat 65617 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 65617-1 = 2 * (2 * (2 * (2 * (3 * (1367))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1367] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p80191 : Nat.Prime 80191 := by
  apply lucasNat 80191 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 80191-1 = 2 * (3 * (3 * (3 * (3 * (3 * (3 * (5 * (11)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p82469 : Nat.Prime 82469 := by
  apply lucasNat 82469 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 82469-1 = 2 * (2 * (53 * (389))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p389] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p82811 : Nat.Prime 82811 := by
  apply lucasNat 82811 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 82811-1 = 2 * (5 * (7 * (7 * (13 * (13))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p84751 : Nat.Prime 84751 := by
  apply lucasNat 84751 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 84751-1 = 2 * (3 * (5 * (5 * (5 * (113))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p113] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p85091 : Nat.Prime 85091 := by
  apply lucasNat 85091 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 85091-1 = 2 * (5 * (67 * (127))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p67, Nat.prime_dvd_prime_iff_eq hq p127] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p92251 : Nat.Prime 92251 := by
  apply lucasNat 92251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 92251-1 = 2 * (3 * (3 * (5 * (5 * (5 * (41)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p106349 : Nat.Prime 106349 := by
  apply lucasNat 106349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 106349-1 = 2 * (2 * (11 * (2417))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p2417] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p108863 : Nat.Prime 108863 := by
  apply lucasNat 108863 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 108863-1 = 2 * (13 * (53 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p131797 : Nat.Prime 131797 := by
  apply lucasNat 131797 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 131797-1 = 2 * (2 * (3 * (3 * (7 * (523))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p523] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p148361 : Nat.Prime 148361 := by
  apply lucasNat 148361 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 148361-1 = 2 * (2 * (2 * (5 * (3709)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p164513 : Nat.Prime 164513 := by
  apply lucasNat 164513 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 164513-1 = 2 * (2 * (2 * (2 * (2 * (53 * (97)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p194113 : Nat.Prime 194113 := by
  apply lucasNat 194113 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 194113-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (337)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p337] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p204173 : Nat.Prime 204173 := by
  apply lucasNat 204173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 204173-1 = 2 * (2 * (51043)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p51043] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p218381 : Nat.Prime 218381 := by
  apply lucasNat 218381 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 218381-1 = 2 * (2 * (5 * (61 * (179)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p61, Nat.prime_dvd_prime_iff_eq hq p179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p219959 : Nat.Prime 219959 := by
  apply lucasNat 219959 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 219959-1 = 2 * (71 * (1549)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p1549] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
end Pratt14
