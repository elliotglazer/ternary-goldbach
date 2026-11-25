module

public import ProfileTape2positive
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape2positive
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem formula : expression tape.fetch 224 = profilePriceExpr 2 false := by decide +kernel
#print axioms formula
end ProfileTape2positive
