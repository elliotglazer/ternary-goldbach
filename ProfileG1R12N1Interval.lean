module

public import ProfileNumbers
public import ProfileG1R12N1Scalar

@[expose] public section

open GoldbachEnergy GoldbachEnergy.Profile ScaledGrid
namespace ProfileG1R12N1
set_option maxRecDepth 65536
private theorem one12 : Between (Piece.Price 44.44 46.052 30 100000000 4047962620) pieces1 12 13 := by
  apply Between.one
  have shape : pieces1[12]! = (⟨3413250864,4202438405,2,5,2⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row12
  norm_num [Piece.Price,point,v12,args12,val,scale] at h ⊢ <;> exact h
theorem interval : Between (Piece.Price 44.44 46.052 30 100000000 4047962620) pieces1 12 13 := one12
#print axioms interval
end ProfileG1R12N1
