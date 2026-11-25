module

public import ProfileTape8positive
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape8positive
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem formula : expression tape.fetch 410 = profilePriceExpr 8 false := by decide +kernel
#print axioms formula
end ProfileTape8positive
