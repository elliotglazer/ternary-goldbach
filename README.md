# Ternary Goldbach research archive

This repository contains the November 2026 Lean proof that every odd natural number greater than five is a sum of three primes, together with the research archive.

## Completed proof · November 24, 2026

Start with the [finite and analytic proof](proof/CompletedFiniteRows.lean), then the [final theorem](proof/CompletedGoldbach.lean). Stock Lean 4.33.1 accepted `CompletedGoldbach.ternary_goldbach : TernaryGoldbach.Statement` using the released RH and primitive Dirichlet GRH objects. The saved theorem has no remaining hypotheses and its exported axiom set is `propext`, `Classical.choice`, and `Quot.sound`. [Kernel receipt](proof/evidence/CompletedGoldbach-receipt.json) · [Proof bundle and replay instructions](proof/README.md)

## November 22 research checkpoint

- **Finite binary Goldbach in Lean.** The closed contiguous prefix reaches **100,328,530,944**. Additional high-endpoint shards are recorded separately. The finite handoff names the checked declarations, their axioms, and the commands for replay. [Finite handoff](work/publish-handoffs/finite.md)
- **Large odd integers.** The archive includes the full-GRH adapter, the partial port of the large-case argument, and the work on Zinoviev’s conditional route. The all-input Lean theorem still has open analytic and integration obligations. [Large-case handoff](work/publish-handoffs/large-case.md) · [Zinoviev handoff](work/publish-handoffs/zinoviev.md)
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

Dated forecasts describe the evidence available when they were written. For later measured values, start with the lane handoff and follow its receipt links. A timing for a native calculation, a conditional theorem, or a representative panel has the scope recorded in its receipt.

## Restore the data and verify the archive

Most files are directly browsable on the default branch. Larger proof inputs, generated certificates, benchmark outputs and experiment data are in the [dated release](https://github.com/elliotglazer/ternary-goldbach/releases/tag/research-2026-11-22). The [file manifest](archive/manifest.tsv) lists the original relative path, byte count, SHA-256 digest and storage location for each research file. The [asset manifest](archive/release-assets.json) records each download’s SHA-256 digest. Some relative links in historical notes point to release files and become usable after restoration.

From a checkout of the release tag, use Python 3.11 or newer and a GitHub CLI account with access to this private repository.

```sh
gh release download research-2026-11-22 --repo elliotglazer/ternary-goldbach --dir release-data --skip-existing
python archive/restore.py --assets release-data --restore
```

For a Git-only integrity check, run `python archive/restore.py`. To validate both Git and the downloaded archives without extracting them, run `python archive/restore.py --assets release-data`. Restoration uses hard links on the checkout filesystem to protect existing files. These commands verify the saved bytes. The agent handoffs give the separate proof-replay commands.

The snapshot preserves locally authored source, dated research notes, proofs, receipts, experiment inputs, and reproducible build instructions. Upstream proof exports and vendored toolchains have source pins or download manifests. Machine caches, installed binaries, private account details, and raw chat sessions were omitted. The original project paths are retained so scripts and evidence links can be followed. Some historical logs contain machine-specific paths and timing measurements.
