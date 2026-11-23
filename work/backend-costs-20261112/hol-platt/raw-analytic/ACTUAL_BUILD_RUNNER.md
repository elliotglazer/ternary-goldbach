# One cached-stage build

`build_existing_windows.py` is an unexecuted runner for one intentional build of `RawPairRoundTheory.uo` in the existing `dependency-build-win01` directory. It preserves the original failed preflight, the successful graph command, and both offline validation attempts. It does not stage sources again or run another graph scan.

Before execution it binds the accepted offline receipt `E6E5B91478C0E7B808DD914BAC09B208110FFA924F2C4752E9681BB89A748B3D`, its graph/validator hashes, the original input manifest, the exact local Holmakefile, every original and staged source, and the exact 40-file starting object set. It requires a new output directory named `build-existing-win01`; that directory is created exclusively, and a second invocation is refused.

The static Linux command invokes existing `run.sh`, then `/usr/bin/time -v`, then `timeout -k 15 10800`, then the installed Holmake with:

```text
--no_prereqs --no-project --no_preexecs --no-cache -j1 RawPairRoundTheory.uo
```

There is no `--json`. The target is intentionally built. All paths are passed as separate arguments into fixed shell text. The runner starts no installations and never changes the original HOL source tree. The already-validated target closure permits only local active build commands; original compiled prerequisites are reused.

The Linux process has a 4 GiB per-process address-space limit, no core dumps, a three-hour execution timeout and a fifteen-second kill grace. A regular-file limit of 32,768 shell blocks bounds each build log and generated file to at most 32 MiB, or 16 MiB on shells whose blocks are 512 bytes. This deliberately conservative limit can stop an oversized generated file too. Such a stop is a recorded failure, not a reason for automatic retry. The 10,900-second Windows wait is a fallback; if it fires, root must check Linux survivors before any further command. Existing 2 GiB stage and 10,000-file bounds are checked before and after the run, not claimed as continuously enforced quotas.

Build stdout, stderr and GNU time output are separate new files. Windows launcher diagnostics have separate files. The final receipt retains user CPU, system CPU, elapsed wall time, maximum resident set size and exit status exactly as printed by GNU time. Peak RSS is GNU time's process-family statistic, not a sampled sum of simultaneous resident memory. Setup/compiler/dependency work for this single Holmake invocation is included; already completed cached theories from the partial attempt are excluded and retain their separate historical evidence.

After either success or failure, the runner rechecks all original and staged source inputs and old logs/bindings. New or regenerated local object files are allowed and inventoried with hashes. A pass requires exit zero, the five expected helper output files, complete GNU time fields and all postchecks. The receipt is build evidence; theorem semantics and axiom checks remain a separate review.

Root can execute once, serially after the active handoff:

```powershell
& 'C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe' -B 'C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112/hol-platt/raw-analytic/build_existing_windows.py'
```

No build or runner execution was performed while preparing this file. The helper still makes no claim about actual transcendental inputs, recurrence source values, Dirichlet L-functions or a final sign block.
