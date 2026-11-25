module

public import ProfileNumbers
public import ProfileG3R22N1Scalar

@[expose] public section

open GoldbachEnergy GoldbachEnergy.Profile ScaledGrid
namespace ProfileG3R22N1
set_option maxRecDepth 65536
private theorem one22 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 22 23 := by
  apply Between.one
  have shape : pieces3[22]! = (⟨892779861,924480682,4,7,16⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row22
  norm_num [Piece.Price,point,v22,args22,val,scale] at h ⊢ <;> exact h
theorem interval : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 22 23 := one22
#print axioms interval
end ProfileG3R22N1
