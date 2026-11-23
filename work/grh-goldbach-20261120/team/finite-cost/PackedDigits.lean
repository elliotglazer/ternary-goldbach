import Init

/-! Soundness of the high-bit positivity test used in the packed Goldbach checker. -/

namespace Goldbach.Packed

/-- Evaluate the first `len` coefficients in radix `2^k`, lowest digit first. -/
def pack (k : Nat) : Nat → (Nat → Nat) → Nat
  | 0, _ => 0
  | n + 1, f => 2 ^ k * pack k n (fun j => f (j + 1)) + f 0

theorem pack_add (k n : Nat) (f g : Nat → Nat) :
    pack k n (fun j => f j + g j) = pack k n f + pack k n g := by
  induction n generalizing f g with
  | zero => rfl
  | succ n ih =>
    simp only [pack, ih (fun j => f (j+1)) (fun j => g (j+1)), Nat.mul_add]
    omega

/-- Bounded coefficients keep their individual bits after packing. -/
theorem pack_testBit (k n : Nat) (f : Nat → Nat) (i b : Nat)
    (hi : i < n) (hb : b < k) (hf : ∀ j < n, f j < 2 ^ k) :
    (pack k n f).testBit (k * i + b) = (f i).testBit b := by
  induction n generalizing f i with
  | zero => omega
  | succ n ih =>
    rw [pack, Nat.testBit_two_pow_mul_add _ (hf 0 (by omega))]
    cases i with
    | zero => simp [hb]
    | succ i =>
      rw [Nat.mul_succ, ite_eq_right (by omega)]
      have hi' : k * i + k + b - k = k * i + b := by omega
      rw [hi']
      exact ih (fun j => f (j + 1)) i (by omega) (fun j hj => hf _ (by omega))

/-- Add `2^b - 1` to each designated coefficient and mask its high bit.
Success proves positivity of every designated coefficient. -/
theorem positive_of_add_mask (n b : Nat) (coeff : Nat → Nat) (target : Nat → Bool)
    (hc : ∀ j < n, coeff j ≤ 2 ^ b)
    (check : (pack (b+1) n coeff + pack (b+1) n (fun j => if target j then 2^b-1 else 0)) &&&
        pack (b+1) n (fun j => if target j then 2^b else 0)
      = pack (b+1) n (fun j => if target j then 2^b else 0)) :
    ∀ j < n, target j = true → 0 < coeff j := by
  let high : Nat → Nat := fun j => if target j then 2^b else 0
  let pad : Nat → Nat := fun j => if target j then 2^b-1 else 0
  change (pack (b+1) n coeff + pack (b+1) n pad) &&& pack (b+1) n high =
    pack (b+1) n high at check
  have hpow := Nat.two_pow_pos b
  have hh : ∀ j < n, high j < 2^(b+1) := by
    intro j hj
    simp only [high, Nat.pow_succ]
    split <;> omega
  have hs : ∀ j < n, coeff j + pad j < 2^(b+1) := by
    intro j hj
    have := hc j hj
    simp only [pad, Nat.pow_succ]
    split <;> omega
  intro j hj ht
  rw [← pack_add] at check
  have bits := congrArg (fun v : Nat => v.testBit ((b+1)*j+b)) check
  change ((pack (b+1) n (fun j => coeff j + pad j) &&& pack (b+1) n high).testBit _) =
    (pack (b+1) n high).testBit _ at bits
  rw [Nat.testBit_and, pack_testBit _ _ _ _ _ hj (by omega) hs,
    pack_testBit _ _ _ _ _ hj (by omega) hh] at bits
  simp [high, pad, ht] at bits
  have := Nat.ge_two_pow_of_testBit bits
  omega

theorem pack_zero (k n : Nat) : pack k n (fun _ => 0) = 0 := by
  induction n with
  | zero => rfl
  | succ n ih => simp [pack, ih]

theorem pack_extend_zero (k n extra : Nat) (f : Nat → Nat) (hf : ∀ j, n ≤ j → f j = 0) :
    pack k (n + extra) f = pack k n f := by
  induction n generalizing f with
  | zero =>
    have hz : f = fun _ => 0 := funext fun j => hf j (Nat.zero_le _)
    simp [hz, pack_zero, pack]
  | succ n ih =>
    rw [show n + 1 + extra = (n + extra) + 1 by omega]
    simp only [pack]
    rw [ih (fun j => f (j+1)) (fun j hj => hf _ (by omega))]

def shifted (offset : Nat) (f : Nat → Nat) (j : Nat) : Nat :=
  if offset ≤ j then f (j-offset) else 0

theorem pack_shifted (k t n : Nat) (f : Nat → Nat) :
    pack k (n+t) (shifted t f) = (2^k)^t * pack k n f := by
  induction t with
  | zero =>
    have h : shifted 0 f = f := funext (fun j => by simp [shifted])
    simp [h]
  | succ t ih =>
    have next : (fun j => shifted (t+1) f (j+1)) = shifted t f := by
      funext j
      simp [shifted]
    rw [Nat.add_succ, pack, next, ih]
    simp [shifted, Nat.pow_succ, Nat.mul_comm, Nat.mul_assoc]

def anchorPolynomial (k : Nat) : List Nat → Nat
  | [] => 0
  | t :: ts => (2^k)^t + anchorPolynomial k ts

def coefficient (f : Nat → Nat) : List Nat → Nat → Nat
  | [], _ => 0
  | t :: ts, j => shifted t f j + coefficient f ts j

/-- The product is the radix expansion of the counts, including all leading,
interior, and trailing coefficients. This identity also allows repeated offsets. -/
theorem product_eq_pack (k len maxOffset : Nat) (offsets : List Nat) (f : Nat → Nat)
    (hf : ∀ j, len ≤ j → f j = 0) (ho : ∀ t ∈ offsets, t ≤ maxOffset) :
    pack k len f * anchorPolynomial k offsets =
      pack k (len + maxOffset) (coefficient f offsets) := by
  induction offsets with
  | nil => simp [anchorPolynomial, coefficient, pack_zero]
  | cons t ts ih =>
    have ht := ho t List.mem_cons_self
    have shift : pack k (len + maxOffset) (shifted t f) = (2^k)^t * pack k len f := by
      rw [show len + maxOffset = (len + (maxOffset - t)) + t by omega,
        pack_shifted, pack_extend_zero _ _ _ _ hf]
    change pack k len f * ((2^k)^t + anchorPolynomial k ts) =
      pack k (len+maxOffset) (fun j => shifted t f j + coefficient f ts j)
    rw [pack_add, shift, Nat.mul_add, Nat.mul_comm (pack k len f) ((2^k)^t),
      ih (fun d hd => ho d (List.mem_cons_of_mem t hd))]

theorem coefficient_le_length (ts : List Nat) (f : Nat → Nat) (hf : ∀ j, f j ≤ 1) (j : Nat) :
    coefficient f ts j ≤ ts.length := by
  induction ts with
  | nil => simp [coefficient]
  | cons t ts ih =>
    simp only [coefficient, List.length_cons]
    have h : shifted t f j ≤ 1 := by
      unfold shifted
      split
      · exact hf _
      · decide
    omega

theorem witness_of_coefficient_pos (ts : List Nat) (f : Nat → Nat) (j : Nat)
    (h : 0 < coefficient f ts j) : ∃ t ∈ ts, t ≤ j ∧ 0 < f (j-t) := by
  induction ts with
  | nil => simp [coefficient] at h
  | cons t ts ih =>
    by_cases hpos : 0 < shifted t f j
    · unfold shifted at hpos
      split at hpos
      · exact ⟨t, List.mem_cons_self, by assumption, hpos⟩
      · omega
    · simp only [coefficient] at h
      obtain ⟨d, hd, hdj, hp⟩ := ih (by omega)
      exact ⟨d, List.mem_cons_of_mem t hd, hdj, hp⟩

/-- A successful packed product check produces an actual source witness at
every target. The numeric operands are the source, anchors, additive pad, and
high mask. A source digit is allowed to be either zero or one. -/
theorem witness_of_packed_product (b len maxOffset : Nat) (offsets : List Nat)
    (source : Nat → Nat) (target : Nat → Bool)
    (hzero : ∀ j, len ≤ j → source j = 0) (hbit : ∀ j, source j ≤ 1)
    (hoff : ∀ t ∈ offsets, t ≤ maxOffset) (hcount : offsets.length ≤ 2^b)
    (check : (pack (b+1) len source * anchorPolynomial (b+1) offsets +
        pack (b+1) (len+maxOffset) (fun j => if target j then 2^b-1 else 0)) &&&
        pack (b+1) (len+maxOffset) (fun j => if target j then 2^b else 0) =
        pack (b+1) (len+maxOffset) (fun j => if target j then 2^b else 0)) :
    ∀ j < len + maxOffset, target j = true → ∃ t ∈ offsets, t ≤ j ∧ 0 < source (j-t) := by
  rw [product_eq_pack _ _ _ _ _ hzero hoff] at check
  intro j hj ht
  apply witness_of_coefficient_pos
  exact positive_of_add_mask _ _ _ target
    (fun i _ => Nat.le_trans (coefficient_le_length offsets source hbit i) hcount)
    check j hj ht

end Goldbach.Packed
