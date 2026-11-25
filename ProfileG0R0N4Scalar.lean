module

public import DirectSound
public import ProfileG0R0N4Entries
public import ProfileTape1positiveFormula
public import ProfileTape1touchingFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileG0R0N4
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
#print axioms row0
end ProfileG0R0N4
