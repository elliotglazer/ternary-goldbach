import PrattChunk02
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p953 : Nat.Prime 953 := by
  apply lucasNat 953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 953-1 = 2 * (2 * (2 * (7 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p977 : Nat.Prime 977 := by
  apply lucasNat 977 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 977-1 = 2 * (2 * (2 * (2 * (61)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p983 : Nat.Prime 983 := by
  apply lucasNat 983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 983-1 = 2 * (491) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p491] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1019 : Nat.Prime 1019 := by
  apply lucasNat 1019 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1019-1 = 2 * (509) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p509] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1033 : Nat.Prime 1033 := by
  apply lucasNat 1033 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1033-1 = 2 * (2 * (2 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1049 : Nat.Prime 1049 := by
  apply lucasNat 1049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1049-1 = 2 * (2 * (2 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1061 : Nat.Prime 1061 := by
  apply lucasNat 1061 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1061-1 = 2 * (2 * (5 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1093 : Nat.Prime 1093 := by
  apply lucasNat 1093 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1093-1 = 2 * (2 * (3 * (7 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1103 : Nat.Prime 1103 := by
  apply lucasNat 1103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1103-1 = 2 * (19 * (29)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1109 : Nat.Prime 1109 := by
  apply lucasNat 1109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1109-1 = 2 * (2 * (277)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p277] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1117 : Nat.Prime 1117 := by
  apply lucasNat 1117 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1117-1 = 2 * (2 * (3 * (3 * (31)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1123 : Nat.Prime 1123 := by
  apply lucasNat 1123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1123-1 = 2 * (3 * (11 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1187 : Nat.Prime 1187 := by
  apply lucasNat 1187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1187-1 = 2 * (593) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p593] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1217 : Nat.Prime 1217 := by
  apply lucasNat 1217 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1217-1 = 2 * (2 * (2 * (2 * (2 * (2 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p1259 : Nat.Prime 1259 := by
  apply lucasNat 1259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1259-1 = 2 * (17 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1279 : Nat.Prime 1279 := by
  apply lucasNat 1279 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1279-1 = 2 * (3 * (3 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1289 : Nat.Prime 1289 := by
  apply lucasNat 1289 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1289-1 = 2 * (2 * (2 * (7 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1319 : Nat.Prime 1319 := by
  apply lucasNat 1319 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1319-1 = 2 * (659) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p659] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1321 : Nat.Prime 1321 := by
  apply lucasNat 1321 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1321-1 = 2 * (2 * (2 * (3 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1367 : Nat.Prime 1367 := by
  apply lucasNat 1367 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1367-1 = 2 * (683) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p683] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1399 : Nat.Prime 1399 := by
  apply lucasNat 1399 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1399-1 = 2 * (3 * (233)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p233] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1409 : Nat.Prime 1409 := by
  apply lucasNat 1409 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1409-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (11))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1453 : Nat.Prime 1453 := by
  apply lucasNat 1453 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1453-1 = 2 * (2 * (3 * (11 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1487 : Nat.Prime 1487 := by
  apply lucasNat 1487 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1487-1 = 2 * (743) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p743] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1493 : Nat.Prime 1493 := by
  apply lucasNat 1493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1493-1 = 2 * (2 * (373)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p373] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1531 : Nat.Prime 1531 := by
  apply lucasNat 1531 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1531-1 = 2 * (3 * (3 * (5 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1543 : Nat.Prime 1543 := by
  apply lucasNat 1543 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1543-1 = 2 * (3 * (257)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p257] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1549 : Nat.Prime 1549 := by
  apply lucasNat 1549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1549-1 = 2 * (2 * (3 * (3 * (43)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1579 : Nat.Prime 1579 := by
  apply lucasNat 1579 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1579-1 = 2 * (3 * (263)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p263] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1907 : Nat.Prime 1907 := by
  apply lucasNat 1907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1907-1 = 2 * (953) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p953] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1987 : Nat.Prime 1987 := by
  apply lucasNat 1987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1987-1 = 2 * (3 * (331)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p331] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1999 : Nat.Prime 1999 := by
  apply lucasNat 1999 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999-1 = 2 * (3 * (3 * (3 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p2039 : Nat.Prime 2039 := by
  apply lucasNat 2039 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2039-1 = 2 * (1019) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1019] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p2131 : Nat.Prime 2131 := by
  apply lucasNat 2131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2131-1 = 2 * (3 * (5 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
end Pratt14
