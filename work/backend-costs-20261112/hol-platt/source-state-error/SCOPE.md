# Persistent source-state error candidate

The program under analysis is SourceArithmetic.source_state, using its literal source_mul update. No numerical program is replaced. The candidate joins that multiplication to the accepted RawPairRound bound, proves a genuine complex modulus triangle inequality, retains the product cross term, and propagates errors through every actual stored update.

The final theorem is deliberately conditional on initial accuracy, step accuracy, a unit exact step and the exact target recurrence. Those are producer and analytic obligations still to be proved. It does not certify logarithms, exponential phases, inverse roots, source values, signs or counts. The declared scalar envelope includes the previous error multiplied by 1+stepError, plus stepError and the actual rounding allowance. No state radius is reset.

Eight exact expected root conclusions are captured once in the reload audit from the reviewed candidate statements. Proof-body repairs must retain those conclusions; the audit is not regenerated to follow statement changes. Complete construction, the reload audit and recorded-result checks are required before acceptance. No performance or forecast improvement is claimed.
