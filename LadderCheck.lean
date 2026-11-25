module
public import GoldbachLean.Saouter1998.Theorem2
@[expose] public section
open GoldbachLean.Saouter1998.Thm2
namespace TestedLadder
def cap : Nat := 100328530944
def primeOf (r : Nat) := 4194304*r+1

def chain (p : Nat) : List (Nat × Nat) → Bool
  | [] => true
  | (r,k)::xs =>
      thm2B r k && (primeOf r < p && p ≤ primeOf r + (cap-2)) && chain (primeOf r) xs

def Covers (lo hi : Nat) := ∀ n, Odd n → lo ≤ n → n ≤ hi →
    ∃ p, p.Prime ∧ Odd p ∧ 4 ≤ n-p ∧ n-p ≤ cap ∧ p ≤ n

theorem ranges (rows : List (Nat × Nat)) (p : Nat) (hp : p.Prime) (ho : Odd p)
    (hc : chain p rows = true) :
    Covers ((rows.getLast?.map (fun v => primeOf v.1)).getD p + 4) (p+cap) := by
  induction rows generalizing p with
  | nil =>
    intro n hn hl hh
    simp at hl
    exact ⟨p,hp,ho,by omega,by omega,by omega⟩
  | cons a l ih =>
    rcases a with ⟨r,k⟩
    simp only [chain, Bool.and_eq_true, decide_eq_true_eq] at hc
    have hq : (primeOf r).Prime := prime_of_thm2B hc.1.1
    have hqo : Odd (primeOf r) := ⟨2097152*r, by unfold primeOf; omega⟩
    intro n hn hl hh
    by_cases h : p+4 ≤ n
    · exact ⟨p,hp,ho,by omega,by omega,by omega⟩
    · apply ih (primeOf r) hq hqo hc.2 n hn
      · cases l with
        | nil => simpa using hl
        | cons x xs =>
          rw [List.getLast?_cons_of_ne_nil (List.cons_ne_nil x xs)] at hl
          simpa only [List.getLast?_cons, Option.map_some, Option.getD_some] using hl
      · obtain ⟨u,hu⟩ := hn
        obtain ⟨v,hv⟩ := ho
        have hg := hc.1.2.2
        unfold cap at *; omega

theorem merge {a b c d : Nat} (hl : Covers a b) (hr : Covers c d)
    (h : c ≤ b+1) : Covers a d := by
  intro n hn ha hd
  by_cases hb : n ≤ b
  · exact hl n hn ha hb
  · exact hr n hn (by omega) hd
end TestedLadder
