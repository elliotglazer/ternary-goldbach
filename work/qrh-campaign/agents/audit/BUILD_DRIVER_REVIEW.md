# Build-driver cache and publication audit

Reviewed file: agents/integration/build_project.py
SHA256: 44CEEDB6C39F35AC948609588FF171A854D834E913537BC413758CD961FE58A0
Status: concrete defects found. Read-only review; no compiler launched, no driver or artifact changes made.

## Findings

### P1: Receipt-less legacy reuse does not establish success (lines47-52)

The predicate accepts any existing main output and any existing log if the output mtime is at least every direct input mtime. A success receipt is checked only if one happens to exist. Consequently an empty/truncated .olean left by an interrupted old direct-output serialization is accepted when its mtime is recent; an empty or failure log also passes. No exit status, output integrity or import result is tested. The comment calling these outputs successful is not supported by the predicate.

Installed Lean4.35 Elab/Frontend.lean:382-389 avoids serialization after elaboration errors, but this does not rule out interruption during serialization itself. Therefore lack of reported elaboration errors is not an adequate legacy-success certificate. I did not find or allege a currently failed legacy artifact; the issue is that this code cannot distinguish it from a successful one.

Repair: require a matching validated receipt for every reusable output. Keep expensive proven legacy artifacts only through an explicit inventory bound to their exact source/dependency/output hashes and recorded exit0 or successful-import evidence. Absence of a receipt must be a cache miss unless such an inventory explicitly vouches for that module.

### P1: Companion generation is neither checked by cache nor atomically published (lines44-49,65-73)

The receipt records source hash and direct dependency .olean mtimes, but no output inventory or artifact hashes. Cache hits test only the main .olean. Deleted, truncated or mismatched .olean.server/.olean.private/.ir.sig/.ir files therefore do not invalidate the cache. Changing only a dependency companion also does not invalidate its consumer.

Installed Lean4.35 Environment.lean:1773-1784 explicitly requires files passed to readModuleDataParts to come from one saveModuleDataParts call. At1902-1918, writeModule writes three .olean parts for a module-system file and normally an .ir.sig/.ir pair; legacy files write one .olean. At2079-2106, loading a module-system .olean reads its server/private companions, and IR loading uses the .ir.sig/.ir pair if the signature file exists. These are not arbitrary independent sidecars.

The staging step protects the old destination while Lean runs. However, replacing companions one at a time and the main file last is only per-file atomic. A crash between replacements can leave a mixed generation. There is also no removal of stale companions when the produced artifact set shrinks. The current timestamp-only legacy fallback can then accept a partially published generation after a crash before receipt creation. An older receipt is not invalidated before replacement either.

Repair: use a unique empty staging directory for each attempt; validate the exact expected artifact inventory and hash every file before publication; invalidate the destination receipt before the first mutation; publish the complete set and remove only known obsolete companions for this module; write an atomic receipt last with the full artifact inventory/hashes. Every cache lookup must validate that inventory and those hashes.

Under the existing single-writer policy, this receipt-last protocol is sufficient for fail-closed restart provided no compiler/editor/other reader accesses the affected module during publication. A crash leaves no valid manifest and triggers repair/rebuild before consumers run. It is not genuinely atomic for concurrent readers. That stronger requirement needs immutable generation directories with readers pinned to one generation (or a shared read/write lock). Windows does not make replacement of a populated destination directory atomic merely by calling rename/os.replace; a generation-pointer protocol must be designed explicitly.

### P2: Dependency identity is incomplete (lines24-27,44-46)

For the current pinned source tree, I scanned852 distinct import lines: no leading-whitespace/meta prefix unsupported by the current regex occurred, and there was no bare `import TernaryGoldbach` case. Current local imports are the TernaryGoldbach.* modules plus LadderHints, so the source-level project import closure appears complete for this snapshot.

The scanner is not a general Lean import parser. Lean4.35 supports meta import and public meta import; leading whitespace and block comments are also not parsed properly by this line regex. A future valid source change can silently omit a dependency, or a commented import can become a spurious one. The seen set also suppresses cycles without reporting them. These are not observed missing edges in the current source snapshot.

More immediately, direct project dependencies are represented only by main-output timestamps. Their full manifests should be used instead, so companion changes and same-mtime output replacement cannot preserve a stale consumer. External dependencies, the actual compiler executable, compile options and resolved LEAN_PATH are not identified: the literal strings '4.35.0' and the Mathlib commit are not verification of the installed files. Thus reuse is valid only under an unstated assumption that all external packages/toolchain/configuration remain immutable at exactly the previously validated state.

Repair: include the compiler identity, command/options, resolved package configuration/pins, and direct dependency manifest hashes in the key. For the fixed read-only external package set, one validated environment manifest is sufficient; it need not hash the entire package cache on every invocation. For import scanning, use a proper Lean dependency mechanism when a safe compiler slot is available, or a conservative header parser that supports comments/modifiers and fails closed on unsupported syntax.

## Other scope limits

The runner has no interprocess lock, so its comment about one process at a time is true within an invocation only. The scheduler currently supplies the external single-writer guarantee; a second invocation would race on logs, receipts and destinations. The staging name uses only PID and mkdir(exist_ok=True), so a stale directory from a recycled PID could contaminate a later promotion. A unique temporary directory and an explicit per-module inventory address this without deleting arbitrary files.

The exit0 check before promotion is correct, and placing staging beside the destination keeps each os.replace on one filesystem. The code does not modify cached Mathlib artifacts. No .ilean is requested by its Lean command, so lack of .ilean alone is not a missing-required-artifact bug. Required companion sets differ between module-system and legacy inputs and must be handled accordingly.

## Minimal next action

The repair proposal was sent directly to qrh_integration, as requested. Integration owns modifications. Preserve the current running compiler, fix cache validation for the next invocation, and backfill only explicitly evidenced legacy receipts. Re-review the revised code before treating the cache as a checked-proof inventory.
