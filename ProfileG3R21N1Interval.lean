module

public import ProfileNumbers
public import ProfileG3R21N1Scalar

@[expose] public section

open GoldbachEnergy GoldbachEnergy.Profile ScaledGrid
namespace ProfileG3R21N1
set_option maxRecDepth 65536
private theorem one21 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 21 22 := by
  apply Between.one
  have shape : pieces3[21]! = (⟨861271578,892779861,4,7,16⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row21
  norm_num [Piece.Price,point,v21,args21,val,scale] at h ⊢ <;> exact h
theorem interval : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 21 22 := one21
#print axioms interval
end ProfileG3R21N1
