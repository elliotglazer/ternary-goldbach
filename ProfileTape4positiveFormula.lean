module

public import ProfileTape4positive
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape4positive
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem formula : expression tape.fetch 286 = profilePriceExpr 4 false := by decide +kernel
#print axioms formula
end ProfileTape4positive
