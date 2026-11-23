# Runnable isolated dependency preflight

Status: written and checked against the pinned Holmake source format; not executed. No stage, graph, dependency object or HOL proof has been produced by these scripts. The existing `RawPairRoundScript.sml` and previously supplied plan remain unchanged.

## First command: stage and inspect only

From the repository root, in the existing Linux HOL environment with Python 3:

```sh
sh work/backend-costs-20261112/hol-platt/raw-analytic/preflight_dependencies.sh
```

This creates the previously nonexistent owned directory `dependency-build-01`. It verifies the pinned 45 source/interface files, copies their exact bytes and the owned helper, writes a local Holmakefile, and runs only `Holmake --json`. It validates the resulting dependency graph before writing `PREFLIGHT_PASSED.json`.

The exact 45 inputs, lengths and SHA256 values are in `dependency_inputs.json`. They total 2,756,114 bytes. The manifest also pins the helper and the named upstream objects, Holmake binary, state, environment wrapper and graph/option source implementations. The runner hardcodes the manifest's hash. Every later action verifies all original pins and all staged source copies again.

The graph checker follows `HM_DepGraph.nodeInfo_toJSON`: top-level array; each node has `node_id`, absolute `target`, `dir`, `dependencies`, `command`, `phony`, `mtime`, `seqnum` and `needs_rebuild`. The actual supported command strings are `BIC_Compile`, `BIC_Build <theory>` and the empty string. It rejects shell commands, phony targets, unresolved external prerequisites and every compilation command whose target or working directory is outside the exact owned stage. It restricts generated module names to the 19 theory/14 support closure plus RawPairRound. It validates unique IDs and all edges. An unfamiliar output/schema fails closed instead of silently expanding scope.

A graph failure leaves the copied sources and logs for inspection and writes no pass gate. It does not trigger a dependency build. The graph is capped at 16 MiB and 10,000 nodes, and its process at 180 seconds.

## Separate root actions after review

Only after reviewing `logs/preflight_graph.out`, its validation receipt and `PREFLIGHT_PASSED.json`:

```sh
sh work/backend-costs-20261112/hol-platt/raw-analytic/build_dependencies.sh
```

This builds explicit local theory targets in dependency order, then the real arithmetic proof libraries. Before each target it emits and validates a fresh graph under the same local-only rule. The dependencies command does not build RawPairRound. On success it writes `DEPENDENCIES_PASSED.json` with object/data hashes and total observed wall time.

After reviewing those results:

```sh
sh work/backend-costs-20261112/hol-platt/raw-analytic/build_raw_pair_round.sh
```

This requires the dependency pass gate, rechecks its output hashes, validates a fresh helper graph and builds only the helper and already-reviewed local prerequisites. It writes `HELPER_PASSED.json`; an exact exported-type/assumption audit is still required.

A different explicitly chosen fresh directory may be selected with `--stage dependency-build-NAME`, consistently on all three commands. There is no automatic retry. A started build command creates a unique STARTED record and cannot be silently rerun against the same stage. Sources are bound to the runner hash, so a runner correction also requires a deliberate fresh attempt or a separately reviewed recovery plan. No automatic deletion, overwrite, cleanup or installation occurs.

## Limits and isolation

All Holmake commands use `--no_prereqs --no-project --no_preexecs --no-cache -j1`. The local Holmakefile includes only the existing integer objects, existing jrhUtils location and BlockRound setup. No original Holmakefile is copied or executed as a build target. `HOLBUILD` is removed from the subprocess environment.

The runner sets a 4 GiB address-space limit and disables core dumps for Holmake and each inherited child process. This is a **per-process limit**, not an assertion that a parent and child together occupy at most 4 GiB. It supervises the process group and stops it on timeout or a detected cap violation. There is one Holmake job. Overall observed wall budget is three hours, including graph calls and carrying the successful dependency total into the helper command. Each ordinary target is capped at 30 minutes and `real_topologyTheory` at 60 minutes. Every graph call remains capped at three minutes.

Stage storage is checked every half-second while a child runs and at command completion: at most 10,000 files, 2 GiB total, and 64 MiB per log. This polling limit can be exceeded transiently between checks; it is not an OS disk quota. The graph has the additional 16 MiB parse cap. A failed action retains its logs and partial artifacts.

The local-only graph restriction and `--no_prereqs` prevent prospective builds in the original installation. Pinned original source and boundary-object hashes are checked before and after commands. This is not a filesystem-level read-only mount or a hash audit of every unrelated installation file. No original file is intentionally written, no original source directory is the working build directory, and no global install/link target is requested.

The runner and graph gates themselves need first-run validation. Any unexpected dependency, parser problem or missing Python/runtime support is an explicit failure to diagnose, not permission to fall back to an unrestricted Holmake invocation.

## Source pins

- `isolated_dependencies.py`: `52CD80D1B83B464D2DA28302799680A3668C256972C75B6022E279FB1AAF6E3E`.
- `dependency_inputs.json`: `D02012728214E9A4A069DABCC65F45D2CF8BD91BF5347282D8930C42EEA6AD86`.
- `preflight_dependencies.sh`: `91D784A66CE614DFA8A77069620734E921AB22D0B4A1CEB581976147D7CCBAEB`.
- `build_dependencies.sh`: `0F9AA8D8084D46C9F799BAEEF7296D855CE2210F1FECE81AACBE9C4E32395228`.
- `build_raw_pair_round.sh`: `C8A4CA15B89B07120B9546CDDED659FB6FA107CAC7E1CAA30CB27AAD696AB191`.

No analytic enclosure or L-function statement is proved by staging or graph validation. A successful dependency/helper build would establish only the separately specified generic rounded multiplication bridge.
