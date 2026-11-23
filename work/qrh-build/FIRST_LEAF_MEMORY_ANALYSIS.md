# First QRH leaf: bounded memory-stop diagnosis

Status: source and receipt analysis only. Three diagnostic sources were staged; the coordinator subsequently ran the two header controls below. This author ran no Lean or Lake process. Original provider sources, dependency artifacts, budgets and existing failed attempts were not changed. This is not provider validation or approval to reuse an output artifact.

## Update after the two header controls

The coordinator's receipts under `work/qrh-build/leaf-import-quarantine/` are:

| Attempt | Wall seconds | CPU seconds (kernel / user) | Peak private bytes | Peak working-set bytes | Samples |
|---|---:|---:|---:|---:|---:|
| `1113T064714_original-imports_a6cc3c55` | 52.02124329999788 | 9.296875 (8.015625 / 1.28125) | 4,296,957,952 | 210,513,920 | 208 |
| `1113T064814_narrow-imports_bf01c3d4` | 15.437123700015945 | 8.171875 (7.328125 / 0.84375) | 4,296,663,040 | 211,927,040 | 62 |

Both have `observed_private_limit_stop`, exit 124, unchanged pinned inputs, empty logs, no completion marker and no artifacts. Thus **the theorem body is not needed to reproduce the memory stop**, including with the three-import header. This establishes an import/startup obstruction under this guard, not an explanation of every committed byte. It does not establish a performance improvement from the differing wall times: neither run completed, and these are single runs with uncontrolled cache/system conditions. Do not run the full-body candidate merely to repeat this obstruction.

A read-only `GlobalMemoryStatusEx` snapshot at 2026-11-13 06:50:23 UTC is saved in `memory-probe/memory_context.json` (SHA256 `23a2157b75c534d5c1e9c52ff964777977a573651101b6dbbcfcabf505f5f207`). Available physical memory was 6,065,074,176 bytes initially and 6,062,329,856 bytes after the metadata reads, out of 33,593,020,416; reported physical load was 81%. `ullTotalPageFile` was 67,952,758,784 and `ullAvailPageFile` 25,886,740,480 initially / 25,844,088,832 finally. These are commit-related counters, not free disk space. Virtual-availability fields describe the observing Python process, not the stopped Lean process. The snapshot was **after** both Lean children exited, so it is not contemporaneous evidence of memory availability at the stops.

The observed guard is a policy stop on process private commitment. It is not an observed Windows allocation failure, Lean memory-limit exception or exhaustion of physical RAM. The roughly 211 MB resident working sets are far below 4 GiB. Current physical headroom is nevertheless finite (about 5.65 GiB), and committed capacity is a real system resource. These records do not justify declaring the guard harmlessly artificial or changing it. They do justify distinguishing it from a demonstrated requirement for more than 4 GiB of resident theorem-elaboration memory.

### What local loader source explains, and what remains unknown

Installed Lean source root: `C:/Users/glaze/.elan/toolchains/leanprover--lean4---v4.35.0/src/lean`.

- `Lean/Environment.lean:1767–1797` describes compacted module parts, deterministic mmap base addresses and chained `CompactedRegion.read` calls.
- `Environment.lean:2079–2092` has `readModuleDataPartsOfMod`: for a module-system artifact it eagerly reads `.olean`, `.olean.server` and `.olean.private`. Its comment says this is necessary because a later import may upgrade the level.
- `Environment.lean:2231–2239` distinguishes a supplied artifact descriptor (whose producer can limit parts) from the fallback above. This justifies inspecting artifact setup before attributing the cost to public theorem dependencies alone. It does not authorize deleting private files or excluding them speculatively.
- `Lean/CompactedRegion.lean:77–109` describes mmap base addresses and cross-region pointer fixup, but the implementation of `lean_compacted_region_read` is an external C++ function. The inspected installed source tree does not contain that implementation. `Environment.lean` SHA256 is `6c90105aecc4d28efe94cc9aef1704c284e7a748b28270b5f8513d2562331e43`; `CompactedRegion.lean` is `56ef2a63c2394faefe590b58a5e3bd239589ddb6657a8523e5b0385800043f94`.

Consequently this local inspection does **not** prove that the executable uses `PAGE_WRITECOPY` / `FILE_MAP_COPY`, how much Windows charges such views to this process, or that such mappings explain the observed commitment. Copy-on-write mapping commitment is a concrete hypothesis for a subsequent mapping-level observation, not an accepted diagnosis. The installed 4.35 source is also not evidence about the original provider's 4.34.1 loader.

The same read-only script inspected sizes of existing direct-import artifact files (not their contents or the whole transitive closure). All 180 original direct imports and all three narrowed imports have each of `.olean`, `.olean.server`, `.olean.private`, `.ir`, `.ir.sig`. The original direct `.olean`/server/private totals are 42,635,448 / 3,228,632 / 127,866,464 bytes; the three-import totals are 82,192 / 20,584 / 866,176 bytes. These are disk sizes of roots only, not the many shared transitive modules, not allocated-memory bounds and not proof that all corresponding IR parts were loaded. The distinction reinforces why direct-import count or size cannot predict this stop.

### Recommended next low-risk diagnostic

Do not increase a budget or run another import yet. Prepare for coordinator review an **observational** extension of the existing monitor: contemporaneous system physical/commit counters, plus one or a few bounded `VirtualQueryEx` summaries before the existing private threshold. Classify address regions by state/type/protection (`MEM_PRIVATE`, `MEM_MAPPED`, copy-on-write protections where reported), retain mapped-file names for compacted artifact regions if obtainable, and keep resident working-set measures distinct. Inspection errors must be recorded, not silently treated as zero. If later authorized, run only one header control under the same 4-GiB / 600-second stop, compiler and package settings; no full-body or dependency build is needed.

This can test whether most address/commit growth accompanies artifact mappings or private allocations, and whether system headroom is actually declining toward exhaustion. Region virtual sizes alone still do not measure physical residency or exact per-region commit charge; a copy-on-write protection label would support, not by itself quantify, the hypothesis. Correlate the observations rather than subtracting region sizes from `PrivateUsage` as if they were interchangeable. No such monitor extension or further Lean run was performed here.

The remainder below preserves the initial diagnosis and staged-control rationale. Statements about what was unmeasured refer to that pre-control state; the two completed controls above supersede the initial uncertainty about whether a theorem body is required.

## What the stopped run establishes

Receipt: `work/qrh-build/first-leaf-quarantine/1113T063006_f9e4d324/diagnostic.json`; telemetry and empty `lean.log` are beside it. The external monitor stopped the process with status `observed_private_limit_stop` and exit 124. It was not a reported Lean elaboration error.

| Measurement | Observed value |
|---|---:|
| Process wall time | 9.438406800007215 seconds |
| Total process CPU | 9.171875 seconds |
| Kernel / user CPU | 8.203125 / 0.96875 seconds |
| Sampled peak private committed bytes | 4,448,313,344 |
| OS peak working-set bytes | 216,997,888 |
| Samples | 38, at nominal 0.25-second intervals |
| Log / output inventory | empty / empty |

The private number is approximately 4.448 GB (4.143 GiB); the working set is about 207 MiB. These are different measurements. The record does **not** show 4.448 GB resident memory. The OS peak-pagefile counter equalled the private peak, but that counter does not establish actual disk paging traffic. The stop threshold was 4 GiB of observed private bytes, so sampling permits overshoot; no hard OS memory cap was claimed.

The command used Lean 4.35.0, `-t0 -j 1 -M4096 -DautoImplicit=false`, the original source root, existing package artifacts and an isolated output path. The original package contributes `autoImplicit=false`; the remaining controls are diagnostic options. The receipt confirms source, compiler, package-options source and source manifest unchanged. It does not rehash all dependencies.

The mostly-kernel CPU and large difference between commitment and working set suggest that allocation/loading behavior deserves investigation. They do not identify a compiler phase. No import timing, completion marker or profile was captured. In particular, an empty log is consistent with either imports or silent body elaboration. **Broad imports have not yet been shown to dominate this stop.**

## Source evidence and the existing narrowing candidate

Original: `work/openai-math/lean/OAI/NumberTheory/DirichletL/Arithmetic/EisensteinCoordinates.lean`, SHA256 `a97237026d0add0b1e1f6a3a025a253a9e6dd17c0e06929f779772727f02260b`.

The first 180 lines are Mathlib imports, including substantial analysis, manifold, distribution, Fourier/Mellin and number-field material. The saved QRH graph gives this leaf no project prerequisites. Its body starts at `namespace OAI` on line 182. It contains elementary Eisenstein coordinate identities, cyclotomic PID, an actual Dirichlet-L nonvanishing target and its right-half-plane case, analytic identity arguments, finite arithmetic-function sums, elementary real budgets and finite-character/Gauss-sum identities. There is no source basis for treating all 180 direct imports as necessary.

Reuse the already prepared, uncompiled source-only candidate from `work/qrh-campaign/agents/mellin/EisensteinCoordinates.lean`; do not create a new proof rewrite. Its three imports are:

```lean
import Mathlib.NumberTheory.NumberField.Cyclotomic.PID
import Mathlib.NumberTheory.LSeries.Nonvanishing
import Mathlib.Analysis.Complex.HalfPlane
```

On the existing 4.35 Mathlib source, these directly provide `IsCyclotomicExtension.Rat.three_pid` (`Cyclotomic/PID.lean:35`), `DirichletCharacter.LFunction_ne_zero_of_one_le_re` (`LSeries/Nonvanishing.lean:397`) and `Complex.isOpen_re_gt` (`Complex/HalfPlane.lean:49`). The prior public-import audit identifies transitive providers for Gauss sums, Möbius convolution, analytic uniqueness/constructions, real square roots, finite sums and the used tactics. See `work/qrh-campaign/agents/mellin/EisensteinImportReview.md` and `import-manifest.json`, latter SHA256 `84dc5f69e205d9c3037b408e208f37b0072c2156bf1249e640938ab8c0eb8a16`.

That historical scanner reported 4,023 reachable module names for the original and 3,827 for the candidate: only 196 fewer, approximately 4.9%. These counts include non-Mathlib names, while recursion only read Mathlib source, and are not a complete compiled-artifact loader graph. They were not recomputed in this task. Reducing 180 direct imports to three is therefore **not** evidence of a comparable reduction in loaded memory. The candidate may still exceed the same limit.

The candidate changes only the import header. Its entire suffix from `namespace OAI` is byte-identical, with SHA256 `6a659f2c2a18dbb4197b99f8811ebecc2aa4bbe204bc21433213398d960a1ab6`. This makes it the smallest presently justified source edit for a body-preserving diagnostic; it is not a proof that three imports are minimal or sufficient. Missing instances, tactic registrations or changed exports remain possible. Even successful isolated elaboration would not justify replacing the original header for downstream consumers that rely on its transitive exports.

## Staged controls and the next bounded action

`work/qrh-build/memory-probe/prepare_sources.py` executed only byte/hash checks and exclusive file writes. Its receipt is `memory-probe/staging.json`. Each variant has an independent `src` root and the same relative module path `OAI/NumberTheory/DirichletL/Arithmetic/EisensteinCoordinates.lean`:

| Variant directory under `memory-probe` | Contents | SHA256 |
|---|---|---|
| `original-imports/src` | Exact original header, then `#check True` | `c91875463748e56248d08cb61560d4e9b59e8f89dad0b44ec9c9a73995fae1d3` |
| `narrow-imports/src` | Three-import header, then `#check True` | `6ec94466c931d165e4bce8ece24bcc2f9bda6c3923a431ff01e5595994ac6c2a` |
| `narrow-full/src` | Three-import header plus unchanged whole body | `7a9e677b2abd33b80be2278b202895e94a11c71a49b81da72314fd8e1d05091b` |

The import-only controls omit theorems and are deliberately **not** semantic replacements for the original leaf. Their marker separates completion of imports from subsequent work. The full-body candidate is the proposed semantics-preserving change, pending actual elaboration and statement/axiom comparison.

Root should first review and run `original-imports`, with the existing one-worker, 4-GiB observed-private and 600-second limits unchanged. Keep the exact compiler and package search-path suffix from the failed receipt. Change only the input source, matching `-R`/working root, expected source pin, diagnostic label and fresh output quarantine. Keep that fresh artifact directory first on `LEAN_PATH`; never expose these same-name control outputs to production or later variants. Use the existing monitored runner after an explicit adaptation review, not an unmonitored raw command. No executable driver adaptation is supplied here.

Interpret results narrowly:

1. If the original-header control stops before `#check True`, importing this header (including module initialization) suffices to reproduce the stop without any leaf theorem. This still does not identify the costly dependency or justify a memory-budget change.
2. If it reaches the marker, imports completed in that run. Compare telemetry, then diagnose the original body separately; a success alone does not establish that imports are cheap or that body elaboration caused the previous stop.
3. Next, if useful, run `narrow-imports` under the same limits. A lower commitment peak is evidence about this control, not a performance claim for the full leaf. If both header controls stop, the large shared closure or loader/runtime configuration remains a candidate; removing more justified imports is not guaranteed to help.
4. Only after those controls justify it, run `narrow-full`. A successful compile would establish that isolated candidate under the tested environment, not the QRH provider, downstream compatibility or standard-axiom closure. If it fails, preserve the exact error rather than adding blanket imports or changing proofs speculatively.

Cache state and repeated-run variation matter for any later timing comparison. A single bounded control is intended to locate an obstruction, not to establish an optimization speedup. No demand for repeated broad builds is made here.

## Remaining risks

The original provider targets Lean 4.34.1 and a different Mathlib revision; this is a 4.35 diagnostic against existing artifacts. Source-level provider review is not elaborated closure. The current leaf's body has not been tested in this task, and the static public-import manifest is not a replacement for testing. There is no evidence yet distinguishing a library-loader commitment cost from a body elaboration cost, nor evidence that a narrower header will fit the unchanged budget.

No original or dependency file was written by this analysis. The staging script verified the original source unchanged after staging. The coordinator's two header attempts terminated without artifacts; the full-body control remains unrun. Nothing is published or accepted for reuse.
