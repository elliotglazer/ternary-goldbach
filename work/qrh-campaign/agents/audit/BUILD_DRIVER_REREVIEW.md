# Build-driver repair re-review

Driver SHA256: D70B96192B3CCCD9FB6E43095082CD35AFF8F0CE1F4F16915A730D9304F23704
legacy-validated.json SHA256: 22A7B54BEEB2DB5CA0E26D11BA5B493548A08DAFCC3ED90C48D63747E8BCB64E

Verdict: both P1 findings from BUILD_DRIVER_REVIEW.md are closed for the current legacy non-module project, immutable external packages, and externally enforced single-writer/no-readers publication policy. No compiler was launched, and no driver, source or artifact file was changed during this review. Integration was informed there is no audit objection to resuming the planned serial build.

## Receipt and inventory changes checked

Timestamp-only legacy acceptance has been removed. A normal cache hit requires a matching key and exact artifact filename/hash inventory. The key now includes the source hash, hashes of all direct project dependency receipts, compiler executable hash, compile options, package paths and target manifest hash. A receipt-less generation can be retained only through the explicit legacy inventory matching exact source, artifact, environment and direct dependency source/artifact hashes.

Staging directories use fresh UUIDs and are not reused. On exit0 the driver rechecks the source hash, validates the exact produced set and computes every artifact hash. It invalidates the old receipt before modifying any destination, removes known obsolete companion names, replaces all produced files, and publishes the receipt last using an atomic file replacement. Interruption during promotion leaves no matching receipt; a later cache lookup either recognizes an exact explicitly approved legacy generation or rebuilds. Corrupted, removed or mismatched recorded artifacts no longer pass cache validation.

For the current non-module project sources the expected set is correctly just the main .olean. This agrees with installed Lean4.35 Environment.writeModule. No .olean.server, .olean.private, .ir.sig or .ir is required for these files. The generic module-system branch has not been needed or tested here.

## Legacy evidence inventory checked

A read-only Python replay independently validated all16 allowlist entries against current files:

- Every source hash matches.
- Every artifact hash matches and every inventory contains exactly one nonempty-named .olean entry.
- Every direct project import is represented in the dependency binding.
- Every dependency source/artifact hash matches disk.
- There are no direct project dependencies outside the16-entry allowlist.
- Every evidence entry matches compile-timings.json.
- Compiler executable and project manifest hashes match.

Fifteen entries have explicitly recorded exit_code0. TernaryGoldbach.Statement has an explicitly different provenance: its exported artifact was successfully imported by the checked CircleMethod, while the original session exit status is unavailable. This is the permitted successful-import evidence route, not an invented exit0 or an inference from an empty log. The artifact hash bound in CircleMethod's dependency record equals the allowlisted Statement artifact hash.

The historical exit/import events are recorded by the integration worker; this reviewer checked consistency of their records and exact current bindings, not a replay of those historical compiler processes.

## Remaining limits

The publication protocol is crash-detecting and safe for restart under no concurrent readers; per-file replacement is not an atomic multi-file generation switch. The scheduler, rather than an interprocess lock, enforces one writer and no readers during promotion.

The read-only external package set remains an explicit environmental assumption. Compiler/options/package paths/target manifest are bound, but individual installed package artifacts and runtime libraries are not independently rehashed by every lookup. This is acceptable within the stated immutable-package scope, not a promise of general cache soundness under package mutation.

The line-based import parser has the previously noted general limitations. A scan of the current source tree found no unsupported import prefixes and no omitted local namespace. Do not infer support for future meta-import/comment/module syntax variants from this re-review. The current fixed source/import scope does not require delaying the build for that broader engineering work.
