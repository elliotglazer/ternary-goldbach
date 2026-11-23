import PrattChunk09
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p3333333298177 : Nat.Prime 3333333298177 := by
  apply lucasNat 3333333298177 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3333333298177-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (7 * (51669973))))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p51669973] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13
  all_goals subst q; decide +kernel
theorem p4545454497469 : Nat.Prime 4545454497469 := by
  apply lucasNat 4545454497469 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4545454497469-1 = 2 * (2 * (3 * (59 * (97 * (167 * (251 * (1579))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p59, Nat.prime_dvd_prime_iff_eq hq p97, Nat.prime_dvd_prime_iff_eq hq p167, Nat.prime_dvd_prime_iff_eq hq p251, Nat.prime_dvd_prime_iff_eq hq p1579] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p8333333245331 : Nat.Prime 8333333245331 := by
  apply lucasNat 8333333245331 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8333333245331-1 = 2 * (5 * (3917 * (212747849))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3917, Nat.prime_dvd_prime_iff_eq hq p212747849] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p9999999895003 : Nat.Prime 9999999895003 := by
  apply lucasNat 9999999895003 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9999999895003-1 = 2 * (3 * (13 * (661 * (4409 * (43991))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p661, Nat.prime_dvd_prime_iff_eq hq p4409, Nat.prime_dvd_prime_iff_eq hq p43991] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p16666666490543 : Nat.Prime 16666666490543 := by
  apply lucasNat 16666666490543 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16666666490543-1 = 2 * (7217713 * (1154567)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7217713, Nat.prime_dvd_prime_iff_eq hq p1154567] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p49999999475423 : Nat.Prime 49999999475423 := by
  apply lucasNat 49999999475423 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 49999999475423-1 = 2 * (83 * (149 * (1399 * (1444967)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p149, Nat.prime_dvd_prime_iff_eq hq p1399, Nat.prime_dvd_prime_iff_eq hq p1444967] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943259 : Nat.Prime 99999998943259 := by
  apply lucasNat 99999998943259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943259-1 = 2 * (3 * (16666666490543)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p16666666490543] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998943263 : Nat.Prime 99999998943263 := by
  apply lucasNat 99999998943263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943263-1 = 2 * (11 * (227 * (52579 * (380837)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p227, Nat.prime_dvd_prime_iff_eq hq p52579, Nat.prime_dvd_prime_iff_eq hq p380837] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943319 : Nat.Prime 99999998943319 := by
  apply lucasNat 99999998943319 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943319-1 = 2 * (3 * (3 * (19 * (292397657729)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p292397657729] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943331 : Nat.Prime 99999998943331 := by
  apply lucasNat 99999998943331 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943331-1 = 2 * (3 * (5 * (6263 * (6427 * (82811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p6263, Nat.prime_dvd_prime_iff_eq hq p6427, Nat.prime_dvd_prime_iff_eq hq p82811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998943407 : Nat.Prime 99999998943407 := by
  apply lucasNat 99999998943407 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943407-1 = 2 * (113 * (13291 * (33291541))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p113, Nat.prime_dvd_prime_iff_eq hq p13291, Nat.prime_dvd_prime_iff_eq hq p33291541] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998943433 : Nat.Prime 99999998943433 := by
  apply lucasNat 99999998943433 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943433-1 = 2 * (2 * (2 * (3 * (7 * (7 * (7 * (19 * (151 * (241 * (17569)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p151, Nat.prime_dvd_prime_iff_eq hq p241, Nat.prime_dvd_prime_iff_eq hq p17569] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem p99999998943469 : Nat.Prime 99999998943469 := by
  apply lucasNat 99999998943469 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943469-1 = 2 * (2 * (3 * (13 * (127 * (569 * (677 * (13103))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p569, Nat.prime_dvd_prime_iff_eq hq p677, Nat.prime_dvd_prime_iff_eq hq p13103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998943479 : Nat.Prime 99999998943479 := by
  apply lucasNat 99999998943479 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943479-1 = 2 * (1277113 * (39150803)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1277113, Nat.prime_dvd_prime_iff_eq hq p39150803] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998943487 : Nat.Prime 99999998943487 := by
  apply lucasNat 99999998943487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943487-1 = 2 * (3 * (1313311 * (12690571))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1313311, Nat.prime_dvd_prime_iff_eq hq p12690571] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998943503 : Nat.Prime 99999998943503 := by
  apply lucasNat 99999998943503 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943503-1 = 2 * (7 * (29 * (173 * (211 * (1543 * (4373)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p173, Nat.prime_dvd_prime_iff_eq hq p211, Nat.prime_dvd_prime_iff_eq hq p1543, Nat.prime_dvd_prime_iff_eq hq p4373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943511 : Nat.Prime 99999998943511 := by
  apply lucasNat 99999998943511 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943511-1 = 2 * (3 * (5 * (17 * (17 * (157 * (73465129)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p157, Nat.prime_dvd_prime_iff_eq hq p73465129] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943517 : Nat.Prime 99999998943517 := by
  apply lucasNat 99999998943517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943517-1 = 2 * (2 * (3 * (3 * (7 * (41 * (9497 * (1019129))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p41, Nat.prime_dvd_prime_iff_eq hq p9497, Nat.prime_dvd_prime_iff_eq hq p1019129] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998943643 : Nat.Prime 99999998943643 := by
  apply lucasNat 99999998943643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943643-1 = 2 * (3 * (3 * (7 * (101 * (1117 * (7034851)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p101, Nat.prime_dvd_prime_iff_eq hq p1117, Nat.prime_dvd_prime_iff_eq hq p7034851] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943659 : Nat.Prime 99999998943659 := by
  apply lucasNat 99999998943659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943659-1 = 2 * (11 * (61 * (502259 * (148361)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p61, Nat.prime_dvd_prime_iff_eq hq p502259, Nat.prime_dvd_prime_iff_eq hq p148361] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943701 : Nat.Prime 99999998943701 := by
  apply lucasNat 99999998943701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943701-1 = 2 * (2 * (5 * (5 * (53 * (2141 * (8812669)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p2141, Nat.prime_dvd_prime_iff_eq hq p8812669] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943727 : Nat.Prime 99999998943727 := by
  apply lucasNat 99999998943727 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943727-1 = 2 * (3 * (7 * (7 * (983 * (346018363))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p983, Nat.prime_dvd_prime_iff_eq hq p346018363] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998943739 : Nat.Prime 99999998943739 := by
  apply lucasNat 99999998943739 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943739-1 = 2 * (3 * (6367 * (2617663969))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p6367, Nat.prime_dvd_prime_iff_eq hq p2617663969] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998943769 : Nat.Prime 99999998943769 := by
  apply lucasNat 99999998943769 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943769-1 = 2 * (2 * (2 * (3 * (3 * (3 * (7 * (11 * (9293 * (646993))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p9293, Nat.prime_dvd_prime_iff_eq hq p646993] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem p99999998943919 : Nat.Prime 99999998943919 := by
  apply lucasNat 99999998943919 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943919-1 = 2 * (3 * (17 * (79 * (12410027171)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p79, Nat.prime_dvd_prime_iff_eq hq p12410027171] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998943931 : Nat.Prime 99999998943931 := by
  apply lucasNat 99999998943931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943931-1 = 2 * (3 * (3 * (3 * (5 * (269 * (20983 * (65617))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p269, Nat.prime_dvd_prime_iff_eq hq p20983, Nat.prime_dvd_prime_iff_eq hq p65617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998943961 : Nat.Prime 99999998943961 := by
  apply lucasNat 99999998943961 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943961-1 = 2 * (2 * (2 * (3 * (5 * (3917 * (212747849)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3917, Nat.prime_dvd_prime_iff_eq hq p212747849] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p99999998943973 : Nat.Prime 99999998943973 := by
  apply lucasNat 99999998943973 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998943973-1 = 2 * (2 * (3 * (8333333245331))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p8333333245331] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998944093 : Nat.Prime 99999998944093 := by
  apply lucasNat 99999998944093 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944093-1 = 2 * (2 * (3 * (3 * (3 * (13 * (199 * (357914927))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p199, Nat.prime_dvd_prime_iff_eq hq p357914927] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998944133 : Nat.Prime 99999998944133 := by
  apply lucasNat 99999998944133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944133-1 = 2 * (2 * (7 * (293 * (3499 * (3483617))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p293, Nat.prime_dvd_prime_iff_eq hq p3499, Nat.prime_dvd_prime_iff_eq hq p3483617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998944231 : Nat.Prime 99999998944231 := by
  apply lucasNat 99999998944231 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944231-1 = 2 * (3 * (5 * (7 * (11 * (19 * (53 * (127 * (338497)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p53, Nat.prime_dvd_prime_iff_eq hq p127, Nat.prime_dvd_prime_iff_eq hq p338497] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998944243 : Nat.Prime 99999998944243 := by
  apply lucasNat 99999998944243 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944243-1 = 2 * (3 * (23 * (1217 * (595429477)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p1217, Nat.prime_dvd_prime_iff_eq hq p595429477] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998944247 : Nat.Prime 99999998944247 := by
  apply lucasNat 99999998944247 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944247-1 = 2 * (919 * (54406963517)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p919, Nat.prime_dvd_prime_iff_eq hq p54406963517] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998944259 : Nat.Prime 99999998944259 := by
  apply lucasNat 99999998944259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998944259-1 = 2 * (7 * (17 * (420168062791))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p420168062791] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
end Pratt14
