module

public import ScaledRefs
public import ScaledEval
public import BindPool

@[expose] public section


open GoldbachEnergy
namespace ScaledGrid

def Tag.code : Tag → OpCode
  | .literal x => .lit (rational x) | .input i => .input i | .pi => .pi | .add => .add
  | .neg => .neg | .mul => .mul | .min => .min | .max => .max | .inv => .inv | .sqrt => .sqrt
  | .atan => .atan | .exp => .exp | .log => .log

theorem filled_code (s : Tag) (f : Nat → Int) :
    (s.fill f).code = s.code.instantiateAt (fun j => rational (f j)) := by cases s <;> rfl

theorem tag_code (op : Op) (k : Int) : (op.tag k).code=op.code k := by cases op <;> rfl

def expression (tape : Nat → Step) (i : Nat) : MathExpr :=
  let s := tape i
  s.tag.code.expr (if _h : s.left < i then expression tape s.left else .rational 0)
    (if _h : s.right < i then expression tape s.right else .rational 0)
termination_by i

theorem connected (pool : Nat → Node) (size : Nat) (f : Nat → Int) (tape : Nat → Step)
    (ids : Nat → Nat) {count : Nat} (ok : Checked (binding pool size f tape ids) 0 count)
    (j : Nat) (hj : j < count) :
    (expression tape j).real (fun i => val (f i)) = nodeValue pool (ids j) := by
  induction j using Nat.strong_induction_on with
  | h j ih =>
    have pass := ok j (Nat.zero_le _) hj
    obtain ⟨h₁,hr⟩ := Bool.and_eq_true_iff.mp pass
    obtain ⟨hc,hl⟩ := Bool.and_eq_true_iff.mp h₁
    obtain ⟨_,tag_eq⟩ := of_decide_eq_true hc
    have code_eq := congrArg Tag.code tag_eq
    rw [filled_code,tag_code] at code_eq
    let v : Nat → ℝ := fun i => val (f i)
    have use_wire (used : Bool) (localRef globalRef : Nat)
        (hw : (!used || wire ids localRef globalRef j (ids j))=true) (hu : used=true) :
        (if localRef < j then expression tape localRef else MathExpr.rational 0).real v =
          (if globalRef < ids j then nodeValue pool globalRef else 0) := by
      have pass : wire ids localRef globalRef j (ids j)=true := by simpa [hu] using hw
      obtain ⟨loc,glob,eqn⟩ := of_decide_eq_true pass
      rw [if_pos loc,if_pos glob,← eqn]
      exact ih localRef loc (loc.trans hj)
    rw [expression,expr_value,nodeValue,←code_eq]
    have lused : (tape j).tag.code.leftUsed=(tape j).tag.leftUsed := by cases (tape j).tag <;> rfl
    have rused : (tape j).tag.code.rightUsed=(tape j).tag.rightUsed := by cases (tape j).tag <;> rfl
    have transfer := (tape j).tag.code.instantiate_value (fun i => rational (f i))
      _ _ _ _ (fun u => use_wire _ _ _ hl (lused ▸ u)) (fun u => use_wire _ _ _ hr (rused ▸ u))
    simpa only [rational_cast,v,dite_eq_ite] using transfer

theorem accepted_root {pool : Nat → Node} {expT atanT : Nat → Entry} {size : Nat}
    (hs : ∀ i, i < size → (pool i).op.Lookups expT atanT) (hc : Checked (testAt pool expT atanT) 0 size)
    {f : Nat → Int} {tape : Nat → Step} {ids : Nat → Nat} {count : Nat}
    (hw : Checked (binding pool size f tape ids) 0 count) (j : Nat) (hj : j < count)
    (e : MathExpr) (eqn : expression tape j=e) (cap : (pool (ids j)).b.hi*1000 ≤ 315*scale) :
    e.real (fun i => val (f i)) ≤ 0.315 := by
  have passed := hw j (Nat.zero_le _) hj
  have hk := (of_decide_eq_true (Bool.and_eq_true_iff.mp (Bool.and_eq_true_iff.mp passed).1).1).1
  have bound := (table_holds pool expT atanT hs hc _ hk).2
  rw [←eqn,connected pool size f tape ids hw j hj]
  apply bound.trans
  unfold val
  rw [div_le_iff₀ (by norm_num [scale] : (0:ℝ) < scale)]
  have cast : ((pool (ids j)).b.hi:ℝ)*1000 ≤ 315*(scale:ℝ) := by exact_mod_cast cap
  linarith only [cast]

#print axioms accepted_root
end ScaledGrid
