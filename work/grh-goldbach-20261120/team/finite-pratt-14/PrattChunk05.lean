import PrattChunk04
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p7529 : Nat.Prime 7529 := by
  apply lucasNat 7529 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7529-1 = 2 * (2 * (2 * (941))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p941] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p7817 : Nat.Prime 7817 := by
  apply lucasNat 7817 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7817-1 = 2 * (2 * (2 * (977))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p977] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p8059 : Nat.Prime 8059 := by
  apply lucasNat 8059 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8059-1 = 2 * (3 * (17 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p8111 : Nat.Prime 8111 := by
  apply lucasNat 8111 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8111-1 = 2 * (5 * (811)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p811] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p8311 : Nat.Prime 8311 := by
  apply lucasNat 8311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8311-1 = 2 * (3 * (5 * (277))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p277] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p8389 : Nat.Prime 8389 := by
  apply lucasNat 8389 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8389-1 = 2 * (2 * (3 * (3 * (233)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p8423 : Nat.Prime 8423 := by
  apply lucasNat 8423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8423-1 = 2 * (4211) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p4211] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p8527 : Nat.Prime 8527 := by
  apply lucasNat 8527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8527-1 = 2 * (3 * (7 * (7 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p8719 : Nat.Prime 8719 := by
  apply lucasNat 8719 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8719-1 = 2 * (3 * (1453)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1453] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p8893 : Nat.Prime 8893 := by
  apply lucasNat 8893 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8893-1 = 2 * (2 * (3 * (3 * (13 * (19))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p8933 : Nat.Prime 8933 := by
  apply lucasNat 8933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8933-1 = 2 * (2 * (7 * (11 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p9293 : Nat.Prime 9293 := by
  apply lucasNat 9293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9293-1 = 2 * (2 * (23 * (101))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p101] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9497 : Nat.Prime 9497 := by
  apply lucasNat 9497 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9497-1 = 2 * (2 * (2 * (1187))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1187] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9601 : Nat.Prime 9601 := by
  apply lucasNat 9601 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9601-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (5))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p10273 : Nat.Prime 10273 := by
  apply lucasNat 10273 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10273-1 = 2 * (2 * (2 * (2 * (2 * (3 * (107)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p10709 : Nat.Prime 10709 := by
  apply lucasNat 10709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10709-1 = 2 * (2 * (2677)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p2677] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p10957 : Nat.Prime 10957 := by
  apply lucasNat 10957 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10957-1 = 2 * (2 * (3 * (11 * (83)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p11443 : Nat.Prime 11443 := by
  apply lucasNat 11443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11443-1 = 2 * (3 * (1907)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1907] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p12073 : Nat.Prime 12073 := by
  apply lucasNat 12073 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12073-1 = 2 * (2 * (2 * (3 * (503)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p503] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p12263 : Nat.Prime 12263 := by
  apply lucasNat 12263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12263-1 = 2 * (6131) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p6131] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p12289 : Nat.Prime 12289 := by
  apply lucasNat 12289 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12289-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3)))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  all_goals subst q; decide +kernel
theorem p12791 : Nat.Prime 12791 := by
  apply lucasNat 12791 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12791-1 = 2 * (5 * (1279)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p1279] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p13103 : Nat.Prime 13103 := by
  apply lucasNat 13103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13103-1 = 2 * (6551) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p6551] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p13291 : Nat.Prime 13291 := by
  apply lucasNat 13291 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13291-1 = 2 * (3 * (5 * (443))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p443] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p14753 : Nat.Prime 14753 := by
  apply lucasNat 14753 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14753-1 = 2 * (2 * (2 * (2 * (2 * (461))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p15319 : Nat.Prime 15319 := by
  apply lucasNat 15319 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15319-1 = 2 * (3 * (3 * (23 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p16567 : Nat.Prime 16567 := by
  apply lucasNat 16567 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16567-1 = 2 * (3 * (11 * (251))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p251] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p17569 : Nat.Prime 17569 := by
  apply lucasNat 17569 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17569-1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (61))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p17627 : Nat.Prime 17627 := by
  apply lucasNat 17627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17627-1 = 2 * (7 * (1259)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p1259] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p20441 : Nat.Prime 20441 := by
  apply lucasNat 20441 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20441-1 = 2 * (2 * (2 * (5 * (7 * (73))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p20983 : Nat.Prime 20983 := by
  apply lucasNat 20983 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20983-1 = 2 * (3 * (13 * (269))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p269] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p21107 : Nat.Prime 21107 := by
  apply lucasNat 21107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21107-1 = 2 * (61 * (173)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p61, Nat.prime_dvd_prime_iff_eq hq p173] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p22709 : Nat.Prime 22709 := by
  apply lucasNat 22709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22709-1 = 2 * (2 * (7 * (811))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p811] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p25583 : Nat.Prime 25583 := by
  apply lucasNat 25583 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 25583-1 = 2 * (12791) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p12791] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
end Pratt14
