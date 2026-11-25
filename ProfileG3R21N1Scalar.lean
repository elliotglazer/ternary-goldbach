module

public import DirectSound
public import ProfileG3R21N1Entries
public import ProfileTape16positiveFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileG3R21N1
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem scalar21 : (profilePriceExpr 16 false).real (fun i => val (v21 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked21 656 (by decide +kernel) _ ProfileTape16positive.formula cap21
theorem row21 : profilePrice (val (v21 0)) (val (v21 1)) (val (v21 2)) (val (v21 3)) 48189030400 16 (val (v21 5)) (val (v21 6)) (val (v21 7)) (val (v21 8)) ≤ 0.315 := by
  have h := scalar21
  rw [profilePriceExpr_real _ 16 48189030400 _] at h
  · exact h
  all_goals norm_num [v21,args21,val,scale]
#print axioms row21
end ProfileG3R21N1
