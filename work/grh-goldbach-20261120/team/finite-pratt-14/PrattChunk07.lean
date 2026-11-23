import PrattChunk06
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p230389 : Nat.Prime 230389 := by
  apply lucasNat 230389 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 230389-1 = 2 * (2 * (3 * (73 * (263)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p73, Nat.prime_dvd_prime_iff_eq hq p263] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p282409 : Nat.Prime 282409 := by
  apply lucasNat 282409 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 282409-1 = 2 * (2 * (2 * (3 * (7 * (41 * (41)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p284521 : Nat.Prime 284521 := by
  apply lucasNat 284521 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 284521-1 = 2 * (2 * (2 * (3 * (5 * (2371))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p2371] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p338497 : Nat.Prime 338497 := by
  apply lucasNat 338497 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 338497-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (41 * (43)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p41, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p354073 : Nat.Prime 354073 := by
  apply lucasNat 354073 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 354073-1 = 2 * (2 * (2 * (3 * (14753)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p14753] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p380837 : Nat.Prime 380837 := by
  apply lucasNat 380837 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 380837-1 = 2 * (2 * (19 * (5011))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p5011] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p423019 : Nat.Prime 423019 := by
  apply lucasNat 423019 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 423019-1 = 2 * (3 * (3 * (71 * (331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p71, Nat.prime_dvd_prime_iff_eq hq p331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p502259 : Nat.Prime 502259 := by
  apply lucasNat 502259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 502259-1 = 2 * (107 * (2347)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p107, Nat.prime_dvd_prime_iff_eq hq p2347] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p524231 : Nat.Prime 524231 := by
  apply lucasNat 524231 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 524231-1 = 2 * (5 * (7 * (7489))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p7489] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p534311 : Nat.Prime 534311 := by
  apply lucasNat 534311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 534311-1 = 2 * (5 * (7 * (17 * (449)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p449] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p548927 : Nat.Prime 548927 := by
  apply lucasNat 548927 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 548927-1 = 2 * (7 * (39209)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p39209] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p602753 : Nat.Prime 602753 := by
  apply lucasNat 602753 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 602753-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (17 * (277)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p277] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p623933 : Nat.Prime 623933 := by
  apply lucasNat 623933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 623933-1 = 2 * (2 * (151 * (1033))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p151, Nat.prime_dvd_prime_iff_eq hq p1033] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p646993 : Nat.Prime 646993 := by
  apply lucasNat 646993 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 646993-1 = 2 * (2 * (2 * (2 * (3 * (3 * (4493)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p4493] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p734389 : Nat.Prime 734389 := by
  apply lucasNat 734389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 734389-1 = 2 * (2 * (3 * (19 * (3221)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p3221] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p778553 : Nat.Prime 778553 := by
  apply lucasNat 778553 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 778553-1 = 2 * (2 * (2 * (307 * (317)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p307, Nat.prime_dvd_prime_iff_eq hq p317] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p801557 : Nat.Prime 801557 := by
  apply lucasNat 801557 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 801557-1 = 2 * (2 * (7 * (28627))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p28627] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p842489 : Nat.Prime 842489 := by
  apply lucasNat 842489 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 842489-1 = 2 * (2 * (2 * (53 * (1987)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p1987] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1019129 : Nat.Prime 1019129 := by
  apply lucasNat 1019129 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1019129-1 = 2 * (2 * (2 * (11 * (37 * (313))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1152121 : Nat.Prime 1152121 := by
  apply lucasNat 1152121 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1152121-1 = 2 * (2 * (2 * (3 * (5 * (9601))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p9601] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1154567 : Nat.Prime 1154567 := by
  apply lucasNat 1154567 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1154567-1 = 2 * (7 * (82469)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p82469] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1247867 : Nat.Prime 1247867 := by
  apply lucasNat 1247867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1247867-1 = 2 * (623933) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p623933] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1277113 : Nat.Prime 1277113 := by
  apply lucasNat 1277113 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1277113-1 = 2 * (2 * (2 * (3 * (127 * (419))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p419] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p1313311 : Nat.Prime 1313311 := by
  apply lucasNat 1313311 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1313311-1 = 2 * (3 * (5 * (43777))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p43777] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1435277 : Nat.Prime 1435277 := by
  apply lucasNat 1435277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1435277-1 = 2 * (2 * (17 * (21107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p21107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p1444967 : Nat.Prime 1444967 := by
  apply lucasNat 1444967 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1444967-1 = 2 * (17 * (42499)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p42499] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p1451767 : Nat.Prime 1451767 := by
  apply lucasNat 1451767 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1451767-1 = 2 * (3 * (17 * (43 * (331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p43, Nat.prime_dvd_prime_iff_eq hq p331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1684979 : Nat.Prime 1684979 := by
  apply lucasNat 1684979 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1684979-1 = 2 * (842489) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p842489] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p1707457 : Nat.Prime 1707457 := by
  apply lucasNat 1707457 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1707457-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (8893))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p8893] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p1716271 : Nat.Prime 1716271 := by
  apply lucasNat 1716271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1716271-1 = 2 * (3 * (5 * (19 * (3011)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p3011] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p1966241 : Nat.Prime 1966241 := by
  apply lucasNat 1966241 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1966241-1 = 2 * (2 * (2 * (2 * (2 * (5 * (12289)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p12289] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p3330659 : Nat.Prime 3330659 := by
  apply lucasNat 3330659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3330659-1 = 2 * (191 * (8719)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p191, Nat.prime_dvd_prime_iff_eq hq p8719] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3390041 : Nat.Prime 3390041 := by
  apply lucasNat 3390041 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3390041-1 = 2 * (2 * (2 * (5 * (84751)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p84751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p3483617 : Nat.Prime 3483617 := by
  apply lucasNat 3483617 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3483617-1 = 2 * (2 * (2 * (2 * (2 * (108863))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p108863] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
end Pratt14
