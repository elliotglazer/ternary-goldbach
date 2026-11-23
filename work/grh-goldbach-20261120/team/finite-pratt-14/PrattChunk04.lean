import PrattChunk03
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p2141 : Nat.Prime 2141 := by
  apply lucasNat 2141 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2141-1 = 2 * (2 * (5 * (107))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2347 : Nat.Prime 2347 := by
  apply lucasNat 2347 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2347-1 = 2 * (3 * (17 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2371 : Nat.Prime 2371 := by
  apply lucasNat 2371 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2371-1 = 2 * (3 * (5 * (79))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p79] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2383 : Nat.Prime 2383 := by
  apply lucasNat 2383 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2383-1 = 2 * (3 * (397)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p397] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p2417 : Nat.Prime 2417 := by
  apply lucasNat 2417 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2417-1 = 2 * (2 * (2 * (2 * (151)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p151] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p2647 : Nat.Prime 2647 := by
  apply lucasNat 2647 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2647-1 = 2 * (3 * (3 * (3 * (7 * (7))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p2677 : Nat.Prime 2677 := by
  apply lucasNat 2677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2677-1 = 2 * (2 * (3 * (223))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p223] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p2741 : Nat.Prime 2741 := by
  apply lucasNat 2741 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 2741-1 = 2 * (2 * (5 * (137))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p137] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3011 : Nat.Prime 3011 := by
  apply lucasNat 3011 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3011-1 = 2 * (5 * (7 * (43))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3083 : Nat.Prime 3083 := by
  apply lucasNat 3083 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3083-1 = 2 * (23 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p23, Nat.prime_dvd_prime_iff_eq hq p67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3221 : Nat.Prime 3221 := by
  apply lucasNat 3221 10 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3221-1 = 2 * (2 * (5 * (7 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p3449 : Nat.Prime 3449 := by
  apply lucasNat 3449 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3449-1 = 2 * (2 * (2 * (431))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p431] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3499 : Nat.Prime 3499 := by
  apply lucasNat 3499 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3499-1 = 2 * (3 * (11 * (53))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p53] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p3559 : Nat.Prime 3559 := by
  apply lucasNat 3559 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3559-1 = 2 * (3 * (593)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p593] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p3709 : Nat.Prime 3709 := by
  apply lucasNat 3709 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3709-1 = 2 * (2 * (3 * (3 * (103)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p103] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p3917 : Nat.Prime 3917 := by
  apply lucasNat 3917 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3917-1 = 2 * (2 * (11 * (89))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p89] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p4013 : Nat.Prime 4013 := by
  apply lucasNat 4013 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4013-1 = 2 * (2 * (17 * (59))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p17, Nat.prime_dvd_prime_iff_eq hq p59] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p4211 : Nat.Prime 4211 := by
  apply lucasNat 4211 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4211-1 = 2 * (5 * (421)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p421] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p4373 : Nat.Prime 4373 := by
  apply lucasNat 4373 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4373-1 = 2 * (2 * (1093)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1093] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p4409 : Nat.Prime 4409 := by
  apply lucasNat 4409 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4409-1 = 2 * (2 * (2 * (19 * (29)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p19, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p4457 : Nat.Prime 4457 := by
  apply lucasNat 4457 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4457-1 = 2 * (2 * (2 * (557))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p557] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p4493 : Nat.Prime 4493 := by
  apply lucasNat 4493 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 4493-1 = 2 * (2 * (1123)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p1123] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p5011 : Nat.Prime 5011 := by
  apply lucasNat 5011 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5011-1 = 2 * (3 * (5 * (167))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p167] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p5483 : Nat.Prime 5483 := by
  apply lucasNat 5483 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5483-1 = 2 * (2741) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p2741] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p5779 : Nat.Prime 5779 := by
  apply lucasNat 5779 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 5779-1 = 2 * (3 * (3 * (3 * (107)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p6131 : Nat.Prime 6131 := by
  apply lucasNat 6131 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6131-1 = 2 * (5 * (613)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p613] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6143 : Nat.Prime 6143 := by
  apply lucasNat 6143 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6143-1 = 2 * (37 * (83)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p37, Nat.prime_dvd_prime_iff_eq hq p83] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6203 : Nat.Prime 6203 := by
  apply lucasNat 6203 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6203-1 = 2 * (7 * (443)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p443] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6263 : Nat.Prime 6263 := by
  apply lucasNat 6263 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6263-1 = 2 * (31 * (101)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p31, Nat.prime_dvd_prime_iff_eq hq p101] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6299 : Nat.Prime 6299 := by
  apply lucasNat 6299 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6299-1 = 2 * (47 * (67)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p47, Nat.prime_dvd_prime_iff_eq hq p67] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6367 : Nat.Prime 6367 := by
  apply lucasNat 6367 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6367-1 = 2 * (3 * (1061)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p1061] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p6427 : Nat.Prime 6427 := by
  apply lucasNat 6427 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6427-1 = 2 * (3 * (3 * (3 * (7 * (17))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p6551 : Nat.Prime 6551 := by
  apply lucasNat 6551 17 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 6551-1 = 2 * (5 * (5 * (131))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p7489 : Nat.Prime 7489 := by
  apply lucasNat 7489 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 7489-1 = 2 * (2 * (2 * (2 * (2 * (2 * (3 * (3 * (13)))))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6 | h7 | h8
  all_goals subst q; decide +kernel
end Pratt14
