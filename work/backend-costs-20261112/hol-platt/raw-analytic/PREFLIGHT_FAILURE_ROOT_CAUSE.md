# Dependency preflight failure and recovery

The first Windows preflight performed an actual partial build. Its graph-only claim was incorrect. I missed a control-flow branch in Holmake when preparing the runner. The failed attempt and its outputs are preserved; no recovery command has been run by this agent.

## Cause

The original command ended with `--json RawPairRoundTheory.uo`. In the pinned HOL source, `tools/Holmake/core/Holmake.sml:2474`, `dispatch_built_graph` handles `show_json` by printing the graph and exiting. However, the explicit-target branch of `work` at lines 2645–2662 does not call that dispatcher. It checks only `cline_nobuild`, then calls `build_graph`. Thus an explicit target bypasses JSON-only handling. The no-target branch at lines 2629–2642 calls the dispatcher correctly.

This explains the observed build without assuming a binary/source mismatch. `HM_Core_Cline.sml:314` does document JSON output followed by termination, but that description is insufficient to establish the behavior of the explicit-target branch. The source SHA256 is `77E43540BF2E3F06661C9E3C4BFFD50EB55DD44EC67B61B6471FA0A00B675923`.

The minimal recovery command omits the positional target. The unchanged local Holmakefile supplies `all: RawPairRoundTheory.uo`. An explicit-target `-n` command would also avoid builds in this source, but would print a dispatch listing rather than the required JSON graph.

The original `preflight_windows.py`, Linux `isolated_dependencies.py`, and their old documentation remain historical evidence. Their explicit-target JSON commands must not be reused as graph-only checks.

## Observed partial result

The Windows receipt reports 180.565913 seconds and exit 15. The output begins `Holmake: Building 20 theory files`. It records completed exports for `hrat`, `hreal`, `realax`, and `real_arith`, then starts the `realScript.uo` theory builder. It does not record a completed `realTheory` export. Root separately checked Linux processes and reported no surviving matching processes.

Read-only verification matched 108 source/boundary records: 45 original sources, the same 45 staged sources, 16 pinned boundary files, and the original/staged helper. This verifies those named files, not every byte of the installation. All hashes and the complete local inventory are in `PREFLIGHT_FAILURE_READONLY_SNAPSHOT.json`, SHA256 `59027E210E968EE8D8CA5825FDE2DDAE5E63AEB246ACF38D2B45829987F861FE`.

That snapshot records 173 stage files totaling 3,776,221 bytes. The 40 files in `.hol/objs` consist of:

- Complete six-file `cachekey/dat/sig/sml/ui/uo` sets for the four completed theories.
- `ui/uo` pairs for `Cond_rewrite`, `hol88Lib`, `RealArith`, `RealArith0`, `realPP`, `realSyntax`, and `realScript`.
- `Diff.ui` and `realSimps.ui` without corresponding `.uo` files.

`realScript.uo` is the builder, not a completed `realTheory.uo`. Interface files alone are not completed module proofs. These outputs remain eligible for normal timestamp/dependency reuse in a later authorized build; none should be deleted merely to restart the preflight.

The failed output SHA256 is `5B9112DEF37299D82F8BF35F8808C7A03728FEDE4FCC5FE76F29BD46F161F747`. Its result receipt SHA256 is `764F4C1474F73B61BA2BD900C146B6BB9C4B74F5AE68C286100E3EE9B1EECC02`. The unchanged local Holmakefile SHA256 is `B0A469EFE1501FDD6D7CB0D6A9F49AB81665DFFF25EED7231508354B89ABB18D`.

## Recovery preflight

`recover_preflight_windows.py` reuses the existing `dependency-build-win01` directory. It does not copy sources, rewrite its Holmakefile, or overwrite the original logs/bindings. It verifies the original adapter, input manifest, dispatch source, failed receipt/output, all original boundary files, staged inputs, and the complete recorded partial inventory before invoking Holmake.

The command runs through existing Windows Python, WSL, and `hol4-setup/run.sh`. It passes paths as arguments to fixed shell text, omits any positional Holmake target, disables prerequisite/project/preexec processing and the build cache, and retains one job, a 4 GiB per-process address-space cap, a 180-second Linux timeout plus five-second kill grace, and a 240-second Windows monitor. The existing stage/file/log caps remain in force.

The graph validator grants exactly one special case for a local `all` node. Its command must be empty, its directory must be the stage, and it must depend only on the exact local `RawPairRoundTheory.uo` node. No other node may depend on it. Node IDs remain unique across the full graph. Only that checked root is removed in a separately recorded component graph; the unchanged strict validator then checks all remaining nodes and rejects phony/custom commands and prospective compilation outside the stage. This is not a general exemption for phony or empty-command targets.

After graph validation, all preexisting files except refreshable `.hol/make-deps` metadata must retain their hashes. The entire `.hol/objs` file set must remain identical. Original inputs are verified again. New logs use exclusive creation and the `recovery01` prefix; the final gate binds the corrected runner, original manifest, failure snapshot and graph. If any check fails, the run stops without retry or cleanup.

Root may run this single recovery command after confirming that no previous process survives:

```powershell
& 'C:/Users/glaze/AppData/Local/Python/pythoncore-3.14-64/python.exe' -B 'C:/Users/glaze/Documents/Codex/2026-11-10/https-github-com-sthubbar-goldbach-lean/work/backend-costs-20261112/hol-platt/raw-analytic/recover_preflight_windows.py' --confirmed-no-survivors
```

This source has been inspected but not executed or runtime-validated. Successful recovery would establish a checked prospective dependency graph only. It does not authorize or certify another theory build. A later build should explicitly use the existing stage and its retained outputs, receive its own command/log names and build timeout, and run only after root reviews the recovery graph. The first unfinished theory is `real`; dependency resolution, rather than deleting local caches, should determine the remaining work. The helper and any actual transcendental or L-function semantics remain uncompiled/unproved by this recovery.
