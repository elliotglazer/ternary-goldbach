# Independent binary Goldbach replay through 564,386,325,504

Every even natural number from 4 through 564,386,325,504 inclusive is a sum of two primes. Stock NanoDa and Lean default accepted the same 749,206,539-byte production proof against an independent Mathlib challenge. Both checks permitted `propext`, `Classical.choice` and `Quot.sound`. [Challenge](TrustedBinaryEndpoint.lean)  [NanoDa verdict](first-protected-kernels.log)  [Lean default verdict](protected-kernels.log)

The 415 original source producers used **5.537 core-hours**. Stock proof export took **0.674 core-hours** and 41.41 minutes wall. Counting one stock comparison and each accepting kernel once gives a measured lower bound of **14.062 core-hours** across source, export and checking. Including repeated comparison and interrupted work raises the observed total to **at least 14.748 core-hours**. Mathlib, the toolchain, challenge preparation and generated C are outside these figures. [Source ledger](source-build.json)  [Source cost breakdown](source-cost.json)  [Stock export](native-export.json)  [Totals](totals.json)

The first protected run completed NanoDa and reached Lean default. A memory guard interrupted Lean default. The recovery authenticated the saved NanoDa log, unchanged export hashes and original policy, then ran the stock comparator and Lean default on those same bytes. The table gives five-second Linux process-sampling lower bounds. The comparator process stays alive while it waits for its child kernel. [First attempt](first-protected-kernels.json)  [Recovery](protected-kernels.json)  [Sampling code](observe_kernel_processes.py)

| Attempt | Process | CPU seconds | Process wall seconds | Peak RSS, MiB |
|---|---|---:|---:|---:|
| 1 | Lake comparator | 336.4 | 16,847.0 | 932 |
| 1 | NanoDa (accepted) | 14,302.1 | 14,348.2 | 4,362 |
| 1 | Lean default (interrupted) | 2,149.2 | 2,158.7 | 5,526 |
| 2 | Lake comparator | 321.4 | 14,029.5 | 933 |
| 2 | Lean default (accepted) | 13,626.9 | 13,707.1 | 5,526 |

The recovery paused 2 times in response to Windows memory pressure, for 24.3 seconds. These pauses are included in process wall time. [Resource events](default-resource-events.jsonl)

The Windows producer and Linux verifier used the same AMD Ryzen 9 8945HS host. The Linux verifier was restricted to one logical CPU. The original source commit was `f17b38415535507fe31ba15eba396ef7fbd863af`. The source ledger includes 356 freshly compiled and 59 reused source-and-dependency-matched producers. The full solution export contained 7,311,216 expression nodes and 119,958 theorem records, including imported declarations. [Production root](ProductPrefix564386325504.lean)  [Export record counts](export-shape.json)

This measurement covers the isolated stock `lake comparator` for the original finite binary endpoint. Palomar policy `04655430` has separate `judge_exports` and `replay_con_ron` stages. The [combined ternary Goldbach theorem](../joined-theorem-3ca2fcf7/README.md) has a separate source record.

## Reproduction

In the original source checkout at `f17b38415535507fe31ba15eba396ef7fbd863af`, use the pinned Lean 4.35.0 toolchain and Mathlib packages. Run `lake build +ProductPrefix564386325504:olean` to build the finite root. The original [Linux endpoint runner](../binary-endpoint-diagnostic/binary_endpoint.py) can export the independent challenge and solution and run both stock kernels. Set `DIAGNOSTIC` to its directory and `LEAN435` to the stock Linux toolchain directory. The protected run uses `bwrap`.

```sh
python3 "$DIAGNOSTIC/binary_endpoint.py" \
  --repo . --source-tree . --packages .lake/packages \
  --proof-lib .lake/build/lib/lean --toolchain "$LEAN435" \
  --commit f17b38415535507fe31ba15eba396ef7fbd863af \
  --tree c5d1fc25d678af056f4b23e4a3d89b1f916ea371 --deadline-seconds 86400 --out "$PWD/finite-endpoint-replay"
```

In this evidence directory, `python3 verify_receipt.py` checks the recorded verdicts, input hashes, policy linkage and source cost accounting. Add `--proof-git /path/to/original-checkout` to hash all 415 frozen source files, or `--exports /path/to/exports` to hash both retained exports.
