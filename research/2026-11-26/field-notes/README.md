# Original working notes, November 25–26, 2026

The six local research collections yielded 57 original Markdown files for the November 23–26 archive search. Their recorded file dates fall on November 25 and 26. The notes range from a one-block Lean 4.37 experiment to the closed Lean 4.35 theorem and the first cold protected rehearsal. The four extracts below preserve technical observations from drafts, experiments and superseded handoffs. Dates and measured outcomes belong to each experiment.

| Extract | Topics |
|---|---|
| [Verification and proof boundaries](verification.md) | The statement controls on 4.33.1 and 4.37, the Platt interface, axiom tracing, source repairs and the closed theorem. |
| [Finite proof experiments](finite-experiments.md) | Comparable finite intervals, factorial versus prime-product certificates, balanced bitmaps, and the distinction between kernel additions and full exports. |
| [Cold build forecasts](scheduling.md) | Measured durations for 1,528 project modules, finite scheduling barriers, and the calibrated four-frontend estimate. |
| [Resources and recovery](resources-and-recovery.md) | Stock and simulator controls, shared memory limits, timed preflights, interrupted jobs and evidence recovery. |

## Source register

The [tab-separated register](sources.tsv) identifies each input by subject, source family, UTC file-modification date and SHA-256 of the original bytes. A SHA-256 refers to the archived original, before editing or normalizing line endings. Forecasts and implementation proposals remain labeled as such. Operational instructions contribute their public technical findings only.

The comparison used all 2,270 Markdown paths at the pinned research snapshot and the verification subtrees throughout its locally available 89-commit history. It compared Git blob identities and headings and checked likely corresponding public paths. Nineteen original files matched public Git blobs byte for byte, including two in earlier trees. A shared heading or related receipt alone earns a separate label in the register. An unmatched note may exist under another branch or outside this snapshot. [Public research snapshot](https://github.com/elliotglazer/ternary-goldbach/tree/c6368decde84d4be04943117a2bfef991f9b1831)

## Byte-identical public originals

| Note | Original |
|---|---|
| N01 | [Stock environment evidence](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/stock-runtime/README.md) |
| N10 | [Timed protected replay handoff](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/stock-execution-handoff-f85040a7.md) |
| N11 | [Protected final replay protocol](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/stock-runtime/protected-final/README.md) |
| N12 | [Shorter local cutoff protocol](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/stock-protected-limited/README.md) |
| N17 | [Independent conditional Goldbach root](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/warm-main/independent-roots/README.md) |
| N27 | [Compact joint verification, full-receipt frames](https://github.com/elliotglazer/ternary-goldbach/blob/785f57bcf04ebc12017582e280a25b7641021d46/verification/community-grh/compact/compact-joint-435.md) |
| N28 | [Compact joint verification, early milestone targets](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/compact-joint-435.md) |
| N31 | [Verification checkpoints before the two source roots finished](https://github.com/elliotglazer/ternary-goldbach/blob/226fb3c9d9a55f767b4c7b2899f4fead9b5447b6/verification/community-grh/compact/README.md) |
| N33 | [First warm GRH diagnostic](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/warm-main/README.md) |
| N35 | [Layered warm reuse](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/warm-main/incremental/README.md) |
| N36 | [Timeouts and partial source evidence](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/warm-main/timed-roots/README-timeouts.md) |
| N37 | [Eight analytic profile data modules](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/eight-numerical-profiles/README.md) |
| N38 | [Conditional and finite proof, completed Linux replay](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/finite-terminal-22f442fa/README.md) |
| N39 | [Closed Goldbach theorem, warm Linux replay](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/joined-theorem-3ca2fcf7/README.md) |
| N40 | [First native prefix above 21 billion](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/finite-21408506880/README.md) |
| N41 | [Second native prefix above 21 billion](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/finite-21945377792/README.md) |
| N50 | [Marginal stock kernel cost of adjacent tiles](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/paired-product-tile-kernel/README.md) |
| N56 | [Finite factorial comparison and provisional cost model](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/finite-factorial-comparison.md) |
| N57 | [First two blocks, portable kernel evidence](https://github.com/elliotglazer/ternary-goldbach/blob/c6368decde84d4be04943117a2bfef991f9b1831/verification/community-grh/compact/finite-first-two-replay.md) |

The larger [operator chronology](../rehearsal.md) records the closed-theorem source receipt and the later protected checkpoint. The reader can use the dated source notes here to reconstruct what each earlier test had established at the time.
