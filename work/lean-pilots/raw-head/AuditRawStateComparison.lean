import RawStateExplicitClosure
import RawStateComputedPacked
import RawStateControls

#print axioms RawStateExplicit.full_output_checked
#print axioms RawStateComputedPacked.full_output_checked
#print axioms RawHead.inverseRootCandidate_eq_of_square_bounds
#print axioms RawHead.traceCertificate_actual_error

run_cmd do
  let env ← Lean.getEnv
  let some explicit := env.find? `RawStateExplicit.full_output_checked
    | throwError "Missing explicit full-output theorem"
  let some computed := env.find? `RawStateComputedPacked.full_output_checked
    | throwError "Missing computed full-output theorem"
  unless Lean.Expr.equal explicit.type computed.type do
    throwError "Full output contracts are not structurally identical"
  Lean.logInfo "MATCHED_STATE_CONTRACT,8,129,full_output_and_analytic_enclosures"
