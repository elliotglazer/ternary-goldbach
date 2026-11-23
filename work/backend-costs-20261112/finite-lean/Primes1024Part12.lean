import Primes1024Part11
set_option maxRecDepth 65536
set_option maxHeartbeats 0
namespace FiniteP0N1024
theorem prime_3999999988766605309 : Nat.Prime 3999999988766605309 := by
  apply lucasNat 3999999988766605309 7 (by decide) (by decide +kernel)
  intro q hq hd
  rw [show 3999999988766605309 - 1 = 2 * (2 * (3 * (1939493 * (171866220913)))) by decide] at hd
  simp only [Nat.Prime.dvd_mul hq, Nat.prime_dvd_prime_iff_eq hq prime_2, Nat.prime_dvd_prime_iff_eq hq prime_3, Nat.prime_dvd_prime_iff_eq hq prime_1939493, Nat.prime_dvd_prime_iff_eq hq prime_171866220913] at hd
  rcases hd with h0 | h1 | h2 | h3 | h4
  all_goals subst q; decide +kernel
end FiniteP0N1024
