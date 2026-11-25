module

public import DirectSound
public import ProfileG1R12N1Entries
public import ProfileTape2positiveFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileG1R12N1
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem scalar12 : (profilePriceExpr 2 false).real (fun i => val (v12 i)) ≤ 0.315 :=
  direct_upper expOK atanOK checked12 224 (by decide +kernel) _ ProfileTape2positive.formula cap12
theorem row12 : profilePrice (val (v12 0)) (val (v12 1)) (val (v12 2)) (val (v12 3)) 4047962620 2 (val (v12 5)) (val (v12 6)) (val (v12 7)) (val (v12 8)) ≤ 0.315 := by
  have h := scalar12
  rw [profilePriceExpr_real _ 2 4047962620 _] at h
  · exact h
  all_goals norm_num [v12,args12,val,scale]
#print axioms row12
end ProfileG1R12N1
