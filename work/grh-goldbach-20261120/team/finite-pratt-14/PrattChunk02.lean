import PrattChunk01
namespace Pratt14
set_option maxRecDepth 20000
set_option maxHeartbeats 0
theorem p419 : Nat.Prime 419 := by
  apply lucasNat 419 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 419-1 = 2 * (11 * (19)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p421 : Nat.Prime 421 := by
  apply lucasNat 421 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 421-1 = 2 * (2 * (3 * (5 * (7)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p431 : Nat.Prime 431 := by
  apply lucasNat 431 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 431-1 = 2 * (5 * (43)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p43] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p439 : Nat.Prime 439 := by
  apply lucasNat 439 15 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 439-1 = 2 * (3 * (73)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p73] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p443 : Nat.Prime 443 := by
  apply lucasNat 443 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 443-1 = 2 * (13 * (17)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p449 : Nat.Prime 449 := by
  apply lucasNat 449 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 449-1 = 2 * (2 * (2 * (2 * (2 * (2 * (7)))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5 | h6
  all_goals subst q; decide +kernel
theorem p461 : Nat.Prime 461 := by
  apply lucasNat 461 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 461-1 = 2 * (2 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p463 : Nat.Prime 463 := by
  apply lucasNat 463 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 463-1 = 2 * (3 * (7 * (11))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p491 : Nat.Prime 491 := by
  apply lucasNat 491 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 491-1 = 2 * (5 * (7 * (7))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p7] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p503 : Nat.Prime 503 := by
  apply lucasNat 503 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 503-1 = 2 * (251) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p251] at hd
  rcases hd with h0 | h1
  all_goals subst q; decide +kernel
theorem p509 : Nat.Prime 509 := by
  apply lucasNat 509 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 509-1 = 2 * (2 * (127)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p127] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p521 : Nat.Prime 521 := by
  apply lucasNat 521 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 521-1 = 2 * (2 * (2 * (5 * (13)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p523 : Nat.Prime 523 := by
  apply lucasNat 523 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 523-1 = 2 * (3 * (3 * (29))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p29] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p541 : Nat.Prime 541 := by
  apply lucasNat 541 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 541-1 = 2 * (2 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p557 : Nat.Prime 557 := by
  apply lucasNat 557 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 557-1 = 2 * (2 * (139)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p139] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p569 : Nat.Prime 569 := by
  apply lucasNat 569 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 569-1 = 2 * (2 * (2 * (71))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p71] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p571 : Nat.Prime 571 := by
  apply lucasNat 571 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 571-1 = 2 * (3 * (5 * (19))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p19] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p593 : Nat.Prime 593 := by
  apply lucasNat 593 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 593-1 = 2 * (2 * (2 * (2 * (37)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p37] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p613 : Nat.Prime 613 := by
  apply lucasNat 613 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 613-1 = 2 * (2 * (3 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p643 : Nat.Prime 643 := by
  apply lucasNat 643 11 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 643-1 = 2 * (3 * (107)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p107] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p659 : Nat.Prime 659 := by
  apply lucasNat 659 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 659-1 = 2 * (7 * (47)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p47] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p661 : Nat.Prime 661 := by
  apply lucasNat 661 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 661-1 = 2 * (2 * (3 * (5 * (11)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p677 : Nat.Prime 677 := by
  apply lucasNat 677 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 677-1 = 2 * (2 * (13 * (13))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p13] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p683 : Nat.Prime 683 := by
  apply lucasNat 683 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 683-1 = 2 * (11 * (31)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p11, Nat.prime_dvd_prime_iff_eq hq p31] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p691 : Nat.Prime 691 := by
  apply lucasNat 691 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 691-1 = 2 * (3 * (5 * (23))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p733 : Nat.Prime 733 := by
  apply lucasNat 733 6 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 733-1 = 2 * (2 * (3 * (61))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p61] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
theorem p743 : Nat.Prime 743 := by
  apply lucasNat 743 5 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 743-1 = 2 * (7 * (53)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p7, Nat.prime_dvd_prime_iff_eq hq p53] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p751 : Nat.Prime 751 := by
  apply lucasNat 751 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 751-1 = 2 * (3 * (5 * (5 * (5)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p787 : Nat.Prime 787 := by
  apply lucasNat 787 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 787-1 = 2 * (3 * (131)) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p131] at hd
  rcases hd with h0 | h1 | h2
  all_goals subst q; decide +kernel
theorem p811 : Nat.Prime 811 := by
  apply lucasNat 811 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 811-1 = 2 * (3 * (3 * (3 * (3 * (5))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p5] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p829 : Nat.Prime 829 := by
  apply lucasNat 829 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 829-1 = 2 * (2 * (3 * (3 * (23)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p23] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p881 : Nat.Prime 881 := by
  apply lucasNat 881 3 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 881-1 = 2 * (2 * (2 * (2 * (5 * (11))))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p11] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4 | h5
  all_goals subst q; decide +kernel
theorem p919 : Nat.Prime 919 := by
  apply lucasNat 919 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 919-1 = 2 * (3 * (3 * (3 * (17)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p3, Nat.prime_dvd_prime_iff_eq hq p17] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
theorem p941 : Nat.Prime 941 := by
  apply lucasNat 941 2 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 941-1 = 2 * (2 * (5 * (47))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq p2, Nat.prime_dvd_prime_iff_eq hq p5, Nat.prime_dvd_prime_iff_eq hq p47] at hd
  rcases hd with h0 | h1 | h2 | h3
  all_goals subst q; decide +kernel
end Pratt14
