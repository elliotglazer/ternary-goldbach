# Finite binary Goldbach in Lean

Lean proves that every even natural number from 4 through 10^K inclusive is the sum of two primes, for each K from 1 through 10. The first nine bounds each have a standalone `PowerK.lean`. The 10^10 proof checks disjoint intervals in parallel and joins them in `shards/Power10Joined.lean`. Each proof includes 4 = 2 + 2. All ten axiom audits returned `propext`, `Classical.choice` and `Quot.sound`.

## Single-file proofs for the smaller bounds

The archive contains a single Lean file for each power from 10^6 through 10^9. Each file includes the prime and interval checks, the certificate, and a theorem for every smaller exponent. It needs only the pinned Lean and Mathlib installation. Combining the proof into one module saves repeated startup and import costs. The finite proofs use elementary arithmetic.

| Inclusive bound | Certificate generation, CPU seconds | Build, CPU seconds | Separate axiom audit, CPU seconds | Total core-hours |
| ---: | ---: | ---: | ---: | ---: |
| 10^6 | 0.016 | 18.03 | 8.25 | 0.0073 |
| 10^7 | 0.14 | 17.56 | 8.44 | 0.0073 |
| 10^8 | 0.95 | 35.50 | 9.70 | 0.0128 |
| 10^8, greedy search | 3.30 | 31.72 | 9.25 | 0.0123 |
| 10^9 | 9.98 | 100.75 | 9.70 | 0.0335 |

Totals include assembling the file. The compiled toolchain and Mathlib dependencies were present for every measurement. At 10^9 the previous full project replay took 192.47 CPU seconds including generation. The single-file replay took 120.45 with the same certificate. Each replay uses one process for the build and a second process to import the result and print the axioms of both public theorems. The 10^7 replay started from a fresh extraction of the archive.

At 10^8 the greedy search picks the anchor that covers the most remaining targets once at most 768 targets remain in an interval. It used 20,295 anchor occurrences, compared with 22,396 for the original compact certificate. Generation and replay together took 44.28 versus 46.16 CPU seconds in these individual runs. The size reduction is reproducible. Run-to-run timing variation exceeds the observed two-second difference. Both the standard-library and FLINT producers generated identical Lean source for the greedy certificate.

At 10^9 the greedy search took over at 192 remaining targets. It reduced the anchor count from 129,075 to 123,720. Its complete run took 142.77 CPU seconds under a different machine load. The default billion-bound replay uses the original compact certificate, which gave the lowest measured total.

As a separate check, Lean's `leanchecker` replayed the declarations in the compiled greedy 10^8 module against its imported libraries. That took another 39.89 CPU seconds. The table above includes the original compilation and axiom audit. To repeat the extra object check after building a module with `standalone.py`, use the same output directory and add `--recheck-only`.

To regenerate the single-file module from the supplied certificate, compile it and run the axiom audit, extract the archive, install the pinned dependencies, then run:

```sh
python standalone.py 9
```

Use `6`, `7` or `8` for the smaller proofs. To replay the greedy certificate, run `python standalone.py 8 --certificate-dir greedy768`. To compile the supplied billion-bound source directly, run `lake env lean -t0 -j1 -M3500 standalone/GoldbachThroughPower9.lean`. Its exact theorem is `SmallGoldbach.Power9.binaryGoldbachUpTo`. Its corollary `SmallGoldbach.Power9.binaryGoldbachUpToPower` accepts any exponent at most nine. The analogous 10^10 corollary is in the upstream adapter described below.

## Measurements

The rows through 10^9 measure a fresh local Lean 4.35.0 process using `-t0 -j1 -M3000` on Windows x86-64, against cached Mathlib and compiled support. The 10^10 proof uses several processes. The machine has an AMD Ryzen 9 8945HS. CPU time includes user and system time. The producer runs before Lean. The native column times a second implementation which sieves the large summand and checks all even targets.

| Inclusive bound | Even targets | Dedicated Lean build, CPU seconds | Lean elapsed seconds | Independent native scan, CPU seconds |
| ---: | ---: | ---: | ---: | ---: |
| 10 | 4 | 8.27 | 8.34 | |
| 100 | 49 | 9.88 | 9.90 | |
| 1,000 | 499 | 11.67 | 11.92 | |
| 10,000 | 4,999 | 11.19 | 11.32 | |
| 100,000 | 49,999 | 12.39 | 12.50 | below clock resolution |
| 1,000,000 | 499,999 | 13.25 | 13.29 | 0.016 |
| 10,000,000 | 4,999,999 | 19.00 | 18.90 | 0.047 |
| 100,000,000 | 49,999,999 | 37.64 | 35.72 | 0.53 |
| 1,000,000,000 | 499,999,999 | 174.66 | 151.00 | 9.47 |
| 10,000,000,000 | 4,999,999,999 | See parallel build below | See parallel build below | 145.63 |

For 10^9 the producer used 13.53 CPU seconds including writing the source. A second replay in a fresh directory rebuilt all seven project support modules, compiled the theorem and audited its axioms. It used 230.77 CPU seconds and 217.31 elapsed seconds with only the toolchain and Mathlib dependencies already installed. Including certificate generation gives 244.30 CPU seconds, or 0.068 core-hours. The concrete theorem stage alone used 155.94 CPU seconds in this second run. The separate nine-theorem axiom audit used 12.14 CPU seconds. Peak memory for the first billion-bound build was 2.22 GiB. The compiled theorem module occupied 18,479,016 bytes. The producer regenerated all nine Lean source files byte for byte in a fresh directory.

## How Lean verifies the range

The source table maps bit index i to the small odd number 3 + 2i. The producer chooses some of these bits and splits them into segments. In each segment Lean proves that the marked numbers lie below (d+1)^2 and that their product is coprime to d!. A composite number in that range would have a prime factor at most d. The certificate only needs to establish primality of marked entries.

Each interval supplies a short list of odd prime anchors. Lean checks anchor primality in batches, using a modular inverse of the fixed factorial modulo the product of the proposed anchors. In the initial interval the anchors already belong to the certified source table. Shifting the source bits by the anchor offsets and taking their bitwise union marks all even sums they represent. Lean checks that every required bit is set. The interval theorems join at exact endpoints.

## Shorter certificates for the middle powers

For the last 192 uncovered targets in an interval, the revised producer finds the candidate prime anchors for each target. A reversed copy of the source bitmap gives these candidates with one shift and bitwise intersection. The producer intersects candidate sets and selects one anchor for every group that has a prime in common. Lean checks the certificates using the same primality and coverage theorems. These variants also use wider intervals and the balanced numeral reader.

| Inclusive bound | Original anchors | Revised anchors | Original dedicated Lean CPU seconds | Revised dedicated Lean CPU seconds |
| ---: | ---: | ---: | ---: | ---: |
| 10^7 | 13,305 | 3,842 | 19.00 | 19.30 |
| 10^8 | 44,542 | 22,396 | 37.64 | 31.20 |
| 10^9 | 258,685 | 129,075 | 174.66 | 99.78 |

At 10^9 the revised source occupies 1,954,471 bytes, down from 3,334,172. The producer used 9.98 CPU seconds. The dedicated Lean run used 3.01 GiB peak memory, up from 2.22 GiB. These timings exclude compiling the common modules. All three revised public theorems passed their standard-axiom audits. [Billion-bound receipt](receipts/compact/Power9.json) · [Axiom audits](receipts/compact/AuditCompact.log)

A fresh directory with the pinned toolchain and dependency cache rebuilt the project support, checked the revised billion-bound proof, and printed its axioms in 182.48 CPU seconds and 178.26 elapsed seconds. Including certificate production gives **192.47 CPU seconds, or 0.0535 core-hours**, compared with 244.30 CPU seconds for the earlier full project run. The standard-library producer independently regenerated all three revised proof files byte for byte. [Clean replay](receipts/compact/clean-replay.json) · [Source hashes](receipts/compact/regenerated.json)

At 10^8 the same-width comparison used 131,072 even targets per interval. Grouping the residual targets cut the number of anchors from 25,758 to 22,396 (13.1%). The two matched-width runs with ordinary numerals took 42.91 and 31.67 CPU seconds. An earlier run of the identical first certificate took 28.03. The counts reproduce exactly. Variation in process startup and machine load makes the timing gain from grouping alone inconclusive. [Ordinary cover](receipts/tail-control/Power8.json) · [Grouped cover](receipts/tail192-wide/Power8.json)

To replay the revised billion-bound theorem from the source archive, run the following command. Use powers 7 and 8 for the other two certificates.

```sh
python replay.py --compact --power 9 --memory 3500
```

To regenerate the revised certificates, use the commands below. Omit `--fast-inverse` to use Python's standard-library modular inverse.

```sh
python generate.py 7 --width 65536 --halo 1568 --tail-size 192 --fast-inverse --fast-hex --out regenerated
python generate.py 8 --width 131072 --halo 2048 --tail-size 192 --fast-inverse --fast-hex --out regenerated
python generate.py 9 --width 262144 --halo 2592 --tail-size 192 --fast-inverse --fast-hex --out regenerated
```

## Original cover measurements

For 10^9 this takes 23,418 small source primes and 258,685 anchor occurrences across 3,815 intervals. Eight intervals per reduction kept memory within the configured limit. The final row stops at the requested even endpoint. `Controls.lean` checks that the verifier rejects a composite source entry, an empty cover and a damaged modular inverse.

At 10^8 we also measured three widths, holding the 2,048-slot anchor search window and the eight-interval check fixed. Each variant produced a closed theorem for the same range. These are single-run local timings.

| Even targets per interval | Intervals | Anchor occurrences | Lean CPU seconds | Peak GiB |
| ---: | ---: | ---: | ---: | ---: |
| 32,768 | 1,526 | 77,498 | 48.45 | 1.58 |
| 65,536 | 763 | 44,542 | 37.64 | 1.73 |
| 131,072 | 382 | 25,758 | 28.03 | 2.09 |

The widest run used 42% less CPU time than the narrowest and 0.51 GiB more memory. Regenerate either variant with `python generate.py 8 --width WIDTH --halo 2048 --out regenerated`. The archived `Power8.lean` uses the middle width, matching the nine independently regenerated default sources.

The upstream adapter compiled both `TernaryGoldbach.BinaryGoldbachUpTo (10^9)` and `TernaryGoldbach.BinaryGoldbachUpTo (4*10^8)`. Both axiom audits returned the same three standard axioms. This integration run used the narrowed import described below.

## Parallel build through ten billion

The certificate uses 43,878 shared small primes and 1,479,253 anchor occurrences in 19,074 contiguous intervals. Each full interval covers 262,144 even targets. Lean checks eight intervals at a time and joins the resulting 2,385 theorems. The first complete local replay used 19 interval modules, 1,303.78 CPU seconds and 651.00 elapsed seconds with four workers. The run rebuilt the project support and audited the final theorem. The toolchain and pinned Mathlib were already installed. [First build receipt](receipts/Power10.standard-replay.json)

The packaged eight-module replay used **1,105.23 CPU seconds and 374.70 elapsed seconds** with four workers. These figures include the seven project support modules, the numeral reader, all intervals, the joined theorem and the axiom audit. The 19-module replay took 209.31 CPU seconds on the shared prime table and factorial. That stage took 35.22 CPU seconds in the packaged run. The complete project builds were separate local measurements under varying load. [Packaged build receipt](receipts/Power10.replay.json)

The source producer can use Python's standard library or the optional `python-flint` package for modular inverses. The original producer took 162.03 CPU seconds. The revised generator took 204.17 CPU seconds using the standard library and 82.14 with `--fast-inverse`. All three runs produced the same 19.4 MB certificate byte for byte. Splitting the certificate into modules took another 0.58 CPU seconds. All thirteen generated source and manifest files matched the checked copies. Generation, splitting and the eight-module replay together took **1,187.95 CPU seconds, or 0.330 core-hours**. `FastHex.lean` decodes long hexadecimal strings in halves and gives the kernel an ordinary natural-number literal. The kernel checks the prime and coverage claims about those numbers. [Producer measurements](receipts/Power10.fast-input.json) · [Regeneration hashes](receipts/Power10.split.json)

## Replaying the source archive

Extract the ZIP, install the toolchain named in `lean-toolchain`, and run the following commands from its root. The Mathlib manifest pins commit `56a005855ea17e0b0958f73ec801ae140b0a1679`.

```sh
lake exe cache get
python replay.py --power 9
```

To build the ten-billion theorem from the supplied interval modules and print its axioms, run the following command from the same directory. To reproduce the four-worker timing, leave `--jobs` at 4.

```sh
python replay_split.py --jobs 4
```

The optional upstream adapter names the result in the ternary-Goldbach project's vocabulary. It gives `SmallGoldbach.binaryGoldbachUpToPower` for every exponent at most 10 and `SmallGoldbach.binaryGoldbachUpTo_of_le_ten_billion` for every smaller bound. Importing these theorems lets a consumer use all the smaller bounds after one replay. The adapter uses the same pinned statement and narrowed import as the billion-bound adapter. Checking the upstream statement, the adapter and its three axiom audits added 53.31 CPU seconds, bringing the total to **0.345 core-hours**. [Adapter build and axiom audits](receipts/Upstream10.json)

```sh
python replay_split.py --upstream-only
```

To regenerate the ten-billion proof sources, run

```sh
python generate.py 10 --width 262144 --halo 3200 --out regenerated
python split_power.py regenerated/Power10.lean regenerated/shards --groups-per-file 300 --fast-hex
```

The replay script rebuilds the project's support and the selected prefix, then prints the axioms of its theorem. The archive includes the original `TernaryGoldbach/Statement.lean` from commit `23b2d68ca344203d4384e0aff7affa4ec034bef9` of calr3/ternary-goldbach. The optional `--upstream` flag builds a copy in which only the umbrella import is replaced by `Mathlib.NumberTheory.LSeries.DirichletContinuation`, and compiles the typed adapter against that copy. The script verifies the original source hash and preserves every following byte. To retain the umbrella import, add `--original-import` and set `--memory` to suit the machine. The original umbrella exceeded a 3,000 MB Lean memory limit on this host. The generated proofs and their Python producer require no NumPy. The optional independent native scan uses NumPy.

```sh
python generate.py 8 --out regenerated
python scan.py 8 9 10
```

The archive includes the Lean sources, exact dependency pins, benchmark receipts and recorded axiom output. The certificate producer supplies integers and proposed witnesses. Lean proves their mathematical meaning from the ordinary library definitions.
