import RawStateProducer
import Mathlib.Data.List.Iterate
import Mathlib.Logic.Function.Iterate

/-! Internal cached recurrence. The supplied initial and step pairs are values,
so the update loop never calls the logarithm, inverse-root or Taylor producers.
The trace includes index zero and uses exactly `N` update calls for `N+1` entries.
Its equality to a concrete literal list remains a separate certificate obligation. -/

namespace RawHead

def cachedState (initial step : ℤ × ℤ) (j : ℕ) : ℤ × ℤ :=
  (fun w => mulStep (2 ^ 122) w step)^[j] initial

/-- Full forward trace, without an unused update after the last retained state. -/
def cachedTrace (initial step : ℤ × ℤ) : ℕ → List (ℤ × ℤ)
  | 0 => [initial]
  | N + 1 => initial :: cachedTrace (mulStep (2 ^ 122) initial step) step N

lemma cachedState_zero (initial step : ℤ × ℤ) :
    cachedState initial step 0 = initial := rfl

lemma cachedState_succ (initial step : ℤ × ℤ) (j : ℕ) :
    cachedState initial step (j + 1) =
      mulStep (2 ^ 122) (cachedState initial step j) step := by
  exact Function.iterate_succ_apply' _ _ _

lemma cachedTrace_eq_iterate (initial step : ℤ × ℤ) (N : ℕ) :
    cachedTrace initial step N =
      List.iterate (fun w => mulStep (2 ^ 122) w step) initial (N + 1) := by
  induction N generalizing initial with
  | zero => simp [cachedTrace, List.iterate]
  | succ N ih => simp only [cachedTrace, List.iterate, ih]

@[simp] lemma length_cachedTrace (initial step : ℤ × ℤ) (N : ℕ) :
    (cachedTrace initial step N).length = N + 1 := by
  rw [cachedTrace_eq_iterate, List.length_iterate]

lemma getElem_cachedTrace (initial step : ℤ × ℤ) (N j : ℕ)
    (h : j < (cachedTrace initial step N).length) :
    (cachedTrace initial step N)[j] = cachedState initial step j := by
  simp only [cachedTrace_eq_iterate, List.getElem_iterate, cachedState]

lemma getElem?_cachedTrace (initial step : ℤ × ℤ) (N j : ℕ) (hj : j ≤ N) :
    (cachedTrace initial step N)[j]? = some (cachedState initial step j) := by
  rw [cachedTrace_eq_iterate]
  exact List.getElem?_iterate _ _ _ _ (by omega)

/-- The cached recurrence is exactly the original program, not just an enclosure. -/
theorem cachedState_eq_rawStateNumerator (k x j : ℕ) :
    cachedState (rawStateInitial x) (rawStepNumerator k x) j =
      rawStateNumerator k x j := by
  induction j with
  | zero => rfl
  | succ j ih => rw [cachedState_succ, ih, rawStateNumerator]

/-- Producers occur only at this boundary; the recursive loop consumes their pairs. -/
def rawCachedTrace (k x N : ℕ) : List (ℤ × ℤ) :=
  let initial := rawStateInitial x
  let step := rawStepNumerator k x
  cachedTrace initial step N

@[simp] lemma length_rawCachedTrace (k x N : ℕ) :
    (rawCachedTrace k x N).length = N + 1 := by
  exact length_cachedTrace _ _ _

theorem getElem_rawCachedTrace (k x N j : ℕ)
    (h : j < (rawCachedTrace k x N).length) :
    (rawCachedTrace k x N)[j] = rawStateNumerator k x j := by
  exact (getElem_cachedTrace (rawStateInitial x) (rawStepNumerator k x) N j h).trans
    (cachedState_eq_rawStateNumerator k x j)

theorem getElem?_rawCachedTrace (k x N j : ℕ) (hj : j ≤ N) :
    (rawCachedTrace k x N)[j]? = some (rawStateNumerator k x j) := by
  change (cachedTrace (rawStateInitial x) (rawStepNumerator k x) N)[j]? = _
  rw [getElem?_cachedTrace _ _ _ _ hj, cachedState_eq_rawStateNumerator]

/-- Internal reuse of already proved literal initial/step equalities. -/
lemma cachedTrace_eq_rawCachedTrace {initial step : ℤ × ℤ} {k x : ℕ}
    (hi : initial = rawStateInitial x) (hs : step = rawStepNumerator k x) (N : ℕ) :
    cachedTrace initial step N = rawCachedTrace k x N := by
  rw [hi, hs]
  rfl

end RawHead
