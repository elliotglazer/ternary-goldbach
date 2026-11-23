import Primes1024Part04
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
theorem prime_151637 : Nat.Prime 151637 := by
  apply lucasNat 151637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151637 - 1 = 2 * (2 * (167 * (227))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_227] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_152239 : Nat.Prime 152239 := by
  apply lucasNat 152239 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 152239 - 1 = 2 * (3 * (25373)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_25373] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_153151 : Nat.Prime 153151 := by
  apply lucasNat 153151 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 153151 - 1 = 2 * (3 * (5 * (5 * (1021)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1021] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_153641 : Nat.Prime 153641 := by
  apply lucasNat 153641 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 153641 - 1 = 2 * (2 * (2 * (5 * (23 * (167))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_167] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_166303 : Nat.Prime 166303 := by
  apply lucasNat 166303 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 166303 - 1 = 2 * (3 * (3 * (9239))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_9239] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_166931 : Nat.Prime 166931 := by
  apply lucasNat 166931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 166931 - 1 = 2 * (5 * (16693)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_16693] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_174649 : Nat.Prime 174649 := by
  apply lucasNat 174649 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 174649 - 1 = 2 * (2 * (2 * (3 * (19 * (383))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_176081 : Nat.Prime 176081 := by
  apply lucasNat 176081 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 176081 - 1 = 2 * (2 * (2 * (2 * (5 * (31 * (71)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_176507 : Nat.Prime 176507 := by
  apply lucasNat 176507 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 176507 - 1 = 2 * (11 * (71 * (113))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_113] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_179213 : Nat.Prime 179213 := by
  apply lucasNat 179213 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 179213 - 1 = 2 * (2 * (11 * (4073))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_4073] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_185873 : Nat.Prime 185873 := by
  apply lucasNat 185873 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 185873 - 1 = 2 * (2 * (2 * (2 * (11617)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11617] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_187043 : Nat.Prime 187043 := by
  apply lucasNat 187043 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 187043 - 1 = 2 * (41 * (2281)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_2281] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_189961 : Nat.Prime 189961 := by
  apply lucasNat 189961 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 189961 - 1 = 2 * (2 * (2 * (3 * (5 * (1583))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1583] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_190243 : Nat.Prime 190243 := by
  apply lucasNat 190243 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 190243 - 1 = 2 * (3 * (3 * (3 * (13 * (271))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_271] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_190667 : Nat.Prime 190667 := by
  apply lucasNat 190667 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 190667 - 1 = 2 * (7 * (13619)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13619] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_191449 : Nat.Prime 191449 := by
  apply lucasNat 191449 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191449 - 1 = 2 * (2 * (2 * (3 * (3 * (2659))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_2659] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_191911 : Nat.Prime 191911 := by
  apply lucasNat 191911 12 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191911 - 1 = 2 * (3 * (5 * (6397))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6397] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_198841 : Nat.Prime 198841 := by
  apply lucasNat 198841 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 198841 - 1 = 2 * (2 * (2 * (3 * (5 * (1657))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1657] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_199321 : Nat.Prime 199321 := by
  apply lucasNat 199321 14 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199321 - 1 = 2 * (2 * (2 * (3 * (5 * (11 * (151)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_199637 : Nat.Prime 199637 := by
  apply lucasNat 199637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199637 - 1 = 2 * (2 * (29 * (1721))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_1721] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_210071 : Nat.Prime 210071 := by
  apply lucasNat 210071 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 210071 - 1 = 2 * (5 * (7 * (3001))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_3001] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_211997 : Nat.Prime 211997 := by
  apply lucasNat 211997 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 211997 - 1 = 2 * (2 * (52999)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_52999] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_216023 : Nat.Prime 216023 := by
  apply lucasNat 216023 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 216023 - 1 = 2 * (108011) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_108011] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_217111 : Nat.Prime 217111 := by
  apply lucasNat 217111 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 217111 - 1 = 2 * (3 * (5 * (7237))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7237] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_224891 : Nat.Prime 224891 := by
  apply lucasNat 224891 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 224891 - 1 = 2 * (5 * (43 * (523))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_523] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_228341 : Nat.Prime 228341 := by
  apply lucasNat 228341 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 228341 - 1 = 2 * (2 * (5 * (7 * (7 * (233))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_233] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_234547 : Nat.Prime 234547 := by
  apply lucasNat 234547 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 234547 - 1 = 2 * (3 * (13 * (31 * (97)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_31, Nat.prime_dvd_prime_iff_eq hq prime_97] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_235199 : Nat.Prime 235199 := by
  apply lucasNat 235199 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 235199 - 1 = 2 * (23 * (5113)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_5113] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_245963 : Nat.Prime 245963 := by
  apply lucasNat 245963 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 245963 - 1 = 2 * (23 * (5347)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_5347] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_245989 : Nat.Prime 245989 := by
  apply lucasNat 245989 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 245989 - 1 = 2 * (2 * (3 * (3 * (6833)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_6833] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_246271 : Nat.Prime 246271 := by
  apply lucasNat 246271 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 246271 - 1 = 2 * (3 * (5 * (8209))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_8209] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_250889 : Nat.Prime 250889 := by
  apply lucasNat 250889 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 250889 - 1 = 2 * (2 * (2 * (11 * (2851)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_2851] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_252913 : Nat.Prime 252913 := by
  apply lucasNat 252913 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 252913 - 1 = 2 * (2 * (2 * (2 * (3 * (11 * (479)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_479] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_258733 : Nat.Prime 258733 := by
  apply lucasNat 258733 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 258733 - 1 = 2 * (2 * (3 * (3 * (7187)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7187] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_261251 : Nat.Prime 261251 := by
  apply lucasNat 261251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 261251 - 1 = 2 * (5 * (5 * (5 * (5 * (11 * (19)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_19] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_264949 : Nat.Prime 264949 := by
  apply lucasNat 264949 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 264949 - 1 = 2 * (2 * (3 * (22079))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_22079] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_265141 : Nat.Prime 265141 := by
  apply lucasNat 265141 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 265141 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (491)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_491] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_268637 : Nat.Prime 268637 := by
  apply lucasNat 268637 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 268637 - 1 = 2 * (2 * (239 * (281))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_239, Nat.prime_dvd_prime_iff_eq hq prime_281] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_273269 : Nat.Prime 273269 := by
  apply lucasNat 273269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 273269 - 1 = 2 * (2 * (53 * (1289))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_1289] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_275941 : Nat.Prime 275941 := by
  apply lucasNat 275941 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 275941 - 1 = 2 * (2 * (3 * (3 * (3 * (5 * (7 * (73))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_280883 : Nat.Prime 280883 := by
  apply lucasNat 280883 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 280883 - 1 = 2 * (7 * (20063)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_20063] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_283607 : Nat.Prime 283607 := by
  apply lucasNat 283607 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 283607 - 1 = 2 * (141803) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_141803] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_283721 : Nat.Prime 283721 := by
  apply lucasNat 283721 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 283721 - 1 = 2 * (2 * (2 * (5 * (41 * (173))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_173] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_299447 : Nat.Prime 299447 := by
  apply lucasNat 299447 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 299447 - 1 = 2 * (7 * (73 * (293))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_293] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_305329 : Nat.Prime 305329 := by
  apply lucasNat 305329 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 305329 - 1 = 2 * (2 * (2 * (2 * (3 * (6361))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_6361] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_315527 : Nat.Prime 315527 := by
  apply lucasNat 315527 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 315527 - 1 = 2 * (79 * (1997)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_79, Nat.prime_dvd_prime_iff_eq hq prime_1997] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_324847 : Nat.Prime 324847 := by
  apply lucasNat 324847 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 324847 - 1 = 2 * (3 * (3 * (18047))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_18047] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_338293 : Nat.Prime 338293 := by
  apply lucasNat 338293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 338293 - 1 = 2 * (2 * (3 * (3 * (9397)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_9397] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_339389 : Nat.Prime 339389 := by
  apply lucasNat 339389 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 339389 - 1 = 2 * (2 * (7 * (17 * (23 * (31))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_341087 : Nat.Prime 341087 := by
  apply lucasNat 341087 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 341087 - 1 = 2 * (199 * (857)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_199, Nat.prime_dvd_prime_iff_eq hq prime_857] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_341521 : Nat.Prime 341521 := by
  apply lucasNat 341521 21 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 341521 - 1 = 2 * (2 * (2 * (2 * (3 * (5 * (1423)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_1423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_348043 : Nat.Prime 348043 := by
  apply lucasNat 348043 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 348043 - 1 = 2 * (3 * (19 * (43 * (71)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_43, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_358811 : Nat.Prime 358811 := by
  apply lucasNat 358811 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 358811 - 1 = 2 * (5 * (53 * (677))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_677] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_358877 : Nat.Prime 358877 := by
  apply lucasNat 358877 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 358877 - 1 = 2 * (2 * (7 * (7 * (1831)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1831] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_358931 : Nat.Prime 358931 := by
  apply lucasNat 358931 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 358931 - 1 = 2 * (5 * (11 * (13 * (251)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_251] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_359111 : Nat.Prime 359111 := by
  apply lucasNat 359111 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 359111 - 1 = 2 * (5 * (35911)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_35911] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_359171 : Nat.Prime 359171 := by
  apply lucasNat 359171 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 359171 - 1 = 2 * (5 * (7 * (7 * (733)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_733] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_364289 : Nat.Prime 364289 := by
  apply lucasNat 364289 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 364289 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (1423)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_1423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_369269 : Nat.Prime 369269 := by
  apply lucasNat 369269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 369269 - 1 = 2 * (2 * (92317)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_92317] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_372637 : Nat.Prime 372637 := by
  apply lucasNat 372637 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 372637 - 1 = 2 * (2 * (3 * (3 * (11 * (941))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_941] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_375467 : Nat.Prime 375467 := by
  apply lucasNat 375467 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 375467 - 1 = 2 * (7 * (13 * (2063))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_2063] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_380557 : Nat.Prime 380557 := by
  apply lucasNat 380557 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 380557 - 1 = 2 * (2 * (3 * (3 * (11 * (31 * (31)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_31] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_383839 : Nat.Prime 383839 := by
  apply lucasNat 383839 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 383839 - 1 = 2 * (3 * (7 * (13 * (19 * (37))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_389743 : Nat.Prime 389743 := by
  apply lucasNat 389743 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389743 - 1 = 2 * (3 * (17 * (3821))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_3821] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_389849 : Nat.Prime 389849 := by
  apply lucasNat 389849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389849 - 1 = 2 * (2 * (2 * (48731))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_48731] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_390097 : Nat.Prime 390097 := by
  apply lucasNat 390097 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 390097 - 1 = 2 * (2 * (2 * (2 * (3 * (3 * (3 * (3 * (7 * (43))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_43] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9
  all_goals subst q; decide +kernel
theorem prime_392593 : Nat.Prime 392593 := by
  apply lucasNat 392593 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 392593 - 1 = 2 * (2 * (2 * (2 * (3 * (8179))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_8179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_393853 : Nat.Prime 393853 := by
  apply lucasNat 393853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 393853 - 1 = 2 * (2 * (3 * (23 * (1427)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_1427] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_395849 : Nat.Prime 395849 := by
  apply lucasNat 395849 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 395849 - 1 = 2 * (2 * (2 * (49481))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_49481] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_400837 : Nat.Prime 400837 := by
  apply lucasNat 400837 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 400837 - 1 = 2 * (2 * (3 * (33403))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_33403] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_407299 : Nat.Prime 407299 := by
  apply lucasNat 407299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 407299 - 1 = 2 * (3 * (67883)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67883] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_408461 : Nat.Prime 408461 := by
  apply lucasNat 408461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 408461 - 1 = 2 * (2 * (5 * (13 * (1571)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_1571] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_429899 : Nat.Prime 429899 := by
  apply lucasNat 429899 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 429899 - 1 = 2 * (7 * (30707)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_30707] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_449567 : Nat.Prime 449567 := by
  apply lucasNat 449567 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 449567 - 1 = 2 * (13 * (17291)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_17291] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_449699 : Nat.Prime 449699 := by
  apply lucasNat 449699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 449699 - 1 = 2 * (37 * (59 * (103))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_59, Nat.prime_dvd_prime_iff_eq hq prime_103] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_456523 : Nat.Prime 456523 := by
  apply lucasNat 456523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 456523 - 1 = 2 * (3 * (11 * (6917))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_6917] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_456683 : Nat.Prime 456683 := by
  apply lucasNat 456683 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 456683 - 1 = 2 * (228341) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_228341] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_457679 : Nat.Prime 457679 := by
  apply lucasNat 457679 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 457679 - 1 = 2 * (13 * (29 * (607))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_607] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_474043 : Nat.Prime 474043 := by
  apply lucasNat 474043 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 474043 - 1 = 2 * (3 * (41 * (41 * (47)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_488143 : Nat.Prime 488143 := by
  apply lucasNat 488143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 488143 - 1 = 2 * (3 * (3 * (47 * (577)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_47, Nat.prime_dvd_prime_iff_eq hq prime_577] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_488227 : Nat.Prime 488227 := by
  apply lucasNat 488227 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 488227 - 1 = 2 * (3 * (81371)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_81371] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_495611 : Nat.Prime 495611 := by
  apply lucasNat 495611 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 495611 - 1 = 2 * (5 * (29 * (1709))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_29, Nat.prime_dvd_prime_iff_eq hq prime_1709] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_495701 : Nat.Prime 495701 := by
  apply lucasNat 495701 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 495701 - 1 = 2 * (2 * (5 * (5 * (4957)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_4957] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_501451 : Nat.Prime 501451 := by
  apply lucasNat 501451 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 501451 - 1 = 2 * (3 * (5 * (5 * (3343)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_3343] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_525893 : Nat.Prime 525893 := by
  apply lucasNat 525893 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 525893 - 1 = 2 * (2 * (73 * (1801))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_73, Nat.prime_dvd_prime_iff_eq hq prime_1801] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_554977 : Nat.Prime 554977 := by
  apply lucasNat 554977 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 554977 - 1 = 2 * (2 * (2 * (2 * (2 * (3 * (3 * (41 * (47)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_47] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
theorem prime_576119 : Nat.Prime 576119 := by
  apply lucasNat 576119 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 576119 - 1 = 2 * (19 * (15161)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_15161] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_589159 : Nat.Prime 589159 := by
  apply lucasNat 589159 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 589159 - 1 = 2 * (3 * (3 * (71 * (461)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_71, Nat.prime_dvd_prime_iff_eq hq prime_461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_619139 : Nat.Prime 619139 := by
  apply lucasNat 619139 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 619139 - 1 = 2 * (13 * (23813)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_23813] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_629987 : Nat.Prime 629987 := by
  apply lucasNat 629987 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 629987 - 1 = 2 * (7 * (17 * (2647))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_2647] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_644107 : Nat.Prime 644107 := by
  apply lucasNat 644107 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 644107 - 1 = 2 * (3 * (107351)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_107351] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_646573 : Nat.Prime 646573 := by
  apply lucasNat 646573 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 646573 - 1 = 2 * (2 * (3 * (53881))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53881] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_649277 : Nat.Prime 649277 := by
  apply lucasNat 649277 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 649277 - 1 = 2 * (2 * (37 * (41 * (107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_656221 : Nat.Prime 656221 := by
  apply lucasNat 656221 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 656221 - 1 = 2 * (2 * (3 * (5 * (10937)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_10937] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_659689 : Nat.Prime 659689 := by
  apply lucasNat 659689 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 659689 - 1 = 2 * (2 * (2 * (3 * (27487)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_27487] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_662309 : Nat.Prime 662309 := by
  apply lucasNat 662309 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 662309 - 1 = 2 * (2 * (23 * (23 * (313)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_313] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_690953 : Nat.Prime 690953 := by
  apply lucasNat 690953 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 690953 - 1 = 2 * (2 * (2 * (86369))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_86369] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_737251 : Nat.Prime 737251 := by
  apply lucasNat 737251 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 737251 - 1 = 2 * (3 * (5 * (5 * (5 * (983))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_983] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_754297 : Nat.Prime 754297 := by
  apply lucasNat 754297 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 754297 - 1 = 2 * (2 * (2 * (3 * (53 * (593))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_593] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_768881 : Nat.Prime 768881 := by
  apply lucasNat 768881 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 768881 - 1 = 2 * (2 * (2 * (2 * (5 * (7 * (1373)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_782611 : Nat.Prime 782611 := by
  apply lucasNat 782611 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 782611 - 1 = 2 * (3 * (5 * (19 * (1373)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_19, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_791699 : Nat.Prime 791699 := by
  apply lucasNat 791699 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 791699 - 1 = 2 * (395849) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_395849] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_794041 : Nat.Prime 794041 := by
  apply lucasNat 794041 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 794041 - 1 = 2 * (2 * (2 * (3 * (5 * (13 * (509)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_509] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_839353 : Nat.Prime 839353 := by
  apply lucasNat 839353 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 839353 - 1 = 2 * (2 * (2 * (3 * (41 * (853))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_853] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_859799 : Nat.Prime 859799 := by
  apply lucasNat 859799 13 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 859799 - 1 = 2 * (429899) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_429899] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_865049 : Nat.Prime 865049 := by
  apply lucasNat 865049 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 865049 - 1 = 2 * (2 * (2 * (108131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_108131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_898153 : Nat.Prime 898153 := by
  apply lucasNat 898153 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 898153 - 1 = 2 * (2 * (2 * (3 * (37423)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_37423] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_929647 : Nat.Prime 929647 := by
  apply lucasNat 929647 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 929647 - 1 = 2 * (3 * (3 * (51647))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_51647] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_941879 : Nat.Prime 941879 := by
  apply lucasNat 941879 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 941879 - 1 = 2 * (7 * (7 * (7 * (1373)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1373] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_976853 : Nat.Prime 976853 := by
  apply lucasNat 976853 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 976853 - 1 = 2 * (2 * (103 * (2371))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_103, Nat.prime_dvd_prime_iff_eq hq prime_2371] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_987803 : Nat.Prime 987803 := by
  apply lucasNat 987803 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 987803 - 1 = 2 * (17 * (17 * (1709))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_1709] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_991223 : Nat.Prime 991223 := by
  apply lucasNat 991223 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 991223 - 1 = 2 * (495611) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_495611] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem prime_1013921 : Nat.Prime 1013921 := by
  apply lucasNat 1013921 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1013921 - 1 = 2 * (2 * (2 * (2 * (2 * (5 * (6337)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_6337] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1014779 : Nat.Prime 1014779 := by
  apply lucasNat 1014779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1014779 - 1 = 2 * (89 * (5701)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_5701] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1022611 : Nat.Prime 1022611 := by
  apply lucasNat 1022611 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1022611 - 1 = 2 * (3 * (5 * (89 * (383)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_89, Nat.prime_dvd_prime_iff_eq hq prime_383] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem prime_1033189 : Nat.Prime 1033189 := by
  apply lucasNat 1033189 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1033189 - 1 = 2 * (2 * (3 * (13 * (37 * (179))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_37, Nat.prime_dvd_prime_iff_eq hq prime_179] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1036681 : Nat.Prime 1036681 := by
  apply lucasNat 1036681 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1036681 - 1 = 2 * (2 * (2 * (3 * (5 * (53 * (163)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_53, Nat.prime_dvd_prime_iff_eq hq prime_163] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1105261 : Nat.Prime 1105261 := by
  apply lucasNat 1105261 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1105261 - 1 = 2 * (2 * (3 * (5 * (13 * (13 * (109)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_109] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem prime_1107773 : Nat.Prime 1107773 := by
  apply lucasNat 1107773 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1107773 - 1 = 2 * (2 * (23 * (12041))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_23, Nat.prime_dvd_prime_iff_eq hq prime_12041] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1111933 : Nat.Prime 1111933 := by
  apply lucasNat 1111933 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1111933 - 1 = 2 * (2 * (3 * (3 * (67 * (461))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_67, Nat.prime_dvd_prime_iff_eq hq prime_461] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1137137 : Nat.Prime 1137137 := by
  apply lucasNat 1137137 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1137137 - 1 = 2 * (2 * (2 * (2 * (7 * (11 * (13 * (71))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_13, Nat.prime_dvd_prime_iff_eq hq prime_71] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem prime_1154561 : Nat.Prime 1154561 := by
  apply lucasNat 1154561 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1154561 - 1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (2 * (5 * (11 * (41))))))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_11, Nat.prime_dvd_prime_iff_eq hq prime_41] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8 | h9 | h10 | h11
  all_goals subst q; decide +kernel
theorem prime_1187111 : Nat.Prime 1187111 := by
  apply lucasNat 1187111 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1187111 - 1 = 2 * (5 * (17 * (6983))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_17, Nat.prime_dvd_prime_iff_eq hq prime_6983] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem prime_1193047 : Nat.Prime 1193047 := by
  apply lucasNat 1193047 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1193047 - 1 = 2 * (3 * (198841)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_198841] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1197037 : Nat.Prime 1197037 := by
  apply lucasNat 1197037 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1197037 - 1 = 2 * (2 * (3 * (3 * (41 * (811))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_41, Nat.prime_dvd_prime_iff_eq hq prime_811] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1204421 : Nat.Prime 1204421 := by
  apply lucasNat 1204421 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1204421 - 1 = 2 * (2 * (5 * (7 * (7 * (1229))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_5, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_1229] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem prime_1226783 : Nat.Prime 1226783 := by
  apply lucasNat 1226783 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1226783 - 1 = 2 * (167 * (3673)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_167, Nat.prime_dvd_prime_iff_eq hq prime_3673] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem prime_1249627 : Nat.Prime 1249627 := by
  apply lucasNat 1249627 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 1249627 - 1 = 2 * (3 * (7 * (29753))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_7, Nat.prime_dvd_prime_iff_eq hq prime_29753] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
end FiniteP0N1024
