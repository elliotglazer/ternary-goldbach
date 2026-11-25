module

public import ProfileTape1positive
public import ScaledBinding
public import ProfileFormula

@[expose] public section

open ScaledGrid GoldbachEnergy
namespace ProfileTape1positive
set_option maxHeartbeats 0
set_option maxRecDepth 65536
theorem formula : expression tape.fetch 184 = profilePriceExpr 1 false := by decide +kernel
#print axioms formula
end ProfileTape1positive
