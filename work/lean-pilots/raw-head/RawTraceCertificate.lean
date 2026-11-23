import RawCachedLoop

/-! Internal exact states certificates. The Boolean checker compares integer pairs;
it does not accept checksums or analytic enclosures in place of update equalities.
Concrete consumers must prove the source bindings and the checker result. -/

namespace RawHead

def traceFollows (step : ℤ × ℤ) : (ℤ × ℤ) → List (ℤ × ℤ) → Bool
  | _, [] => true
  | previous, next :: rest =>
      decide (next = mulStep (2 ^ 122) previous step) && traceFollows step next rest

def traceCertificate (initial step : ℤ × ℤ) : List (ℤ × ℤ) → Bool
  | [] => false
  | first :: rest => decide (first = initial) && traceFollows step first rest

lemma traceFollows_sound (step initial : ℤ × ℤ) (rest : List (ℤ × ℤ))
    (h : traceFollows step initial rest = true) :
    initial :: rest = cachedTrace initial step rest.length := by
  induction rest generalizing initial with
  | nil => rfl
  | cons next rest ih =>
    have hp : next = mulStep (2 ^ 122) initial step ∧
        traceFollows step next rest = true := by
      simpa only [traceFollows, Bool.and_eq_true, decide_eq_true_eq] using h
    simp only [List.length_cons, cachedTrace]
    congr 1
    rw [← hp.1]
    exact ih next hp.2

theorem traceCertificate_sound (initial step : ℤ × ℤ) (states : List (ℤ × ℤ))
    (h : traceCertificate initial step states = true) :
    states = cachedTrace initial step (states.length - 1) := by
  cases states with
  | nil => simp [traceCertificate] at h
  | cons first rest =>
    have hp : first = initial ∧ traceFollows step first rest = true := by
      simpa only [traceCertificate, Bool.and_eq_true, decide_eq_true_eq] using h
    rcases hp with ⟨hfirst, hrest⟩
    subst first
    simpa only [List.length_cons, Nat.add_sub_cancel] using
      traceFollows_sound step initial rest hrest

/-- Explicit operation certificates imply the same individual states as the loop. -/
lemma trace_index_of_edges (initial step : ℤ × ℤ) (states : List (ℤ × ℤ))
    (hpos : 0 < states.length) (hfirst : states[0] = initial)
    (hedge : ∀ j (hj : j + 1 < states.length),
      states[j + 1] = mulStep (2 ^ 122) (states[j]'(by omega)) step)
    (j : ℕ) (hj : j < states.length) :
    states[j] = cachedState initial step j := by
  induction j with
  | zero => simpa only [cachedState_zero] using hfirst
  | succ j ih =>
    rw [hedge j hj, cachedState_succ, ih (by omega)]

theorem trace_eq_cachedTrace_of_edges (initial step : ℤ × ℤ)
    (states : List (ℤ × ℤ)) (hpos : 0 < states.length) (hfirst : states[0] = initial)
    (hedge : ∀ j (hj : j + 1 < states.length),
      states[j + 1] = mulStep (2 ^ 122) (states[j]'(by omega)) step) :
    states = cachedTrace initial step (states.length - 1) := by
  apply List.ext_getElem
  · rw [length_cachedTrace]
    omega
  · intro j hj hcached
    rw [getElem_cachedTrace]
    exact trace_index_of_edges initial step states hpos hfirst hedge j hj

lemma traceFollows_cachedTrace (initial step : ℤ × ℤ) (N : ℕ) :
    traceFollows step initial (cachedTrace initial step N).tail = true := by
  induction N generalizing initial with
  | zero => rfl
  | succ N ih =>
    cases N with
    | zero => simp [cachedTrace, traceFollows]
    | succ N =>
      simpa only [cachedTrace, List.tail_cons, traceFollows, decide_true,
        Bool.true_and] using ih (mulStep (2 ^ 122) initial step)

lemma traceCertificate_cachedTrace (initial step : ℤ × ℤ) (N : ℕ) :
    traceCertificate initial step (cachedTrace initial step N) = true := by
  cases N with
  | zero => simp [cachedTrace, traceCertificate, traceFollows]
  | succ N =>
    have h := traceFollows_cachedTrace initial step (N + 1)
    simpa only [cachedTrace, List.tail_cons, traceCertificate, decide_true,
      Bool.true_and] using h

theorem traceCertificate_of_edges (initial step : ℤ × ℤ)
    (states : List (ℤ × ℤ)) (hpos : 0 < states.length) (hfirst : states[0] = initial)
    (hedge : ∀ j (hj : j + 1 < states.length),
      states[j + 1] = mulStep (2 ^ 122) (states[j]'(by omega)) step) :
    traceCertificate initial step states = true := by
  rw [trace_eq_cachedTrace_of_edges initial step states hpos hfirst hedge]
  exact traceCertificate_cachedTrace _ _ _

/-- Internal transport from accepted literal sources and exact states checking. -/
theorem traceCertificate_actual_index {initial step : ℤ × ℤ} {k x : ℕ}
    (hi : initial = rawStateInitial x) (hs : step = rawStepNumerator k x)
    (states : List (ℤ × ℤ)) (hc : traceCertificate initial step states = true)
    (j : ℕ) (hj : j < states.length) : states[j] = rawStateNumerator k x j := by
  have ht := traceCertificate_sound initial step states hc
  subst initial
  subst step
  have ho := congrArg (fun xs : List (ℤ × ℤ) => xs[j]?) ht
  rw [List.getElem?_eq_getElem hj,
    getElem?_cachedTrace _ _ _ _ (by omega),
    cachedState_eq_rawStateNumerator] at ho
  exact Option.some.inj ho

theorem traceCertificate_actual_error {initial step : ℤ × ℤ} {x k : ℕ}
    (hi : initial = rawStateInitial x) (hs : step = rawStepNumerator k x)
    (states : List (ℤ × ℤ)) (hc : traceCertificate initial step states = true)
    (hx : 0 < x) (hk : k ≤ 18) (hlo : 2 ^ k ≤ x) (hhi : x ≤ 2 * 2 ^ k)
    (j : ℕ) (hj : j < states.length) (hheight : j ≤ 90000) :
    ‖expIntegerValue (2 ^ 120) states[j] -
      integerPower (x : ℝ) ((j : ℝ) * 5 / 64)‖ < 1 / (2 : ℝ) ^ 96 := by
  rw [traceCertificate_actual_index hi hs states hc j hj]
  exact rawStateValue_error hx hk hlo hhi hheight

end RawHead
