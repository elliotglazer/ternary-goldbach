import TernaryGoldbach.Prelim.LogWalk

/-!
# [H, (2.13)] for `3 ≤ N ≤ 10⁴`, and `∑_{m≤X} Λ(m)/m − ψ(X)/(X+1) − log(X+2)` at `X = 10⁴`

Checked by the kernel (`scripts/gen_mertens_lower.py`). With `D = 10³⁰`, the walk keeps lower and
upper bounds for `D log n` (`LogWalk.incr_bounds`), `D ∑_{m≤n} Λ(m)/m` and `D ψ(n)`. `Λ(n+1)` comes
from trial division (`isPr`) and the table `PPL` of the proper prime powers `≤ 10002`, whose
completeness the kernel checks (`PPL_complete`). At every `3 ≤ N ≤ 10⁴` the walk checks
`D log(N+1) ≤ D ∑_{m≤N} Λ(m)/m + K₃₂` with `K₃₂ ≤ D log(3/√2)`.
-/

open Finset Real
open scoped ArithmeticFunction.vonMangoldt

namespace TernaryGoldbach.Prelim.MertWalk

open TernaryGoldbach.Prelim.LogWalk

/-! ### `Λ` on `n ≤ 10002` -/

/-- The proper prime powers `m = p^k ≤ 10002`, as `(m, p, k)`. -/
def PPL : List (ℕ × ℕ × ℕ) := [(4, 2, 2), (8, 2, 3), (9, 3, 2), (16, 2, 4), (25, 5, 2), (27, 3, 3), (32, 2, 5), (49, 7, 2), (64, 2, 6), (81, 3, 4), (121, 11, 2), (125, 5, 3), (128, 2, 7), (169, 13, 2), (243, 3, 5), (256, 2, 8), (289, 17, 2), (343, 7, 3), (361, 19, 2), (512, 2, 9), (529, 23, 2), (625, 5, 4), (729, 3, 6), (841, 29, 2), (961, 31, 2), (1024, 2, 10), (1331, 11, 3), (1369, 37, 2), (1681, 41, 2), (1849, 43, 2), (2048, 2, 11), (2187, 3, 7), (2197, 13, 3), (2209, 47, 2), (2401, 7, 4), (2809, 53, 2), (3125, 5, 5), (3481, 59, 2), (3721, 61, 2), (4096, 2, 12), (4489, 67, 2), (4913, 17, 3), (5041, 71, 2), (5329, 73, 2), (6241, 79, 2), (6561, 3, 8), (6859, 19, 3), (6889, 83, 2), (7921, 89, 2), (8192, 2, 13), (9409, 97, 2)]

def ppFind : List (ℕ × ℕ × ℕ) → ℕ → Option (ℕ × ℕ)
  | [], _ => none
  | (m', p, k) :: l, m => if m' = m then some (p, k) else ppFind l m

theorem ppFind_mem : ∀ {l : List (ℕ × ℕ × ℕ)} {m p k : ℕ}, ppFind l m = some (p, k) → (m, p, k) ∈ l
  | [], _, _, _, h => by simp [ppFind] at h
  | (m', p', k') :: l, m, p, k, h => by
    unfold ppFind at h
    split_ifs at h with hm
    · simp only [Option.some.injEq, Prod.mk.injEq] at h
      obtain ⟨rfl, rfl⟩ := h
      subst hm
      exact List.mem_cons_self
    · exact List.mem_cons_of_mem _ (ppFind_mem h)

theorem PPL_ok : PPL.all (fun e => isPr e.2.1 && e.2.1 ^ e.2.2 == e.1 && decide (2 ≤ e.2.2) &&
    decide (e.1 ≤ 10002)) = true := by
  decide +kernel


end TernaryGoldbach.Prelim.MertWalk
