import Primes1024Part05
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
theorem prime_1285099 : Nat.Prime 1285099 := by
  apply lucasNat 1285099 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1285099 - 1 = 2 * (3 * (17 * (43 * (293)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1342177 : Nat.Prime 1342177 := by
  apply lucasNat 1342177 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1342177 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (11 * (31 * (41)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1345541 : Nat.Prime 1345541 := by
  apply lucasNat 1345541 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1345541 - 1 = 2 * (2 * (5 * (7 * (7 * (1373))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1369429 : Nat.Prime 1369429 := by
  apply lucasNat 1369429 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1369429 - 1 = 2 * (2 * (3 * (139 * (821)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_139, Nat.prime_dvd_prime_iff_eq hq prime_821] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1370503 : Nat.Prime 1370503 := by
  apply lucasNat 1370503 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1370503 - 1 = 2 * (3 * (3 * (7 * (73 * (149))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_149] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1370599 : Nat.Prime 1370599 := by
  apply lucasNat 1370599 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1370599 - 1 = 2 * (3 * (29 * (7877))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_7877] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1381907 : Nat.Prime 1381907 := by
  apply lucasNat 1381907 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1381907 - 1 = 2 * (690953) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_690953] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1450201 : Nat.Prime 1450201 := by
  apply lucasNat 1450201 31 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1450201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (2417)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_2417] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1450513 : Nat.Prime 1450513 := by
  apply lucasNat 1450513 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1450513 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (1439))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1451003 : Nat.Prime 1451003 := by
  apply lucasNat 1451003 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1451003 - 1 = 2 * (7 * (103643)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_103643] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1545041 : Nat.Prime 1545041 := by
  apply lucasNat 1545041 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1545041 - 1 = 2 * (2 * (2 * (2 * (5 * (7 * (31 * (89))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_89] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1577293 : Nat.Prime 1577293 := by
  apply lucasNat 1577293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1577293 - 1 = 2 * (2 * (3 * (131441))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_131441] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1579621 : Nat.Prime 1579621 := by
  apply lucasNat 1579621 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1579621 - 1 = 2 * (2 * (3 * (5 * (7 * (3761))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3761] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1616473 : Nat.Prime 1616473 := by
  apply lucasNat 1616473 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1616473 - 1 = 2 * (2 * (2 * (3 * (3 * (11 * (13 * (157))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_157] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1678771 : Nat.Prime 1678771 := by
  apply lucasNat 1678771 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1678771 - 1 = 2 * (3 * (3 * (5 * (23 * (811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1701643 : Nat.Prime 1701643 := by
  apply lucasNat 1701643 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1701643 - 1 = 2 * (3 * (283607)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_283607] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1760233 : Nat.Prime 1760233 := by
  apply lucasNat 1760233 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1760233 - 1 = 2 * (2 * (2 * (3 * (71 * (1033))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_1033] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1869991 : Nat.Prime 1869991 := by
  apply lucasNat 1869991 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1869991 - 1 = 2 * (3 * (5 * (83 * (751)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_751] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1939493 : Nat.Prime 1939493 := by
  apply lucasNat 1939493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1939493 - 1 = 2 * (2 * (233 * (2081))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_233, Nat.prime_dvd_prime_iff_eq hq prime_2081] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1966561 : Nat.Prime 1966561 := by
  apply lucasNat 1966561 46 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1966561 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (5 * (17 * (241)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_1988411 : Nat.Prime 1988411 := by
  apply lucasNat 1988411 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1988411 - 1 = 2 * (5 * (198841)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_198841] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1991177 : Nat.Prime 1991177 := by
  apply lucasNat 1991177 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1991177 - 1 = 2 * (2 * (2 * (11 * (11 * (11 * (11 * (17))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2021083 : Nat.Prime 2021083 := by
  apply lucasNat 2021083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2021083 - 1 = 2 * (3 * (7 * (48121))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_48121] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2034779 : Nat.Prime 2034779 := by
  apply lucasNat 2034779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2034779 - 1 = 2 * (31 * (37 * (887))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_887] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2048149 : Nat.Prime 2048149 := by
  apply lucasNat 2048149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2048149 - 1 = 2 * (2 * (3 * (3 * (56893)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_56893] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2121241 : Nat.Prime 2121241 := by
  apply lucasNat 2121241 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2121241 - 1 = 2 * (2 * (2 * (3 * (5 * (11 * (1607)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2154851 : Nat.Prime 2154851 := by
  apply lucasNat 2154851 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2154851 - 1 = 2 * (5 * (5 * (71 * (607)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_607] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2162623 : Nat.Prime 2162623 := by
  apply lucasNat 2162623 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2162623 - 1 = 2 * (3 * (7 * (11 * (31 * (151))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2175769 : Nat.Prime 2175769 := by
  apply lucasNat 2175769 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2175769 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (7 * (1439))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2219621 : Nat.Prime 2219621 := by
  apply lucasNat 2219621 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2219621 - 1 = 2 * (2 * (5 * (13 * (8537)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_8537] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2251031 : Nat.Prime 2251031 := by
  apply lucasNat 2251031 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2251031 - 1 = 2 * (5 * (163 * (1381))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_163, Nat.prime_dvd_prime_iff_eq hq prime_1381] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2297707 : Nat.Prime 2297707 := by
  apply lucasNat 2297707 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2297707 - 1 = 2 * (3 * (293 * (1307))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_293, Nat.prime_dvd_prime_iff_eq hq prime_1307] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2309123 : Nat.Prime 2309123 := by
  apply lucasNat 2309123 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2309123 - 1 = 2 * (1154561) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1154561] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2328401 : Nat.Prime 2328401 := by
  apply lucasNat 2328401 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2328401 - 1 = 2 * (2 * (2 * (2 * (5 * (5 * (5821)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_5821] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2346977 : Nat.Prime 2346977 := by
  apply lucasNat 2346977 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2346977 - 1 = 2 * (2 * (2 * (2 * (2 * (71 * (1033)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_1033] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_2408843 : Nat.Prime 2408843 := by
  apply lucasNat 2408843 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2408843 - 1 = 2 * (1204421) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1204421] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_2452699 : Nat.Prime 2452699 := by
  apply lucasNat 2452699 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2452699 - 1 = 2 * (3 * (3 * (136261))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_136261] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2462711 : Nat.Prime 2462711 := by
  apply lucasNat 2462711 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2462711 - 1 = 2 * (5 * (246271)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_246271] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2465539 : Nat.Prime 2465539 := by
  apply lucasNat 2465539 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2465539 - 1 = 2 * (3 * (163 * (2521))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_163, Nat.prime_dvd_prime_iff_eq hq prime_2521] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2485513 : Nat.Prime 2485513 := by
  apply lucasNat 2485513 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2485513 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (37 * (311))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_311] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2499463 : Nat.Prime 2499463 := by
  apply lucasNat 2499463 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2499463 - 1 = 2 * (3 * (3 * (7 * (83 * (239))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_239] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2555809 : Nat.Prime 2555809 := by
  apply lucasNat 2555809 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2555809 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (79 * (337))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_337] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2669339 : Nat.Prime 2669339 := by
  apply lucasNat 2669339 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2669339 - 1 = 2 * (7 * (190667)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_190667] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2707909 : Nat.Prime 2707909 := by
  apply lucasNat 2707909 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2707909 - 1 = 2 * (2 * (3 * (7 * (32237)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_32237] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2850097 : Nat.Prime 2850097 := by
  apply lucasNat 2850097 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2850097 - 1 = 2 * (2 * (2 * (2 * (3 * (59377))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_59377] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_2859391 : Nat.Prime 2859391 := by
  apply lucasNat 2859391 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2859391 - 1 = 2 * (3 * (3 * (5 * (31771)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31771] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2876737 : Nat.Prime 2876737 := by
  apply lucasNat 2876737 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2876737 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (14983))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_14983] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_2900951 : Nat.Prime 2900951 := by
  apply lucasNat 2900951 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2900951 - 1 = 2 * (5 * (5 * (13 * (4463)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_4463] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_2907899 : Nat.Prime 2907899 := by
  apply lucasNat 2907899 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2907899 - 1 = 2 * (7 * (53 * (3919))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_3919] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_2914319 : Nat.Prime 2914319 := by
  apply lucasNat 2914319 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2914319 - 1 = 2 * (11 * (132469)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_132469] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_2999639 : Nat.Prime 2999639 := by
  apply lucasNat 2999639 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2999639 - 1 = 2 * (107 * (107 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_107, Nat.prime_dvd_prime_iff_eq hq prime_131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3013987 : Nat.Prime 3013987 := by
  apply lucasNat 3013987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3013987 - 1 = 2 * (3 * (103 * (4877))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_4877] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3033169 : Nat.Prime 3033169 := by
  apply lucasNat 3033169 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3033169 - 1 = 2 * (2 * (2 * (2 * (3 * (29 * (2179)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_2179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_3103549 : Nat.Prime 3103549 := by
  apply lucasNat 3103549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3103549 - 1 = 2 * (2 * (3 * (7 * (36947)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_36947] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_3151259 : Nat.Prime 3151259 := by
  apply lucasNat 3151259 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3151259 - 1 = 2 * (11 * (143239)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_143239] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3179389 : Nat.Prime 3179389 := by
  apply lucasNat 3179389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3179389 - 1 = 2 * (2 * (3 * (264949))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_264949] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3392549 : Nat.Prime 3392549 := by
  apply lucasNat 3392549 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3392549 - 1 = 2 * (2 * (367 * (2311))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_367, Nat.prime_dvd_prime_iff_eq hq prime_2311] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3526247 : Nat.Prime 3526247 := by
  apply lucasNat 3526247 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3526247 - 1 = 2 * (41 * (43003)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_43003] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3579139 : Nat.Prime 3579139 := by
  apply lucasNat 3579139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3579139 - 1 = 2 * (3 * (3 * (198841))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_198841] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_3865859 : Nat.Prime 3865859 := by
  apply lucasNat 3865859 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3865859 - 1 = 2 * (173 * (11173)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_173, Nat.prime_dvd_prime_iff_eq hq prime_11173] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_3904517 : Nat.Prime 3904517 := by
  apply lucasNat 3904517 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3904517 - 1 = 2 * (2 * (7 * (7 * (11 * (1811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_1811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_3954851 : Nat.Prime 3954851 := by
  apply lucasNat 3954851 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3954851 - 1 = 2 * (5 * (5 * (19 * (23 * (181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4021207 : Nat.Prime 4021207 := by
  apply lucasNat 4021207 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4021207 - 1 = 2 * (3 * (7 * (67 * (1429)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_1429] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_4129777 : Nat.Prime 4129777 := by
  apply lucasNat 4129777 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4129777 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (7 * (17 * (241)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_4186129 : Nat.Prime 4186129 := by
  apply lucasNat 4186129 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4186129 - 1 = 2 * (2 * (2 * (2 * (3 * (87211))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_87211] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4338353 : Nat.Prime 4338353 := by
  apply lucasNat 4338353 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4338353 - 1 = 2 * (2 * (2 * (2 * (23 * (11789))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_11789] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4711963 : Nat.Prime 4711963 := by
  apply lucasNat 4711963 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4711963 - 1 = 2 * (3 * (19 * (41333))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_41333] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_4756333 : Nat.Prime 4756333 := by
  apply lucasNat 4756333 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4756333 - 1 = 2 * (2 * (3 * (7 * (7 * (8089))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_8089] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_4823821 : Nat.Prime 4823821 := by
  apply lucasNat 4823821 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4823821 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (8933)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_8933] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_4999961 : Nat.Prime 4999961 := by
  apply lucasNat 4999961 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4999961 - 1 = 2 * (2 * (2 * (5 * (7 * (7 * (2551)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_2551] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_5140397 : Nat.Prime 5140397 := by
  apply lucasNat 5140397 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5140397 - 1 = 2 * (2 * (1285099)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1285099] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5480197 : Nat.Prime 5480197 := by
  apply lucasNat 5480197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5480197 - 1 = 2 * (2 * (3 * (456683))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_456683] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5492287 : Nat.Prime 5492287 := by
  apply lucasNat 5492287 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5492287 - 1 = 2 * (3 * (3 * (3 * (3 * (3 * (3 * (3767))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_3767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_5621687 : Nat.Prime 5621687 := by
  apply lucasNat 5621687 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5621687 - 1 = 2 * (7 * (281 * (1429))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_1429] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_5672833 : Nat.Prime 5672833 := by
  apply lucasNat 5672833 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5672833 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (11 * (17 * (79)))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_79] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10
  all_goals subst q; decide +kernel
theorem prime_5679407 : Nat.Prime 5679407 := by
  apply lucasNat 5679407 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5679407 - 1 = 2 * (241 * (11783)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_241, Nat.prime_dvd_prime_iff_eq hq prime_11783] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5833103 : Nat.Prime 5833103 := by
  apply lucasNat 5833103 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5833103 - 1 = 2 * (11 * (265141)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_265141] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_5948413 : Nat.Prime 5948413 := by
  apply lucasNat 5948413 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5948413 - 1 = 2 * (2 * (3 * (495701))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_495701] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_6071591 : Nat.Prime 6071591 := by
  apply lucasNat 6071591 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6071591 - 1 = 2 * (5 * (7 * (7 * (12391)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_12391] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6197647 : Nat.Prime 6197647 := by
  apply lucasNat 6197647 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6197647 - 1 = 2 * (3 * (7 * (13 * (11351)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_11351] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6318989 : Nat.Prime 6318989 := by
  apply lucasNat 6318989 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6318989 - 1 = 2 * (2 * (13 * (137 * (887)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_887] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_6710887 : Nat.Prime 6710887 := by
  apply lucasNat 6710887 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6710887 - 1 = 2 * (3 * (3 * (7 * (13 * (17 * (241)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_6868201 : Nat.Prime 6868201 := by
  apply lucasNat 6868201 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6868201 - 1 = 2 * (2 * (2 * (3 * (5 * (5 * (11447)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11447] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_7122667 : Nat.Prime 7122667 := by
  apply lucasNat 7122667 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7122667 - 1 = 2 * (3 * (1187111)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1187111] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_7479727 : Nat.Prime 7479727 := by
  apply lucasNat 7479727 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7479727 - 1 = 2 * (3 * (73 * (17077))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_17077] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_7913669 : Nat.Prime 7913669 := by
  apply lucasNat 7913669 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7913669 - 1 = 2 * (2 * (7 * (137 * (2063)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_2063] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_8291443 : Nat.Prime 8291443 := by
  apply lucasNat 8291443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8291443 - 1 = 2 * (3 * (1381907)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1381907] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_8365933 : Nat.Prime 8365933 := by
  apply lucasNat 8365933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8365933 - 1 = 2 * (2 * (3 * (3 * (281 * (827))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_281, Nat.prime_dvd_prime_iff_eq hq prime_827] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8521759 : Nat.Prime 8521759 := by
  apply lucasNat 8521759 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8521759 - 1 = 2 * (3 * (3 * (7 * (47 * (1439))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_1439] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_8521763 : Nat.Prime 8521763 := by
  apply lucasNat 8521763 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 8521763 - 1 = 2 * (523 * (8147)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_523, Nat.prime_dvd_prime_iff_eq hq prime_8147] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_9061111 : Nat.Prime 9061111 := by
  apply lucasNat 9061111 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9061111 - 1 = 2 * (3 * (3 * (5 * (83 * (1213))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_83, Nat.prime_dvd_prime_iff_eq hq prime_1213] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_9565627 : Nat.Prime 9565627 := by
  apply lucasNat 9565627 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9565627 - 1 = 2 * (3 * (7 * (19 * (11987)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_11987] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_9673351 : Nat.Prime 9673351 := by
  apply lucasNat 9673351 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 9673351 - 1 = 2 * (3 * (5 * (5 * (64489)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_64489] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_10009133 : Nat.Prime 10009133 := by
  apply lucasNat 10009133 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10009133 - 1 = 2 * (2 * (7 * (7 * (223 * (229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_223, Nat.prime_dvd_prime_iff_eq hq prime_229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_10223237 : Nat.Prime 10223237 := by
  apply lucasNat 10223237 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10223237 - 1 = 2 * (2 * (2555809)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2555809] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_10239067 : Nat.Prime 10239067 := by
  apply lucasNat 10239067 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 10239067 - 1 = 2 * (3 * (3 * (17 * (33461)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_33461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_11332367 : Nat.Prime 11332367 := by
  apply lucasNat 11332367 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11332367 - 1 = 2 * (59 * (137 * (701))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_137, Nat.prime_dvd_prime_iff_eq hq prime_701] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_11767033 : Nat.Prime 11767033 := by
  apply lucasNat 11767033 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 11767033 - 1 = 2 * (2 * (2 * (3 * (3 * (3 * (3 * (3 * (6053)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_6053] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_12132677 : Nat.Prime 12132677 := by
  apply lucasNat 12132677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12132677 - 1 = 2 * (2 * (3033169)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3033169] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_12167047 : Nat.Prime 12167047 := by
  apply lucasNat 12167047 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12167047 - 1 = 2 * (3 * (3 * (23 * (29389)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_29389] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_12271333 : Nat.Prime 12271333 := by
  apply lucasNat 12271333 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12271333 - 1 = 2 * (2 * (3 * (1022611))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1022611] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_12558383 : Nat.Prime 12558383 := by
  apply lucasNat 12558383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12558383 - 1 = 2 * (41 * (153151)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_153151] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_12595213 : Nat.Prime 12595213 := by
  apply lucasNat 12595213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 12595213 - 1 = 2 * (2 * (3 * (3 * (7 * (151 * (331)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_151, Nat.prime_dvd_prime_iff_eq hq prime_331] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_13203581 : Nat.Prime 13203581 := by
  apply lucasNat 13203581 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13203581 - 1 = 2 * (2 * (5 * (13 * (43 * (1181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_1181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_13506187 : Nat.Prime 13506187 := by
  apply lucasNat 13506187 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13506187 - 1 = 2 * (3 * (2251031)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2251031] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_13786243 : Nat.Prime 13786243 := by
  apply lucasNat 13786243 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 13786243 - 1 = 2 * (3 * (2297707)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2297707] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_14128181 : Nat.Prime 14128181 := by
  apply lucasNat 14128181 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14128181 - 1 = 2 * (2 * (5 * (11 * (149 * (431))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_149, Nat.prime_dvd_prime_iff_eq hq prime_431] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_14759341 : Nat.Prime 14759341 := by
  apply lucasNat 14759341 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14759341 - 1 = 2 * (2 * (3 * (5 * (245989)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_245989] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_14810233 : Nat.Prime 14810233 := by
  apply lucasNat 14810233 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 14810233 - 1 = 2 * (2 * (2 * (3 * (43 * (113 * (127)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_113, Nat.prime_dvd_prime_iff_eq hq prime_127] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_15162899 : Nat.Prime 15162899 := by
  apply lucasNat 15162899 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15162899 - 1 = 2 * (2617 * (2897)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_2617, Nat.prime_dvd_prime_iff_eq hq prime_2897] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_15167683 : Nat.Prime 15167683 := by
  apply lucasNat 15167683 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15167683 - 1 = 2 * (3 * (3 * (3 * (280883)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_280883] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_15378457 : Nat.Prime 15378457 := by
  apply lucasNat 15378457 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15378457 - 1 = 2 * (2 * (2 * (3 * (79 * (8111))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_8111] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_15618061 : Nat.Prime 15618061 := by
  apply lucasNat 15618061 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15618061 - 1 = 2 * (2 * (3 * (3 * (5 * (86767))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_86767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_15732481 : Nat.Prime 15732481 := by
  apply lucasNat 15732481 23 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 15732481 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (3 * (5 * (17 * (241))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_241] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_16275793 : Nat.Prime 16275793 := by
  apply lucasNat 16275793 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16275793 - 1 = 2 * (2 * (2 * (2 * (3 * (13 * (26083)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_26083] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_16499641 : Nat.Prime 16499641 := by
  apply lucasNat 16499641 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16499641 - 1 = 2 * (2 * (2 * (3 * (5 * (359 * (383)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_359, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_16909327 : Nat.Prime 16909327 := by
  apply lucasNat 16909327 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16909327 - 1 = 2 * (3 * (3 * (7 * (67 * (2003))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_2003] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_16976153 : Nat.Prime 16976153 := by
  apply lucasNat 16976153 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 16976153 - 1 = 2 * (2 * (2 * (79 * (26861)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_26861] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_17452891 : Nat.Prime 17452891 := by
  apply lucasNat 17452891 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 17452891 - 1 = 2 * (3 * (3 * (5 * (7 * (13 * (2131)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2131] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_20602097 : Nat.Prime 20602097 := by
  apply lucasNat 20602097 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 20602097 - 1 = 2 * (2 * (2 * (2 * (17 * (75743))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_75743] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_21582749 : Nat.Prime 21582749 := by
  apply lucasNat 21582749 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21582749 - 1 = 2 * (2 * (11 * (499 * (983)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_499, Nat.prime_dvd_prime_iff_eq hq prime_983] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_21691751 : Nat.Prime 21691751 := by
  apply lucasNat 21691751 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21691751 - 1 = 2 * (5 * (5 * (5 * (86767)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_86767] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_21913109 : Nat.Prime 21913109 := by
  apply lucasNat 21913109 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21913109 - 1 = 2 * (2 * (7 * (782611))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_782611] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_21942623 : Nat.Prime 21942623 := by
  apply lucasNat 21942623 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21942623 - 1 = 2 * (13 * (13 * (64919))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_64919] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_21983483 : Nat.Prime 21983483 := by
  apply lucasNat 21983483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 21983483 - 1 = 2 * (17 * (646573)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_646573] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_22253723 : Nat.Prime 22253723 := by
  apply lucasNat 22253723 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22253723 - 1 = 2 * (31 * (358931)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_358931] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_22605091 : Nat.Prime 22605091 := by
  apply lucasNat 22605091 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 22605091 - 1 = 2 * (3 * (5 * (23 * (181 * (181))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_181] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_23216041 : Nat.Prime 23216041 := by
  apply lucasNat 23216041 33 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 23216041 - 1 = 2 * (2 * (2 * (3 * (3 * (5 * (64489)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_64489] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
end FiniteP0N1024
