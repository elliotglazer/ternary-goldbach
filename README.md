# Ternary Goldbach research archive

Harald Helfgott proved that every odd integer greater than five is a sum of three primes. This Lean development builds on Charlie Reams’s formalization of Helfgott’s argument and imports Levent Alpöge’s compiled proofs of the Riemann hypothesis (RH) and GRH for primitive Dirichlet characters. Elliot Glazer directed this project with ChatGPT 6.2 Astra as the AI collaborator on the Lean proofs and computational checks. This project verified binary Goldbach through 564,386,325,504, combined it with a prime-gap bound to cover odd inputs through 2 × 10¹⁹, and checked 223 analytic intervals and a uniform estimate for the infinite tail. Together these steps give a Lean theorem covering every odd input greater than five. [Helfgott’s proof](https://arxiv.org/abs/1501.05438) · [Reams’s formalization](https://github.com/calr3/ternary-goldbach/tree/23b2d68ca344203d4384e0aff7affa4ec034bef9) · [Alpöge’s compiled release](https://proofsandreasons.io/rh-oleans.html)

## Completed proof · November 24, 2026

Start with the [finite and analytic proof](proof/CompletedFiniteRows.lean), then the [final theorem](proof/CompletedGoldbach.lean). Stock Lean 4.33.1 accepted `CompletedGoldbach.ternary_goldbach : TernaryGoldbach.Statement`. The final link supplied `riemannHypothesis` and `LFunction_eq_zero_re_of_isPrimitive` from the upstream compiled release. The saved theorem has no remaining hypotheses and its exported axiom set is `propext`, `Classical.choice`, and `Quot.sound`. [Independent checks of Alpöge’s development](https://math.mit.edu/~drew/grh/) · [Goldbach kernel receipt](proof/evidence/CompletedGoldbach-receipt.json) · [Proof bundle and replay instructions](proof/README.md)

### Compilation time

Using the released RH/GRH objects, the closed Goldbach theorem took **at least 5.19 core-hours** of recorded CPU time. The binary Goldbach check accounted for **3.49 of the 5.07 core-hours** recorded before the final link (69%). The table counts each timed Goldbach module once.

| Build step | CPU time | Elapsed time |
| --- | ---: | ---: |
| Verify binary Goldbach through 100,328,530,944 | 1 h 36 min | — |
| Extend binary Goldbach through 564,386,325,504 | 1 h 53 min | — |
| Check the prime-gap argument, analytic estimates, and infinite tail | 46 min 46 sec | — |
| Check the additional modules for the 223 analytic intervals | 47 min 27 sec | — |
| Combine the finite and analytic results, with RH and GRH as hypotheses | 19 sec | — |
| Import the released RH/GRH objects, check the closed theorem, and write it to disk | 7 min 40 sec | 38 min 21 sec |
| **Goldbach total using the released objects** | **≥ 5.19 core-hours** | **Unmeasured end to end** |
| Optional upstream RH/GRH source build | **≈ 530 additional core-hours** | **7 h 58 min** in an independent build on a 192-core server, including restarts |

The local figures cover 405 of 415 binary modules and 130 of 317 other Goldbach modules. Dashes mark stages without an aggregate elapsed-time measurement. The timings exclude certificate generation, downloads, and mathlib setup. [Per-module CPU timings](proof/evidence/analytic-progress.json) · [Final-link timing log](proof/evidence/CompletedGoldbach.log)

Budget roughly **535 core-hours** for the recorded Goldbach work plus a source build of RH/GRH, with additional time for the 197 untimed Goldbach modules. This estimate combines our local measurements with the upstream compiler estimate. The elapsed time in the last row comes from Andrew Sutherland’s separate sandboxed rebuild. [Upstream CPU estimate](https://proofsandreasons.io/rh-oleans.html) · [Independent rebuild timeline](https://math.mit.edu/~drew/grh/sandbox-timeline.txt)

## November 22 research checkpoint

- **Finite binary Goldbach in Lean.** The closed contiguous prefix reaches **100,328,530,944**. Additional high-endpoint shards are recorded separately. The finite handoff names the checked declarations, their axioms, and the commands for replay. [Finite handoff](work/publish-handoffs/finite.md)
- **Large odd integers.** The archive includes the full-GRH adapter, the partial port of the large-case argument, and the work on Zinoviev’s conditional route. At this checkpoint, the all-input Lean theorem still had open analytic and integration obligations. [Large-case handoff](work/publish-handoffs/large-case.md) · [Zinoviev handoff](work/publish-handoffs/zinoviev.md)
- **Replacing the finite zero calculation.** The QRH blueprint records which estimates follow from QRH, the finite zero facts still needed, and alternatives based on certificates. The HOL4 experiments include actual replay timings, kernel-checked subtheorems, and numerical tests whose analytic premises remain open. [QRH blueprint](outputs/qrh-blueprint-next/OVERVIEW.md) · [Historical and HOL4 measurements](work/publish-handoffs/historical.md) · [Forecast audit](work/publish-handoffs/forecast-review.md)
- **Bridging the finite and analytic ranges.** The prime-gap and ladder handoffs give exact coverage endpoints, hypotheses, certificate inputs, and unresolved steps. [Prime-gap handoff](work/publish-handoffs/gap-routes.md) · [Ladder and precision handoff](work/publish-handoffs/ladders.md)

## Research records

| Directory | Contents |
| --- | --- |
| [Agent handoffs](work/publish-handoffs/) | Per-lane findings, stopped experiments, replay instructions, and archived technical discussions |
| [Blueprint releases](outputs/) | Earlier and later QRH blueprints, chapter reviews, numeric audits, and the finite Lean distribution |
| [QRH working files](work/qrh-blueprint/) and [agent experiments](work/qrh-campaign/agents/) | Intermediate proposals, rejected approaches, measured constants, generators, and receipts |
| [GRH and finite verification](work/grh-goldbach-20261120/) | GRH export provenance, prime-gap bridges, finite Lean and HOL proofs, and analytic experiments |
| [Backend comparisons](work/backend-costs-20261112/) | Lean, HOL4, Rocq, Candle, and MM0 cost models, fixtures, verifier experiments, and timing logs |
| [Goldbach benchmarks](work/formal-goldbach-bench/) and [MM0 experiments](work/mm0-efficient/) | Finite proof production, native measurements, compact proof formats, and replay data |
| [Source provenance](work/publish-handoffs/upstream/) | Upstream checkout revisions and local changes needed to reconstruct the working versions |

The [agent journal](work/publish-handoffs/agent-journal/README.md) preserves reports from 28 project agents. The [dated project journal](work/publish-handoffs/research-journal/) and [four technical exchanges with Claude](work/publish-handoffs/claude/README.md) preserve the group’s research decisions and mathematical questions. The [finite Lean milestone package](work/publish-handoffs/finite-files/) contains the already-checked six-band module closure and its compiler pins.

The journals record proposals, rejected arguments, and cost forecasts as of their entry dates. The November 24 build receipt above records what Lean ultimately accepted. For later measured values, start with the lane handoff and follow its receipt links. A timing for a native calculation, a conditional theorem, or a representative panel has the scope recorded in its receipt.

## Restore the data and verify the archive

Most files are directly browsable on the default branch. Larger proof inputs, generated certificates, benchmark outputs and experiment data are in the [dated release](https://github.com/elliotglazer/ternary-goldbach/releases/tag/research-2026-11-22). The [file manifest](archive/manifest.tsv) lists the original relative path, byte count, SHA-256 digest and storage location for each research file. The [asset manifest](archive/release-assets.json) records each download’s SHA-256 digest. Some relative links in historical notes point to release files and become usable after restoration.

From a checkout of the release tag, use Python 3.11 or newer and the GitHub CLI to fetch the archived assets.

```sh
gh release download research-2026-11-22 --repo elliotglazer/ternary-goldbach --dir release-data --skip-existing
python archive/restore.py --assets release-data --restore
```

For a Git-only integrity check, run `python archive/restore.py`. To validate both Git and the downloaded archives without extracting them, run `python archive/restore.py --assets release-data`. Restoration uses hard links on the checkout filesystem to protect existing files. These commands verify the saved bytes. The agent handoffs give the separate proof-replay commands.

The snapshot preserves locally authored source, dated research notes, proofs, receipts, experiment inputs, and reproducible build instructions. Upstream proof exports and vendored toolchains have source pins or download manifests. Machine caches, installed binaries, private account details, and raw chat sessions were omitted. The original project paths are retained so scripts and evidence links can be followed. Some historical logs contain machine-specific paths and timing measurements.

## License and attribution

Original contributions to this repository are available under the [Apache License 2.0](LICENSE). Third-party materials retain their respective licenses and notices. The restored proof bundle includes Charlie Reams’s original license and notice under `upstream-calr3/`. Four source files from Steve Hubbard’s Goldbach Lean project are fetched at a pinned revision during replay. [Attribution notice](NOTICE) · [Hubbard’s source repository](https://github.com/sthubbar/goldbach-lean/tree/05fe86a4649a4bb2728244a8805ec6bbc822d250)
