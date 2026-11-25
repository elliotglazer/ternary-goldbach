module

public import DirectSound
public import ProfileG3R0N12Entries
public import ProfileTape16positiveFormula
public import ProfileTape2touchingFormula
public import ProfileTape8positiveFormula
public import ProfileNumbers

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileG3R0N12
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem scalar0 : (profilePriceExpr 2 true).real (fun i => val (v0 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked0 215 (by decide +kernel) _ ProfileTape2touching.formula cap0
theorem row0 : profilePrice (val (v0 0)) (val (v0 1)) (val (v0 2)) (val (v0 3)) 48189030400 2 (val (v0 5)) (val (v0 6)) (val (v0 7)) (val (v0 8)) ≤ 0.315 := by
  have h := scalar0
  rw [profilePriceExpr_real _ 2 48189030400 _] at h
  · exact h
  all_goals norm_num [v0,args0,val,scale]
theorem scalar1 : (profilePriceExpr 8 false).real (fun i => val (v1 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked1 410 (by decide +kernel) _ ProfileTape8positive.formula cap1
theorem row1 : profilePrice (val (v1 0)) (val (v1 1)) (val (v1 2)) (val (v1 3)) 48189030400 8 (val (v1 5)) (val (v1 6)) (val (v1 7)) (val (v1 8)) ≤ 0.315 := by
  have h := scalar1
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v1,args1,val,scale]
theorem scalar2 : (profilePriceExpr 8 false).real (fun i => val (v2 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked2 410 (by decide +kernel) _ ProfileTape8positive.formula cap2
theorem row2 : profilePrice (val (v2 0)) (val (v2 1)) (val (v2 2)) (val (v2 3)) 48189030400 8 (val (v2 5)) (val (v2 6)) (val (v2 7)) (val (v2 8)) ≤ 0.315 := by
  have h := scalar2
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v2,args2,val,scale]
theorem scalar3 : (profilePriceExpr 8 false).real (fun i => val (v3 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked3 410 (by decide +kernel) _ ProfileTape8positive.formula cap3
theorem row3 : profilePrice (val (v3 0)) (val (v3 1)) (val (v3 2)) (val (v3 3)) 48189030400 8 (val (v3 5)) (val (v3 6)) (val (v3 7)) (val (v3 8)) ≤ 0.315 := by
  have h := scalar3
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v3,args3,val,scale]
theorem scalar4 : (profilePriceExpr 16 false).real (fun i => val (v4 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked4 656 (by decide +kernel) _ ProfileTape16positive.formula cap4
theorem row4 : profilePrice (val (v4 0)) (val (v4 1)) (val (v4 2)) (val (v4 3)) 48189030400 16 (val (v4 5)) (val (v4 6)) (val (v4 7)) (val (v4 8)) ≤ 0.315 := by
  have h := scalar4
  rw [profilePriceExpr_real _ 16 48189030400 _] at h
  · exact h
  all_goals norm_num [v4,args4,val,scale]
theorem scalar5 : (profilePriceExpr 8 false).real (fun i => val (v5 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked5 410 (by decide +kernel) _ ProfileTape8positive.formula cap5
theorem row5 : profilePrice (val (v5 0)) (val (v5 1)) (val (v5 2)) (val (v5 3)) 48189030400 8 (val (v5 5)) (val (v5 6)) (val (v5 7)) (val (v5 8)) ≤ 0.315 := by
  have h := scalar5
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v5,args5,val,scale]
theorem scalar6 : (profilePriceExpr 8 false).real (fun i => val (v6 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked6 410 (by decide +kernel) _ ProfileTape8positive.formula cap6
theorem row6 : profilePrice (val (v6 0)) (val (v6 1)) (val (v6 2)) (val (v6 3)) 48189030400 8 (val (v6 5)) (val (v6 6)) (val (v6 7)) (val (v6 8)) ≤ 0.315 := by
  have h := scalar6
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v6,args6,val,scale]
theorem scalar7 : (profilePriceExpr 8 false).real (fun i => val (v7 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked7 410 (by decide +kernel) _ ProfileTape8positive.formula cap7
theorem row7 : profilePrice (val (v7 0)) (val (v7 1)) (val (v7 2)) (val (v7 3)) 48189030400 8 (val (v7 5)) (val (v7 6)) (val (v7 7)) (val (v7 8)) ≤ 0.315 := by
  have h := scalar7
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v7,args7,val,scale]
theorem scalar8 : (profilePriceExpr 8 false).real (fun i => val (v8 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked8 410 (by decide +kernel) _ ProfileTape8positive.formula cap8
theorem row8 : profilePrice (val (v8 0)) (val (v8 1)) (val (v8 2)) (val (v8 3)) 48189030400 8 (val (v8 5)) (val (v8 6)) (val (v8 7)) (val (v8 8)) ≤ 0.315 := by
  have h := scalar8
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v8,args8,val,scale]
theorem scalar9 : (profilePriceExpr 8 false).real (fun i => val (v9 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked9 410 (by decide +kernel) _ ProfileTape8positive.formula cap9
theorem row9 : profilePrice (val (v9 0)) (val (v9 1)) (val (v9 2)) (val (v9 3)) 48189030400 8 (val (v9 5)) (val (v9 6)) (val (v9 7)) (val (v9 8)) ≤ 0.315 := by
  have h := scalar9
  rw [profilePriceExpr_real _ 8 48189030400 _] at h
  · exact h
  all_goals norm_num [v9,args9,val,scale]
theorem scalar10 : (profilePriceExpr 16 false).real (fun i => val (v10 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked10 656 (by decide +kernel) _ ProfileTape16positive.formula cap10
theorem row10 : profilePrice (val (v10 0)) (val (v10 1)) (val (v10 2)) (val (v10 3)) 48189030400 16 (val (v10 5)) (val (v10 6)) (val (v10 7)) (val (v10 8)) ≤ 0.315 := by
  have h := scalar10
  rw [profilePriceExpr_real _ 16 48189030400 _] at h
  · exact h
  all_goals norm_num [v10,args10,val,scale]
theorem scalar11 : (profilePriceExpr 16 false).real (fun i => val (v11 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked11 656 (by decide +kernel) _ ProfileTape16positive.formula cap11
theorem row11 : profilePrice (val (v11 0)) (val (v11 1)) (val (v11 2)) (val (v11 3)) 48189030400 16 (val (v11 5)) (val (v11 6)) (val (v11 7)) (val (v11 8)) ≤ 0.315 := by
  have h := scalar11
  rw [profilePriceExpr_real _ 16 48189030400 _] at h
  · exact h
  all_goals norm_num [v11,args11,val,scale]
#print axioms row0
end ProfileG3R0N12
open GoldbachEnergy GoldbachEnergy.Profile ScaledGrid
namespace ProfileG3R0N12
set_option maxRecDepth 65536
private theorem one0 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 0 1 := by
  apply Between.one
  have shape : pieces3[0]! = (⟨0,105947395,2,5,2⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row0
  norm_num [Piece.Price,point,v0,args0,val,scale] at h ⊢ <;> exact h
private theorem one1 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 1 2 := by
  apply Between.one
  have shape : pieces3[1]! = (⟨105947395,214508281,4,7,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row1
  norm_num [Piece.Price,point,v1,args1,val,scale] at h ⊢ <;> exact h
private theorem one2 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 2 3 := by
  apply Between.one
  have shape : pieces3[2]! = (⟨214508281,269788867,4,7,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row2
  norm_num [Piece.Price,point,v2,args2,val,scale] at h ⊢ <;> exact h
private theorem one3 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 3 4 := by
  apply Between.one
  have shape : pieces3[3]! = (⟨269788867,325747125,4,7,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row3
  norm_num [Piece.Price,point,v3,args3,val,scale] at h ⊢ <;> exact h
private theorem one4 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 4 5 := by
  apply Between.one
  have shape : pieces3[4]! = (⟨325747125,382391361,6,7,16⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row4
  norm_num [Piece.Price,point,v4,args4,val,scale] at h ⊢ <;> exact h
private theorem one5 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 5 6 := by
  apply Between.one
  have shape : pieces3[5]! = (⟨382391361,410973345,2,5,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row5
  norm_num [Piece.Price,point,v5,args5,val,scale] at h ⊢ <;> exact h
private theorem one6 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 6 7 := by
  apply Between.one
  have shape : pieces3[6]! = (⟨410973345,439729987,2,5,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row6
  norm_num [Piece.Price,point,v6,args6,val,scale] at h ⊢ <;> exact h
private theorem one7 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 7 8 := by
  apply Between.one
  have shape : pieces3[7]! = (⟨439729987,468662350,2,5,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row7
  norm_num [Piece.Price,point,v7,args7,val,scale] at h ⊢ <;> exact h
private theorem one8 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 8 9 := by
  apply Between.one
  have shape : pieces3[8]! = (⟨468662350,497771511,2,5,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row8
  norm_num [Piece.Price,point,v8,args8,val,scale] at h ⊢ <;> exact h
private theorem one9 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 9 10 := by
  apply Between.one
  have shape : pieces3[9]! = (⟨497771511,527058550,2,5,8⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row9
  norm_num [Piece.Price,point,v9,args9,val,scale] at h ⊢ <;> exact h
private theorem one10 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 10 11 := by
  apply Between.one
  have shape : pieces3[10]! = (⟨527058550,556524554,4,7,16⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row10
  norm_num [Piece.Price,point,v10,args10,val,scale] at h ⊢ <;> exact h
private theorem one11 : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 11 12 := by
  apply Between.one
  have shape : pieces3[11]! = (⟨556524554,586170615,4,7,16⟩ : Piece) := by decide +kernel
  rw [shape]
  have h := row11
  norm_num [Piece.Price,point,v11,args11,val,scale] at h ⊢ <;> exact h
theorem interval : Between (Piece.Price 46.05 56 70 100000000 48189030400) pieces3 0 12 := (Between.join (Between.join (Between.join one0 (Between.join one1 one2)) (Between.join one3 (Between.join one4 one5))) (Between.join (Between.join one6 (Between.join one7 one8)) (Between.join one9 (Between.join one10 one11))))
#print axioms interval
end ProfileG3R0N12
