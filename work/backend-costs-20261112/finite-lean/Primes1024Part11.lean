import Primes1024Part10
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
theorem prime_1163467128786097 : Nat.Prime 1163467128786097 := by
  apply lucasNat 1163467128786097 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1163467128786097 - 1 = 2 * (2 * (2 * (2 * (3 * (131 * (2339 * (79106353))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_2339, Nat.prime_dvd_prime_iff_eq hq prime_79106353] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_5050505036321471 : Nat.Prime 5050505036321471 := by
  apply lucasNat 5050505036321471 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5050505036321471 - 1 = 2 * (5 * (11 * (86501 * (530787877)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_86501, Nat.prime_dvd_prime_iff_eq hq prime_530787877] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_5847953199951173 : Nat.Prime 5847953199951173 := by
  apply lucasNat 5847953199951173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5847953199951173 - 1 = 2 * (2 * (1499 * (975309072707))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1499, Nat.prime_dvd_prime_iff_eq hq prime_975309072707] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7272727252302913 : Nat.Prime 7272727252302913 := by
  apply lucasNat 7272727252302913 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7272727252302913 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (83 * (13049 * (34973633))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_13049, Nat.prime_dvd_prime_iff_eq hq prime_34973633] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_12903225770214847 : Nat.Prime 12903225770214847 := by
  apply lucasNat 12903225770214847 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12903225770214847 - 1 = 2 * (3 * (3 * (3 * (11 * (67 * (307 * (1056084511))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_307, Nat.prime_dvd_prime_iff_eq hq prime_1056084511] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_24691357955349409 : Nat.Prime 24691357955349409 := by
  apply lucasNat 24691357955349409 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 24691357955349409 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (23 * (113 * (127 * (25037 * (31123)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_113, Nat.prime_dvd_prime_iff_eq hq prime_127, Nat.prime_dvd_prime_iff_eq hq prime_25037, Nat.prime_dvd_prime_iff_eq hq prime_31123] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_38461538353525013 : Nat.Prime 38461538353525013 := by
  apply lucasNat 38461538353525013 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 38461538353525013 - 1 = 2 * (2 * (11 * (1579621 * (553376963)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1579621, Nat.prime_dvd_prime_iff_eq hq prime_553376963] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_46511627776355831 : Nat.Prime 46511627776355831 := by
  apply lucasNat 46511627776355831 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 46511627776355831 - 1 = 2 * (5 * (11 * (37 * (853 * (13397325173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_853, Nat.prime_dvd_prime_iff_eq hq prime_13397325173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_60606060435857653 : Nat.Prime 60606060435857653 := by
  apply lucasNat 60606060435857653 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 60606060435857653 - 1 = 2 * (2 * (3 * (5050505036321471))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5050505036321471] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_166666666198608437 : Nat.Prime 166666666198608437 := by
  apply lucasNat 166666666198608437 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 166666666198608437 - 1 = 2 * (2 * (7 * (2141 * (2780187265607)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2141, Nat.prime_dvd_prime_iff_eq hq prime_2780187265607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_199999999438330103 : Nat.Prime 199999999438330103 := by
  apply lucasNat 199999999438330103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199999999438330103 - 1 = 2 * (11 * (14221 * (14423 * (44322227)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_14221, Nat.prime_dvd_prime_iff_eq hq prime_14423, Nat.prime_dvd_prime_iff_eq hq prime_44322227] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_249999999297912583 : Nat.Prime 249999999297912583 := by
  apply lucasNat 249999999297912583 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 249999999297912583 - 1 = 2 * (3 * (58427 * (713140612211))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_58427, Nat.prime_dvd_prime_iff_eq hq prime_713140612211] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_285714284911900139 : Nat.Prime 285714284911900139 := by
  apply lucasNat 285714284911900139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 285714284911900139 - 1 = 2 * (7 * (59 * (61 * (83 * (68319389951))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_68319389951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_333333332397216779 : Nat.Prime 333333332397216779 := by
  apply lucasNat 333333332397216779 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 333333332397216779 - 1 = 2 * (11 * (11 * (23 * (73 * (820375499971))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_820375499971] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_666666664794434023 : Nat.Prime 666666664794434023 := by
  apply lucasNat 666666664794434023 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 666666664794434023 - 1 = 2 * (3 * (43 * (43 * (887 * (49433 * (1370503)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_887, Nat.prime_dvd_prime_iff_eq hq prime_49433, Nat.prime_dvd_prime_iff_eq hq prime_1370503] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_999999997191650569 : Nat.Prime 999999997191650569 := by
  apply lucasNat 999999997191650569 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 999999997191650569 - 1 = 2 * (2 * (2 * (3 * (2499463 * (16670247389))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2499463, Nat.prime_dvd_prime_iff_eq hq prime_16670247389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_999999997191650629 : Nat.Prime 999999997191650629 := by
  apply lucasNat 999999997191650629 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 999999997191650629 - 1 = 2 * (2 * (3 * (3 * (17 * (149 * (13441 * (19687 * (41443)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_13441, Nat.prime_dvd_prime_iff_eq hq prime_19687, Nat.prime_dvd_prime_iff_eq hq prime_41443] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1999999994383300901 : Nat.Prime 1999999994383300901 := by
  apply lucasNat 1999999994383300901 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999994383300901 - 1 = 2 * (2 * (5 * (5 * (19 * (8563 * (122927896297)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_8563, Nat.prime_dvd_prime_iff_eq hq prime_122927896297] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1999999994383300961 : Nat.Prime 1999999994383300961 := by
  apply lucasNat 1999999994383300961 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1999999994383300961 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (53 * (73 * (457 * (821 * (2707 * (3181))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_457, Nat.prime_dvd_prime_iff_eq hq prime_821, Nat.prime_dvd_prime_iff_eq hq prime_2707, Nat.prime_dvd_prime_iff_eq hq prime_3181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_3999999988766600789 : Nat.Prime 3999999988766600789 := by
  apply lucasNat 3999999988766600789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600789 - 1 = 2 * (2 * (37 * (281 * (96181590573401)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_96181590573401] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766600881 : Nat.Prime 3999999988766600881 := by
  apply lucasNat 3999999988766600881 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600881 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (17 * (980392154109461))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_980392154109461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766600941 : Nat.Prime 3999999988766600941 := by
  apply lucasNat 3999999988766600941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600941 - 1 = 2 * (2 * (3 * (5 * (11 * (107 * (56641177977437)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_107, Nat.prime_dvd_prime_iff_eq hq prime_56641177977437] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766600977 : Nat.Prime 3999999988766600977 := by
  apply lucasNat 3999999988766600977 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766600977 - 1 = 2 * (2 * (2 * (2 * (3 * (3151259 * (26444456993)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3151259, Nat.prime_dvd_prime_iff_eq hq prime_26444456993] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766601041 : Nat.Prime 3999999988766601041 := by
  apply lucasNat 3999999988766601041 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601041 - 1 = 2 * (2 * (2 * (2 * (5 * (13 * (19 * (21649 * (9350508071)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_21649, Nat.prime_dvd_prime_iff_eq hq prime_9350508071] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766601077 : Nat.Prime 3999999988766601077 := by
  apply lucasNat 3999999988766601077 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601077 - 1 = 2 * (2 * (8287 * (120670930033987))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_8287, Nat.prime_dvd_prime_iff_eq hq prime_120670930033987] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601107 : Nat.Prime 3999999988766601107 := by
  apply lucasNat 3999999988766601107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601107 - 1 = 2 * (7 * (23 * (59 * (17041 * (12355406267))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_17041, Nat.prime_dvd_prime_iff_eq hq prime_12355406267] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766601181 : Nat.Prime 3999999988766601181 := by
  apply lucasNat 3999999988766601181 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601181 - 1 = 2 * (2 * (3 * (3 * (3 * (3 * (3 * (5 * (6829 * (19073 * (6318989)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6829, Nat.prime_dvd_prime_iff_eq hq prime_19073, Nat.prime_dvd_prime_iff_eq hq prime_6318989] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766601217 : Nat.Prime 3999999988766601217 := by
  apply lucasNat 3999999988766601217 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601217 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (643 * (1777 * (94964029)))))))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_643, Nat.prime_dvd_prime_iff_eq hq prime_1777, Nat.prime_dvd_prime_iff_eq hq prime_94964029] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15 | h16
  all_goals subst q; decide +kernel
theorem prime_3999999988766601233 : Nat.Prime 3999999988766601233 := by
  apply lucasNat 3999999988766601233 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601233 - 1 = 2 * (2 * (2 * (2 * (7 * (37 * (54167 * (17819908109))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_54167, Nat.prime_dvd_prime_iff_eq hq prime_17819908109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766601319 : Nat.Prime 3999999988766601319 := by
  apply lucasNat 3999999988766601319 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601319 - 1 = 2 * (3 * (214548871 * (3107295143))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_214548871, Nat.prime_dvd_prime_iff_eq hq prime_3107295143] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601329 : Nat.Prime 3999999988766601329 := by
  apply lucasNat 3999999988766601329 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601329 - 1 = 2 * (2 * (2 * (2 * (249999999297912583)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_249999999297912583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601349 : Nat.Prime 3999999988766601349 := by
  apply lucasNat 3999999988766601349 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601349 - 1 = 2 * (2 * (3 * (333333332397216779))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_333333332397216779] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601353 : Nat.Prime 3999999988766601353 := by
  apply lucasNat 3999999988766601353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601353 - 1 = 2 * (2 * (2 * (13 * (38461538353525013)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_38461538353525013] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601467 : Nat.Prime 3999999988766601467 := by
  apply lucasNat 3999999988766601467 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601467 - 1 = 2 * (43 * (46511627776355831)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_46511627776355831] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766601481 : Nat.Prime 3999999988766601481 := by
  apply lucasNat 3999999988766601481 22 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601481 - 1 = 2 * (2 * (2 * (3 * (5 * (419 * (501451 * (158648591))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_419, Nat.prime_dvd_prime_iff_eq hq prime_501451, Nat.prime_dvd_prime_iff_eq hq prime_158648591] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766601487 : Nat.Prime 3999999988766601487 := by
  apply lucasNat 3999999988766601487 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601487 - 1 = 2 * (3 * (3 * (191 * (1163467128786097)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_191, Nat.prime_dvd_prime_iff_eq hq prime_1163467128786097] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601503 : Nat.Prime 3999999988766601503 := by
  apply lucasNat 3999999988766601503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601503 - 1 = 2 * (3793 * (474043 * (1112319149))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3793, Nat.prime_dvd_prime_iff_eq hq prime_474043, Nat.prime_dvd_prime_iff_eq hq prime_1112319149] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601511 : Nat.Prime 3999999988766601511 := by
  apply lucasNat 3999999988766601511 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601511 - 1 = 2 * (3 * (5 * (5679407 * (23476629331)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_5679407, Nat.prime_dvd_prime_iff_eq hq prime_23476629331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601527 : Nat.Prime 3999999988766601527 := by
  apply lucasNat 3999999988766601527 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601527 - 1 = 2 * (7 * (17 * (157 * (331 * (2909 * (111176159)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_331, Nat.prime_dvd_prime_iff_eq hq prime_2909, Nat.prime_dvd_prime_iff_eq hq prime_111176159] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766601587 : Nat.Prime 3999999988766601587 := by
  apply lucasNat 3999999988766601587 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601587 - 1 = 2 * (13 * (211 * (729128689166351))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_211, Nat.prime_dvd_prime_iff_eq hq prime_729128689166351] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766601607 : Nat.Prime 3999999988766601607 := by
  apply lucasNat 3999999988766601607 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601607 - 1 = 2 * (3 * (251 * (449567 * (5908001453)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_449567, Nat.prime_dvd_prime_iff_eq hq prime_5908001453] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766601731 : Nat.Prime 3999999988766601731 := by
  apply lucasNat 3999999988766601731 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601731 - 1 = 2 * (5 * (17 * (45599 * (275941 * (1869991))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_45599, Nat.prime_dvd_prime_iff_eq hq prime_275941, Nat.prime_dvd_prime_iff_eq hq prime_1869991] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766601803 : Nat.Prime 3999999988766601803 := by
  apply lucasNat 3999999988766601803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601803 - 1 = 2 * (1999999994383300901) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1999999994383300901] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_3999999988766601889 : Nat.Prime 3999999988766601889 := by
  apply lucasNat 3999999988766601889 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601889 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (23 * (31 * (3461 * (16884866371))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_3461, Nat.prime_dvd_prime_iff_eq hq prime_16884866371] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766601901 : Nat.Prime 3999999988766601901 := by
  apply lucasNat 3999999988766601901 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601901 - 1 = 2 * (2 * (3 * (3 * (5 * (5 * (17 * (17 * (15378700456619)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_15378700456619] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766601913 : Nat.Prime 3999999988766601913 := by
  apply lucasNat 3999999988766601913 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601913 - 1 = 2 * (2 * (2 * (3 * (281 * (593119808535973))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_593119808535973] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766601923 : Nat.Prime 3999999988766601923 := by
  apply lucasNat 3999999988766601923 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601923 - 1 = 2 * (1999999994383300961) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1999999994383300961] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_3999999988766601947 : Nat.Prime 3999999988766601947 := by
  apply lucasNat 3999999988766601947 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601947 - 1 = 2 * (7 * (285714284911900139)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_285714284911900139] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766601983 : Nat.Prime 3999999988766601983 := by
  apply lucasNat 3999999988766601983 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766601983 - 1 = 2 * (43 * (1213 * (38344293302849))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_1213, Nat.prime_dvd_prime_iff_eq hq prime_38344293302849] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602061 : Nat.Prime 3999999988766602061 := by
  apply lucasNat 3999999988766602061 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602061 - 1 = 2 * (2 * (5 * (199999999438330103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_199999999438330103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602081 : Nat.Prime 3999999988766602081 := by
  apply lucasNat 3999999988766602081 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602081 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (5 * (13 * (293 * (929 * (13009 * (60343)))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_293, Nat.prime_dvd_prime_iff_eq hq prime_929, Nat.prime_dvd_prime_iff_eq hq prime_13009, Nat.prime_dvd_prime_iff_eq hq prime_60343] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12
  all_goals subst q; decide +kernel
theorem prime_3999999988766602147 : Nat.Prime 3999999988766602147 := by
  apply lucasNat 3999999988766602147 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602147 - 1 = 2 * (3 * (29 * (11719 * (1961643969841)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_11719, Nat.prime_dvd_prime_iff_eq hq prime_1961643969841] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602151 : Nat.Prime 3999999988766602151 := by
  apply lucasNat 3999999988766602151 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602151 - 1 = 2 * (5 * (5 * (11 * (7272727252302913)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_7272727252302913] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602169 : Nat.Prime 3999999988766602169 := by
  apply lucasNat 3999999988766602169 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602169 - 1 = 2 * (2 * (2 * (59 * (26573 * (318916804553))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_26573, Nat.prime_dvd_prime_iff_eq hq prime_318916804553] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602213 : Nat.Prime 3999999988766602213 := by
  apply lucasNat 3999999988766602213 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602213 - 1 = 2 * (2 * (3 * (7 * (73 * (652315718976941))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_652315718976941] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602241 : Nat.Prime 3999999988766602241 := by
  apply lucasNat 3999999988766602241 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602241 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (7 * (17 * (43 * (131 * (1165475951))))))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_131, Nat.prime_dvd_prime_iff_eq hq prime_1165475951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11 | h12 | h13 | h14 | h15
  all_goals subst q; decide +kernel
theorem prime_3999999988766602243 : Nat.Prime 3999999988766602243 := by
  apply lucasNat 3999999988766602243 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602243 - 1 = 2 * (3 * (3 * (421 * (74201 * (7113701389))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_421, Nat.prime_dvd_prime_iff_eq hq prime_74201, Nat.prime_dvd_prime_iff_eq hq prime_7113701389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602259 : Nat.Prime 3999999988766602259 := by
  apply lucasNat 3999999988766602259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602259 - 1 = 2 * (12391 * (161407472712719)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_12391, Nat.prime_dvd_prime_iff_eq hq prime_161407472712719] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766602277 : Nat.Prime 3999999988766602277 := by
  apply lucasNat 3999999988766602277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602277 - 1 = 2 * (2 * (999999997191650569)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_999999997191650569] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766602307 : Nat.Prime 3999999988766602307 := by
  apply lucasNat 3999999988766602307 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602307 - 1 = 2 * (3529 * (5140397 * (110250781))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3529, Nat.prime_dvd_prime_iff_eq hq prime_5140397, Nat.prime_dvd_prime_iff_eq hq prime_110250781] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602333 : Nat.Prime 3999999988766602333 := by
  apply lucasNat 3999999988766602333 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602333 - 1 = 2 * (2 * (3 * (3 * (19 * (5847953199951173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_5847953199951173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602343 : Nat.Prime 3999999988766602343 := by
  apply lucasNat 3999999988766602343 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602343 - 1 = 2 * (17 * (37 * (68134433 * (46667303)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_68134433, Nat.prime_dvd_prime_iff_eq hq prime_46667303] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602489 : Nat.Prime 3999999988766602489 := by
  apply lucasNat 3999999988766602489 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602489 - 1 = 2 * (2 * (2 * (3 * (166666666198608437)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_166666666198608437] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602501 : Nat.Prime 3999999988766602501 := by
  apply lucasNat 3999999988766602501 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602501 - 1 = 2 * (2 * (3 * (5 * (5 * (5 * (5 * (533333331835547))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_533333331835547] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766602507 : Nat.Prime 3999999988766602507 := by
  apply lucasNat 3999999988766602507 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602507 - 1 = 2 * (3 * (7 * (6071591 * (15685854823)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_6071591, Nat.prime_dvd_prime_iff_eq hq prime_15685854823] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766602517 : Nat.Prime 3999999988766602517 := by
  apply lucasNat 3999999988766602517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602517 - 1 = 2 * (2 * (999999997191650629)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_999999997191650629] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766602531 : Nat.Prime 3999999988766602531 := by
  apply lucasNat 3999999988766602531 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602531 - 1 = 2 * (3 * (3 * (3 * (5 * (557 * (26597513057827)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_557, Nat.prime_dvd_prime_iff_eq hq prime_26597513057827] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766602543 : Nat.Prime 3999999988766602543 := by
  apply lucasNat 3999999988766602543 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602543 - 1 = 2 * (3 * (61 * (139 * (859799 * (91446517))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_859799, Nat.prime_dvd_prime_iff_eq hq prime_91446517] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602571 : Nat.Prime 3999999988766602571 := by
  apply lucasNat 3999999988766602571 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602571 - 1 = 2 * (5 * (31 * (12903225770214847))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_12903225770214847] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766602621 : Nat.Prime 3999999988766602621 := by
  apply lucasNat 3999999988766602621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602621 - 1 = 2 * (2 * (3 * (3 * (5 * (71 * (197 * (809 * (34703 * (56591))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_809, Nat.prime_dvd_prime_iff_eq hq prime_34703, Nat.prime_dvd_prime_iff_eq hq prime_56591] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766602649 : Nat.Prime 3999999988766602649 := by
  apply lucasNat 3999999988766602649 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602649 - 1 = 2 * (2 * (2 * (17 * (101 * (291205590329543))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_101, Nat.prime_dvd_prime_iff_eq hq prime_291205590329543] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602657 : Nat.Prime 3999999988766602657 := by
  apply lucasNat 3999999988766602657 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602657 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (11 * (311 * (3877 * (1047173461)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_311, Nat.prime_dvd_prime_iff_eq hq prime_3877, Nat.prime_dvd_prime_iff_eq hq prime_1047173461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766602819 : Nat.Prime 3999999988766602819 := by
  apply lucasNat 3999999988766602819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602819 - 1 = 2 * (3 * (3 * (17 * (31 * (199 * (449699 * (4711963))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_199, Nat.prime_dvd_prime_iff_eq hq prime_449699, Nat.prime_dvd_prime_iff_eq hq prime_4711963] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766602957 : Nat.Prime 3999999988766602957 := by
  apply lucasNat 3999999988766602957 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602957 - 1 = 2 * (2 * (3 * (79 * (33539017 * (125805991))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_33539017, Nat.prime_dvd_prime_iff_eq hq prime_125805991] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766602963 : Nat.Prime 3999999988766602963 := by
  apply lucasNat 3999999988766602963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766602963 - 1 = 2 * (3 * (3 * (3 * (3 * (33223 * (743200733087)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_33223, Nat.prime_dvd_prime_iff_eq hq prime_743200733087] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603021 : Nat.Prime 3999999988766603021 := by
  apply lucasNat 3999999988766603021 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603021 - 1 = 2 * (2 * (5 * (193 * (1036269427141607)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_193, Nat.prime_dvd_prime_iff_eq hq prime_1036269427141607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603093 : Nat.Prime 3999999988766603093 := by
  apply lucasNat 3999999988766603093 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603093 - 1 = 2 * (2 * (19 * (5948413 * (8848003459)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_5948413, Nat.prime_dvd_prime_iff_eq hq prime_8848003459] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603099 : Nat.Prime 3999999988766603099 := by
  apply lucasNat 3999999988766603099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603099 - 1 = 2 * (139 * (241 * (503 * (179213 * (662309))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_503, Nat.prime_dvd_prime_iff_eq hq prime_179213, Nat.prime_dvd_prime_iff_eq hq prime_662309] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603113 : Nat.Prime 3999999988766603113 := by
  apply lucasNat 3999999988766603113 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603113 - 1 = 2 * (2 * (2 * (3 * (59 * (251 * (166303 * (67674169))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_166303, Nat.prime_dvd_prime_iff_eq hq prime_67674169] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603123 : Nat.Prime 3999999988766603123 := by
  apply lucasNat 3999999988766603123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603123 - 1 = 2 * (7 * (103 * (8329 * (10847 * (30703807))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_8329, Nat.prime_dvd_prime_iff_eq hq prime_10847, Nat.prime_dvd_prime_iff_eq hq prime_30703807] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603189 : Nat.Prime 3999999988766603189 := by
  apply lucasNat 3999999988766603189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603189 - 1 = 2 * (2 * (71 * (109 * (28597 * (4518504059))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_109, Nat.prime_dvd_prime_iff_eq hq prime_28597, Nat.prime_dvd_prime_iff_eq hq prime_4518504059] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603191 : Nat.Prime 3999999988766603191 := by
  apply lucasNat 3999999988766603191 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603191 - 1 = 2 * (3 * (5 * (29 * (31 * (148312939887527))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_148312939887527] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603249 : Nat.Prime 3999999988766603249 := by
  apply lucasNat 3999999988766603249 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603249 - 1 = 2 * (2 * (2 * (2 * (7 * (29 * (269 * (4578167621329))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_269, Nat.prime_dvd_prime_iff_eq hq prime_4578167621329] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603273 : Nat.Prime 3999999988766603273 := by
  apply lucasNat 3999999988766603273 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603273 - 1 = 2 * (2 * (2 * (11 * (11 * (43 * (79 * (1216435499957))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_1216435499957] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603281 : Nat.Prime 3999999988766603281 := by
  apply lucasNat 3999999988766603281 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603281 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (863 * (1277 * (15123316997)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_863, Nat.prime_dvd_prime_iff_eq hq prime_1277, Nat.prime_dvd_prime_iff_eq hq prime_15123316997] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766603477 : Nat.Prime 3999999988766603477 := by
  apply lucasNat 3999999988766603477 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603477 - 1 = 2 * (2 * (21617 * (372637 * (124141961)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_21617, Nat.prime_dvd_prime_iff_eq hq prime_372637, Nat.prime_dvd_prime_iff_eq hq prime_124141961] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603501 : Nat.Prime 3999999988766603501 := by
  apply lucasNat 3999999988766603501 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603501 - 1 = 2 * (2 * (5 * (5 * (5 * (7 * (7 * (7 * (31 * (752374680479))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_752374680479] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766603539 : Nat.Prime 3999999988766603539 := by
  apply lucasNat 3999999988766603539 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603539 - 1 = 2 * (3 * (3 * (29 * (41 * (353 * (176507 * (2999639))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_353, Nat.prime_dvd_prime_iff_eq hq prime_176507, Nat.prime_dvd_prime_iff_eq hq prime_2999639] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603603 : Nat.Prime 3999999988766603603 := by
  apply lucasNat 3999999988766603603 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603603 - 1 = 2 * (11 * (11633 * (15629517863627))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_11633, Nat.prime_dvd_prime_iff_eq hq prime_15629517863627] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766603699 : Nat.Prime 3999999988766603699 := by
  apply lucasNat 3999999988766603699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603699 - 1 = 2 * (33301 * (217111 * (276624659))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_33301, Nat.prime_dvd_prime_iff_eq hq prime_217111, Nat.prime_dvd_prime_iff_eq hq prime_276624659] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766603707 : Nat.Prime 3999999988766603707 := by
  apply lucasNat 3999999988766603707 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603707 - 1 = 2 * (3 * (245963 * (2710434759677))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_245963, Nat.prime_dvd_prime_iff_eq hq prime_2710434759677] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766603737 : Nat.Prime 3999999988766603737 := by
  apply lucasNat 3999999988766603737 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603737 - 1 = 2 * (2 * (2 * (3 * (3 * (17 * (93083 * (35108170633))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_93083, Nat.prime_dvd_prime_iff_eq hq prime_35108170633] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766603777 : Nat.Prime 3999999988766603777 := by
  apply lucasNat 3999999988766603777 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603777 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (19 * (411184209371567)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_411184209371567] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766603791 : Nat.Prime 3999999988766603791 := by
  apply lucasNat 3999999988766603791 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603791 - 1 = 2 * (3 * (3 * (5 * (223 * (2850097 * (69928301)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_2850097, Nat.prime_dvd_prime_iff_eq hq prime_69928301] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603803 : Nat.Prime 3999999988766603803 := by
  apply lucasNat 3999999988766603803 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603803 - 1 = 2 * (3 * (197 * (491 * (1867 * (3691617563))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_491, Nat.prime_dvd_prime_iff_eq hq prime_1867, Nat.prime_dvd_prime_iff_eq hq prime_3691617563] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603819 : Nat.Prime 3999999988766603819 := by
  apply lucasNat 3999999988766603819 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603819 - 1 = 2 * (73 * (509 * (2473 * (3169 * (6868201))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_509, Nat.prime_dvd_prime_iff_eq hq prime_2473, Nat.prime_dvd_prime_iff_eq hq prime_3169, Nat.prime_dvd_prime_iff_eq hq prime_6868201] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766603837 : Nat.Prime 3999999988766603837 := by
  apply lucasNat 3999999988766603837 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603837 - 1 = 2 * (2 * (7 * (21942623 * (6510486119)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_21942623, Nat.prime_dvd_prime_iff_eq hq prime_6510486119] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766603867 : Nat.Prime 3999999988766603867 := by
  apply lucasNat 3999999988766603867 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603867 - 1 = 2 * (11 * (23 * (41 * (463 * (3433 * (121302799)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_463, Nat.prime_dvd_prime_iff_eq hq prime_3433, Nat.prime_dvd_prime_iff_eq hq prime_121302799] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603929 : Nat.Prime 3999999988766603929 := by
  apply lucasNat 3999999988766603929 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603929 - 1 = 2 * (2 * (2 * (3 * (19 * (659689 * (13297068467)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_659689, Nat.prime_dvd_prime_iff_eq hq prime_13297068467] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3999999988766603977 : Nat.Prime 3999999988766603977 := by
  apply lucasNat 3999999988766603977 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766603977 - 1 = 2 * (2 * (2 * (3 * (7 * (11 * (41981 * (51559090027))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41981, Nat.prime_dvd_prime_iff_eq hq prime_51559090027] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766604001 : Nat.Prime 3999999988766604001 := by
  apply lucasNat 3999999988766604001 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604001 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (5 * (5 * (5 * (21983483 * (15162899)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_21983483, Nat.prime_dvd_prime_iff_eq hq prime_15162899] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766604139 : Nat.Prime 3999999988766604139 := by
  apply lucasNat 3999999988766604139 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604139 - 1 = 2 * (3 * (666666664794434023)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_666666664794434023] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766604167 : Nat.Prime 3999999988766604167 := by
  apply lucasNat 3999999988766604167 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604167 - 1 = 2 * (21599 * (149873 * (617835629))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_21599, Nat.prime_dvd_prime_iff_eq hq prime_149873, Nat.prime_dvd_prime_iff_eq hq prime_617835629] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604187 : Nat.Prime 3999999988766604187 := by
  apply lucasNat 3999999988766604187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604187 - 1 = 2 * (3 * (3 * (7 * (7 * (7 * (13 * (823 * (60555023561)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_823, Nat.prime_dvd_prime_iff_eq hq prime_60555023561] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766604191 : Nat.Prime 3999999988766604191 := by
  apply lucasNat 3999999988766604191 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604191 - 1 = 2 * (5 * (217145179 * (1842085561))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_217145179, Nat.prime_dvd_prime_iff_eq hq prime_1842085561] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604197 : Nat.Prime 3999999988766604197 := by
  apply lucasNat 3999999988766604197 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604197 - 1 = 2 * (2 * (11 * (197 * (42299 * (10909654253))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_197, Nat.prime_dvd_prime_iff_eq hq prime_42299, Nat.prime_dvd_prime_iff_eq hq prime_10909654253] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604217 : Nat.Prime 3999999988766604217 := by
  apply lucasNat 3999999988766604217 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604217 - 1 = 2 * (2 * (2 * (3 * (15167683 * (10988274623))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_15167683, Nat.prime_dvd_prime_iff_eq hq prime_10988274623] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604259 : Nat.Prime 3999999988766604259 := by
  apply lucasNat 3999999988766604259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604259 - 1 = 2 * (3 * (3 * (3 * (3 * (24691357955349409))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_24691357955349409] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604271 : Nat.Prime 3999999988766604271 := by
  apply lucasNat 3999999988766604271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604271 - 1 = 2 * (3 * (5 * (7 * (19 * (67 * (271 * (373 * (148024693)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_271, Nat.prime_dvd_prime_iff_eq hq prime_373, Nat.prime_dvd_prime_iff_eq hq prime_148024693] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766604287 : Nat.Prime 3999999988766604287 := by
  apply lucasNat 3999999988766604287 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604287 - 1 = 2 * (15377 * (130064381503759)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_15377, Nat.prime_dvd_prime_iff_eq hq prime_130064381503759] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3999999988766604307 : Nat.Prime 3999999988766604307 := by
  apply lucasNat 3999999988766604307 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604307 - 1 = 2 * (3 * (11 * (31 * (983 * (1988844565217))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_983, Nat.prime_dvd_prime_iff_eq hq prime_1988844565217] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604353 : Nat.Prime 3999999988766604353 := by
  apply lucasNat 3999999988766604353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604353 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (157 * (397 * (31667 * (31665251))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_157, Nat.prime_dvd_prime_iff_eq hq prime_397, Nat.prime_dvd_prime_iff_eq hq prime_31667, Nat.prime_dvd_prime_iff_eq hq prime_31665251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_3999999988766604359 : Nat.Prime 3999999988766604359 := by
  apply lucasNat 3999999988766604359 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604359 - 1 = 2 * (41 * (53 * (103 * (5791 * (1543048151))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_5791, Nat.prime_dvd_prime_iff_eq hq prime_1543048151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604373 : Nat.Prime 3999999988766604373 := by
  apply lucasNat 3999999988766604373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604373 - 1 = 2 * (2 * (3 * (11 * (23 * (61 * (757 * (28532019251))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_61, Nat.prime_dvd_prime_iff_eq hq prime_757, Nat.prime_dvd_prime_iff_eq hq prime_28532019251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766604419 : Nat.Prime 3999999988766604419 := by
  apply lucasNat 3999999988766604419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604419 - 1 = 2 * (23 * (1021 * (85167993628723))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1021, Nat.prime_dvd_prime_iff_eq hq prime_85167993628723] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604503 : Nat.Prime 3999999988766604503 := by
  apply lucasNat 3999999988766604503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604503 - 1 = 2 * (124087 * (976853 * (16499641))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_124087, Nat.prime_dvd_prime_iff_eq hq prime_976853, Nat.prime_dvd_prime_iff_eq hq prime_16499641] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604619 : Nat.Prime 3999999988766604619 := by
  apply lucasNat 3999999988766604619 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604619 - 1 = 2 * (3 * (3 * (251 * (885347496406951)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_251, Nat.prime_dvd_prime_iff_eq hq prime_885347496406951] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766604649 : Nat.Prime 3999999988766604649 := by
  apply lucasNat 3999999988766604649 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604649 - 1 = 2 * (2 * (2 * (3 * (7 * (23 * (23 * (43 * (349 * (6553 * (457679)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_349, Nat.prime_dvd_prime_iff_eq hq prime_6553, Nat.prime_dvd_prime_iff_eq hq prime_457679] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_3999999988766604653 : Nat.Prime 3999999988766604653 := by
  apply lucasNat 3999999988766604653 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604653 - 1 = 2 * (2 * (3013987 * (331786433449))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3013987, Nat.prime_dvd_prime_iff_eq hq prime_331786433449] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766604803 : Nat.Prime 3999999988766604803 := by
  apply lucasNat 3999999988766604803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604803 - 1 = 2 * (7 * (19 * (31 * (173 * (2803951881919))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_2803951881919] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766604817 : Nat.Prime 3999999988766604817 := by
  apply lucasNat 3999999988766604817 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604817 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (2859391 * (1387796897)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2859391, Nat.prime_dvd_prime_iff_eq hq prime_1387796897] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766604853 : Nat.Prime 3999999988766604853 := by
  apply lucasNat 3999999988766604853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766604853 - 1 = 2 * (2 * (3 * (3 * (3 * (79 * (5480197 * (85548613))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_5480197, Nat.prime_dvd_prime_iff_eq hq prime_85548613] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_3999999988766605027 : Nat.Prime 3999999988766605027 := by
  apply lucasNat 3999999988766605027 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605027 - 1 = 2 * (3 * (7 * (241 * (1014779 * (389423527))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_1014779, Nat.prime_dvd_prime_iff_eq hq prime_389423527] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3999999988766605091 : Nat.Prime 3999999988766605091 := by
  apply lucasNat 3999999988766605091 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605091 - 1 = 2 * (5 * (22643 * (24917 * (708973939)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_22643, Nat.prime_dvd_prime_iff_eq hq prime_24917, Nat.prime_dvd_prime_iff_eq hq prime_708973939] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766605097 : Nat.Prime 3999999988766605097 := by
  apply lucasNat 3999999988766605097 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605097 - 1 = 2 * (2 * (2 * (7 * (13 * (17 * (41 * (797 * (9890938723)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_797, Nat.prime_dvd_prime_iff_eq hq prime_9890938723] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_3999999988766605099 : Nat.Prime 3999999988766605099 := by
  apply lucasNat 3999999988766605099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605099 - 1 = 2 * (3 * (11 * (60606060435857653))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_60606060435857653] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3999999988766605193 : Nat.Prime 3999999988766605193 := by
  apply lucasNat 3999999988766605193 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605193 - 1 = 2 * (2 * (2 * (53254163 * (9388937323)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53254163, Nat.prime_dvd_prime_iff_eq hq prime_9388937323] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3999999988766605261 : Nat.Prime 3999999988766605261 := by
  apply lucasNat 3999999988766605261 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605261 - 1 = 2 * (2 * (3 * (5 * (41 * (10009133 * (162453257)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_10009133, Nat.prime_dvd_prime_iff_eq hq prime_162453257] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
end FiniteP0N1024
