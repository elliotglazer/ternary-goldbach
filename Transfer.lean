module

public import Assembly

@[expose] public section


namespace GrhGoldbach.LocalAssembly

/-- Transfer the fixed-width real prime interval to odd ternary
representations through 10^27. The binary premise is the expansion
of the pinned project's BinaryGoldbachUpTo (4·10^15). -/
theorem ternary_of_interval_and_binary
    (hinterval : ∀ {x : ℝ}, 1e15 ≤ x → x ≤ 1e27 →
      ∃ p : ℕ, p.Prime ∧ x - 4000000000000000 + 4 < p ∧ (p : ℝ) ≤ x)
    (hbinary : ∀ m : ℕ, Even m → 4 ≤ m → m ≤ 4000000000000000 →
      ∃ p q : ℕ, p.Prime ∧ q.Prime ∧ p + q = m)
    (n : ℕ) (hn : Odd n) (hlo : 5 < n) (hhi : n ≤ 10^27) :
    ∃ p q r : ℕ, p.Prime ∧ q.Prime ∧ r.Prime ∧ p + q + r = n := by
  by_cases hsmall : n ≤ 4000000000000003
  · have heven : Even (n-3) := Nat.Odd.sub_odd hn (by decide)
    obtain ⟨p,q,hp,hq,hpq⟩ := hbinary (n-3) heven (by obtain ⟨k,hk⟩ := hn; omega) (by omega)
    exact ⟨3,p,q,Nat.prime_three,hp,hq,by omega⟩
  · let x : ℝ := (n:ℝ) - 4
    have hn' : (4000000000000003:ℝ) < n := by exact_mod_cast lt_of_not_ge hsmall
    have hhi' : (n:ℝ) ≤ 10^27 := by exact_mod_cast hhi
    obtain ⟨p,hp,hl,hu⟩ := hinterval (x := x) (by dsimp [x]; linarith only [hn'])
      (by dsimp [x]; linarith only [hhi'])
    dsimp [x] at hl hu
    have hp4 : p + 4 ≤ n := by exact_mod_cast (show (p:ℝ) + 4 ≤ n by linarith only [hu])
    have hpB : n < p + 4000000000000000 := by
      exact_mod_cast (show (n:ℝ) < p + 4000000000000000 by linarith only [hl])
    obtain ⟨q,r,hq,hr,hqr⟩ := hbinary (n-p) (Nat.Odd.sub_odd hn (hp.odd_of_ne_two (by omega)))
      (by omega) (by omega)
    exact ⟨p,q,r,hp,hq,hr,by omega⟩

#print axioms ternary_of_interval_and_binary
end GrhGoldbach.LocalAssembly
