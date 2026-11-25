module

public import DirectSound
public import ProfileG3R47N4Entries
public import ProfileTape1positiveFormula
public import ProfileNumbers

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileG3R47N4
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem scalar47 : (profilePriceExpr 1 false).real (fun i => val (v47 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked47 184 (by decide +kernel) _ ProfileTape1positive.formula cap47
theorem row47 : profilePrice (val (v47 0)) (val (v47 1)) (val (v47 2)) (val (v47 3)) 48189030400 1 (val (v47 5)) (val (v47 6)) (val (v47 7)) (val (v47 8)) ≤ 0.315 := by
  have h := scalar47
  rw [profilePriceExpr_real _ 1 48189030400 _] at h
  · exact h
  all_goals norm_num [v47,args47,val,scale]
theorem scalar48 : (profilePriceExpr 1 false).real (fun i => val (v48 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked48 184 (by decide +kernel) _ ProfileTape1positive.formula cap48
theorem row48 : profilePrice (val (v48 0)) (val (v48 1)) (val (v48 2)) (val (v48 3)) 48189030400 1 (val (v48 5)) (val (v48 6)) (val (v48 7)) (val (v48 8)) ≤ 0.315 := by
  have h := scalar48
  rw [profilePriceExpr_real _ 1 48189030400 _] at h
  · exact h
  all_goals norm_num [v48,args48,val,scale]
theorem scalar49 : (profilePriceExpr 1 false).real (fun i => val (v49 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked49 184 (by decide +kernel) _ ProfileTape1positive.formula cap49
theorem row49 : profilePrice (val (v49 0)) (val (v49 1)) (val (v49 2)) (val (v49 3)) 48189030400 1 (val (v49 5)) (val (v49 6)) (val (v49 7)) (val (v49 8)) ≤ 0.315 := by
  have h := scalar49
  rw [profilePriceExpr_real _ 1 48189030400 _] at h
  · exact h
  all_goals norm_num [v49,args49,val,scale]
theorem scalar50 : (profilePriceExpr 1 false).real (fun i => val (v50 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked50 184 (by decide +kernel) _ ProfileTape1positive.formula cap50
theorem row50 : profilePrice (val (v50 0)) (val (v50 1)) (val (v50 2)) (val (v50 3)) 48189030400 1 (val (v50 5)) (val (v50 6)) (val (v50 7)) (val (v50 8)) ≤ 0.315 := by
  have h := scalar50
  rw [profilePriceExpr_real _ 1 48189030400 _] at h
  · exact h
  all_goals norm_num [v50,args50,val,scale]
#print axioms row47
end ProfileG3R47N4
open GoldbachEnergy GoldbachEnergy.Profile ScaledGrid
namespace ProfileG3R47N4
set_option maxRecDepth 65536
private theorem one47 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 47 48 := by
  apply Between.one
  have shape : pieces3[47]! = (⟨49754063583642,108519480435792,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row47
  norm_num [Piece.Price,point,v47,args47,val,scale] at h ⊢ <;> exact h
private theorem one48 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 48 49 := by
  apply Between.one
  have shape : pieces3[48]! = (⟨108519480435792,236687793974573,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row48
  norm_num [Piece.Price,point,v48,args48,val,scale] at h ⊢ <;> exact h
private theorem one49 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 49 50 := by
  apply Between.one
  have shape : pieces3[49]! = (⟨236687793974573,516224934614696,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row49
  norm_num [Piece.Price,point,v49,args49,val,scale] at h ⊢ <;> exact h
private theorem one50 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 50 51 := by
  apply Between.one
  have shape : pieces3[50]! = (⟨516224934614696,1125899906842624,2,5,1⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row50
  norm_num [Piece.Price,point,v50,args50,val,scale] at h ⊢ <;> exact h
theorem interval : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 47 51 := (Between.join (Between.join one47 one48) (Between.join one49 one50))
#print axioms interval
end ProfileG3R47N4
