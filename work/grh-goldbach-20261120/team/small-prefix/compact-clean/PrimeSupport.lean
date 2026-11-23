import Mathlib.NumberTheory.LucasPrimality
import Mathlib.Data.ZMod.Basic

theorem lucasNat (p a : Nat) (hp : 1 < p)
    (ha : Nat.powMod a (p - 1) p = 1)
    (hd : ∀ q : Nat, q.Prime → q ∣ p - 1 → Nat.powMod a ((p - 1) / q) p ≠ 1) :
    p.Prime := by
  have heq (e : Nat) : (a : ZMod p) ^ e = 1 ↔ Nat.powMod a e p = 1 := by
    rw [← Nat.cast_pow, ← Nat.cast_one, ZMod.natCast_eq_natCast_iff',
      ← Nat.powMod_def, Nat.mod_eq_of_lt hp]
  exact lucas_primality p (a : ZMod p) ((heq _).mpr ha)
    (fun q hq hqd hz => hd q hq hqd ((heq _).mp hz))

#print axioms lucasNat
