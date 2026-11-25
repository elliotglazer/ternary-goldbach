module

public import ScalarTemplate

@[expose] public section


namespace GoldbachEnergy

inductive MathExpr where
  | rational (x : ℚ) | varRef (i : Nat) | pi
  | unary (code : OpCode) (a : MathExpr)
  | binary (code : OpCode) (a b : MathExpr)
  deriving DecidableEq

noncomputable def MathExpr.real (input : ℕ → ℝ) : MathExpr → ℝ
  | .rational r => r | .varRef i => input i | .pi => Real.pi
  | .unary op a => op.value input (a.real input) 0
  | .binary op a b => op.value input (a.real input) (b.real input)

def OpCode.expr (op : OpCode) (a b : MathExpr) : MathExpr :=
  match op with
  | .lit r => .rational r | .input i => .varRef i | .pi => .pi
  | .neg | .sqrt | .atan | .inv | .exp | .log => .unary op a
  | .add | .mul | .min | .max => .binary op a b

theorem expr_value (c : OpCode) (input : ℕ → ℝ) (a b : MathExpr) :
    (c.expr a b).real input = c.value input (a.real input) (b.real input) := by cases c <;> rfl

def buildFormula : List TemplateStep → Array MathExpr → Array MathExpr
  | [], a => a
  | i::is,a => buildFormula is (a.push (i.code.expr (a.getD i.left (.rational 0)) (a.getD i.right (.rational 0))))

private theorem at_mapped (input : ℕ → ℝ) (a : Array MathExpr) (i : Nat) :
    (a.map (MathExpr.real input)).getD i 0 = (a.getD i (.rational 0)).real input := by
  by_cases h : i < a.size
  · simp [Array.getD,h]
  · simp [Array.getD,h,MathExpr.real]

theorem compiled_formula (is : List TemplateStep) (input : ℕ → ℝ) (a : Array MathExpr) :
    templateValues input is (a.map (MathExpr.real input)) = (buildFormula is a).map (MathExpr.real input) := by
  induction is generalizing a with
  | nil => rfl
  | cons i is ih =>
    simp only [templateValues,buildFormula]
    rw [← ih,Array.map_push,expr_value,at_mapped,at_mapped]

theorem explicit_expression_bound (is : List Instruction) (ts : List TemplateStep) (hs : is.map Instruction.shape=ts)
    {inputs : ℕ → RatBounds} {input : ℕ → ℝ} (hi : ∀ j, (inputs j).Contains (input j))
    (hc : checkProgram inputs is #[]=true) (j : ℕ) (e : MathExpr)
    (he : (buildFormula ts #[]).getD j (.rational 0) = e) :
    ((programBounds is #[]).getD j zeroBounds).Contains (e.real input) := by
  have h := template_from_witness is ts hs hi hc j
  have hval := compiled_formula ts input #[]
  simp only [Array.map_empty] at hval
  rwa [hval,at_mapped,he] at h

#print axioms explicit_expression_bound
end GoldbachEnergy
