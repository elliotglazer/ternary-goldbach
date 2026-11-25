module

public import ProfileTape16positive
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape16positive
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem formula : expression tape.fetch 656 = profilePriceExpr 16 false := by decide +kernel
#print axioms formula
end ProfileTape16positive
