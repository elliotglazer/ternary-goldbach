module

public import ProfileTape1touching
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape1touching
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem formula : expression tape.fetch 178 = profilePriceExpr 1 true := by decide +kernel
#print axioms formula
end ProfileTape1touching
