module

public import DirectSound
public import ProfileG3R22N1Entries
public import ProfileTape16positiveFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileG3R22N1
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem scalar22 : (profilePriceExpr 16 false).real (fun i => val (v22 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked22 656 (by decide +kernel) _ ProfileTape16positive.formula cap22
theorem row22 : profilePrice (val (v22 0)) (val (v22 1)) (val (v22 2)) (val (v22 3)) 48189030400 16 (val (v22 5)) (val (v22 6)) (val (v22 7)) (val (v22 8)) ≤ 0.315 := by
  have h := scalar22
  rw [profilePriceExpr_real _ 16 48189030400 _] at h
  · exact h
  all_goals norm_num [v22,args22,val,scale]
#print axioms row22
end ProfileG3R22N1
