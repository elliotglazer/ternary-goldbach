import TernaryGoldbach.Prelim.SmallPsiTable

namespace TernaryGoldbach.Prelim.SmallTab

abbrev PsiWalkState := ℕ × ℕ × ℕ × ℕ × ℕ × ℕ × ℕ

def outerState (cN cD tN tD : ℕ) (s : PsiWalkState) (xs : List (ℕ × ℕ × ℕ)) :=
  let (n, tl, th, pl, ph, ll, lh) := s
  outer cN cD tN tD n tl th pl ph ll lh xs

theorem outerState_append (cN cD tN tD : ℕ) (xs ys : List (ℕ × ℕ × ℕ)) (s : PsiWalkState) :
    outerState cN cD tN tD s (xs ++ ys) =
      (outerState cN cD tN tD s xs).bind (fun u => outerState cN cD tN tD u ys) := by
  induction xs generalizing s with
  | nil => rcases s with ⟨n, tl, th, pl, ph, ll, lh⟩; rfl
  | cons x xs ih =>
    rcases s with ⟨n, tl, th, pl, ph, ll, lh⟩
    rcases x with ⟨g, l, h⟩
    simp only [List.cons_append, outerState, outer]
    split <;> try rfl
    split <;> try rfl
    split <;> try rfl
    exact ih (n + g, _, _, _, _, _, _)

theorem outerState_join {a b c d : ℕ} {xs ys : List (ℕ × ℕ × ℕ)} {s u v : PsiWalkState}
    (h : outerState a b c d s xs = some u) (k : outerState a b c d u ys = some v) :
    outerState a b c d s (xs ++ ys) = some v := by
  rw [outerState_append, h]
  exact k

end TernaryGoldbach.Prelim.SmallTab
