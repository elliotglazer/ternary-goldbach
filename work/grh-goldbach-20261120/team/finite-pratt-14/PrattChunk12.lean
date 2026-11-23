import PrattChunk11
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p99999998945107 : Nat.Prime 99999998945107 := by
  apply lucasNat 99999998945107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945107-1 = 2 * (3 * (13 * (1282051268527))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p1282051268527] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998945113 : Nat.Prime 99999998945113 := by
  apply lucasNat 99999998945113 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945113-1 = 2 * (2 * (2 * (3 * (7 * (595238088959))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p595238088959] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998945137 : Nat.Prime 99999998945137 := by
  apply lucasNat 99999998945137 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945137-1 = 2 * (2 * (2 * (2 * (3 * (3 * (179 * (10957 * (354073)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p179, Nat.prime_dvd_prime_iff_eq hq p10957, Nat.prime_dvd_prime_iff_eq hq p354073] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998945153 : Nat.Prime 99999998945153 := by
  apply lucasNat 99999998945153 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945153-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (463 * (1687364993)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p463, Nat.prime_dvd_prime_iff_eq hq p1687364993] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem p99999998945243 : Nat.Prime 99999998945243 := by
  apply lucasNat 99999998945243 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945243-1 = 2 * (11 * (29 * (643 * (243763313)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p29, Nat.prime_dvd_prime_iff_eq hq p643, Nat.prime_dvd_prime_iff_eq hq p243763313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998945311 : Nat.Prime 99999998945311 := by
  apply lucasNat 99999998945311 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945311-1 = 2 * (3 * (5 * (3333333298177))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p3333333298177] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998945491 : Nat.Prime 99999998945491 := by
  apply lucasNat 99999998945491 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945491-1 = 2 * (3 * (5 * (7 * (7 * (7 * (44501 * (218381))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p44501, Nat.prime_dvd_prime_iff_eq hq p218381] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998945663 : Nat.Prime 99999998945663 := by
  apply lucasNat 99999998945663 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945663-1 = 2 * (31 * (101 * (197 * (81062633)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p101, Nat.prime_dvd_prime_iff_eq hq p197, Nat.prime_dvd_prime_iff_eq hq p81062633] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998945789 : Nat.Prime 99999998945789 := by
  apply lucasNat 99999998945789 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945789-1 = 2 * (2 * (17 * (19 * (8933 * (8664433))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p8933, Nat.prime_dvd_prime_iff_eq hq p8664433] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p99999998945969 : Nat.Prime 99999998945969 := by
  apply lucasNat 99999998945969 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998945969-1 = 2 * (2 * (2 * (2 * (11 * (6299 * (8423 * (10709))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p6299, Nat.prime_dvd_prime_iff_eq hq p8423, Nat.prime_dvd_prime_iff_eq hq p10709] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p99999998946311 : Nat.Prime 99999998946311 := by
  apply lucasNat 99999998946311 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998946311-1 = 2 * (5 * (8389 * (1192037179))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p8389, Nat.prime_dvd_prime_iff_eq hq p1192037179] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998946971 : Nat.Prime 99999998946971 := by
  apply lucasNat 99999998946971 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998946971-1 = 2 * (5 * (149 * (67114093253))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p149, Nat.prime_dvd_prime_iff_eq hq p67114093253] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998948159 : Nat.Prime 99999998948159 := by
  apply lucasNat 99999998948159 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998948159-1 = 2 * (311 * (40883 * (3932483))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p311, Nat.prime_dvd_prime_iff_eq hq p40883, Nat.prime_dvd_prime_iff_eq hq p3932483] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p99999998948189 : Nat.Prime 99999998948189 := by
  apply lucasNat 99999998948189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998948189-1 = 2 * (2 * (83 * (103 * (2924318603)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p83, Nat.prime_dvd_prime_iff_eq hq p103, Nat.prime_dvd_prime_iff_eq hq p2924318603] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p99999998950031 : Nat.Prime 99999998950031 := by
  apply lucasNat 99999998950031 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998950031-1 = 2 * (5 * (9999999895003)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p9999999895003] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p99999998950847 : Nat.Prime 99999998950847 := by
  apply lucasNat 99999998950847 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 99999998950847-1 = 2 * (49999999475423) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p49999999475423] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
end Pratt14
