# Native screen base-interpreter source review

13 November 2026. PASS for the bounded source revision. No required correction found. This review read source, compared text and checked file hashes only. Neither worker nor runner was imported or executed; no FLINT evaluation or build was performed. Execution authorization remains with the coordinator.

The numerical review in WORKER_SOURCE_REVIEW.md, SHA256 177E79C7F2807839780364F9ECC220610A67A03E42CC32C8C5BB94709579BBB9, transfers to this revision. Exact text comparison matched the fixed precision/plan block and the complete suffix beginning with the local generator-order checks. Thus character identity, all eight points, completion normalization, exact Fraction threshold, outward dyadic export, strict comparison and stopping rules are unchanged. The new code before that suffix concerns interpreter admission, package loading and diagnostic identity.

## Interpreter and loading changes

The runner now invokes the pinned direct Python 3.14.7 executable with `-I -S -u`, rather than the virtual-environment redirector. It checks the executable and python314.dll hashes before launch. The worker waits for a GO line containing its own PID, then checks executable identity/hash, version, 64-bit ABI, cache tag and isolated/no-site flags. The runner assigns the original process handle to the job, verifies membership and handle/PID agreement, and only then sends GO. It checks the start event carries that same PID. The existing helper exposes the two Windows APIs used here.

This removes the specific virtual-environment redirection ambiguity. It is not a claim that every byte of interpreter startup runs inside the job: standard-library startup precedes assignment and GO. No numerical import or calculation in this source precedes GO. The inherited memory limits, active-process limit, sampled CPU/wall checks, exclusive run directory, output caps and final eight-point acceptance remain unchanged.

After GO, the worker rejects an already imported site or flint module, checks the four selected package hashes, and inserts only the explicit existing site-packages directory. It does not call site.addsitedir, so this operation does not process .pth files or site hooks. The package entry point's existing DLL-directory setup still runs normally. The worker checks the loaded package path and requires the three loaded numerical extensions to lie under the selected directory. The four selected package pins, base executable/runtime pins, virtual-environment configuration pin and native-helper pin all matched the files read during review.

Those selected pins do not constitute a complete transitive DLL or Python-module trust closure, as the revision explicitly states. Interpreter/package incompatibility remains a possible stopped attempt. There is no automatic redirector fallback. An early admission or I/O failure need not produce a worker failure event; the parent's missing-event/exit checks prevent treating it as a successful eight-point result.

## Scope

The original sources and numerical review remain preserved. A successful run would provide native interval evidence for the fixed modulus-margin tests, under the existing conditional source/error interpretation. It would not produce canonical signs, a transform array, a zero count, finite RH or an ordinary-rule HOL certificate. The delta does not justify any new precision or performance claim.

## Revision pins

| File | SHA256 |
|---|---|
| worker_v2.py | 517333F06458759348B5098EB58466B8A82AE2D97143054E34E49F2B7409483D |
| run_screen_v2.py | A10B98FC9515117EBB77CBB1074DD2B3666AC2C01814CF19E8FC37F835C5DDE0 |
| BASE_INTERPRETER_REVISION.md | D7E2C15A20057C82F48D9611C6E6F677244FF75E60B0B9E9A3656A8D8AC9D31F |
| worker.py, preserved | D2B3FF44B42DA82D4AE456344D0B2C4EED8DFB74484AC316AC6F4A1BFE2E8094 |
| run_screen.py, preserved | F82F19162C29C53F8434D800C87BF101715A6F57D78F3E1A8C55E8A42DD5E850 |

The executable, DLL, native-helper and four package hashes are literal in the reviewed v2 sources. This review binds those exact source bytes and confirms their selected file pins; it does not replace runtime admission checks.
