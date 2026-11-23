# QRH integration and compiler environment

Status recorded on 2026-11-10. The source checkout and native compiler are available. QRH has not been compiled or imported in this environment. Its transitive axiom closure remains unverified.

## Pinned sources

The Goldbach checkout is `work/ternary-goldbach`, initially at `23b2d68ca344203d4384e0aff7affa4ec034bef9`. Its Mathlib manifest pins `56a005855ea17e0b0958f73ec801ae140b0a1679`, release v4.35.0.

The sparse QRH checkout is `work/openai-math`, pinned to `4eaee87548250b2682affda7d05d947c05554bae`. It contains `lean/OAI/NumberTheory/DirichletL` and `lean/ComparatorChallenges`, together with ancestor-level configuration files. `git status --short` was empty after checkout.

QRH uses Lean v4.34.1 and Mathlib `d13f23b723b8a846827a245b89c10fc7d3f11612`. This differs from the Goldbach v4.35.0 environment. Port compatibility has not been established.

The public theorem at `lean/OAI/NumberTheory/DirichletL/Nonvanishing.lean`, lines 19–24, takes a positive modulus through `NeZero q`, a complex Dirichlet character, `7/8 < s.re`, and exclusion of the principal-character pole. It forwards to `SevenEighths.ProbeFinalAssemblyUnconditional.dirichlet_nonzero`. The zeta theorem at lines 29–31 requires only `7/8 < s.re`.

`Detector/FinalAssemblyUnconditional.lean` supplies `detector_certified_bands` through `terminal_certificate`, then supplies it to `dirichlet_of_certified` and `zeta_of_certified`. The source declaration binders expose no extra mathematical hypothesis. This source observation does not establish its transitive axiom closure.

`ComparatorChallenges/DirichletSevenEighths.json` names the public Dirichlet theorem and permits `propext`, `Quot.sound`, and `Classical.choice`. `enable_nanoda` is false. The configuration records intended validation parameters. It is not evidence that a comparator run completed here.

## Exact import closure

`scan_qrh.py` reads local imports recursively. The public theorem reaches 2924 OAI modules and 486490 source lines. No OAI imports are missing from the sparse checkout. A lexical scan found no occurrences of the words `sorry`, `axiom`, or `admit` in that closure. The generated module list is `qrh-modules.json` and the adjacency map is `qrh-import-graph.json`.

`compare_closures.py` establishes that `Foundation` reaches 287 modules. `FinalAssemblyUnconditional` reaches 2923 modules and already imports `Foundation` transitively. Removing the explicit Foundation import from the public wrapper would leave the substantive closure unchanged.

External imports reach Lean, Mathlib, PrimeNumberTheoremAnd, and RellichKondrachov. The non-Mathlib entry points are `PrimeNumberTheoremAnd.Wiener`, imported by `IdealMangoldt.lean:2` and `PrimeCounting/Progressions.lean:1`, and `RellichKondrachov.Analysis.FunctionalSpaces.Sobolev.Euclidean.Rellich`, imported by `CubicSieve/RadialWindows.lean:1`.

QRH's manifest pins PrimeNumberTheoremAnd to `c39a751132c88b6e8080b74c74023fd95b3d8be0` and rellich-kondrachov to `70f85d4c1bf99c6e7d61e8be4daa6f3664d08d23`. The upstream Lake configuration also applies compatibility patches and configures many unrelated packages. Its configuration has executable pre-resolution patch logic, so simply loading the complete upstream Lake project can materialize unrelated packages. A minimal isolated QRH project should select the actual import closure, preserve the required patch contents, and document every source adaptation before compilation.

## Working native environment

The compiler is `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe`. Its version command returned `Lean (version 4.35.0, x86_64-w64-windows-gnu, commit eb6cafb7290e8bd5f2937522d8d804f58f02bafc, Release)`.

The reusable package root is `C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages`. Its Mathlib `.git/HEAD` is the exact target pin `56a005855ea17e0b0958f73ec801ae140b0a1679`. The directory contains Mathlib, aesop, batteries, Cli, importGraph, LeanSearchClient, plausible, proofwidgets, and Qq artifacts. Treat these directories as read-only.

PowerShell setup for a standalone scratch file is

```powershell
$env:LEAN_PATH = ((Get-ChildItem 'C:/Users/glaze/Documents/Codex/2026-11-02/lo/formalization/z-in-q/.lake/packages' -Directory | ForEach-Object { Join-Path $_.FullName '.lake/build/lib/lean' }) -join ';')
& 'C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean.exe' -j 2 '<absolute scratch file>'
```

The scratch `InitProbe.lean`, containing `example : 1 + 1 = 2 := rfl`, completed with exit 0. `NatProbe.lean` imported `Mathlib.Data.Nat.Basic`, checked `Nat.add_comm`, and completed with exit 0. This validates actual native loading of a Mathlib module. The broad `MathlibProbe.lean` was stopped before completion. It does not have a successful validation result.

The sandbox repeatedly stalled simple shell reads. The same commands with `login:false` and `sandbox_permissions:require_escalated` succeeded after automatic approval. WSL inventory contains only the stopped docker-desktop distribution. No ready Linux proof environment was found.

One Numeric worker process was accidentally stopped while identifying broad probes. The worker was informed and started a new logged compile. Use process command lines and owner coordination before stopping any further process.

## Project compilation

`build_project.py` computes a requested TernaryGoldbach import closure, compiles one module at a time with native Lean and `-j 2`, writes artifacts only under `integration/artifacts`, and writes per-module logs under `integration/logs`. The original project and cached dependencies are read-only inputs. A dry run verified the PsiAsymp closure has 58 project modules. The broader SchoenfeldGen closure has 469, so it has not been built.

From the main task workspace, the focused commands are

```powershell
python work/qrh-campaign/agents/integration/build_project.py TernaryGoldbach.Explicit.PsiAsymp
python work/qrh-campaign/agents/integration/build_project.py TernaryGoldbach.Prelim.SmallPsiTableMain TernaryGoldbach.Prelim.SmallPsi700
```

The second command supports the finite psi scratch helper and has an 11-module closure. Add `--scan-only` to inventory either command without compilation. These build commands were prepared and dry-run only. No project module compilation had started at report time.

For a scratch file importing project modules, prepend the absolute `integration/artifacts` directory to the PowerShell LEAN_PATH above. The PsiAsymp closure includes ZeroSumGen, XiPartial, ZetaZeroSums, and EtaPlusMellin, so completing it will provide the main scratch workers' project imports.

A filename search under Documents/Codex and Myproject found no existing PsiAsymp, ZeroSumGen, EtaPlusMellin, OAI Nonvanishing, or OAI FinalAssemblyUnconditional artifacts. Matches named Nonvanishing belonged to Mathlib's LSeries module.

## Remaining integration work

The immediate route is to validate the Mathlib-only scratch estimates, build the needed Goldbach import closure serially, and check the project-dependent scratch proofs. QRH then requires a separate v4.35 port or another explicitly reviewed compatible integration. Its original v4.34.1 compiled objects cannot supply imports to the v4.35 project.

A complete QRH validation must compile the actual assembly, run `#print axioms` on both exported nonvanishing theorems, and perform the independent statement/comparator audit before claiming closure. Replacing PlattGRH also requires the new analytic estimates and their numerical end-to-end assembly. Importing QRH alone does not establish the existing critical-line hypothesis.
