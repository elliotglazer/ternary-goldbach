import PrattChunk00
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p149 : Nat.Prime 149 := by
  apply lucasNat 149 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 149-1 = 2 * (2 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p151 : Nat.Prime 151 := by
  apply lucasNat 151 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 151-1 = 2 * (3 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p157 : Nat.Prime 157 := by
  apply lucasNat 157 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 157-1 = 2 * (2 * (3 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p163 : Nat.Prime 163 := by
  apply lucasNat 163 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 163-1 = 2 * (3 * (3 * (3 * (3)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p167 : Nat.Prime 167 := by
  apply lucasNat 167 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 167-1 = 2 * (83) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p173 : Nat.Prime 173 := by
  apply lucasNat 173 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 173-1 = 2 * (2 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p179 : Nat.Prime 179 := by
  apply lucasNat 179 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 179-1 = 2 * (89) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p89] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p181 : Nat.Prime 181 := by
  apply lucasNat 181 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 181-1 = 2 * (2 * (3 * (3 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p191 : Nat.Prime 191 := by
  apply lucasNat 191 19 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 191-1 = 2 * (5 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p193 : Nat.Prime 193 := by
  apply lucasNat 193 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 193-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p197 : Nat.Prime 197 := by
  apply lucasNat 197 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 197-1 = 2 * (2 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p199 : Nat.Prime 199 := by
  apply lucasNat 199 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 199-1 = 2 * (3 * (3 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p211 : Nat.Prime 211 := by
  apply lucasNat 211 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 211-1 = 2 * (3 * (5 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p223 : Nat.Prime 223 := by
  apply lucasNat 223 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 223-1 = 2 * (3 * (37)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p227 : Nat.Prime 227 := by
  apply lucasNat 227 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 227-1 = 2 * (113) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p113] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p233 : Nat.Prime 233 := by
  apply lucasNat 233 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 233-1 = 2 * (2 * (2 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p241 : Nat.Prime 241 := by
  apply lucasNat 241 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 241-1 = 2 * (2 * (2 * (2 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p251 : Nat.Prime 251 := by
  apply lucasNat 251 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 251-1 = 2 * (5 * (5 * (5))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p257 : Nat.Prime 257 := by
  apply lucasNat 257 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 257-1 = 2 * (2 * (2 * (2 * (2 * (2 * (2 * (2))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7
  all_goals subst q; decide +kernel
theorem p263 : Nat.Prime 263 := by
  apply lucasNat 263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 263-1 = 2 * (131) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p269 : Nat.Prime 269 := by
  apply lucasNat 269 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 269-1 = 2 * (2 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p277 : Nat.Prime 277 := by
  apply lucasNat 277 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 277-1 = 2 * (2 * (3 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p283 : Nat.Prime 283 := by
  apply lucasNat 283 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 283-1 = 2 * (3 * (47)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p47] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p293 : Nat.Prime 293 := by
  apply lucasNat 293 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 293-1 = 2 * (2 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p307 : Nat.Prime 307 := by
  apply lucasNat 307 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 307-1 = 2 * (3 * (3 * (17))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p311 : Nat.Prime 311 := by
  apply lucasNat 311 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 311-1 = 2 * (5 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p313 : Nat.Prime 313 := by
  apply lucasNat 313 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 313-1 = 2 * (2 * (2 * (3 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p317 : Nat.Prime 317 := by
  apply lucasNat 317 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 317-1 = 2 * (2 * (79)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p331 : Nat.Prime 331 := by
  apply lucasNat 331 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 331-1 = 2 * (3 * (5 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p337 : Nat.Prime 337 := by
  apply lucasNat 337 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 337-1 = 2 * (2 * (2 * (2 * (3 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p367 : Nat.Prime 367 := by
  apply lucasNat 367 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 367-1 = 2 * (3 * (61)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p373 : Nat.Prime 373 := by
  apply lucasNat 373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 373-1 = 2 * (2 * (3 * (31))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p389 : Nat.Prime 389 := by
  apply lucasNat 389 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 389-1 = 2 * (2 * (97)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p97] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p397 : Nat.Prime 397 := by
  apply lucasNat 397 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 397-1 = 2 * (2 * (3 * (3 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
end Pratt14
