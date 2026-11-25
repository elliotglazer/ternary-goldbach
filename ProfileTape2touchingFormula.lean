module

public import ProfileTape2touching
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape2touching
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem formula : expression tape.fetch 215 = profilePriceExpr 2 true := by decide +kernel
#print axioms formula
end ProfileTape2touching
