import RawLogCases64
import RawInverseRootGenerated64

#print axioms RawInverseRootGenerated64.all_inverse_roots

run_cmd do
  let env ← Lean.getEnv
  let some (.thmInfo supplied) := env.find? ``RawLogCases64.all_inverse_roots
    | throwError "missing supplied-witness root"
  let some (.thmInfo generated) := env.find? ``RawInverseRootGenerated64.all_inverse_roots
    | throwError "missing computed-candidate root"
  unless Lean.Expr.equal supplied.type generated.type do
    throwError "inverse-root experiment types differ"
  Lean.logInfo "MATCHED_TYPE,64,supplied_and_generated_inverse_roots"
