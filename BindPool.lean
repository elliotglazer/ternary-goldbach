module

public import GlobalPool
public import CalcLanguage

@[expose] public section


namespace GoldbachEnergy

def OpCode.instantiateAt (f : Nat → ℚ) : OpCode → OpCode
  | .input i => .lit (f i)
  | c => c

def OpCode.leftUsed : OpCode → Bool
  | .lit _ | .input _ | .pi => false
  | _ => true

def OpCode.rightUsed : OpCode → Bool
  | .add | .mul | .min | .max => true
  | _ => false

theorem OpCode.instantiate_value (f : Nat → ℚ) (c : OpCode) (x y a b : ℝ)
    (hl : c.leftUsed=true → x=a) (hr : c.rightUsed=true → y=b) :
    c.value (fun i => f i) x y = (c.instantiateAt f).value (fun _ => 0) a b := by
  cases c <;> simp_all [leftUsed,rightUsed,instantiateAt,OpCode.value]

def wireOK (ids : Array Nat) (localRef globalRef current : Nat) :=
  decide (localRef < ids.size ∧ globalRef < current ∧ ids.getD localRef 0=globalRef)

def boundAt (p : Pool) (f : Nat → ℚ) (ids : Array Nat) (step : TemplateStep) (i : Nat) :=
  let n := p.node i
  decide (i < p.size ∧ step.code.instantiateAt f=n.op.code) &&
    (!step.code.leftUsed || wireOK ids step.left n.left i) &&
    (!step.code.rightUsed || wireOK ids step.right n.right i)

theorem boundAt_value {p : Pool} {f : Nat → ℚ} {ids : Array Nat} {s : TemplateStep} {i : Nat}
    (h : boundAt p f ids s i=true) :
    s.code.value (fun j => f j) ((ids.map p.value).getD s.left 0) ((ids.map p.value).getD s.right 0)=p.value i := by
  obtain ⟨h1,hR⟩ := Bool.and_eq_true_iff.mp h
  obtain ⟨hc,hL⟩ := Bool.and_eq_true_iff.mp h1
  obtain ⟨_,eqn⟩ := of_decide_eq_true hc
  have wire (used : Bool) (localRef globalRef : Nat) (pass : (!used || wireOK ids localRef globalRef i)=true)
      (hu : used=true) :
      (ids.map p.value).getD localRef 0=(if globalRef < i then p.value globalRef else 0) := by
    have test : wireOK ids localRef globalRef i=true := by simpa [hu] using pass
    obtain ⟨loc,glob,eqref⟩ := of_decide_eq_true test
    simp [Array.getD,loc] at eqref
    simp [Array.getD,loc,glob,eqref]
  rw [Pool.value,← eqn]
  exact s.code.instantiate_value f _ _ _ _ (wire _ _ _ hL) (wire _ _ _ hR)

def checkBindings (p : Pool) (f : Nat → ℚ) : List (TemplateStep × Nat) → Array Nat → Bool
  | [],_ => true
  | (s,i)::ss,ids => boundAt p f ids s i && checkBindings p f ss (ids.push i)

def bindingOutput : List (TemplateStep × Nat) → Array Nat → Array Nat
  | [],ids => ids
  | (_,i)::ss,ids => bindingOutput ss (ids.push i)

theorem bindings_sound (p : Pool) (f : Nat → ℚ) (ss : List (TemplateStep × Nat)) (ids : Array Nat)
    (h : checkBindings p f ss ids=true) :
    templateValues (fun j => f j) (ss.map Prod.fst) (ids.map p.value)=
      (bindingOutput ss ids).map p.value := by
  induction ss generalizing ids with
  | nil => rfl
  | cons pair ss ih =>
    obtain ⟨s,i⟩ := pair
    obtain ⟨one,rest⟩ := Bool.and_eq_true_iff.mp h
    simp only [List.map_cons,templateValues,bindingOutput]
    rw [boundAt_value one,← Array.map_push]
    exact ih _ rest

#print axioms bindings_sound
end GoldbachEnergy
