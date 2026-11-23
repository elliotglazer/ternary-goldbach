# Windows Python adapter for the graph-only preflight

Prepared without execution. The original Linux runner, its wrappers and its plan remain unchanged as an unrun attempt. Root found no Python 3 in docker-desktop or the setup sysroot; this adapter installs nothing.

## First command for root

From the repository root in PowerShell:

```powershell
& 'C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe' -B `
  'work/backend-costs-20261112/hol-platt/raw-analytic/preflight_windows.py'
```

Default output is the new, exclusively created directory `dependency-build-win01`. Existing directories are refused. A deliberate fresh name may be given with `--stage dependency-build-NAME`. No theory build action is implemented in this adapter.

The Windows Python process verifies the same pinned manifest and all 45 source files, stages their exact bytes plus the owned helper, and writes a custom Holmakefile using Linux mount paths. The exact source total remains 2,756,114 bytes. It imports only reusable validation/hash helpers from the hash-pinned original runner. That import runs no main/configuration/execution function; bytecode writes are disabled. The original Linux runner does not need to execute under Linux.

Paths are translated only from Windows drive C to `/mnt/host/c/...`. Another drive is rejected. The WSL executable is the existing Windows `System32/wsl.exe`; the distribution is fixed to `docker-desktop`.

## Fixed shell program and positional paths

The adapter passes an argv list to `subprocess.Popen`, with no shell on the Windows side:

    wsl.exe -d docker-desktop --exec sh -c STATIC_PROGRAM
      raw-analytic-preflight LINUX_STAGE LINUX_RUN_SH LINUX_HOLMAKE

The static program is:

```sh
set -eu
cd "$1"
ulimit -v 4194304
ulimit -c 0
unset HOLBUILD
exec "$2" timeout -k 5 180 "$3" --no_prereqs --no-project --no_preexecs --no-cache -j1 --json RawPairRoundTheory.uo
```

No path is inserted into shell source. The existing setup/run.sh supplies the library path and executable search path for the existing timeout/Holmake runtime. Linux timeout bounds the actual graph process to 180 seconds, then allows five seconds before forced termination. The inherited Linux address-space limit is 4 GiB per process. There is one Holmake job.

A 240-second Windows wrapper cap catches a stuck WSL launcher. Ending the Windows launcher alone is not evidence that a Linux process group has exited; the Linux timeout is the authoritative graph bound. The result receipt explicitly retains that distinction. A WSL/runtime failure is a failed preflight, not permission to run an unbounded alternative.

## Graph gate and outputs

The graph gate uses Linux path semantics even though its validator runs on Windows. It checks the pinned HM_DepGraph schema and rejects:

- any command target or command working directory outside the owned Linux stage;
- phony actions or custom shell commands;
- unknown theory/support-module outputs or BIC script names;
- an unresolved external prerequisite, malformed node, duplicate ID or dangling edge.

It validates every command-bearing node, including any node marked fresh. Limits are unchanged: at most 16 MiB parsed graph, 10,000 graph nodes, 10,000 stage files, 2 GiB stage storage and 64 MiB per log. File/log checks are polled every half second, so they are not atomic disk quotas.

Outputs include `windows_stage_binding.json`, the exact argv/static shell program, graph stdout/stderr, wall/exit receipt, graph validation receipt and, only on complete success, `WINDOWS_PREFLIGHT_PASSED.json`. Original source and boundary hashes are checked before and after the graph command; staged source hashes are checked again. All failures preserve the new stage.

This pass gate is intentionally different from the original Linux runner's `PREFLIGHT_PASSED.json`. The original Python-based build wrappers still cannot run in the current Linux environment. Root must review this concrete graph and approve a separate Windows-to-WSL build adapter or bounded shell build command before any theory compilation. Do not fabricate or rename pass gates to bypass that step.

## Pins and status

- Windows adapter `preflight_windows.py`: `D9A02AD7A656D390082E5207C8EAC19D70E12C3F241FE51C972F521A4DB67461`.
- Preserved original runner `isolated_dependencies.py`: `52CD80D1B83B464D2DA28302799680A3668C256972C75B6022E279FB1AAF6E3E`.
- Shared manifest `dependency_inputs.json`: `D02012728214E9A4A069DABCC65F45D2CF8BD91BF5347282D8930C42EEA6AD86`.
- Owned helper remains `FE67132187C0E3C07FD256BB3B475A41333BAB49C70B7E49CB5B2CFCA946F0D1`.

The adapter has not been run or syntax-tested during this task. The first root launch must validate its runtime behavior. No new dependency, transcendental enclosure, raw-state source theorem or L-function result is claimed.
