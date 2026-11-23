# Arithmetic-to-complex bridge audit

This module is prepared before the dependency/helper build completes. It has not been compiled or run. The seven expected conclusions are copied from the existing RawPairRound source and include all positive-grid premises. The audit checks exact conclusions, empty hypotheses, imported theorem tags and standard HOL ancestry. It does not accept an actual source, transform, sign or zero count.

Build the helper in raw-analytic/dependency-build-win01 first, inspect its exit and preservation receipt, then pin its outputs before compiling this audit. The audit directory is separate so loading the helper cannot rebuild or mutate the protected dependency stage. Its Holmake invocation must use no_prereqs, no-project, no_preexecs and no-cache with one job, as in the other isolated audits.


## Accepted successor

Rawaudit03 passed against the completed helper in ../raw-pair-round-proof. See that directory's RESULT_REVIEW.md for exact statements, pins, timing and scope. The original dependency stage remains preserved and contains no completed RawPairRoundTheory. Consumers must give the repaired helper priority through PRE_INCLUDES.
