module

public import ProfileNumbers
public import ProfileG2R0N12Scalar

@[expose] public section

open GoldbachEnergy GoldbachEnergy.Profile ScaledGrid
namespace ProfileG2R0N12
set_option maxRecDepth 65536
private theorem one0 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 0 1 := by
  apply Between.one
  have shape : pieces2[0]! = (⟨0,16135465114,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row0
  norm_num [Piece.Price,point,v0,args0,val,scale] at h ⊢ <;> exact h
private theorem one1 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 1 2 := by
  apply Between.one
  have shape : pieces2[1]! = (⟨16135465114,92889141385,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row1
  norm_num [Piece.Price,point,v1,args1,val,scale] at h ⊢ <;> exact h
private theorem one2 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 2 3 := by
  apply Between.one
  have shape : pieces2[2]! = (⟨92889141385,207665127256,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row2
  norm_num [Piece.Price,point,v2,args2,val,scale] at h ⊢ <;> exact h
private theorem one3 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 3 4 := by
  apply Between.one
  have shape : pieces2[3]! = (⟨207665127256,457993387174,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row3
  norm_num [Piece.Price,point,v3,args3,val,scale] at h ⊢ <;> exact h
private theorem one4 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 4 5 := by
  apply Between.one
  have shape : pieces2[4]! = (⟨457993387174,1003963323632,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row4
  norm_num [Piece.Price,point,v4,args4,val,scale] at h ⊢ <;> exact h
private theorem one5 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 5 6 := by
  apply Between.one
  have shape : pieces2[5]! = (⟨1003963323632,2194732482556,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row5
  norm_num [Piece.Price,point,v5,args5,val,scale] at h ⊢ <;> exact h
private theorem one6 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 6 7 := by
  apply Between.one
  have shape : pieces2[6]! = (⟨2194732482556,4791819052997,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row6
  norm_num [Piece.Price,point,v6,args6,val,scale] at h ⊢ <;> exact h
private theorem one7 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 7 8 := by
  apply Between.one
  have shape : pieces2[7]! = (⟨4791819052997,10456106378402,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row7
  norm_num [Piece.Price,point,v7,args7,val,scale] at h ⊢ <;> exact h
private theorem one8 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 8 9 := by
  apply Between.one
  have shape : pieces2[8]! = (⟨10456106378402,22810007580578,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row8
  norm_num [Piece.Price,point,v8,args8,val,scale] at h ⊢ <;> exact h
private theorem one9 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 9 10 := by
  apply Between.one
  have shape : pieces2[9]! = (⟨22810007580578,49754063583642,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row9
  norm_num [Piece.Price,point,v9,args9,val,scale] at h ⊢ <;> exact h
private theorem one10 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 10 11 := by
  apply Between.one
  have shape : pieces2[10]! = (⟨49754063583642,108519480435792,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row10
  norm_num [Piece.Price,point,v10,args10,val,scale] at h ⊢ <;> exact h
private theorem one11 : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 11 12 := by
  apply Between.one
  have shape : pieces2[11]! = (⟨108519480435792,236687793974573,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row11
  norm_num [Piece.Price,point,v11,args11,val,scale] at h ⊢ <;> exact h
theorem interval : Between (Piece.Price 46.05 56 70 1 100000000) pieces2 0 12 := (Between.join (Between.join (Between.join one0 (Between.join one1 one2)) (Between.join one3 (Between.join one4 one5))) (Between.join (Between.join one6 (Between.join one7 one8)) (Between.join one9 (Between.join one10 one11))))
#print axioms interval
end ProfileG2R0N12
