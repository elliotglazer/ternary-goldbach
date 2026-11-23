import PrimeBitmap
import Mathlib.Data.List.Prime

namespace BatchPrime

inductive Tree where
  | empty
  | node (left : Tree) (prime base : Nat) (factors : List Nat) (right : Tree)

def contains (p : Nat) : Tree → Bool
  | .empty => false
  | .node l q _ _ r => if p = q then true else if p < q then contains p l else contains p r

def nodeValid (tree : Tree) (p a : Nat) (fs : List Nat) : Bool :=
  if p = 2 then true else
    decide (1 < p) && (fs.prod == p - 1) &&
    fs.all (fun q => decide (q < p) && contains q tree) &&
    (Nat.powMod a (p - 1) p == 1) &&
    fs.all (fun q => decide (Nat.powMod a ((p - 1) / q) p ≠ 1))

def treeValid (full : Tree) : Tree → Bool
  | .empty => true
  | .node l p a fs r => treeValid full l && (nodeValid full p a fs && treeValid full r)

theorem treeValid_node {full l r : Tree} {p a : Nat} {fs : List Nat}
    (hl : treeValid full l = true) (hn : nodeValid full p a fs = true)
    (hr : treeValid full r = true) : treeValid full (.node l p a fs r) = true := by
  simp only [treeValid, hl, hn, hr, Bool.and_true]

theorem nodeValid_eq_true {tree : Tree} {p a : Nat} {fs : List Nat} :
    nodeValid tree p a fs = true ↔
      p = 2 ∨ (1 < p ∧ fs.prod = p - 1 ∧
        (∀ q ∈ fs, q < p ∧ contains q tree = true) ∧
        Nat.powMod a (p - 1) p = 1 ∧
        ∀ q ∈ fs, Nat.powMod a ((p - 1) / q) p ≠ 1) := by
  by_cases hp : p = 2 <;> simp [nodeValid, hp, List.all_eq_true, and_assoc]

theorem contains_valid {full tree : Tree} {p : Nat}
    (hv : treeValid full tree = true) (hm : contains p tree = true) :
    ∃ a fs, nodeValid full p a fs = true := by
  induction tree with
  | empty => simp only [contains, Bool.false_eq_true] at hm
  | node l q a fs r ihl ihr =>
    simp only [treeValid, Bool.and_eq_true] at hv
    obtain ⟨hl, hn, hr⟩ := hv
    simp only [contains] at hm
    split at hm
    · rename_i heq
      subst p
      exact ⟨a, fs, hn⟩
    · split at hm
      · exact ihl hl hm
      · exact ihr hr hm

theorem nodeValid_prime : ∀ p full a fs,
    treeValid full full = true → nodeValid full p a fs = true → p.Prime := by
  intro p
  induction p using Nat.strong_induction_on with
  | h p ih =>
    intro full a fs hv hn
    rcases nodeValid_eq_true.mp hn with hp | ⟨hp, hprod, hknown, hpow, hmods⟩
    · subst p
      exact Nat.prime_two
    · have hfs : ∀ q ∈ fs, q.Prime := by
        intro q hq
        obtain ⟨hq_lt, hq_mem⟩ := hknown q hq
        obtain ⟨b, gs, hq_valid⟩ := contains_valid hv hq_mem
        exact ih q hq_lt full b gs hv hq_valid
      apply lucasNat p a hp hpow
      intro q hq hd
      have hqmem : q ∈ fs := mem_list_primes_of_dvd_prod
        (Nat.prime_iff.mp hq) (fun r hr => Nat.prime_iff.mp (hfs r hr))
        (hprod.symm ▸ hd)
      exact hmods q hqmem

theorem contains_prime {tree : Tree} {p : Nat}
    (hv : treeValid tree tree = true) (hm : contains p tree = true) : p.Prime := by
  obtain ⟨a, fs, hn⟩ := contains_valid hv hm
  exact nodeValid_prime p tree a fs hv hn

def rootsKnown (tree : Tree) (ps : List Nat) : Bool := ps.all (fun p => contains p tree)

theorem rootsKnown_sound {tree : Tree} {ps : List Nat}
    (hv : treeValid tree tree = true) (hr : rootsKnown tree ps = true) :
    ∀ p ∈ ps, p.Prime := by
  intro p hp
  exact contains_prime hv ((List.all_eq_true.mp hr) p hp)

def checkedCover (target : Nat) (tree : Tree) : List (Nat × Nat) → Bool
  | [] => true
  | (p, q) :: ws => (p + q == target) && (contains p tree &&
      (contains q tree && checkedCover (target + 2) tree ws))

theorem checkedCover_sound {tree : Tree} (hv : treeValid tree tree = true) :
    ∀ ws target, checkedCover target tree ws = true →
      ∀ j < ws.length, PrimeCoverage.BinaryGoldbach (target + 2 * j) := by
  intro ws
  induction ws with
  | nil => simp only [List.length_nil, Nat.not_lt_zero, IsEmpty.forall_iff, implies_true]
  | cons pair ws ih =>
    obtain ⟨p, q⟩ := pair
    intro target hc j hj
    simp only [checkedCover, Bool.and_eq_true, beq_iff_eq] at hc
    obtain ⟨hsum, hp, hq, htail⟩ := hc
    cases j with
    | zero =>
      simp only [Nat.mul_zero, Nat.add_zero]
      exact ⟨p, q, contains_prime hv hp, contains_prime hv hq, hsum⟩
    | succ j =>
      have hj' : j < ws.length := by simpa only [List.length_cons, Nat.succ_lt_succ_iff] using hj
      have heq : target + 2 * (j + 1) = (target + 2) + 2 * j := by omega
      simpa only [heq] using ih (target + 2) htail j hj'

end BatchPrime
