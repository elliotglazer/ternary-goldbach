module

public import ProfileNumbers
public import ProfileG0R0N4Scalar

@[expose] public section

open GoldbachEnergy GoldbachEnergy.Profile ScaledGrid
namespace ProfileG0R0N4
set_option maxRecDepth 65536
private theorem one0 : Between (Piece.Price 44.44 46.052 30 1 100000000) pieces0 0 1 := by
  apply Between.one
  have shape : pieces0[0]! = (⟨0,5072425032,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row0
  norm_num [Piece.Price,point,v0,args0,val,scale] at h ⊢ <;> exact h
private theorem one1 : Between (Piece.Price 44.44 46.052 30 1 100000000) pieces0 1 2 := by
  apply Between.one
  have shape : pieces0[1]! = (⟨5072425032,16135465114,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row1
  norm_num [Piece.Price,point,v1,args1,val,scale] at h ⊢ <;> exact h
private theorem one2 : Between (Piece.Price 44.44 46.052 30 1 100000000) pieces0 2 3 := by
  apply Between.one
  have shape : pieces0[2]! = (⟨16135465114,40264132377,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row2
  norm_num [Piece.Price,point,v2,args2,val,scale] at h ⊢ <;> exact h
private theorem one3 : Between (Piece.Price 44.44 46.052 30 1 100000000) pieces0 3 4 := by
  apply Between.one
  have shape : pieces0[3]! = (⟨40264132377,92889141385,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row3
  norm_num [Piece.Price,point,v3,args3,val,scale] at h ⊢ <;> exact h
theorem interval : Between (Piece.Price 44.44 46.052 30 1 100000000) pieces0 0 4 := (Between.join (Between.join one0 one1) (Between.join one2 one3))
#print axioms interval
end ProfileG0R0N4
