module

public import DirectSound
public import ProfileG2R0N12Entries
public import ProfileTape1positiveFormula
public import ProfileTape1touchingFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileG2R0N12
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem scalar0 : (profilePriceExpr 1 true).real (fun i => val (v0 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked0 178 (by decide +kernel) _ ProfileTape1touching.formula cap0
theorem row0 : profilePrice (val (v0 0)) (val (v0 1)) (val (v0 2)) (val (v0 3)) 100000000 1 (val (v0 5)) (val (v0 6)) (val (v0 7)) (val (v0 8)) ≤ 0.315 := by
  have h := scalar0
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v0,args0,val,scale]
theorem scalar1 : (profilePriceExpr 1 false).real (fun i => val (v1 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked1 184 (by decide +kernel) _ ProfileTape1positive.formula cap1
theorem row1 : profilePrice (val (v1 0)) (val (v1 1)) (val (v1 2)) (val (v1 3)) 100000000 1 (val (v1 5)) (val (v1 6)) (val (v1 7)) (val (v1 8)) ≤ 0.315 := by
  have h := scalar1
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v1,args1,val,scale]
theorem scalar2 : (profilePriceExpr 1 false).real (fun i => val (v2 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked2 184 (by decide +kernel) _ ProfileTape1positive.formula cap2
theorem row2 : profilePrice (val (v2 0)) (val (v2 1)) (val (v2 2)) (val (v2 3)) 100000000 1 (val (v2 5)) (val (v2 6)) (val (v2 7)) (val (v2 8)) ≤ 0.315 := by
  have h := scalar2
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v2,args2,val,scale]
theorem scalar3 : (profilePriceExpr 1 false).real (fun i => val (v3 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked3 184 (by decide +kernel) _ ProfileTape1positive.formula cap3
theorem row3 : profilePrice (val (v3 0)) (val (v3 1)) (val (v3 2)) (val (v3 3)) 100000000 1 (val (v3 5)) (val (v3 6)) (val (v3 7)) (val (v3 8)) ≤ 0.315 := by
  have h := scalar3
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v3,args3,val,scale]
theorem scalar4 : (profilePriceExpr 1 false).real (fun i => val (v4 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked4 184 (by decide +kernel) _ ProfileTape1positive.formula cap4
theorem row4 : profilePrice (val (v4 0)) (val (v4 1)) (val (v4 2)) (val (v4 3)) 100000000 1 (val (v4 5)) (val (v4 6)) (val (v4 7)) (val (v4 8)) ≤ 0.315 := by
  have h := scalar4
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v4,args4,val,scale]
theorem scalar5 : (profilePriceExpr 1 false).real (fun i => val (v5 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked5 184 (by decide +kernel) _ ProfileTape1positive.formula cap5
theorem row5 : profilePrice (val (v5 0)) (val (v5 1)) (val (v5 2)) (val (v5 3)) 100000000 1 (val (v5 5)) (val (v5 6)) (val (v5 7)) (val (v5 8)) ≤ 0.315 := by
  have h := scalar5
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v5,args5,val,scale]
theorem scalar6 : (profilePriceExpr 1 false).real (fun i => val (v6 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked6 184 (by decide +kernel) _ ProfileTape1positive.formula cap6
theorem row6 : profilePrice (val (v6 0)) (val (v6 1)) (val (v6 2)) (val (v6 3)) 100000000 1 (val (v6 5)) (val (v6 6)) (val (v6 7)) (val (v6 8)) ≤ 0.315 := by
  have h := scalar6
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v6,args6,val,scale]
theorem scalar7 : (profilePriceExpr 1 false).real (fun i => val (v7 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked7 184 (by decide +kernel) _ ProfileTape1positive.formula cap7
theorem row7 : profilePrice (val (v7 0)) (val (v7 1)) (val (v7 2)) (val (v7 3)) 100000000 1 (val (v7 5)) (val (v7 6)) (val (v7 7)) (val (v7 8)) ≤ 0.315 := by
  have h := scalar7
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v7,args7,val,scale]
theorem scalar8 : (profilePriceExpr 1 false).real (fun i => val (v8 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked8 184 (by decide +kernel) _ ProfileTape1positive.formula cap8
theorem row8 : profilePrice (val (v8 0)) (val (v8 1)) (val (v8 2)) (val (v8 3)) 100000000 1 (val (v8 5)) (val (v8 6)) (val (v8 7)) (val (v8 8)) ≤ 0.315 := by
  have h := scalar8
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v8,args8,val,scale]
theorem scalar9 : (profilePriceExpr 1 false).real (fun i => val (v9 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked9 184 (by decide +kernel) _ ProfileTape1positive.formula cap9
theorem row9 : profilePrice (val (v9 0)) (val (v9 1)) (val (v9 2)) (val (v9 3)) 100000000 1 (val (v9 5)) (val (v9 6)) (val (v9 7)) (val (v9 8)) ≤ 0.315 := by
  have h := scalar9
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v9,args9,val,scale]
theorem scalar10 : (profilePriceExpr 1 false).real (fun i => val (v10 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked10 184 (by decide +kernel) _ ProfileTape1positive.formula cap10
theorem row10 : profilePrice (val (v10 0)) (val (v10 1)) (val (v10 2)) (val (v10 3)) 100000000 1 (val (v10 5)) (val (v10 6)) (val (v10 7)) (val (v10 8)) ≤ 0.315 := by
  have h := scalar10
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v10,args10,val,scale]
theorem scalar11 : (profilePriceExpr 1 false).real (fun i => val (v11 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked11 184 (by decide +kernel) _ ProfileTape1positive.formula cap11
theorem row11 : profilePrice (val (v11 0)) (val (v11 1)) (val (v11 2)) (val (v11 3)) 100000000 1 (val (v11 5)) (val (v11 6)) (val (v11 7)) (val (v11 8)) ≤ 0.315 := by
  have h := scalar11
  rw [profilePriceExpr_real _ 1 100000000 _] at h
  · exact h
  all_goals norm_num [v11,args11,val,scale]
#print axioms row0
end ProfileG2R0N12
