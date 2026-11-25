module

public import DirectData
public import ScaledBinding
public import ScaledEntries

@[expose] public section


open GoldbachEnergy
namespace ScaledGrid

theorem direct_value (tape : Nat → Step) (v : Nat → Int) (w : Nat → Witness) (j : Nat) :
    (expression tape j).real (fun k => val (v k)) = nodeValue (directNode tape v w) j := by
  induction j using Nat.strong_induction_on with
  | h j ih =>
    have arg (k : Nat) :
        (if k < j then expression tape k else MathExpr.rational 0).real (fun k => val (v k)) =
        (if k < j then nodeValue (directNode tape v w) k else 0) := by
      split
      · rename_i hk; exact ih k hk
      · simp [MathExpr.real]
    rw [expression,expr_value,nodeValue]
    simp only [dite_eq_ite,directNode,arg]
    cases ht : (tape j).tag <;> simp [Tag.code,Tag.op,Tag.bounds,Op.code,OpCode.value,rational_cast]
    all_goals by_cases hl : (tape j).left < j <;> by_cases hr : (tape j).right < j <;> simp [hl,hr]

theorem direct_upper {tape : Nat → Step} {v : Nat → Int} {w : Nat → Witness} {n ne na : Nat}
    {e a : Nat → Entry} (he : ∀ i, i < ne → ExpEntry (e i)) (ha : ∀ i, i < na → AtanEntry (a i))
    (ok : Checked (directTest tape v w e a ne na) 0 n) (j : Nat) (hj : j < n)
    (expr : MathExpr) (shape : expression tape j=expr)
    (cap : (directNode tape v w j).b.hi*1000 ≤ 315*scale) :
    expr.real (fun i => val (v i)) ≤ 0.315 := by
  let pool := directNode tape v w
  have good (i : Nat) (hi : i<n) := Bool.and_eq_true_iff.mp (ok i (Nat.zero_le _) hi)
  have bound := (table_holds pool e a
    (fun i hi => checked_refs _ he ha (good i hi).2) (fun i _ hi => (good i hi).1) j hj).2
  rw [←shape,direct_value tape v w j]
  apply bound.trans
  unfold val
  rw [div_le_iff₀ (by norm_num [scale] : (0:ℝ)<scale)]
  have cast : ((directNode tape v w j).b.hi:ℝ)*1000 ≤ 315*(scale:ℝ) := by exact_mod_cast cap
  dsimp [pool] at *
  linarith only [cast]

#print axioms direct_upper
end ScaledGrid
