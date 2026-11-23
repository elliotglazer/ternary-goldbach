# Checking the actual Goldbach zero-sum theorem

The target is `TernaryGoldbach.Explicit.localized_low_zeros_lt` in `LocalLowZeros.lean`. It imports `WeilNumC` and the new full-RH window. The upstream `WeilWindow` imports `PsiPlateau` as well as `WeilBridge`. The combined upstream import closure at Goldbach commit `23b2d68ca344203d4384e0aff7affa4ec034bef9` contains 73 Goldbach modules. The dependency order, per-module import edges, validated caches and exact revisions for all nine external packages are in [plan.json](./plan.json).

The initial audit validated 24 existing Goldbach artifact inventories against their source hashes and immediate dependency receipts. Sixteen originated in the November 10 build and its legacy validation. One of these, `Statement`, preserves a downstream successful import and the artifact hash without its original compiler exit status. The other 49 Goldbach modules require compilation from source. The standard Mathlib and package caches live outside this project and are read-only during this build. Each successful upstream module is retained for resume via the existing `build_project.py` receipt protocol.

Run from `team/local-window` in PowerShell. The compiler is the installed Windows Lean 4.35.0. These commands use the bundled Python interpreter and the existing pinned dependencies.

```powershell
$windowPython = Join-Path $env:USERPROFILE '.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe'
& $windowPython closure.py plan
& $windowPython closure.py all
```

The `all` action builds the upstream targets in dependency order with one Lean process, two worker threads and `-M4096`. It then checks the seven local modules and the final axiom audit using `-t0 -j1 -M4096`. Run `closure.py upstream` or `closure.py local` to select either stage. The local pass verifies the upstream receipts before starting and uses a separate artifact directory. A failed module writes a log. Successfully compiled modules remain available for the next run.

The first 23 timed historical modules averaged 113.3 seconds each, with a median of 44.9. At these rates, the initial 49 uncached upstream modules represent 93 or 37 minutes of serial wall time, respectively. The old timings come from different modules and a different machine load. The local density, weight and extension audit timings ranged from 40 to 402 seconds per invocation. A full-run wall-time estimate should be updated against current upstream timings, separately from these measured standalone checks. Time to repair source or porting errors is unmeasured.

On November 20 the actual upstream `WeilTest` module compiled in 330.4 seconds, and the driver reused its artifact when starting `WeilPrime`. If the initial 49 modules averaged the same time as `WeilTest`, the upstream stage would take 4.5 wall hours. The historical median and mean together with this first current timing suggest budgeting roughly one to five serial hours before allowing for source repairs. The first new [success receipt](../../../../qrh-campaign/agents/integration/logs/TernaryGoldbach.Explicit.WeilTest.success.json) binds both its source and compiled artifact.

`WeilPrime` subsequently compiled in 130.4 seconds. Its [success receipt](../../../../qrh-campaign/agents/integration/logs/TernaryGoldbach.Explicit.WeilPrime.success.json) records the hash of the `WeilTest` receipt it consumed. The updated plan validates 26 of 73 upstream modules. At the average of these two current observations, the remaining 47 modules would take about three serial wall hours before the local integration and axiom audit. The next uncached original module in the order is `TernaryGoldbach.Explicit.ZetaExplicit`.

A full `all` run started at 10:00 a.m. Pacific on November 20 at below-normal process priority. [Live build output](run-20261120.log) · [Driver diagnostics](run-20261120.err) · [Process ID](run-20261120.pid). To resume after interruption, run the same `all` command once the recorded worker has exited.
